Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD6768B9BC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjBFKRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjBFKQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:16:57 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441F71BED;
        Mon,  6 Feb 2023 02:16:55 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id mc11so32647642ejb.10;
        Mon, 06 Feb 2023 02:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaHb57ie27t7sx02n9fnOtU+5lDezV2NzpCj5krDBkk=;
        b=qhRI6z/EKxXVF4OV0/1XtnQmyWLNB8sb4HfKXV+xn4TlnkT1HDYa1zidWqykMzxAYb
         skRJFkAK1NdszFKs7tNQOJNv4wC8z3wGT2MAN0338yx0kbkrGRa2mDay/Z0gt29VLJkz
         8iRe+fltR2GLsu5J7WFoWrdE0XAS7i0z2GxR3vbTd0+5B3CAG7Pvl6/T+NVg+vIIlJc2
         7UMJz02qtml7yZNvD6kYVHOB5CHNG4XUEGoJPo/ay2T9tZnccaXSlHc8mtXYdwzILOng
         opTSWew0O7d+4uH4WhGoWv4+9S8Jh8Kq1/RSubiPa+PYZt+surh3H5seVzOVpf/GaNPL
         +ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NaHb57ie27t7sx02n9fnOtU+5lDezV2NzpCj5krDBkk=;
        b=JdDT1i12En2DncF3DeMf4YxjiB3Ydyscuh7UjrkKDH13zWzEnNo96afGmtjrm7pOu2
         RMD6lwQ4+MBfm3Sp0WGxFCaxUyjM9Fcug0bT/rruhiKkgEocs2Hp4IDDOe5m6R2BO8I7
         Vt2hWtx7YN1T44Ol7/YcDVHGrDDExOVakSn5PF3DRtcqLkPpLj8Mny7XaPrSybE71K+R
         vPcPYtH4DtdVSd9UMxWTgWRCbV2bZbI3PcAVDM9C2znYmmsq9LKt0CjLNm2FzNDi3hHv
         XJ0Gda2GhGWxP9rub5uqRNmgwt1r9h56jqqdmm+ferW5pVitk9rurkomkBCS8iaZdEZj
         TIGQ==
X-Gm-Message-State: AO0yUKU+v1gZHuXLM0S7MyC5QClm+qQQve5VGVAMOw2GiBgLQuT6PIVw
        WZOCK/vbv+z343wOkEsmNlw=
X-Google-Smtp-Source: AK7set8eqweCYkTJHa5IlZM3FNA8Y53SWlZroCZVo32uXRsMo9wnuHcFu9XwyzJ2gBmhkS+2r4sqGg==
X-Received: by 2002:a17:907:a089:b0:88d:ba89:1838 with SMTP id hu9-20020a170907a08900b0088dba891838mr17543237ejc.9.1675678614907;
        Mon, 06 Feb 2023 02:16:54 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id hz19-20020a1709072cf300b008847d7ed37bsm5285983ejc.100.2023.02.06.02.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:16:54 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: wdehoog@exalondelft.nl
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Willem-Jan de Hoog <wdehoog@exalondelft.nl>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        erkin.bozoglu@xeront.com
Subject: [PATCH v2 2/2] nvmem: brcm_nvram: use bcm47xx buffered data
Date:   Mon,  6 Feb 2023 13:16:42 +0300
Message-Id: <20230206101642.22720-3-wdehoog@exalondelft.nl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230206101642.22720-1-wdehoog@exalondelft.nl>
References: <20230206101642.22720-1-wdehoog@exalondelft.nl>
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

From: Willem-Jan de Hoog <wdehoog@exalondelft.nl>

The bcm47xx module has a copy of the NVRAM data in ram. When available, use
this one instead of reading from io memory since it causes mtd/ubi to fail.

[ arinc.unal@arinc9.com: Improved patch subject and log ]

Signed-off-by: Willem-Jan de Hoog <wdehoog@exalondelft.nl>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/nvmem/brcm_nvram.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index 34130449f2d2..f74bcb1c948e 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -33,6 +33,12 @@ struct brcm_nvram_header {
 static int brcm_nvram_read(void *context, unsigned int offset, void *val,
 			   size_t bytes)
 {
+#ifdef CONFIG_BCM47XX_NVRAM
+
+	return bcm47xx_nvram_read(offset, val, bytes);
+
+#else
+
 	struct brcm_nvram *priv = context;
 	u8 *dst = val;
 
@@ -40,6 +46,8 @@ static int brcm_nvram_read(void *context, unsigned int offset, void *val,
 		*dst++ = readb(priv->base + offset++);
 
 	return 0;
+
+#endif
 }
 
 static int brcm_nvram_add_cells(struct brcm_nvram *priv, uint8_t *data,
-- 
2.37.2

