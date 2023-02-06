Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE7768B968
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjBFKGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjBFKF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:05:58 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2D193F4;
        Mon,  6 Feb 2023 02:05:16 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id m2so32588378ejb.8;
        Mon, 06 Feb 2023 02:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gqf1vCXAbzOf8WDTZTA0pRXwIBMxs7RLBp7o8lAX0PU=;
        b=T/BkKnXItAdLlJcLNUMa+VCEdmv6AMdP0dWS0Of5OxiLbWBVgnVYIECIo6c4MYN47H
         g07qpZLpDfvrFdME3IiSyDfrdO+nKnoc2wP2GNGGzi2Gpt/1C+MdoYydbc+AHnDq6llK
         Ibt5bSqGyn75c/DvpwlAAAaR7/ueJdl12v4G2HAaQXD4iAP+tpNVWsiFvCYl3czcy7zm
         C/mheRhfSuXWdl9r8yyMu6sjpeyMZuOq4lYtzBUkZ+TkHnwZcLbn22kgDOWDo2rwqwMD
         2ChYMIagNBEEAjPE/6C/karJX0/R8mWFcAXkRp+zxig32eruF3TvopdD/AYuYmvZGAyb
         Vc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gqf1vCXAbzOf8WDTZTA0pRXwIBMxs7RLBp7o8lAX0PU=;
        b=7VPThdA8GwGXYwBrzGZzyY7O8FKsJm4Y9QYNZtp7Z2H+8hJIuONNz4PPiAwi9NDU6T
         jCIv5nwwLyCWBNEnPwUb2IBkQcHf9fuy7+PKX2Ou2F5ItRpn1A7ixVAl++u8/9aNUZHc
         tJb9i1KqEh7Bw/pU/wXsSQzmafTAyKTjfqVDmcAcWxtMJkSiSKe20c88wLuI8nqVmNse
         oq8+3t9r/CwPi3zG9qO+O93t35oZg38a/UGnTPJCvbsx/vHiL+IKQUmf4a+4/v1KWEUh
         9hBWBcLSksmpQ/wIA32Cb99gPcyNOK3wOUk4wfwAsdtHtz31Gna2Kpnlpk/bYpPIiUNq
         Euaw==
X-Gm-Message-State: AO0yUKXt/cvFC5IguPnpwePe/Qd7hZQYswRhYRB1UvvwFc128iuHkb3d
        +DjhMLFF5Yo1Bl3M08Qm0nc=
X-Google-Smtp-Source: AK7set+dLPcd5QuiLWBH7phQh03dPTamLJPxtAgvDwcz5xmNJIQ3hFiqOl4bmWdL30CfeqcEyDuZLA==
X-Received: by 2002:a17:907:94c2:b0:88d:ba89:1851 with SMTP id dn2-20020a17090794c200b0088dba891851mr16848475ejc.34.1675677914683;
        Mon, 06 Feb 2023 02:05:14 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id s19-20020a1709067b9300b008878909859bsm5240746ejo.152.2023.02.06.02.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:05:14 -0800 (PST)
From:   Willem-Jan de Hoog <arinc9.unal@gmail.com>
X-Google-Original-From: Willem-Jan de Hoog <wdehoog@exalondelft.nl>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Willem-Jan de Hoog <wdehoog@exalondelft.nl>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        erkin.bozoglu@xeront.com
Subject: [PATCH 1/2] firmware: bcm47xx_nvram: allow to read from buffered nvram data
Date:   Mon,  6 Feb 2023 13:05:01 +0300
Message-Id: <20230206100502.20243-2-wdehoog@exalondelft.nl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230206100502.20243-1-wdehoog@exalondelft.nl>
References: <20230206100502.20243-1-wdehoog@exalondelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The bcm47xx code makes a copy of the NVRAM data in ram. Allow access to
this data so property values can be read using nvmem cell api.

[ arinc.unal: Improved patch subject and log ]

Signed-off-by: Willem-Jan de Hoog <wdehoog@exalondelft.nl>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/firmware/broadcom/bcm47xx_nvram.c | 14 ++++++++++++++
 include/linux/bcm47xx_nvram.h             |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/firmware/broadcom/bcm47xx_nvram.c b/drivers/firmware/broadcom/bcm47xx_nvram.c
index 5f47dbf4889a..7e5c62dc702f 100644
--- a/drivers/firmware/broadcom/bcm47xx_nvram.c
+++ b/drivers/firmware/broadcom/bcm47xx_nvram.c
@@ -182,6 +182,20 @@ static int nvram_init(void)
 	return -ENXIO;
 }
 
+int bcm47xx_nvram_read(unsigned int offset, char *val, size_t val_len)
+{
+	if (!nvram_len)
+		return -ENXIO;
+
+	if ((offset+val_len) > nvram_len)
+		return -EINVAL;
+
+	while (val_len--)
+		*val++ = nvram_buf[offset++];
+
+	return 0;
+}
+
 int bcm47xx_nvram_getenv(const char *name, char *val, size_t val_len)
 {
 	char *var, *value, *end, *eq;
diff --git a/include/linux/bcm47xx_nvram.h b/include/linux/bcm47xx_nvram.h
index 7615f8d7b1ed..b265b8ce6434 100644
--- a/include/linux/bcm47xx_nvram.h
+++ b/include/linux/bcm47xx_nvram.h
@@ -20,6 +20,7 @@ static inline void bcm47xx_nvram_release_contents(char *nvram)
 {
 	vfree(nvram);
 };
+int bcm47xx_nvram_read(unsigned int offset, char *val, size_t val_len);
 #else
 static inline int bcm47xx_nvram_init_from_iomem(void __iomem *nvram_start,
 						size_t res_size)
@@ -48,6 +49,11 @@ static inline char *bcm47xx_nvram_get_contents(size_t *val_len)
 static inline void bcm47xx_nvram_release_contents(char *nvram)
 {
 };
+
+static inline int bcm47xx_nvram_read(unsigned int offset, char *val, size_t val_len)
+{
+	return -ENOTSUPP;
+}:
 #endif
 
 #endif /* __BCM47XX_NVRAM_H */
-- 
2.37.2

