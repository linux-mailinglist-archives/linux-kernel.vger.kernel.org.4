Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5186C82A7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjCXQwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjCXQwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:52:47 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3D3212A5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:52:45 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id i15so1646690pfo.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679676765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UmG7kTY7wjWcxkBXGijn5KqU6ZYb3Prx7pN3zRMZ2Q=;
        b=QVEqXaO0vwbg6qjXz3p/QiK0qIDvtFqAcZvJt3om0UyJ5+nosdtMGMbAVa/In6hj/w
         0+ZwuC7B75j+g1KDkicEbZ7/Q/xWoHazfxg3v+uqOL3522+PaRj1VS0jSt3dF6L9rvM1
         TXJipMfXePUNNeIEyhXzjjD19TU3PPhBTAl4uWKbrDj+i2eTgnmZZn4GDoa50RCZFmEB
         Tchet5lHEGcf+l4KoTxe8L9EdlqoYNgJ/SG7/OxNWuCPddbqZMXvNhuRW7Hrpl6NDO+D
         MH1DT7EVv/VXD+wlvHH0yJIA3OydtPXoDqcBGnZHYGbKt79L9kLk5DKAKycKKDn8wt4k
         iGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679676765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UmG7kTY7wjWcxkBXGijn5KqU6ZYb3Prx7pN3zRMZ2Q=;
        b=OvogoVifohIgRKXrdeaSNfanF+EXzpThJGu7PFTtBGoo/2O4GDrIuFN8GXE7zMFnhu
         qVSbP+JhSbQr3iNLBuZNvbTux2H22QrBzJZnsmVCZYQu8dpoA16AjG5B66HqxatPjIQn
         D1IhEzZu4bUN0lRIcBOabPE+XQNtT8XqcGq+PTmUgr+kZQwWCKwO1wHbOFx6zSf7OKLQ
         NxZyhHyzWoKT1y06xxfsb356NH9CyrBlfIfAA4jCTMG7IyrOF24GSSxdnkCUhLhsoXjD
         l6dCCHE0+4FCqFQNQbeVQs/rX2vuK5g/ZQH93IB2bQ3vKDOrBOfmSLmmcwbtCVqYANQY
         4WbQ==
X-Gm-Message-State: AAQBX9dI/24YCPJMA0a1MB2YtdKVgSCBSn9zXpAduRg2AaLzOnwSu15W
        XJSSgRkU0SSupN76rcDkyw2OOFrSBjQ=
X-Google-Smtp-Source: AK7set+KBVxkxFHsXaMsVsIir/eox0dKYMv1EYMazIh/KAM89fItbtAbbbylsEN1+4M6KgzY6HlOlw==
X-Received: by 2002:aa7:9629:0:b0:628:1274:4d60 with SMTP id r9-20020aa79629000000b0062812744d60mr3776739pfg.21.1679676764785;
        Fri, 24 Mar 2023 09:52:44 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a5-20020aa780c5000000b0062b5a55835dsm1420289pfn.213.2023.03.24.09.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 09:52:44 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH 3/3] memory: brcmstb_memc: Add new DDR attributes
Date:   Fri, 24 Mar 2023 09:52:31 -0700
Message-Id: <20230324165231.3468069-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324165231.3468069-1-f.fainelli@gmail.com>
References: <20230324165231.3468069-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide information about the DDR size, type, width, total width,
dual/single rank. This is useful for reporting purposes and inventory of
the system(s).

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/memory/brcmstb_memc.c | 80 ++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/brcmstb_memc.c b/drivers/memory/brcmstb_memc.c
index 67c75e21c95e..032567dfd6e2 100644
--- a/drivers/memory/brcmstb_memc.c
+++ b/drivers/memory/brcmstb_memc.c
@@ -13,7 +13,14 @@
 
 #define REG_MEMC_CNTRLR_CONFIG		0x00
 #define  CNTRLR_CONFIG_LPDDR4_SHIFT	5
-#define  CNTRLR_CONFIG_MASK		0xf
+#define  CNTRLR_CONFIG_MASK		GENMASK(3, 0)
+#define  CNTRLR_CONFIG_SIZE_SHIFT	4
+#define  CNTRLR_CONFIG_SIZE_MASK	GENMASK(7, 4)
+#define  CNTRLR_CONFIG_WIDTH_SHIFT	8
+#define  CNTRLR_CONFIG_WIDTH_MASK	GENMASK(9, 8)
+#define  CNTRLR_CONFIG_TOT_WIDTH_SHIFT	10
+#define  CNTRLR_CONFIG_TOT_WIDTH_MASK	GENMASK(11, 10)
+#define  CNTRLR_CONFIG_RANK_SHIFT	16
 #define REG_MEMC_SRPD_CFG_21		0x20
 #define REG_MEMC_SRPD_CFG_20		0x34
 #define REG_MEMC_SRPD_CFG_1x		0x3c
@@ -63,6 +70,67 @@ static int brcmstb_memc_srpd_config(struct brcmstb_memc *memc,
 	return 0;
 }
 
+static ssize_t ddr_rank_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct brcmstb_memc *memc = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n",
+		       memc->config_reg & CNTRLR_CONFIG_RANK_SHIFT ?
+		       "dual" : "single");
+}
+
+static ssize_t ddr_size_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct brcmstb_memc *memc = dev_get_drvdata(dev);
+	u32 val = (memc->config_reg & CNTRLR_CONFIG_SIZE_MASK) >>
+		  CNTRLR_CONFIG_SIZE_SHIFT;
+
+	return sprintf(buf, "%dMb\n", 256 << val);
+}
+
+static ssize_t ddr_total_width_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct brcmstb_memc *memc = dev_get_drvdata(dev);
+	u32 val = (memc->config_reg & CNTRLR_CONFIG_TOT_WIDTH_MASK) >>
+		   CNTRLR_CONFIG_TOT_WIDTH_SHIFT;
+
+	return sprintf(buf, "x%d\n", 8 << val);
+}
+
+static ssize_t ddr_type_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct brcmstb_memc *memc = dev_get_drvdata(dev);
+	const char *ddr_type_to_str[] = {
+		"DDR2",
+		"DDR3",
+		"DDR4",
+		"GDDR5M",
+		"GDDR5",
+		"LPDDR4",
+	};
+	u32 val = memc->config_reg & CNTRLR_CONFIG_MASK;
+	const char *type = "unknown";
+
+	if (val < ARRAY_SIZE(ddr_type_to_str))
+		type = ddr_type_to_str[val];
+
+	return sprintf(buf, "%s\n", type);
+}
+
+static ssize_t ddr_width_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct brcmstb_memc *memc = dev_get_drvdata(dev);
+	u32 val = (memc->config_reg & CNTRLR_CONFIG_WIDTH_MASK) >>
+		  CNTRLR_CONFIG_WIDTH_SHIFT;
+
+	return sprintf(buf, "x%d\n", 8 << val);
+}
+
 static ssize_t frequency_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
@@ -105,10 +173,20 @@ static ssize_t srpd_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
+static DEVICE_ATTR_RO(ddr_rank);
+static DEVICE_ATTR_RO(ddr_size);
+static DEVICE_ATTR_RO(ddr_total_width);
+static DEVICE_ATTR_RO(ddr_type);
+static DEVICE_ATTR_RO(ddr_width);
 static DEVICE_ATTR_RO(frequency);
 static DEVICE_ATTR_RW(srpd);
 
 static struct attribute *dev_attrs[] = {
+	&dev_attr_ddr_rank.attr,
+	&dev_attr_ddr_size.attr,
+	&dev_attr_ddr_total_width.attr,
+	&dev_attr_ddr_type.attr,
+	&dev_attr_ddr_width.attr,
 	&dev_attr_frequency.attr,
 	&dev_attr_srpd.attr,
 	NULL,
-- 
2.34.1

