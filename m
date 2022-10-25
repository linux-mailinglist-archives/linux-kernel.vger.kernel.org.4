Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB68660CCE4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbiJYND2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbiJYNCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:02:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50698CC82E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:00:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lgo@pengutronix.de>)
        id 1onJY9-0005ei-Ga; Tue, 25 Oct 2022 15:00:57 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <lgo@pengutronix.de>)
        id 1onJY9-000JYF-OD; Tue, 25 Oct 2022 15:00:56 +0200
Received: from lgo by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <lgo@pengutronix.de>)
        id 1onJY7-00Dg1R-Re; Tue, 25 Oct 2022 15:00:55 +0200
From:   =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de
Subject: [PATCH v2 0/2] iio: adc: add ADC driver for the TI LMP92064
Date:   Tue, 25 Oct 2022 15:00:22 +0200
Message-Id: <20221025130023.3259128-1-l.goehrs@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: lgo@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Changes from v1 -> v2:

 - Rebase from 6.0 to 6.1-rc2 to get access to devm_regulator_get_enable.
 - Use regmap instead of raw SPI commands. This fixes multiple issues:
   - Remove need to assemble register address using bit shifts.
   - Remove non DMA-safe stack-allocated buffers.
   - Regmap has internal lock handling, removing the need for locking in the
     driver read code using mlock.
 - Use be16_to_cpu() instead of manually assembling values using bit shifts.
 - Use generic device_property_read_u32() instead of devicetree specific
   of_property_read_u32().
 - Rename the "shunt-resistor" devicetree property to
   "shunt-resistor-micro-ohms".
 - Add supply regulator support for the two voltage domains of the chip
   (vdd and vdig).
 - Only perform soft reset if no GPIO line for hard resets is available.
 - Change the error returned if the device does not respond after a reset
   from "EBUSY" to "ENXIO" to indicate that this is likely a persistent
   error (like a broken connection).
 - Don't set the SPI mode manually.
 - Provide a spi_device_id table.
 - Declare local variables in reverse christmas tree order.
 - Fix formatting of multi-line comments and some whitespace issues.
 - Fix typos and missing "allOf:$ref to spi-peripheral-props.yaml"
   in devicetree bindings.

See https://lore.kernel.org/lkml/20221004134238.3144326-1-l.goehrs@pengutronix.de/
for the v1.
 
Thanks to Marcus, Jonathan and Krzysztof for the reviews.

