Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F40737B79
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjFUG1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjFUG1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:27:37 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A29F1A3;
        Tue, 20 Jun 2023 23:27:32 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id CCFDA5FD5E;
        Wed, 21 Jun 2023 09:27:29 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687328849;
        bh=N2HRZnWuvFjvEElOdblUUvxZovm+tssABjlPdSEQ1WM=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=hN0tzJhH2qasFeA6SfHCf7pXBx6CYdMSBhCmy3P2KWknggaeJYEhHsLStd1QZ6uls
         YlY7D3nEDd/VBXC4oaqaC4hN6ZtxqT870i0f2l47VtClnpoM2O+oliKdQAH9kfDZ+I
         AHuNX+my6yiqGCW+fcztAMD3crBuEVtHciXbn0FLtRxVLqa/KJPtHPmwSuEGJ1lVQ5
         2q3raK2F5PpUC7gP9mY4RR9YSCMKsO8UxBfIbPDOXbw2gz8rcGjpiA4wQFw+gXLj+5
         JpypYdP8j2Ie/V3Jc6InZDvPPD0+E7XMOfilMQmTya6/6hOA5efRk6EEs+bNWysrqM
         m32OameZJ3d3w==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 21 Jun 2023 09:27:27 +0300 (MSK)
From:   George Stark <gnstark@sberdevices.ru>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>,
        <andriy.shevchenko@linux.intel.com>, <nuno.sa@analog.com>,
        <gnstark@sberdevices.ru>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@sberdevices.ru>,
        George Stark <GNStark@sberdevices.ru>
Subject: [PATCH v1 0/3] meson saradc: add iio channels to read channel 7 mux inputs
Date:   Wed, 21 Jun 2023 09:26:07 +0300
Message-ID: <20230621062715.455652-1-gnstark@sberdevices.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/20 23:30:00 #21539802
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Stark <GNStark@sberdevices.ru>

In meson saradc channel7 is connected to muxer which allows to measure
inner sources like Vdd, GND, several Vdd dividers. This patch series
adds independent iio channel (with label) for every chan7 mux input.
Mux switch is handled transparent for clients.
This functionality can help debug\test\calibrate adc.
This code is relevant for all supported amlogic soc families

This patch series was created after discussion [1], [2]

[1] https://lore.kernel.org/lkml/20230524000111.14370-1-gnstark@sberdevices.ru/
[2] https://lore.kernel.org/lkml/20230527214854.126517-1-gnstark@sberdevices.ru/

George Stark (3):
  meson saradc: code refactoring
  meson saradc: add channel labels
  meson saradc: support reading from channel7 mux inputs

 drivers/iio/adc/meson_saradc.c | 165 +++++++++++++++++++++++----------
 1 file changed, 115 insertions(+), 50 deletions(-)

-- 
2.38.4

