Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A3F72DF42
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240494AbjFMKXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241027AbjFMKWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:22:52 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B861727;
        Tue, 13 Jun 2023 03:22:51 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-97454836448so760734466b.2;
        Tue, 13 Jun 2023 03:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686651770; x=1689243770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EUCnj0ZPld4vqxanptYEvW6XmMYghvfI8oxWwI+FpaU=;
        b=U4GmKt5dlbIp5dn+6ShMpUaKUDy5rHVKJ1V/NRI43IKoPBhCorzEe9s25aOh/7Mr+U
         m1RC3Cu3H5NwJ8XvTNDn7lByCet06z8Vhqga/i+MQtmfFCLPc5K+1RNywHB1A8zR5nmc
         mwzeBIEdqMkBaSzDY5wXSSrToxuSZyAJaDQ3aBW/GxEfxy3znUdlkYpmVdD1j2GJqVMP
         jAt71mr7oWPvU7jKz+3q/PpE82ywjeB0J1EcnJSyZ4QvnqKbmoaOFhEl59uTfWsh1x5+
         +MSTXrJVtf3DZBgxyEIHK6kl3Di9lIlAMEUXbl/L2on1o/EL5a2UhVNyKUZ7qnTsWdlA
         KQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686651770; x=1689243770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUCnj0ZPld4vqxanptYEvW6XmMYghvfI8oxWwI+FpaU=;
        b=LuxDbGabffM+z/Ofwvt8hJ5iTxCdGOyYty72Nwe8Wsp7Uh93Z9Nf2KNUdeEL+4tn1+
         iioTGnusNIzWCzCKQG7WbN/Lp1Tzh+AnorTN6yLU8cVxzx8y7f48Q/mXbR7v2Eg2TIkF
         KTVZjU7wS4RIDKEWrYg8ZyqD4yQgAAN5BAyL9kxWXbfmDlX+d5o9O2gI39MgbxYqXjH0
         lH0okrwR24T6X2XQLfNyKuZYz0U3vxVy1adDfq5laJjJ+1dixYNN0HNe9ww3nrlRgiIB
         BIWL9BnASX/iDTTyzZKPLTG7aTc/NeXGKm27GnXlw4UZNom9bMNPZwsGV0OdW43EIyxs
         f1Gg==
X-Gm-Message-State: AC+VfDymQMoEycejjbJdToH00phl01UyBe2TOe8OYU+JLgjWkvr41YPk
        8ulg2Uk0c7IcMugxhobOKk4=
X-Google-Smtp-Source: ACHHUZ6QsMbaGc2BnIgCIW4AjNHl58ydjY9MTQrkBCDBPlq/lMgdlJzqAnmgx65UrGhR1vT+B4rNKA==
X-Received: by 2002:a17:907:6d08:b0:978:992e:efc4 with SMTP id sa8-20020a1709076d0800b00978992eefc4mr11081904ejc.8.1686651769678;
        Tue, 13 Jun 2023 03:22:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:aa3f:ead8::298a])
        by smtp.gmail.com with ESMTPSA id b7-20020a170906038700b009787b18c253sm6492493eja.181.2023.06.13.03.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 03:22:49 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v6 0/7] iio: accel: Add support for Kionix/ROHM KX132-1211 accelerometer
Date:   Tue, 13 Jun 2023 12:22:33 +0200
Message-Id: <cover.1686651032.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Version 6 for adding support for the kx132-1211 accelerometer

KX132-1211 accelerometer is a sensor which:
	- supports G-ranges of (+/-) 2, 4, 8, and 16G
	- can be connected to I2C or SPI
	- has internal HW FIFO buffer
	- supports various ODRs (output data rates)

The KX132-1211 accelerometer is very similar to the KX022A. 
One key difference is number of bits to report the number of data bytes that 
have been stored in the buffer: 8 bits for KX022A vs 10 bits for
KX132-1211.

Changes in v6:
- check for availability of chip_info for the SPI case
- changed the order of elements in the kx022a_data struct to save memory

Changes in v5:
- moved the "kfree" call to match the reverse of what happens in 
  kx022a_fifo_enable() as suggested by Matti and Jonathan
- used min_t, checked for availability of chip_info and moved the
  position of u16 buf_smp_lvl_mask as suggested by Andy
- introduced buf_smp_lvl_mask in Patch 7 as suggested by Jonathan

Changes in v4:
- moved the allocation of the fifo_buffer to kx022a_fifo_enable and
  kx022a_fifo_disable
- some fixes to the regmap ranges of kx132-1211 

Changes in v3:
- added two new patches by separating the addition of the 
  i2c_device_id table and the removal of blank lines from other
  unrelated changes
- fixes a warning detected by the kernel test robot
- made all the changes related the chip_info in one patch

Changes in v2:
- added a new patch for warning when the device_id match fails in the
  probe function
- added a new patch for the function that retrieves the number of bytes
  in the buffer
- added a change to the Kconfig file in the patch adding the support
  for the kx132-1211
- various fixes and modifications listed under each patch

Mehdi Djait (7):
  dt-bindings: iio: Add KX132-1211 accelerometer
  iio: accel: kionix-kx022a: Remove blank lines
  iio: accel: kionix-kx022a: Warn on failed matches and assume
    compatibility
  iio: accel: kionix-kx022a: Add an i2c_device_id table
  iio: accel: kionix-kx022a: Refactor driver and add chip_info structure
  iio: accel: kionix-kx022a: Add a function to retrieve number of bytes
    in buffer
  iio: accel: Add support for Kionix/ROHM KX132-1211 accelerometer

 .../bindings/iio/accel/kionix,kx022a.yaml     |  12 +-
 drivers/iio/accel/Kconfig                     |   8 +-
 drivers/iio/accel/kionix-kx022a-i2c.c         |  24 +-
 drivers/iio/accel/kionix-kx022a-spi.c         |  15 +-
 drivers/iio/accel/kionix-kx022a.c             | 312 ++++++++++++++----
 drivers/iio/accel/kionix-kx022a.h             | 110 +++++-
 6 files changed, 406 insertions(+), 75 deletions(-)

-- 
2.30.2

