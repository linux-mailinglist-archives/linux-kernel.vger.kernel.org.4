Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BAD5BECFC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiITSsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiITSr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:47:58 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1FD719B8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:47:57 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id i203-20020a1c3bd4000000b003b3df9a5ecbso7532363wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=e1rax8zHktkJE4NlsAmrfBmfy6JQLwKUdVTmbuE0Kvk=;
        b=a/n6KLKyuuFnUM9vPXO3YclSzmLnz5UmmI77Eu3qAaW7GkwFECSgfrEM4d7ThRkn+b
         ZTMsEBSKTuD7zZiQVnWgjr07lcGlSZ9GvvEgMm0rhzp6C0aGUGevKgOvhoTx7JxtonZC
         cRH+h/UsrueXTDj97dWDJ+LJl89I4BlMeysqwnhpKoX3kUbWiKuuMaXAF8Zpx1L8spQA
         Hk/fmXNFF5Mygf7rmhKqwumIZA0iLEqpSsNbVh8OcqU9iYKYY9QYErbSUiNfkFYXOFPR
         LAi4v5NqDj/zYgN5BQZ8iCvyfyDZ/LxZM9kQpWnHtWqeAGSezF8VPy4ng6kbwnRmQpE9
         Sp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=e1rax8zHktkJE4NlsAmrfBmfy6JQLwKUdVTmbuE0Kvk=;
        b=G3bmRkog5Qz752B53brzHv5a4p7ccSAlPPokywoq+WkpZ+5KJZqJ5PDfl2IygLXZIf
         fgEN6Jb30SvuAITGF1Vk9sbU3D9R8bDRKQgUFbzT/xHHMACI/V1ZDlI+316rWaKUJv6T
         BR7dzppe+2U5F/mEHe16emiEgywTRlw9+lwNsMsEvAI7t9l6ZDN4J2/mLIiGJu1dsBTr
         erwsAj1Izb6o9y0stR3BvYSQinpM/o3v61/vpZ4ea7+HqZ/ALYLTwjyKaJ6NIBlKXy8x
         5zRK4jBy54fcD4w5axzmehkwUGe+1jpyE024/SLPAmP4uOjbbB/uDsnnzYcfdM9tXfzc
         MYVQ==
X-Gm-Message-State: ACrzQf342aZffEe/Ba+3L59VJHVPkAMyk0HEpGYUsiOe/XRFCgKy0vXn
        4zbjyMMgQX0oW4SyZs5gbbYhtg==
X-Google-Smtp-Source: AMsMyM4R92uxH1TZaMut6DsSvvNnopmxhOhsLA3A+9DuCP3Acj5edYh4JdyiyzPrQqGkRn4eb4NHpQ==
X-Received: by 2002:a05:600c:310b:b0:3b4:c709:4322 with SMTP id g11-20020a05600c310b00b003b4c7094322mr3342558wmo.141.1663699676003;
        Tue, 20 Sep 2022 11:47:56 -0700 (PDT)
Received: from localhost.localdomain (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id id21-20020a05600ca19500b003b27f644488sm507061wmb.29.2022.09.20.11.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 11:47:55 -0700 (PDT)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH v3 1/2] mtd: spi-nor: issi: is25wp256: Init flash based on SFDP
Date:   Tue, 20 Sep 2022 19:47:48 +0100
Message-Id: <20220920184748.44812-1-sudip.mukherjee@sifive.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The datasheet of is25wp256 says it supports SFDP. Get rid of the static
initialization of the flash parameters and init them when parsing SFDP.

Testing showed the flash using SPINOR_OP_READ_1_1_4_4B 0x6c,
SPINOR_OP_PP_4B 0x12 and SPINOR_OP_BE_4K_4B 0x21 before enabling SFDP.
After this patch, it parses the SFDP information and still uses the
same opcodes.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---

No change from v2, just resending again with the next patch.
Results from the tests given by Tudor in the following mail.


 drivers/mtd/spi-nor/issi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index 89a66a19d754f..8b48459b5054c 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -71,7 +71,7 @@ static const struct flash_info issi_nor_parts[] = {
 	{ "is25wp128",  INFO(0x9d7018, 0, 64 * 1024, 256)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 512)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
+		PARSE_SFDP
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
 		.fixups = &is25lp256_fixups },
 
-- 
2.30.2

