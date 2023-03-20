Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E6B6C2328
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjCTUxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjCTUxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:53:43 -0400
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5555134C3D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:53:36 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id B9F6516C0057;
        Mon, 20 Mar 2023 22:35:30 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tLxfaqPRw7I4; Mon, 20 Mar 2023 22:35:28 +0200 (EET)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1679344528; bh=WSkN0ZZK6/27eS+cWv7kIvWxbi85TDSr0hkiRngacrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i4J1qBnHV/8QMhVVNv+tnfYDl4MISC2dq6Jk1H6YB38pe/Ub5qsvS5QyK12mG7Qt6
         eoGRRObhCCkyee/8nsXkutuOQtUkTi1YPcEWZOzm2V07LNERW4iTDUSdZFXZ42q4Kc
         NiIbGkVnbKHTNsUUegv38VN1fK1BvE7JKIwMwo6o=
To:     Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Marian Postevca <posteuca@mutex.one>
Subject: [PATCH 4/4] ASoC: amd: acp: Improve support for speaker power events
Date:   Mon, 20 Mar 2023 22:35:19 +0200
Message-Id: <20230320203519.20137-5-posteuca@mutex.one>
In-Reply-To: <20230320203519.20137-1-posteuca@mutex.one>
References: <20230320203519.20137-1-posteuca@mutex.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to reduce the audible pops when speaker or headphones
are activated or disabled we need to delay the switching of the
GPIOs.
We need to also disable/enable the speaker/headphones GPIOs when
the audio stream is stopped/started. To avoid race conditions
between the speaker power event callback and the trigger callback
we use a ring buffer to save the events that we need to process
in the delayed work callback.

Signed-off-by: Marian Postevca <posteuca@mutex.one>
---
 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c | 154 +++++++++++++++++-
 1 file changed, 149 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c b/sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c
index 138a7c12669b..033c94e91928 100644
--- a/sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c
+++ b/sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c
@@ -20,8 +20,18 @@
 #include <linux/io.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
+#include <linux/circ_buf.h>
+
 #include "../acp-mach.h"
 
+#define RB_SIZE         32
+
+#define circ_count(circ)	  \
+	(CIRC_CNT((circ)->head, (circ)->tail, RB_SIZE))
+
+#define circ_space(circ)	  \
+	(CIRC_SPACE((circ)->head, (circ)->tail, RB_SIZE))
+
 #define get_mach_priv(card) ((struct acp3x_es83xx_private *)((acp_get_drvdata(card))->mach_priv))
 
 /* mclk-div-by-2 + terminating entry */
@@ -32,14 +42,35 @@
 #define ES83XX_ENABLE_DMIC	BIT(4)
 #define ES83XX_48_MHZ_MCLK	BIT(5)
 
+enum {
+	SPEAKER_ON = 0,
+	SPEAKER_OFF,
+	SPEAKER_SUSPEND,
+	SPEAKER_RESUME,
+	SPEAKER_MAX
+};
+
+const char *msg[SPEAKER_MAX] = {
+	"SPEAKER_ON",
+	"SPEAKER_OFF",
+	"SPEAKER_SUSPEND",
+	"SPEAKER_RESUME"
+};
+
 struct acp3x_es83xx_private {
 	unsigned long quirk;
+	bool speaker_on;
+	bool stream_suspended;
 	struct snd_soc_component *codec;
 	struct device *codec_dev;
 	struct gpio_desc *gpio_speakers, *gpio_headphone;
 	struct acpi_gpio_params enable_spk_gpio, enable_hp_gpio;
 	struct acpi_gpio_mapping gpio_mapping[3];
 	struct snd_soc_dapm_route mic_map[2];
+	struct delayed_work jack_work;
+	struct mutex rb_lock;
+	struct circ_buf gpio_rb;
+	u8 gpio_events_buf[RB_SIZE];
 };
 
 static const unsigned int rates[] = {
@@ -86,6 +117,107 @@ static void acp3x_es83xx_set_gpios_values(struct acp3x_es83xx_private *priv,
 	gpiod_set_value_cansleep(priv->gpio_headphone, headphone);
 }
 
+static void acp3x_es83xx_rb_insert_evt(struct circ_buf *rb, u8 val)
+{
+	u8 *buf = rb->buf;
+
+	if (circ_space(rb) == 0) {
+		/* make some space by dropping the oldest entry, we are more
+		 * interested in the last event
+		 */
+		rb->tail = (rb->tail + 1) & (RB_SIZE - 1);
+	}
+	buf[rb->head] = val;
+	rb->head = (rb->head + 1) & (RB_SIZE - 1);
+}
+
+static int acp3x_es83xx_rb_remove_evt(struct circ_buf *rb)
+{
+	u8 *buf = rb->buf;
+	int rc = -1;
+
+	if (circ_count(rb)) {
+		rc = buf[rb->tail];
+		rb->tail = (rb->tail + 1) & (RB_SIZE - 1);
+	}
+	return rc;
+}
+
+static void acp3x_es83xx_jack_events(struct work_struct *work)
+{
+	struct acp3x_es83xx_private *priv =
+		container_of(work, struct acp3x_es83xx_private, jack_work.work);
+	int evt;
+
+	mutex_lock(&priv->rb_lock);
+	do {
+		evt = acp3x_es83xx_rb_remove_evt(&priv->gpio_rb);
+		dev_dbg(priv->codec_dev, "jack event, %s\n", msg[evt]);
+		switch (evt) {
+		case SPEAKER_SUSPEND:
+			acp3x_es83xx_set_gpios_values(priv, 0, 0);
+			break;
+		case SPEAKER_RESUME:
+			acp3x_es83xx_set_gpios_values(priv, priv->speaker_on, !priv->speaker_on);
+			break;
+		case SPEAKER_ON:
+			priv->speaker_on = true;
+			acp3x_es83xx_set_gpios_values(priv, 1, 0);
+			break;
+		case SPEAKER_OFF:
+			priv->speaker_on = false;
+			acp3x_es83xx_set_gpios_values(priv, 0, 1);
+			break;
+		}
+	} while (evt != -1);
+	mutex_unlock(&priv->rb_lock);
+}
+
+static int acp3x_es83xx_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_card *card = rtd->card;
+	struct acp3x_es83xx_private *priv = get_mach_priv(card);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		if (substream->stream == 0) {
+			dev_dbg(priv->codec_dev, "trigger start/release/resume, activating GPIOs\n");
+			mutex_lock(&priv->rb_lock);
+			if (priv->stream_suspended) {
+				priv->stream_suspended = false;
+				acp3x_es83xx_rb_insert_evt(&priv->gpio_rb, SPEAKER_RESUME);
+				mutex_unlock(&priv->rb_lock);
+				queue_delayed_work(system_wq, &priv->jack_work,
+						   msecs_to_jiffies(1));
+			} else {
+				mutex_unlock(&priv->rb_lock);
+			}
+		}
+
+		break;
+
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_STOP:
+		if (substream->stream == 0) {
+			dev_dbg(priv->codec_dev, "trigger pause/suspend/stop deactivating GPIOs\n");
+			mutex_lock(&priv->rb_lock);
+			priv->stream_suspended = true;
+			acp3x_es83xx_rb_insert_evt(&priv->gpio_rb, SPEAKER_SUSPEND);
+			mutex_unlock(&priv->rb_lock);
+			queue_delayed_work(system_wq, &priv->jack_work, msecs_to_jiffies(1));
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int acp3x_es83xx_create_swnode(struct device *codec_dev)
 {
 	struct property_entry props[MAX_NO_PROPS] = {};
@@ -212,12 +344,17 @@ static int acp3x_es83xx_speaker_power_event(struct snd_soc_dapm_widget *w,
 					    struct snd_kcontrol *kcontrol, int event)
 {
 	struct acp3x_es83xx_private *priv = get_mach_priv(w->dapm->card);
+	u8 val;
+
+	val = SND_SOC_DAPM_EVENT_ON(event) ? SPEAKER_ON : SPEAKER_OFF;
 
-	dev_dbg(priv->codec_dev, "speaker power event: %d\n", event);
-	if (SND_SOC_DAPM_EVENT_ON(event))
-		acp3x_es83xx_set_gpios_values(priv, 1, 0);
-	else
-		acp3x_es83xx_set_gpios_values(priv, 0, 1);
+	dev_dbg(priv->codec_dev, "speaker power event = %s\n", msg[val]);
+
+	mutex_lock(&priv->rb_lock);
+	acp3x_es83xx_rb_insert_evt(&priv->gpio_rb, val);
+	mutex_unlock(&priv->rb_lock);
+
+	queue_delayed_work(system_wq, &priv->jack_work, msecs_to_jiffies(70));
 
 	return 0;
 }
@@ -353,6 +490,7 @@ static int acp3x_es83xx_init(struct snd_soc_pcm_runtime *runtime)
 
 static const struct snd_soc_ops acp3x_es83xx_ops = {
 	.startup = acp3x_es83xx_codec_startup,
+	.trigger = acp3x_es83xx_trigger,
 };
 
 
@@ -452,6 +590,12 @@ static int acp3x_es83xx_probe(struct snd_soc_card *card)
 		priv->codec_dev = codec_dev;
 		priv->quirk = (unsigned long)dmi_id->driver_data;
 		acp_drvdata->mach_priv = priv;
+
+		priv->gpio_rb.buf = priv->gpio_events_buf;
+		priv->gpio_rb.head = priv->gpio_rb.tail = 0;
+		mutex_init(&priv->rb_lock);
+
+		INIT_DELAYED_WORK(&priv->jack_work, acp3x_es83xx_jack_events);
 		dev_info(dev, "successfully probed the sound card\n");
 	} else {
 		ret = -ENODEV;
-- 
2.39.1

