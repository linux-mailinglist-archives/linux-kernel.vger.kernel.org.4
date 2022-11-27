Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF919639CB3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 21:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiK0UEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 15:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiK0UEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 15:04:45 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4055E0E
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:04:44 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id e27so21221922ejc.12
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+PQ8C4HY8GI4Ih4606HRpgDC5j1lzCXOLCR0j10k4og=;
        b=U7ppHaFyl2uoDpwagB2uxHAl3qXc867gSP+EYCeh+Ekig4WP0Bj22uBXpJjS8d8vEE
         LfkOFhLIy9pJy18/nyFhYljoO5jFByJETKBHVuWQFPnFRy774YGv7VpFp+RRKYcrp1if
         819lzsJqo5p6Lm3XpekIHPbmMZ0zCSiwwxfNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+PQ8C4HY8GI4Ih4606HRpgDC5j1lzCXOLCR0j10k4og=;
        b=4+X+qlNu+WA4S952orNgqWCnhRank3PkTzFIjBz9X+Jv69Ih1jSBlDUfQh3jtHHAeD
         IzQH/RwQYQYBAFbKq4XBKepdpxSehT/UjPltGpgxmVSOpIyJamDsL13LLtkCCbHUjb85
         e7yoxn4cqgZPbc2MH89LaYM+Exu5oUY2iw76AXp+YQN2nrWh73mOccT/JrmNNF93bRYN
         iZfFbtepuBcRivoxzUIEnrAo7pTe/DvJ3a82eN+8LpJ+Y6P+rxqI2TTu2Y8gZ8xTtqLs
         kepsJ6UccMbrey3eT2ox4/I60QldRrZ1Q9B8yLB0rpsGNt7uKUbN4FHIqnH56+VTgIE8
         k7rQ==
X-Gm-Message-State: ANoB5plLj4rb7KcyTbkow9fNw6amn6KjPryrnEFtMREsSrQjV/y5BrLK
        2YmemHeMlQR3rTW7w5K05SSwDVVrYvW04Q==
X-Google-Smtp-Source: AA0mqf42mS5Gm+YoLaWqTwXnCwIMBQWeQRJjTw5H5MATSu9YOsyjAoJB9z+d52K7UVjI1cU0rqhGNg==
X-Received: by 2002:a17:907:2c45:b0:7b8:bbbe:5ca with SMTP id hf5-20020a1709072c4500b007b8bbbe05camr23250340ejc.544.1669579483314;
        Sun, 27 Nov 2022 12:04:43 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id y5-20020aa7ccc5000000b0045b3853c4b7sm4365211edt.51.2022.11.27.12.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 12:04:42 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Sun, 27 Nov 2022 21:04:15 +0100
Subject: [PATCH] ASoC: SOF: mediatek: add shutdown callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221127-mtk-snd-v1-0-b7886faa612b@chromium.org>
To:     Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        alsa-devel@alsa-project.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2277; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=s1hlyXlFMcsbbpy4qR3m3W7fS0UNSJO46JANbYHIp7k=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjg8LGMFtVpE68zXEwJMlnmGcwIe5eTlR8bzX79ra4
 AxIafBCJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4PCxgAKCRDRN9E+zzrEiFtXEA
 Cf5Sg6YXeWg5yplb+YZwdBmNJiO11ksXUZ3IaGKVDn17qaPvhSLMD/2JjzzMLAh20rsOEke/qO/fjK
 341aMOWWArQ0zVwVdBdnDuC6xqfzdUJbH3DxKiElpYI9Zi6R2v6T8U+CRLhVLl6pWc917giiYK1AUI
 cuxoIhteEClZYg+9lIehzMJszaHDDPY6upPC1Dc2sOmHh1zfjqHB1vZAqMc0qXW8rsRUQMmkhvShs/
 kV+AtdLGWzdvE0jx8KN0XtUWIcwQg5O2EdN0xYbE4AkKaXCskBhKanLbblN6ajBDnh/qKb+6vwsWiB
 UBT2+KVYWh22KI3ry5+hx4O7KNixHflRtNZ8+67TmFEizc9EC+m5TGT98ek84Gr99KZo9YSXAom571
 QuAJ7RMaEcFmUJWo5lwZM0rRnAxaLp4UmA8QgpR0CqPDsA3VDMWmRVoYb0hNFBRPXAgPPju9S4wnWJ
 ma9Eug+OfJBSaJrVzFX7QUJC3h2XL2AeddGWR8ztI3d2gK/PNHMzbR35taHoM+E1nHOz3SnsWzB/N3
 eTYnx1sAnYNbNHqko7qj3c4CF2yp6J2emRGKTw9XnsAfrqXtNMJd8+eqBsV1pCMM6n9vP2X0Y0LAnV
 ooib9iObWJi/rL13BKkBNmNtEWN0VmDYGopctoP8eP79KJxn6iNehmddVjrw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we do not shutdown the peripheral properly at shutdown, the whole system
crashes after kexec() on the first io access.

Let's implement the appropriate callback.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: Liam Girdwood <lgirdwood@gmail.com>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: Daniel Baluta <daniel.baluta@nxp.com>
To: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
To: Takashi Iwai <tiwai@suse.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: sound-open-firmware@alsa-project.org
Cc: alsa-devel@alsa-project.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/sof/mediatek/mt8186/mt8186.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/sof/mediatek/mt8186/mt8186.c b/sound/soc/sof/mediatek/mt8186/mt8186.c
index 181189e00e02..79da25725987 100644
--- a/sound/soc/sof/mediatek/mt8186/mt8186.c
+++ b/sound/soc/sof/mediatek/mt8186/mt8186.c
@@ -430,6 +430,11 @@ static int mt8186_dsp_remove(struct snd_sof_dev *sdev)
 	return 0;
 }
 
+static int mt8186_dsp_shutdown(struct snd_sof_dev *sdev)
+{
+	return snd_sof_suspend(sdev->dev);
+}
+
 static int mt8186_dsp_suspend(struct snd_sof_dev *sdev, u32 target_state)
 {
 	mt8186_sof_hifixdsp_shutdown(sdev);
@@ -538,6 +543,7 @@ static struct snd_sof_dsp_ops sof_mt8186_ops = {
 	/* probe and remove */
 	.probe		= mt8186_dsp_probe,
 	.remove		= mt8186_dsp_remove,
+	.shutdown	= mt8186_dsp_shutdown,
 
 	/* DSP core boot */
 	.run		= mt8186_run,
@@ -629,6 +635,7 @@ MODULE_DEVICE_TABLE(of, sof_of_mt8186_ids);
 static struct platform_driver snd_sof_of_mt8186_driver = {
 	.probe = sof_of_probe,
 	.remove = sof_of_remove,
+	.shutdown = sof_of_shutdown,
 	.driver = {
 	.name = "sof-audio-of-mt8186",
 		.pm = &sof_of_pm,

---
base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
change-id: 20221127-mtk-snd-e0abf36be4c0

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
