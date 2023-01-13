Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EF666983F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241346AbjAMNRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241827AbjAMNQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:16:06 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1474E6A0EC
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:06:40 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230113130638epoutp03875447c288e013a38b3039d45a9353c7~54CfuTBSz3012530125epoutp03t
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:06:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230113130638epoutp03875447c288e013a38b3039d45a9353c7~54CfuTBSz3012530125epoutp03t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673615198;
        bh=sBSRBzG0AQsIk4/QpJhOfNlFsSkR8zqwfdpCy/Qu8/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QENJE6tJFPXKGmEFq0H0dlD3FoVxHBy6FDw/TlDxo6fMX7mEXRvJWoFaww4rqGpij
         5CP12bm3zkyiFdaIMnSigYcHCOVzqOHbqpoETTN7A3yr6XuqXY81eGURn7etP5q09B
         DtAbhJ7mJlNNu8+PqDm0YeG+HHEzO8Ej/c0vLtCk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230113130638epcas5p38d2c4653c6e7f8729eac4caa2ca99d6e~54CfMgBUq2978829788epcas5p3r;
        Fri, 13 Jan 2023 13:06:38 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NthWc3lqNz4x9Pr; Fri, 13 Jan
        2023 13:06:36 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.A9.02301.C5751C36; Fri, 13 Jan 2023 22:06:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230113121821epcas5p4ebd116d75f12dafeb09391eb6f7a2646~53YV20UKO1715317153epcas5p4i;
        Fri, 13 Jan 2023 12:18:21 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230113121821epsmtrp225b0ae2eddb4bdc30719db3424617acc~53YV0o8UZ1441514415epsmtrp2g;
        Fri, 13 Jan 2023 12:18:21 +0000 (GMT)
X-AuditID: b6c32a49-201ff700000108fd-9b-63c1575c5439
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.65.10542.D0C41C36; Fri, 13 Jan 2023 21:18:21 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230113121818epsmtip2961cb8d899e26a39bab35f9968104f19~53YTI7ade0625706257epsmtip2g;
        Fri, 13 Jan 2023 12:18:18 +0000 (GMT)
From:   Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH v3 2/5] ASoC: samsung: i2s: add support for FSD I2S
Date:   Fri, 13 Jan 2023 17:47:46 +0530
Message-Id: <20230113121749.4657-3-p.rajanbabu@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230113121749.4657-1-p.rajanbabu@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSf0xbVRTHve+1r4+56rNs2V0RRpphAgmllbY8GGziiD4yTTAoM2wR38q1
        JZS2awsDs+lExwYMujLQ2VR+iEzHwkqhZVB+yMoGIokTV4YuEGlCjFkGAxmdyTZnf4D+97nn
        fM/Pe0hcYCWEZJHWhAxaViMitnD6xuLjEw8fvKaU1Duj6IXmPoL2Tnsw2tPr4tFNvkWCbrn+
        E5eu/9OH037vGYy+5bYR9IWbIxh9w5FLf+16wKOr3WYubf25n0ufGr7Oo8funebS3Q+7wCsU
        071WSTAD1nke09NZTTBzt4cIZmTpIsHUOzsBY3fOcJi1npgcMr84XY3YQmSIRVqlrrBIq8oQ
        Hcgt2F8gV0ikidJUOkUUq2VLUIYo642cxNeKNIEJRLFlrKY0YMphjUZR0t50g67UhGLVOqMp
        Q4T0hRq9TC82siXGUq1KrEWmNKlE8rI8IHy/WN1lWQT687vL+zrWeSfBUnQNiCAhJYO+v+9w
        a8AWUkANAtjT9JAXdAiovwAc+q0k7FgD0Gl2cDcjvrlYxw2L3AB66zRh0SkMNt++TwQdBCWH
        nbZPQmm3UZUYrLpn4QQfOOUAcGrchwVVkdR+uLT8AA8yh4qDk+sLoWg+tQfeb3jMCZfbBS93
        jwY0JBlBpcOOiVBLkOog4dk270ZLWfCp93demCPh3QnnBgvh2vIwEWYd/Hz10w0uh1Wr3ViY
        98FRr40TzI9T8dDuTgqbo2HTj1dCEpx6DtY9WtyQ82F/8ybHQfu3PSDMUXBkdhgE00CKgecf
        C8NLMQN4y+fBzoEY6/8VWgHoBDuR3liiQka5XqpFx/77NKWupAeEjjQhux/ML6yIPQAjgQdA
        Ehdt4w/d+F4p4BeyFR8ig67AUKpBRg+QB9ZnwYXblbrAlWtNBVJZqkSmUChkqckKqWgHH7la
        lAJKxZpQMUJ6ZNiMw8gI4Uks79f2qDEk6PugqjYmaQXtKDPNrHdMj+tHaxm9beu5tOTsM02t
        MWNZg21kypzbknntWdv07FfjJyJezS+P031nZhcZObz0VkNCSuJWXnt9y0fuWn/BHylmzlLm
        8SPRR80ThxJ6LV3pF/b6X7SvbCcG9vB60+wVX+T9cvWf3cTMCXHmOro8UOm/M1oDFbPTU8nS
        05+9+1I12VjLbZ9/WvdD9pTbt0uIP5Pw8U5VRO3k3SN+jobaF8U//II5z3/J1WgtUzZUON5J
        S53L97fe7JKOE0nuY44rjU9yl997E0D1UcNB8dXetyMnX3eJzz6JP/68fOJLD3IPth9YTTnU
        9qijW8QxqllpAm4wsv8CG2Nfny0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSvC6vz8Fkgy8d2hYP5m1js7hy8RCT
        xaHNW9ktpj58wmYx/8g5Vou+Fw+ZLb5d6WCyuLxrDpvFjPP7mCyObgy2WLT1C7tF565+VotZ
        F3awWrTuPcJucfhNO6vFhu9rGR0EPDZ8bmLz2DnrLrvHplWdbB53ru1h89j3dhmbR9+WVYwe
        67dcZfH4vEkugCOKyyYlNSezLLVI3y6BK2PtxCeMBZNVKrYt/crewPhWtouRk0NCwERiybJe
        1i5GLg4hgR2MEnuXfGaESEhLTO/fwwZhC0us/PecHaKomUmi6epfJpAEm4CpxKo5jWDdIgIT
        mCROvjvGApJgFtjKKDH1sxGILSzgLPH23RdmEJtFQFXi5NcHYFN5Bawl3k/6wwKxQV5i9YYD
        QDUcHJwCNhJLj+eChIWASva+fMw0gZFvASPDKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT8
        3E2M4GDX0trBuGfVB71DjEwcjIcYJTiYlUR49xzdnyzEm5JYWZValB9fVJqTWnyIUZqDRUmc
        90LXyXghgfTEktTs1NSC1CKYLBMHp1QDE+tyfT+mn9Ix63ynHFr/uzTFKDPBfHXzEibLqzbr
        C1f8y/uwh+mj/uVNwZJMmTWMzzS0Ei5LXH22wy5FWiFC8t4do35rHoGdBxmPnj7BcX3GG789
        JpKt9zx73VXuZogdtzSxkg+YeMbi1MYTV6Verq5UEog4pX671PF6/d7anODekzs/B224eIVR
        67xOcPbjRek/P+xw+JfyMnKmzCTX1Zu4b93W+m+eF/217GdudUi20u2DK4wq5j1ZFV4etrzt
        5I51PLlH084WzVj0r+BXodF5noeLjoROm/KZSYslv3/GQos/a9WSb+xcJMWxcafJ8y6JU8ov
        Jy9bluvPdGWRZux5191CGmItfAkvr846eUyJpTgj0VCLuag4EQDrM9Se5QIAAA==
X-CMS-MailID: 20230113121821epcas5p4ebd116d75f12dafeb09391eb6f7a2646
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230113121821epcas5p4ebd116d75f12dafeb09391eb6f7a2646
References: <20230113121749.4657-1-p.rajanbabu@samsung.com>
        <CGME20230113121821epcas5p4ebd116d75f12dafeb09391eb6f7a2646@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for enabling I2S controller on FSD platform.

FSD I2S controller is based on Exynos7 I2S controller, supporting
2CH playback/capture in I2S mode and 7.1CH playback/capture in TDM
mode.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
---
 sound/soc/samsung/i2s-regs.h |  1 +
 sound/soc/samsung/i2s.c      | 53 ++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/sound/soc/samsung/i2s-regs.h b/sound/soc/samsung/i2s-regs.h
index b4b5d6053503..138e95581979 100644
--- a/sound/soc/samsung/i2s-regs.h
+++ b/sound/soc/samsung/i2s-regs.h
@@ -132,6 +132,7 @@
 #define EXYNOS7_MOD_RCLK_192FS	7
 
 #define PSR_PSREN		(1 << 15)
+#define PSR_PSVAL(x)		((((x) - 1) << 8) & 0x3f00)
 
 #define FIC_TX2COUNT(x)		(((x) >>  24) & 0xf)
 #define FIC_TX1COUNT(x)		(((x) >>  16) & 0xf)
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 9505200f3d11..6f96032090de 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -50,6 +50,10 @@ struct samsung_i2s_dai_data {
 	u32 quirks;
 	unsigned int pcm_rates;
 	const struct samsung_i2s_variant_regs *i2s_variant_regs;
+	void (*fixup_early)(struct snd_pcm_substream *substream,
+					struct snd_soc_dai *dai);
+	void (*fixup_late)(struct snd_pcm_substream *substream,
+					struct snd_soc_dai *dai);
 };
 
 struct i2s_dai {
@@ -111,6 +115,10 @@ struct samsung_i2s_priv {
 	u32 suspend_i2spsr;
 
 	const struct samsung_i2s_variant_regs *variant_regs;
+	void (*fixup_early)(struct snd_pcm_substream *substream,
+						struct snd_soc_dai *dai);
+	void (*fixup_late)(struct snd_pcm_substream *substream,
+						struct snd_soc_dai *dai);
 	u32 quirks;
 
 	/* The clock provider's data */
@@ -940,6 +948,10 @@ static int i2s_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		pm_runtime_get_sync(dai->dev);
+
+		if (priv->fixup_early)
+			priv->fixup_early(substream, dai);
+
 		spin_lock_irqsave(&priv->lock, flags);
 
 		if (config_setup(i2s)) {
@@ -947,6 +959,9 @@ static int i2s_trigger(struct snd_pcm_substream *substream,
 			return -EINVAL;
 		}
 
+		if (priv->fixup_late)
+			priv->fixup_late(substream, dai);
+
 		if (capture)
 			i2s_rxctrl(i2s, 1);
 		else
@@ -1410,6 +1425,8 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 
 	if (np) {
 		priv->quirks = i2s_dai_data->quirks;
+		priv->fixup_early = i2s_dai_data->fixup_early;
+		priv->fixup_late = i2s_dai_data->fixup_late;
 	} else {
 		if (!i2s_pdata) {
 			dev_err(&pdev->dev, "Missing platform data\n");
@@ -1563,6 +1580,31 @@ static int samsung_i2s_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void fsd_i2s_fixup_early(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct i2s_dai *i2s = to_info(asoc_rtd_to_cpu(rtd, 0));
+	struct i2s_dai *other = get_other_dai(i2s);
+
+	if (!is_opened(other)) {
+		i2s_set_sysclk(dai, SAMSUNG_I2S_CDCLK, 0, SND_SOC_CLOCK_OUT);
+		i2s_set_sysclk(dai, SAMSUNG_I2S_OPCLK, 0, MOD_OPCLK_PCLK);
+	}
+}
+
+static void fsd_i2s_fixup_late(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct samsung_i2s_priv *priv = snd_soc_dai_get_drvdata(dai);
+	struct i2s_dai *i2s = to_info(asoc_rtd_to_cpu(rtd, 0));
+	struct i2s_dai *other = get_other_dai(i2s);
+
+	if (!is_opened(other))
+		writel(PSR_PSVAL(2) | PSR_PSREN, priv->addr + I2SPSR);
+}
+
 static const struct samsung_i2s_variant_regs i2sv3_regs = {
 	.bfs_off = 1,
 	.rfs_off = 3,
@@ -1652,6 +1694,14 @@ static const struct samsung_i2s_dai_data i2sv5_dai_type_i2s1 __maybe_unused = {
 	.i2s_variant_regs = &i2sv5_i2s1_regs,
 };
 
+static const struct samsung_i2s_dai_data fsd_dai_type __maybe_unused = {
+	.quirks = QUIRK_SEC_DAI | QUIRK_NEED_RSTCLR | QUIRK_SUPPORTS_TDM,
+	.pcm_rates = SNDRV_PCM_RATE_8000_192000,
+	.i2s_variant_regs = &i2sv7_regs,
+	.fixup_early = fsd_i2s_fixup_early,
+	.fixup_late = fsd_i2s_fixup_late,
+};
+
 static const struct platform_device_id samsung_i2s_driver_ids[] = {
 	{
 		.name           = "samsung-i2s",
@@ -1678,6 +1728,9 @@ static const struct of_device_id exynos_i2s_match[] = {
 	}, {
 		.compatible = "samsung,exynos7-i2s1",
 		.data = &i2sv5_dai_type_i2s1,
+	}, {
+		.compatible = "tesla,fsd-i2s",
+		.data = &fsd_dai_type,
 	},
 	{},
 };
-- 
2.17.1

