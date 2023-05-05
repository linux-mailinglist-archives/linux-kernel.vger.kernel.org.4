Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886CB6F871A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 18:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjEEQzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 12:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjEEQz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 12:55:29 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D46E1990C
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 09:55:28 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3077d134028so668153f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 09:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683305726; x=1685897726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aF6c8vCGTR2QK7g+acfgalvT960Ey/zX9u4pUO/YPk4=;
        b=euW9BAvFE3t8iXyBsk24WqybtXMz1hn3/8p/p/SMWqG4ZV999cMBeAtF0afO96udkc
         hVHkCRO060nJyTif0EyCHr/FIioeqMhH15kXHq6m9gg/aW9nHWW+JjBgx/n/irJFyeNN
         RKrZaFDs+/5AbGQr6mKXRT0Z5OMw4Zr1jNERuUMH1OPOR9ojXB1+Sm6mzCi+bUyatuRs
         EPf0tthaARk1SxWI8TGPler1LKwustDq+QSfiN1fttlsMvqNMb6tzxQji395ttDYRqr9
         5XOHQmWffE/Z8qnOCD/wNOawcOR1jJexdSnHTd0UGMxsPjZ4ZMa0r0bj0Ahbt5Nd836w
         G4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683305726; x=1685897726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aF6c8vCGTR2QK7g+acfgalvT960Ey/zX9u4pUO/YPk4=;
        b=CC3uFfZIeuOFEt7BM+Y58RRk+eX8vjzm2HIhUqvHIAAc6L2V7N+oKCkwYfDaUggeiO
         fPSCiQjfQt9uHhyv6JJ1RrDt4jqXG8NFEX7OE7Aw13RviDc5s2hefwzSQF+N5rBao9Zc
         Gira6L0dm2yXZNTiKchGinV4BgCBWNmOWEMCtvSmkMe22Up89SsOh1TIl1vJtrA4SgSs
         XtAzNoVcriLNcMAaydJ/Qty7OtTp6rGYeVpgVdB8StkrlONTKpNbEa2ciePOVrh9Vn4t
         URp/DagMBbHGP9psC0LxwPbCH2yW5jzk6hPjR6P0XCyD1UDJYp1DuvlysrChabKw6ATw
         8g9w==
X-Gm-Message-State: AC+VfDyCq2z8SBkF+CcN5B1354e2/3RzfI3yFGoyznouPz9eVhKLIjnr
        3DKw5yNeiAyV3OasZWSzsGgdeg==
X-Google-Smtp-Source: ACHHUZ4ZlBcgwrnBXnaGvQz3fDW5M2lcW+c3h6TrPi1wm2tp5F2+pVpr65y2y9ab/41UtPIf0A16/Q==
X-Received: by 2002:a5d:48cc:0:b0:304:adbe:ea9d with SMTP id p12-20020a5d48cc000000b00304adbeea9dmr2018714wrs.30.1683305726481;
        Fri, 05 May 2023 09:55:26 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id x7-20020adfffc7000000b002c7066a6f77sm2923551wrs.31.2023.05.05.09.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 09:55:25 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, tiwai@suse.com
Cc:     perex@perex.cz, lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/3] ALSA: pcm: add snd_pcm_add_chmap_ctls_with_prefix
Date:   Fri,  5 May 2023 17:55:12 +0100
Message-Id: <20230505165514.4666-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230505165514.4666-1-srinivas.kandagatla@linaro.org>
References: <20230505165514.4666-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Qualcomm SoC which has multiple Display Port controllers, using
snd_pcm_add_chmap_ctls() to add chmap controls from every ASoC hdmi codec
instance for a give card fails while adding second instance as the control
with same name "Playback Channel Map" already exists from the first instance.

Fix this by adding a new api wrapper to pass ASoC component name prefix to
avoid such duplicate control naming.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
We can also make snd_pcm_add_chmap_ctls to take prefix argument and avoid adding
this new api, but that would touch lots of drivers.


 include/sound/pcm.h  |  7 +++++++
 sound/core/pcm_lib.c | 30 ++++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 27040b472a4f..39efd25b53e3 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1528,6 +1528,13 @@ int snd_pcm_add_chmap_ctls(struct snd_pcm *pcm, int stream,
 			   unsigned long private_value,
 			   struct snd_pcm_chmap **info_ret);
 
+int snd_pcm_add_chmap_ctls_with_prefix(struct snd_pcm *pcm, int stream,
+				       const struct snd_pcm_chmap_elem *chmap,
+				       int max_channels,
+				       unsigned long private_value,
+				       struct snd_pcm_chmap **info_ret,
+				       const char *prefix);
+
 /**
  * pcm_format_to_bits - Strong-typed conversion of pcm_format to bitwise
  * @pcm_format: PCM format
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 8b6aeb8a78f7..ed75dd007425 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2483,11 +2483,12 @@ static void pcm_chmap_ctl_private_free(struct snd_kcontrol *kcontrol)
  * Create channel-mapping control elements assigned to the given PCM stream(s).
  * Return: Zero if successful, or a negative error value.
  */
-int snd_pcm_add_chmap_ctls(struct snd_pcm *pcm, int stream,
+int snd_pcm_add_chmap_ctls_with_prefix(struct snd_pcm *pcm, int stream,
 			   const struct snd_pcm_chmap_elem *chmap,
 			   int max_channels,
 			   unsigned long private_value,
-			   struct snd_pcm_chmap **info_ret)
+			   struct snd_pcm_chmap **info_ret,
+			   const char *prefix)
 {
 	struct snd_pcm_chmap *info;
 	struct snd_kcontrol_new knew = {
@@ -2499,6 +2500,7 @@ int snd_pcm_add_chmap_ctls(struct snd_pcm *pcm, int stream,
 		.get = pcm_chmap_ctl_get,
 		.tlv.c = pcm_chmap_ctl_tlv,
 	};
+	char *name = NULL;
 	int err;
 
 	if (WARN_ON(pcm->streams[stream].chmap_kctl))
@@ -2514,10 +2516,21 @@ int snd_pcm_add_chmap_ctls(struct snd_pcm *pcm, int stream,
 		knew.name = "Playback Channel Map";
 	else
 		knew.name = "Capture Channel Map";
+
+	if (prefix) {
+		name = kasprintf(GFP_KERNEL, "%s %s", prefix, knew.name);
+		if (!name) {
+			kfree(info);
+			return -ENOMEM;
+		}
+		knew.name = name;
+	}
+
 	knew.device = pcm->device;
 	knew.count = pcm->streams[stream].substream_count;
 	knew.private_value = private_value;
 	info->kctl = snd_ctl_new1(&knew, info);
+	kfree(name);
 	if (!info->kctl) {
 		kfree(info);
 		return -ENOMEM;
@@ -2530,5 +2543,18 @@ int snd_pcm_add_chmap_ctls(struct snd_pcm *pcm, int stream,
 	if (info_ret)
 		*info_ret = info;
 	return 0;
+
+}
+EXPORT_SYMBOL_GPL(snd_pcm_add_chmap_ctls_with_prefix);
+
+int snd_pcm_add_chmap_ctls(struct snd_pcm *pcm, int stream,
+			   const struct snd_pcm_chmap_elem *chmap,
+			   int max_channels,
+			   unsigned long private_value,
+			   struct snd_pcm_chmap **info_ret)
+{
+	return snd_pcm_add_chmap_ctls_with_prefix(pcm, stream, chmap,
+						  max_channels, private_value,
+						  info_ret, NULL);
 }
 EXPORT_SYMBOL_GPL(snd_pcm_add_chmap_ctls);
-- 
2.21.0

