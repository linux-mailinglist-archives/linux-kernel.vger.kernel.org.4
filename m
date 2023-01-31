Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB9A682968
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjAaJrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjAaJrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:47:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA5DCA2C;
        Tue, 31 Jan 2023 01:46:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97D8861485;
        Tue, 31 Jan 2023 09:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D279C433EF;
        Tue, 31 Jan 2023 09:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675158380;
        bh=KTfxAv4/PIks1rtAcMvxbdh4fpDCyfuw7pXRReopI3Q=;
        h=From:To:Cc:Subject:Date:From;
        b=nu1hPCq9s7Jhnb2Yl9juR5sAlsr0lq6ir2BCfz3ElXtbHzNbizn+DzUNFurLSgomT
         i6X4/Ra8hBdbUiPfbOzDbJy0oYh/iigjyWBjLn2nUN4lv6N/gIpm7wsaV1Hl/UJY0O
         kJiBJ9xVBmAYzeTKP1DeMPkZYhI18L9LyB7ja6bxJh3YVfMTAWVSmfmZs+BtGEXdbz
         y3iibSwb/vaQALRn0b++qB/1GVsN6XWKAXregjKVdxV9Yf/DG2DZaMtiaZsb9LP6Sh
         ADmy6BuRHFhxWWvezjlgKYB7RGal2G2b+lYT+qYnIvozJuBH03HuRl+jIu+PC4ACNq
         k46Sj9kV/IsHA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrea Merello <andrea.merello@iit.it>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adis16480: select CONFIG_CRC32
Date:   Tue, 31 Jan 2023 10:46:11 +0100
Message-Id: <20230131094616.130238-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

In rare randconfig builds, the missing CRC32 helper causes
a link error:

ld.lld: error: undefined symbol: crc32_le
>>> referenced by usercopy_64.c
>>>               vmlinux.o:(adis16480_trigger_handler)

Fixes: 941f130881fa ("iio: adis16480: support burst read function")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/imu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
index f1d7d4b5e222..c2f97629e9cd 100644
--- a/drivers/iio/imu/Kconfig
+++ b/drivers/iio/imu/Kconfig
@@ -47,6 +47,7 @@ config ADIS16480
 	depends on SPI
 	select IIO_ADIS_LIB
 	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
+	select CRC32
 	help
 	  Say yes here to build support for Analog Devices ADIS16375, ADIS16480,
 	  ADIS16485, ADIS16488 inertial sensors.
-- 
2.39.0

