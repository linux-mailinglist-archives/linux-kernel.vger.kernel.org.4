Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C01B65F258
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjAERPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbjAERO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:14:27 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E7767BF9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 09:08:45 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t15so27899558wro.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 09:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHSeF2epzfegJ6dyqinGOhs8+O9cuqph/+zCKOX0s7I=;
        b=T9j5Z6Z77lWG3Lcdp+nVPM40kdXJmbdnZ0Ac4zTt8hMNtusoqDFw62aFNPEuz55H/U
         WImqKxepwo6EUI0Xbkt1jCxk4Flmu6Ye1l8pG1r26F4sGNR/2N2JaGSHa3HeHNKL/TPY
         KEEOajm91lmqyutXBKH9DN5ZlKWWuG14PbgOwDLl19aSK3sfZze9c5z0wWUGH6Lt2q5s
         UIkJ4RgB+DPR6oBEk09ocHcYb0CwDcEHRSqJkKMnsx/3GyxPh3zuL0qVhkyNgJ3eGaze
         1uP3WbkMTlbXAoKJme+in2vRJRwlNGLdmy9nooKLqZsJ9lNbN/Trpe4/W73uYOffX/vf
         8JyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHSeF2epzfegJ6dyqinGOhs8+O9cuqph/+zCKOX0s7I=;
        b=h9nOpnj5HVNfBs45OX1ERrRLb7c0PDw0KF/vViYIvrD1uxUy4Mt3JLmbxh6/gNefA8
         qBSPWghybZlzpzL1VwvXDS4TlF+2Bii1BdgDJUxBW3YapsDMKEtWglNpAbK3bJhp7tg4
         n6wGHx0/+tjHpAaCKfZeg3PPR/AELIyjxB++J7GzbSTcisPAcy1+fi9YQoFXFSZ7Y0kE
         KnRD5icsAe3kMPhEZwzz3N9mrdQqiKaB5weDDIq3U0OAH+E6+lFvWtgO83a7Hz+JyeSq
         ZpuJsOVDgdQGAysaKpYHF9od+FJPirmPmA4mZMhMVlFAKmP2CB4IJrXKFPDZ09GzPRlO
         gfZg==
X-Gm-Message-State: AFqh2kpqdtHtr4bkBTVWURYfI1oDF9ZkoJD0WC4MOuRnNR43eCKHY7ce
        SpiQZUfT5WfjsuvQi7fUPDqyvA==
X-Google-Smtp-Source: AMrXdXsPKg+NGFgNV4C04Y1XgAhoYS0yvh7sfB1ozmk0QG2qKNE3ZLFRHj1PCnQ4jZIVzo+0C0/PJw==
X-Received: by 2002:a5d:4f05:0:b0:28c:6430:c1bc with SMTP id c5-20020a5d4f05000000b0028c6430c1bcmr15570468wru.3.1672938469840;
        Thu, 05 Jan 2023 09:07:49 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a245:805c:9cf4:fdb8:bb61:5f4e])
        by smtp.gmail.com with ESMTPSA id f14-20020adfe90e000000b002365730eae8sm37164853wrm.55.2023.01.05.09.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 09:07:49 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 3/8] soc: mediatek: pm-domains: Create bus protection operation functions
Date:   Thu,  5 Jan 2023 18:07:30 +0100
Message-Id: <20230105170735.1637416-4-msp@baylibre.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105170735.1637416-1-msp@baylibre.com>
References: <20230105170735.1637416-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate the register access used for bus protection enable/disable into
their own functions. These will be used later for WAY_EN bits.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/soc/mediatek/mtk-pm-domains.c | 68 +++++++++++++++------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 4333cd297405..999e1f6c86b0 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -117,26 +117,50 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
 					MTK_POLL_TIMEOUT);
 }
 
+static int scpsys_bus_protect_clear(const struct scpsys_bus_prot_data *bpd,
+				    struct regmap *regmap)
+{
+	u32 val;
+	u32 sta_mask = bpd->bus_prot_sta_mask;
+
+	if (bpd->bus_prot_reg_update)
+		regmap_clear_bits(regmap, bpd->bus_prot_clr, bpd->bus_prot_set_clr_mask);
+	else
+		regmap_write(regmap, bpd->bus_prot_clr, bpd->bus_prot_set_clr_mask);
+
+	if (bpd->ignore_clr_ack)
+		return 0;
+
+	return regmap_read_poll_timeout(regmap, bpd->bus_prot_sta,
+					val, !(val & sta_mask),
+					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+}
+
+static int scpsys_bus_protect_set(const struct scpsys_bus_prot_data *bpd,
+				  struct regmap *regmap)
+{
+	u32 val;
+	u32 sta_mask = bpd->bus_prot_sta_mask;
+
+	if (bpd->bus_prot_reg_update)
+		regmap_set_bits(regmap, bpd->bus_prot_set, bpd->bus_prot_set_clr_mask);
+	else
+		regmap_write(regmap, bpd->bus_prot_set, bpd->bus_prot_set_clr_mask);
+
+	return regmap_read_poll_timeout(regmap, bpd->bus_prot_sta,
+					val, (val & sta_mask) == sta_mask,
+					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+}
+
 static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, struct regmap *regmap)
 {
 	int i, ret;
 
 	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
-		u32 val;
-		u32 set_clr_mask = bpd[i].bus_prot_set_clr_mask;
-		u32 sta_mask = bpd[i].bus_prot_sta_mask;
-
-		if (!set_clr_mask)
+		if (!bpd[i].bus_prot_set_clr_mask)
 			break;
 
-		if (bpd[i].bus_prot_reg_update)
-			regmap_set_bits(regmap, bpd[i].bus_prot_set, set_clr_mask);
-		else
-			regmap_write(regmap, bpd[i].bus_prot_set, set_clr_mask);
-
-		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
-					       val, (val & sta_mask) == sta_mask,
-					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+		ret = scpsys_bus_protect_set(&bpd[i], regmap);
 		if (ret)
 			return ret;
 	}
@@ -161,24 +185,10 @@ static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
 	int i, ret;
 
 	for (i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
-		u32 val;
-		u32 set_clr_mask = bpd[i].bus_prot_set_clr_mask;
-		u32 sta_mask = bpd[i].bus_prot_sta_mask;
-
-		if (!set_clr_mask)
-			continue;
-
-		if (bpd[i].bus_prot_reg_update)
-			regmap_clear_bits(regmap, bpd[i].bus_prot_clr, set_clr_mask);
-		else
-			regmap_write(regmap, bpd[i].bus_prot_clr, set_clr_mask);
-
-		if (bpd[i].ignore_clr_ack)
+		if (!bpd[i].bus_prot_set_clr_mask)
 			continue;
 
-		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
-					       val, !(val & sta_mask),
-					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+		ret = scpsys_bus_protect_clear(&bpd[i], regmap);
 		if (ret)
 			return ret;
 	}
-- 
2.39.0

