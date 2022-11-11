Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33955625355
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 07:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiKKGHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 01:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbiKKGGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 01:06:55 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4316D623B9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 22:06:50 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id v28so4048674pfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 22:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o8qCR2kQV/G3rlCD/io98swL+E5jJJbXa7meHBVW8/o=;
        b=oG+pymicBK/qTgzMQxNYX1A08D6VEuMZp1ec4nW7iJhx+3l5tvW5Wzy5SLbwWgk/SX
         Ry3EfbLSaHpb0e4UpAmT9/gOkOqh71giqI/ZM8H6tE1L20lN02NrxPjrOZ0GzFtamMx3
         pLYApNX7GS+K3Xr2UhNY4OMOlL+FYu1nSGG8JE/9AvNvcBQ5Xe3ToQ5ArBhE+iRHbMVQ
         Ni6Z0IFSePoG6CQa1qy4/VRKuDsF5MpclIUoQxx0drj+1uiVSrfeLKo9rJCvb6+/XABN
         9HMet0dqTzdcoit8vyQsB6w/WezhQpd4EgY+S6jm3z56pnW1kyock1bVxC/KHfPNR79U
         Lw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8qCR2kQV/G3rlCD/io98swL+E5jJJbXa7meHBVW8/o=;
        b=RlbiTVKchqmlVE7EMdPTOyAlVVWFHvESfVE5opVAQwwepuJuSRPr2W/9DJowD6WJ+L
         qck+qxUksatGXDpTJHNGiQi0V3E3SWVz2AbTT3z7XL55wv7wC3nTWxWURuDV5aYsIYb6
         EKsg5yKhCt6yxKkHqT0rxgIc0kF5v4CamejGFb+yzcMqumaY+/ZgA5F+oY3esWbZ5FP/
         NlfGjJPCgdER472dkZpSSdtnIsZxU3sOhd0KatBOrPlRTdu0huIvAQm7DFuf+M47rT1M
         audhP3KCyR3Ywzg/DqjH3wZrwhb6Hfz1feNZMcRhjR1hweNFtWTpHQpTQ7+l3nptJ4VU
         5YHA==
X-Gm-Message-State: ANoB5pmy6EYRNzj8sXIKpWQCf4DpNRechbEJerhAxv9bZWhkMhrkvRWq
        6FcHoXWgQvptQeAb0vy5SmB9Molpw00=
X-Google-Smtp-Source: AA0mqf7Dh6RKOAqPaWFaPHdPb+WSoRG+awiml/Qw4ROHAetoq7X1iVVXBgNSpslv6yIupg0it/qKTA==
X-Received: by 2002:a65:588c:0:b0:434:b8ef:1ec6 with SMTP id d12-20020a65588c000000b00434b8ef1ec6mr385852pgu.246.1668146809695;
        Thu, 10 Nov 2022 22:06:49 -0800 (PST)
Received: from localhost.localdomain.dhcpserver.bu9bmc.local (1-34-79-176.hinet-ip.hinet.net. [1.34.79.176])
        by smtp.gmail.com with ESMTPSA id j30-20020a63fc1e000000b0045ff216a0casm622827pgi.3.2022.11.10.22.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 22:06:49 -0800 (PST)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>,
        Potin Lai <potin.lai.pt@gmail.com>
Subject: [RESEND PATCH v4 1/1] mtd: spi-nor: winbond: Add support for w25q01jvq
Date:   Fri, 11 Nov 2022 14:05:30 +0800
Message-Id: <20221111060530.2201084-1-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.31.1
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

From: Potin Lai <potin.lai@quantatw.com>

Add support for winbond w25q01jvq chip

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
Reviewed-by: Michael Walle <michael@walle.cc>
Signed-off-by: Joel Stanley <joel@jms.id.au>

---
LINK: [v3] https://lore.kernel.org/all/20220222085148.21594-1-potin.lai@quantatw.com/
LINK: [v2] https://lore.kernel.org/all/20220222064227.16724-1-potin.lai@quantatw.com/
LINK: [v1] https://lore.kernel.org/all/20211224104522.24615-1-potin.lai@quantatw.com/

Changes v3 --> v4:
- fix correct chip name "w25q01jvq"

root@bletchley:~# cat /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/jedec_id
ef4021
root@bletchley:~# cat /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/manufacturer
winbond
root@bletchley:~# cat /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/partname
w25q01jvq
root@bletchley:~# md5sum /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp
a7b9dbf76e99a33db99e557b6676588a /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp
root@bletchley:~# hexdump -C /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp
00000000  53 46 44 50 06 01 01 ff  00 06 01 10 80 00 00 ff  |SFDP............|
00000010  84 00 01 02 d0 00 00 ff  03 00 01 02 f0 00 00 ff  |................|
00000020  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
*
00000080  e5 20 fb ff ff ff ff 3f  44 eb 08 6b 08 3b 42 bb  |. .....?D..k.;B.|
00000090  fe ff ff ff ff ff 00 00  ff ff 40 eb 0c 20 0f 52  |..........@.. .R|
000000a0  10 d8 00 00 36 02 a6 00  82 ea 14 e2 e9 63 76 33  |....6........cv3|
000000b0  7a 75 7a 75 f7 a2 d5 5c  19 f7 4d ff e9 70 f9 a5  |zuzu...\..M..p..|
000000c0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
000000d0  ff 0a f0 ff 21 ff dc ff                           |....!...|
000000d8

Changes v2 --> v3:
- move spi-nor flash information to comment area

Changes v1 --> v2:
- rework patch to work with new flags
---
 drivers/mtd/spi-nor/winbond.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index ffaa24055259..e60ad92c0ace 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -139,6 +139,8 @@ static const struct flash_info winbond_nor_parts[] = {
 	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ) },
+	{ "w25q01jvq", INFO(0xef4021, 0, 64 * 1024, 2048)
+		PARSE_SFDP },
 };
 
 /**
-- 
2.31.1

