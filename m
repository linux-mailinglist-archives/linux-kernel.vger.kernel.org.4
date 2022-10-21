Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B72360719C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJUIDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiJUIDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:03:11 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07788249D20;
        Fri, 21 Oct 2022 01:03:10 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id bs14so2617559ljb.9;
        Fri, 21 Oct 2022 01:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eut+q0KfsYmTJrRf2CkFUmnxmAlkH/IplJp4TkrJndA=;
        b=O86H85ID2TK1WkMsHY3glNLuQzqtZD2fE3vxLXsfaR++Bs+JvGdF98SSyXEmeT3wD8
         2cRBk/4NeeOdoY53GSorJhNd6vCv+BKlTIkpiaLdKVK5Dq1SMn/Wzr1YxQvYi5lf6JoQ
         8fPcYjM0MstDhaNcHpGtVykDAklE2+P57T5S5JsVi4t32iTTwlf2PLeHf3RQ61588LYG
         CpOfy478cTkv+LzdtVzqrSCMVgbOF5VGqDMy8kXW6Ze/PdyoNP4ZEjeoLS/RvS+/7HXs
         vHzRWLtgpUi+FD4eqTV3Xy/9aSUi4ESACAz4eLz/QvaBzDjdOG9KhMMpyk9RxlC7KunW
         FM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eut+q0KfsYmTJrRf2CkFUmnxmAlkH/IplJp4TkrJndA=;
        b=H4grWPYrvs1y9FMlua9hZHhSut+iCh6wayLtfsCZsXw0Fl5+xWhnce7/yflx0LbT86
         3703p9YIxDaGh/E+YyYIlHzAGKVwu4G3ZdwOJ4NkuF2oJ5lZIo9wAc0IZgidSPVXMcef
         QS4Ag7p9VSl2k6CEEoiJQbftLZQuQFLJp2Lffp6wfPoG8k0fumN4ws0AIZvQDelegchM
         aSZutf3JtSj9LmUNjqymm0fECqum5/0PTqI7uyOhuaOQjC4aohSOCAZgTZurMbSBgPMh
         rqYeAkyT8uuo1orqPA8K3pJiyrvaY6NsxeMz420pjeTYHOYOnSdZ3HbNIelVicDZ8sMi
         YeHg==
X-Gm-Message-State: ACrzQf0x4VevrxF2uTQDadmdQ7PDFlrIwDkLPAaLOJeNtQC7GBiePJPB
        gh9vW3MF+XLZiFfkgIDq3BphM5G/9oO3NA==
X-Google-Smtp-Source: AMsMyM4z1qpSgLAFD+7+G/GqFnHixVFPB1iFZ9ePaHc+ynujqVOZSna6EoyivBspQsH+ExjB7H0tMw==
X-Received: by 2002:a2e:bf16:0:b0:26d:8eb4:609b with SMTP id c22-20020a2ebf16000000b0026d8eb4609bmr6182391ljr.124.1666339388228;
        Fri, 21 Oct 2022 01:03:08 -0700 (PDT)
Received: from localhost.localdomain (host-185-69-38-8.kaisa-laajakaista.fi. [185.69.38.8])
        by smtp.gmail.com with ESMTPSA id e11-20020a05651236cb00b00497aae401edsm3060720lfs.109.2022.10.21.01.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 01:03:07 -0700 (PDT)
From:   Peter Ujfalusi <peter.ujfalusi@gmail.com>
To:     tony@atomide.com, lee.jones@linaro.org
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mfd: twl4030-audio: Drop legacy, non DT boot support
Date:   Fri, 21 Oct 2022 11:12:18 +0300
Message-Id: <20221021081218.2654-1-peter.ujfalusi@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Legacy or non DT boot is no longer possible on systems where the
tw4030/5030 is used.

Drop the support for handling legacy pdata.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---
Hi,

Changes since v1:
- the node NULL check is dropped from the probe as it is redundant

Regards,
Peter

 drivers/mfd/twl4030-audio.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/mfd/twl4030-audio.c b/drivers/mfd/twl4030-audio.c
index 4536d829b43e..02865100b44d 100644
--- a/drivers/mfd/twl4030-audio.c
+++ b/drivers/mfd/twl4030-audio.c
@@ -144,14 +144,10 @@ unsigned int twl4030_audio_get_mclk(void)
 }
 EXPORT_SYMBOL_GPL(twl4030_audio_get_mclk);
 
-static bool twl4030_audio_has_codec(struct twl4030_audio_data *pdata,
-			      struct device_node *parent)
+static bool twl4030_audio_has_codec(struct device_node *parent)
 {
 	struct device_node *node;
 
-	if (pdata && pdata->codec)
-		return true;
-
 	node = of_get_child_by_name(parent, "codec");
 	if (node) {
 		of_node_put(node);
@@ -161,14 +157,10 @@ static bool twl4030_audio_has_codec(struct twl4030_audio_data *pdata,
 	return false;
 }
 
-static bool twl4030_audio_has_vibra(struct twl4030_audio_data *pdata,
-			      struct device_node *node)
+static bool twl4030_audio_has_vibra(struct device_node *node)
 {
 	int vibra;
 
-	if (pdata && pdata->vibra)
-		return true;
-
 	if (!of_property_read_u32(node, "ti,enable-vibra", &vibra) && vibra)
 		return true;
 
@@ -178,17 +170,11 @@ static bool twl4030_audio_has_vibra(struct twl4030_audio_data *pdata,
 static int twl4030_audio_probe(struct platform_device *pdev)
 {
 	struct twl4030_audio *audio;
-	struct twl4030_audio_data *pdata = dev_get_platdata(&pdev->dev);
 	struct device_node *node = pdev->dev.of_node;
 	struct mfd_cell *cell = NULL;
 	int ret, childs = 0;
 	u8 val;
 
-	if (!pdata && !node) {
-		dev_err(&pdev->dev, "Platform data is missing\n");
-		return -EINVAL;
-	}
-
 	audio = devm_kzalloc(&pdev->dev, sizeof(struct twl4030_audio),
 			     GFP_KERNEL);
 	if (!audio)
@@ -222,22 +208,14 @@ static int twl4030_audio_probe(struct platform_device *pdev)
 	audio->resource[TWL4030_AUDIO_RES_APLL].reg = TWL4030_REG_APLL_CTL;
 	audio->resource[TWL4030_AUDIO_RES_APLL].mask = TWL4030_APLL_EN;
 
-	if (twl4030_audio_has_codec(pdata, node)) {
+	if (twl4030_audio_has_codec(node)) {
 		cell = &audio->cells[childs];
 		cell->name = "twl4030-codec";
-		if (pdata) {
-			cell->platform_data = pdata->codec;
-			cell->pdata_size = sizeof(*pdata->codec);
-		}
 		childs++;
 	}
-	if (twl4030_audio_has_vibra(pdata, node)) {
+	if (twl4030_audio_has_vibra(node)) {
 		cell = &audio->cells[childs];
 		cell->name = "twl4030-vibra";
-		if (pdata) {
-			cell->platform_data = pdata->vibra;
-			cell->pdata_size = sizeof(*pdata->vibra);
-		}
 		childs++;
 	}
 
-- 
2.38.1

