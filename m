Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C8A64C92B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbiLNMjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbiLNMj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:39:26 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8CB21E00
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:38:08 -0800 (PST)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 28B5E85165;
        Wed, 14 Dec 2022 13:38:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1671021486;
        bh=6Jupxi3YTw8zb2A9Zvbmvr72UlqBukNaZRCAsj7GqjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o5UgHlc7BdfCg9o2XR7gT44W6Ksgs3OtjVtv8ynu0m10B2QzPRU+PC/kEWRkvFPfP
         acl5roqWq/GsUSGan5B3XwKx/OYt2Pt7chpee0qctOneZIh2EKdT+8t3H0H3cIIbfj
         25DbmW865Sa3PAJ0S+ZrifUDk0UBtKfpQpMuY6+Dw277FYYfsYVpyqohBIR2f9CNsY
         MGUkEtxm5m/RVsyl4t9dyespT3Zmwpcur3weMXvUgq9H6DbcZs0hwVb/zKcYtK+WdD
         JEob0lISivpColvXh/iz+g3tB/r/AOcxp82bZgDE+fL9AJQsqO0bQe6xNT3fMlgCd1
         p0QRaC44qiFAA==
From:   Lukasz Majewski <lukma@denx.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Stephen Kitt <steve@sk2.org>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 3/4] ASoC: wm8940: Mute also the speaker output
Date:   Wed, 14 Dec 2022 13:37:42 +0100
Message-Id: <20221214123743.3713843-4-lukma@denx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221214123743.3713843-1-lukma@denx.de>
References: <20221214123743.3713843-1-lukma@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this change the BTL speaker produces some
"distortion" noise when test program
(speaker-test -t waw) is ended with ctrl+c.

As our design uses speaker outputs to drive BTL speaker,
it was necessary to also mute the speaker via the codec
internal WM8940_SPKVOL register with setting
WM8940_SPKMUTE bit.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 sound/soc/codecs/wm8940.c | 11 ++++++++++-
 sound/soc/codecs/wm8940.h |  3 +++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index 094e74905df9..13cb57210b4b 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -465,9 +465,18 @@ static int wm8940_mute(struct snd_soc_dai *dai, int mute, int direction)
 {
 	struct snd_soc_component *component = dai->component;
 	u16 mute_reg = snd_soc_component_read(component, WM8940_DAC) & 0xffbf;
+	u16 spkvol_reg = snd_soc_component_read(component, WM8940_SPKVOL);
+	int ret;
 
-	if (mute)
+	spkvol_reg &= ~WM8940_SPKMUTE;
+	if (mute) {
 		mute_reg |= 0x40;
+		spkvol_reg |= WM8940_SPKMUTE;
+	}
+
+	ret = snd_soc_component_write(component, WM8940_SPKVOL, spkvol_reg);
+	if (ret)
+		return ret;
 
 	return snd_soc_component_write(component, WM8940_DAC, mute_reg);
 }
diff --git a/sound/soc/codecs/wm8940.h b/sound/soc/codecs/wm8940.h
index 0d4f53ada2e6..eb051ed29bb8 100644
--- a/sound/soc/codecs/wm8940.h
+++ b/sound/soc/codecs/wm8940.h
@@ -95,5 +95,8 @@ struct wm8940_setup_data {
 #define WM8940_OPCLKDIV_3 2
 #define WM8940_OPCLKDIV_4 3
 
+/* Bit definitions */
+#define WM8940_SPKMUTE BIT(6)
+
 #endif /* _WM8940_H */
 
-- 
2.20.1

