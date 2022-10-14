Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F39F5FECF2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJNLKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJNLKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:10:15 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E9E476E6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 04:10:12 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221014111010epoutp0480c178e1ef9c17524768680cc792b63f~d6v1THHn30818408184epoutp04k
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 11:10:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221014111010epoutp0480c178e1ef9c17524768680cc792b63f~d6v1THHn30818408184epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665745810;
        bh=X+AgLGa5lEnY8GHICnKcE5aQCOfPFmz4hGlS4PuZixQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=llKkbRjQEpsYxihhXRlOSXqYYCjY5MuaUJe9WFg5/f/0FhK13bBaw2zv7I1HVPIS8
         sgBFu3wcVmHHdcSh1KF80gNGX6ADJfGYL6Zm0aHJXCvQn0MsL+r8xnOcQhMekwHZB9
         qlQ275ficWYw5ZQSXPrxPQpvkjvFbMuX/zrTODU8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221014111010epcas5p20d10d00d365e0f4073ddf47b171ecc0e~d6v0rrd7w1113011130epcas5p2a;
        Fri, 14 Oct 2022 11:10:10 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MpkFC5vL9z4x9Pr; Fri, 14 Oct
        2022 11:10:07 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        27.06.39477.F8349436; Fri, 14 Oct 2022 20:10:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221014104857epcas5p2a275a1d606ca066227228d13bcf5b120~d6dS97GIL0052600526epcas5p22;
        Fri, 14 Oct 2022 10:48:57 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221014104857epsmtrp2a596a658fb9740b9ee46152613e68298~d6dS8-1ID0248602486epsmtrp2u;
        Fri, 14 Oct 2022 10:48:57 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-58-6349438fde64
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.2C.18644.89E39436; Fri, 14 Oct 2022 19:48:56 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221014104854epsmtip10e316d810d89bf2e6392115791f00634~d6dQxi0AG2688026880epsmtip1J;
        Fri, 14 Oct 2022 10:48:54 +0000 (GMT)
From:   Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH 2/6] ASoC: samsung: i2s: configure PSR from sound card
Date:   Fri, 14 Oct 2022 15:51:47 +0530
Message-Id: <20221014102151.108539-3-p.rajanbabu@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221014102151.108539-1-p.rajanbabu@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmlm6/s2eyQfs8XYsH87axWVy5eIjJ
        4tDmrewWUx8+YbOYf+Qcq0Xfi4fMFt+udDBZXN41h81ixvl9TBZHNwZbLNr6hd2ic1c/q8Ws
        CztYLVr3HmG3OPymndViw/e1jA4CHhs+N7F57Jx1l91j06pONo871/aweex7u4zNo2/LKkaP
        9Vuusnh83iQXwBGVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+Ti
        E6DrlpkD9IGSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1
        xMrQwMDIFKgwITtj1amPTAVPFCvOXGlib2BcIN3FyMkhIWAiMXXJQ/YuRi4OIYHdjBK9iw6z
        QjifGCXe7jrHDFIlJPCZUWLl5iqYjps79jJDFO1ilDiy/z0jhNPKJLF9+212kCo2AVOJVXMa
        wUaJCDQxSbS9mcgC4jALbGSUOH3sIVMXIweHsICbROf+EJAGFgFViWeHbrKAhHkFbCWu3w+A
        2CYvsXrDAbArOAXsJJ63NIHNlBBYyCFxdvIFdogiF4n1h68yQ9jCEq+Ob4GKS0l8freXDcLO
        l5j2sRnKrpBo+7iBCcK2lzhwZQ7YXmYBTYn1u/QhwrISU0+tAythFuCT6P39BKqcV2LHPBhb
        VWL98k2MELa0xL7re6FsD4nZc89DQ2gio8S19SeYJjDKzUJYsYCRcRWjZGpBcW56arFpgVFe
        ajk81pLzczcxglOpltcOxocPPugdYmTiYDzEKMHBrCTC+1rJM1mINyWxsiq1KD++qDQntfgQ
        oykw/CYyS4km5wOTeV5JvKGJpYGJmZmZiaWxmaGSOO/iGVrJQgLpiSWp2ampBalFMH1MHJxS
        DUyOHLwhH2zl7bpfvFo7e8dsFflVCxebrJJqe6rpXBBme0Oy+Ktj+DS3iXNm2iTf/7h+zu76
        TazSZVN2eL0OmF7IeeSZ2W1On1UfhbnWfJ0btKsnbU6kQPRKfz5hFUch5wtBURpi9+eJcDEG
        ud6VsDLdlv14BUOO5pSLE861cM/Nnc4Zc3GHyqFJuUteXuF2OH9qo8zyC1FNJY1v86I4wz83
        Wi94nTFr0ZfG5CNKbCq3VU7Fb9KR7VrTe3rBjv/f3H8sdj4/gzu7VFp89dnkbm6n1e+juv80
        nd15fP+xiO1LQmf38/x+vCdN4cI9XwPzG5INoUeO6ymmzZmc23Q/PdHozIQLC9+I32m8OqPU
        xPicEktxRqKhFnNRcSIAn/E/Ty4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSnO5MO89kg0saFg/mbWOzuHLxEJPF
        oc1b2S2mPnzCZjH/yDlWi74XD5ktvl3pYLK4vGsOm8WM8/uYLI5uDLZYtPULu0Xnrn5Wi1kX
        drBatO49wm5x+E07q8WG72sZHQQ8NnxuYvPYOesuu8emVZ1sHneu7WHz2Pd2GZtH35ZVjB7r
        t1xl8fi8SS6AI4rLJiU1J7MstUjfLoErY9Wpj0wFTxQrzlxpYm9gXCDdxcjJISFgInFzx17m
        LkYuDiGBHYwST7fOY4dISEtM79/DBmELS6z895wdoqiZSWLy3nVgRWwCphKr5jSygiREBCYw
        SZx8d4wFJMEssJVRYupnoy5GDg5hATeJzv0hIGEWAVWJZ4dusoCEeQVsJa7fD4CYLy+xesMB
        ZhCbU8BO4nlLEyuILQRU8vz8O8YJjHwLGBlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefn
        bmIEB7qW1g7GPas+6B1iZOJgPMQowcGsJML7WskzWYg3JbGyKrUoP76oNCe1+BCjNAeLkjjv
        ha6T8UIC6YklqdmpqQWpRTBZJg5OqQamwhwOKe1kzyDG92kZl3c9WTFBsTfk6pG2XEn/W5wx
        x/f7xn2+VVpoZjs/am/Tfu6sWn3HUBZbMd1j27IE3HX/2ysXuul9WbOymCthS+KcYOv5qbEO
        lVebzW5WPNfeae69zshGNn6W6xvWwhvLWie/WyMwy8+4tNJKmNlhinWDxOWbf5LfZjVYq8+Z
        x6ly/0TEa8vbLd7WCU9263WZv5pj59j66t8kxltuc44WznOxCZorMa1wTb568Wsppi0fr7Nu
        NZJdwCC+oqn90cxtrcI7Zm231Xv+SvPHhpBH28+e0pWeNetC44e8iKa6vvxbtzz2P79guOdt
        7Ca7mfWhtU8U1W02rLSOMikPqJkk9lWJpTgj0VCLuag4EQB8G1By4wIAAA==
X-CMS-MailID: 20221014104857epcas5p2a275a1d606ca066227228d13bcf5b120
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221014104857epcas5p2a275a1d606ca066227228d13bcf5b120
References: <20221014102151.108539-1-p.rajanbabu@samsung.com>
        <CGME20221014104857epcas5p2a275a1d606ca066227228d13bcf5b120@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the prescaler value in samsung I2S dai is calculated by
dividing the peripheral input clock frequency with frame clock
frequency and root clock frequency divider. This prescaler value is
used to divide the input clock to generate root clock (RCLK) from which
frame clock is generated for I2S communication.

However for the platforms which does not have a dedicated audio PLL as
an input clock source, the prescaler divider will not generate accurate
root clock frequency, which inturn affects sampling frequency also.

To overcome this scenario, support has been added to let the sound card
identify right prescaler divider value and configure the prescaler (PSR)
divider directly the from the sound card to achieve near accurate sample
frequencies

Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
---
 sound/soc/samsung/i2s-regs.h |  2 ++
 sound/soc/samsung/i2s.c      | 36 ++++++++++++++++++++++++++++++++----
 sound/soc/samsung/i2s.h      |  1 +
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/i2s-regs.h b/sound/soc/samsung/i2s-regs.h
index cb2be4a3b70b..e2581dc73df2 100644
--- a/sound/soc/samsung/i2s-regs.h
+++ b/sound/soc/samsung/i2s-regs.h
@@ -132,6 +132,8 @@
 #define EXYNOS7_MOD_RCLK_192FS	7
 
 #define PSR_PSREN		(1 << 15)
+#define PSR_PSVAL_SHIFT		8
+#define PSR_PSVAL_MASK		0x3f
 
 #define FIC_TX2COUNT(x)		(((x) >>  24) & 0xf)
 #define FIC_TX1COUNT(x)		(((x) >>  16) & 0xf)
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index fb806b0af6ab..a96286b27f1d 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -59,10 +59,10 @@ struct i2s_dai {
 	/* Frame clock */
 	unsigned frmclk;
 	/*
-	 * Specifically requested RCLK, BCLK by machine driver.
+	 * Specifically requested RCLK, BCLK and PSR by machine driver.
 	 * 0 indicates CPU driver is free to choose any value.
 	 */
-	unsigned rfs, bfs;
+	unsigned int rfs, bfs, psr;
 	/* Pointer to the Primary_Fifo if this is Sec_Fifo, NULL otherwise */
 	struct i2s_dai *pri_dai;
 	/* Pointer to the Secondary_Fifo if it has one, NULL otherwise */
@@ -389,6 +389,17 @@ static inline int get_blc(struct i2s_dai *i2s)
 	}
 }
 
+static inline unsigned int get_psval(struct i2s_dai *i2s)
+{
+	struct samsung_i2s_priv *priv = i2s->priv;
+	u32 psr;
+
+	psr = readl(priv->addr + I2SPSR) >> PSR_PSVAL_SHIFT;
+	psr &= PSR_PSVAL_MASK;
+
+	return (psr + 1);
+}
+
 /* TX channel control */
 static void i2s_txctrl(struct i2s_dai *i2s, int on)
 {
@@ -994,7 +1005,11 @@ static int config_setup(struct i2s_dai *i2s)
 		return 0;
 
 	if (!(priv->quirks & QUIRK_NO_MUXPSR)) {
-		psr = priv->rclk_srcrate / i2s->frmclk / rfs;
+		if (i2s->psr)
+			psr = i2s->psr;
+		else
+			psr = priv->rclk_srcrate / i2s->frmclk / rfs;
+
 		writel(((psr - 1) << 8) | PSR_PSREN, priv->addr + I2SPSR);
 		dev_dbg(&i2s->pdev->dev,
 			"RCLK_SRC=%luHz PSR=%u, RCLK=%dfs, BCLK=%dfs\n",
@@ -1072,6 +1087,18 @@ static int i2s_set_clkdiv(struct snd_soc_dai *dai,
 		i2s->bfs = div;
 		pm_runtime_put(dai->dev);
 		break;
+	case SAMSUNG_I2S_DIV_RCLK:
+		pm_runtime_get_sync(dai->dev);
+		if ((any_active(i2s) && div && (get_psval(i2s) != div))
+			|| (other && other->psr && (other->psr != div))) {
+			pm_runtime_put(dai->dev);
+			dev_err(&i2s->pdev->dev,
+				"%s:%d Other DAI busy\n", __func__, __LINE__);
+			return -EAGAIN;
+		}
+		i2s->psr = div;
+		pm_runtime_put(dai->dev);
+		break;
 	default:
 		dev_err(&i2s->pdev->dev,
 			"Invalid clock divider(%d)\n", div_id);
@@ -1140,9 +1167,10 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 					   other->idma_playback.addr);
 	}
 
-	/* Reset any constraint on RFS and BFS */
+	/* Reset any constraint on RFS, BFS and PSR*/
 	i2s->rfs = 0;
 	i2s->bfs = 0;
+	i2s->psr = 0;
 
 	spin_lock_irqsave(&priv->lock, flags);
 	i2s_txctrl(i2s, 0);
diff --git a/sound/soc/samsung/i2s.h b/sound/soc/samsung/i2s.h
index 78b475ef98d9..e783d33fdfac 100644
--- a/sound/soc/samsung/i2s.h
+++ b/sound/soc/samsung/i2s.h
@@ -13,6 +13,7 @@
 #define SAMSUNG_I2S_DAI_SEC    "samsung-i2s-sec"
 
 #define SAMSUNG_I2S_DIV_BCLK		1
+#define SAMSUNG_I2S_DIV_RCLK		2
 
 #define SAMSUNG_I2S_RCLKSRC_0		0
 #define SAMSUNG_I2S_RCLKSRC_1		1
-- 
2.17.1

