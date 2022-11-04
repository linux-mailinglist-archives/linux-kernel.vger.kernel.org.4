Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42A36193D5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiKDJsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiKDJsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:48:02 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DC3E0C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 02:48:01 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id l11so6800803edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 02:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ESIFs3oJHDSvCLWap8pAAJrNAhFQntQkQpkAjXYar+4=;
        b=ihVfFMm6Vu0eGpp3JnPrLZAFKbpzMCetRS+zRcv61cnXi9YuD9HLgoUY1GGQE8ZnlL
         GLMxLjvDh44ErRKzQ1Szf+w15VIsvZCmJgokohMIb/z1jkr4Gs/FBwA2n8PAUALsgHVv
         pgzL1cv35XwScmwombqFnKqmgP9dDOVS9NoSq5lemuvmqA1J4uIVKJ6HAosSS1wZ2qo0
         PXgaXMhpZz4gh/fkyd5yTNSX4teE9SUCoO/GnJYGX4qiuErMTYj3Lobph9zKEuw3iVKR
         HrUWKVob93reAA+ql5xzkfGYIR2BZhbdDmWyq2JmR2ACtZovchKKZc4ZCeez8CDN8Oru
         B1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ESIFs3oJHDSvCLWap8pAAJrNAhFQntQkQpkAjXYar+4=;
        b=UuhIelFET/XFeiZi/lICpse1zTq6Ben2qKloYpvvIYg3p/F0Z3XZEUWOAp9j6aAB62
         XLTudnxODTckNkgDCH0ghP+iYhlDPtTeQEpE166r+70wGH5vmXDdkU3WuMJelC2/svKw
         ZkPKyZ4GwPm0sVrToaf+9o4izgu/Ef2d0ZYD7LOL/jcQZ0CFQ5LRUOI1PoBj/GT5V0PC
         Sjdwq5vuNf8n9AvxAz3a6U7naJj3tbvnDCxotcuZsrFVMABeF5Tn5kDmD5grj5GMHVuj
         ac/ednmT15+pMj4TD9qt4wKmcnbN5dn/6+bSYzpcbPE0ER+suj174Num7p+v5pTymQ5w
         V8NQ==
X-Gm-Message-State: ACrzQf2Kca116NB+egO46Qhrzh/gJs9bQ0uiYS4hLNp7r3kerK7Sz3DK
        /Bi2WuNAmyJ1U3rIGXbo/ft/s79GiNE=
X-Google-Smtp-Source: AMsMyM5ewo9+X3JXMYB4Uk+sdNSHtfne4qKDEIT8E43aoXxyhp4vD1j4FDJicN8lYCDQDnC9Xe9B5g==
X-Received: by 2002:aa7:d385:0:b0:461:8cd3:b38b with SMTP id x5-20020aa7d385000000b004618cd3b38bmr34931896edq.172.1667555280005;
        Fri, 04 Nov 2022 02:48:00 -0700 (PDT)
Received: from debian64.daheim (p5b0d7d1e.dip0.t-ipconnect.de. [91.13.125.30])
        by smtp.gmail.com with ESMTPSA id 23-20020a508757000000b004614fd33789sm1695689edv.18.2022.11.04.02.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 02:47:59 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.96)
        (envelope-from <chunkeey@gmail.com>)
        id 1oqtIt-000QPM-0E;
        Fri, 04 Nov 2022 10:47:59 +0100
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rafal@milecki.pl, srinivas.kandagatla@linaro.org,
        gregkh@linuxfoundation.org, a.fatoum@pengutronix.de
Subject: [PATCH v1] nvmem: address crc32 check on redundant-layout powerpc machines
Date:   Fri,  4 Nov 2022 10:47:59 +0100
Message-Id: <41e7ab94800b4a9aef73e212464bd94117429bec.1667555240.git.chunkeey@gmail.com>
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

The Western Digital MyBook Live (PowerPC 464/APM82181)
has a set of redundant u-boot-env. Loading up the driver
causes it to error out with:

| u_boot_env: Invalid calculated CRC32: 0x4f8f2c86 (expected: 0x98b14514)
| u_boot_env: probe of partition@1e000 failed with error -22

Looking up the userspace libubootenv utilities source [0],
it looks like the "mark" or "flag" is not part of the
crc32 sum... which is unfortunate :(

|static int libuboot_load(struct uboot_ctx *ctx)
|{
|[...]
|       if (ctx->redundant) {
|		[...]
|               offsetdata = offsetof(struct uboot_env_redund, data);
|		[...]
|       }
|       usable_envsize = ctx->size - offsetdata;
|       buf[0] = malloc(bufsize);
|[...]
|	for (i = 0; i < copies; i++) {
|		data = (uint8_t *)(buf[i] + offsetdata);
|               uint32_t crc;
|
|		ret = devread(ctx, i, buf[i]);
|		[...]
|		crc = *(uint32_t *)(buf[i] + offsetcrc);
|               dev->crc = crc32(0, (uint8_t *)data, usable_envsize);
|

Now, this alone didn't fully fix the kernel's uboot-env nvmem
driver. The driver then ran into an endian error on the
big-endian powerpc device:

| u_boot_env: Invalid calculated CRC32: 0x1445b198 (expected: 0x98b14514)

however the __le32 type for the crc32 value is justified because the
the crc32() is just a macro for crc32_le(). So, to side-step that
problem, the crc32 check gets extended to also accept a byteswapped
crc32.

[0] https://github.com/sbabic/libubootenv/blob/master/src/uboot_env.c#L951
Fixes: d5542923f200 ("nvmem: add driver handling U-Boot environment variables")
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
Might it be better to add a dt-property (I wouldn't piggy-pack on
the existing big-endian;) to specify that the crc32 value stored
in the flash/rom is swapped?
---
 drivers/nvmem/u-boot-env.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 8e72d1bbd649..f78e2f5d2ef1 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -135,7 +135,7 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		break;
 	case U_BOOT_FORMAT_REDUNDANT:
 		crc32_offset = offsetof(struct u_boot_env_image_redundant, crc32);
-		crc32_data_offset = offsetof(struct u_boot_env_image_redundant, mark);
+		crc32_data_offset = offsetof(struct u_boot_env_image_redundant, data);
 		data_offset = offsetof(struct u_boot_env_image_redundant, data);
 		break;
 	}
@@ -144,7 +144,11 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 	data_len = priv->mtd->size - data_offset;
 
 	calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
-	if (calc != crc32) {
+	/*
+	 * also accept byteswapped crc32 values for compatibility with
+	 * existing legacy powerpc devices and userspace tools.
+	 */
+	if (calc != crc32 && calc != swab32(crc32)) {
 		dev_err(dev, "Invalid calculated CRC32: 0x%08x (expected: 0x%08x)\n", calc, crc32);
 		err = -EINVAL;
 		goto err_kfree;
-- 
2.38.1

