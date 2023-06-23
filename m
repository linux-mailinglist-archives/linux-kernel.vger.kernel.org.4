Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB6073AE8C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 04:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjFWCYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 22:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjFWCX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 22:23:58 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8609A1BCA;
        Thu, 22 Jun 2023 19:23:52 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 7B5075FD1D;
        Fri, 23 Jun 2023 05:23:49 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687487029;
        bh=4DyGjQMn+es+mH1vT9Y4V2O51Aluf6NSHZpaGh0GwY0=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=egT3vADQODLoHOyyZ7SxtoiA1XgL2C/KMR5zVFMcaEaTfO4kFaAkoA+ALrH6oHxGg
         W17FPY1cf4laxvuSLq9c5q07U8rN2aZ66N4KNth0rYJzv2FZOFXfSupVfpEAehAV31
         uFx/aD3TMZiLU5BgbyeXVdQwSRzM3+dqrsSs2QqZl8IX4WGg+Qj1o++u9flm1SXphH
         Opg0V4lG0Yy8DOttA/pscRjTHJ7rxAVebIYT3Gm20IKCwyB/nkhfpnz1I2Mm2b9Cvk
         licMT//odGa2Hr3RZw9qQTva8meYMwHIkqZWH+FLKZG9NVM5Bclhj9GVzKG+SPIGzC
         4XA7/1SA95mZg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri, 23 Jun 2023 05:23:46 +0300 (MSK)
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
Subject: [PATCH v2 0/6] meson saradc: add iio channels to read channel 7 mux inputs
Date:   Fri, 23 Jun 2023 05:20:08 +0300
Message-ID: <20230623022334.791026-1-gnstark@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/22 21:10:00 #21557945
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

Hello Andy

Thanks for review.

Changelog:
v1->v2:
split refactoring patch [1] into 4 smaller patches, fix comment style

[1] https://lore.kernel.org/lkml/20230621062715.455652-2-gnstark@sberdevices.ru/

George Stark (6):
  meson saradc: move enums declaration before variables declaration
  meson saradc: move meson_sar_adc_set_chan7_mux routine upper
  meson saradc: unite iio channel array definitions
  meson saradc: add enum for iio channel array indexes
  meson saradc: add channel labels
  meson saradc: support reading from channel7 mux inputs

 drivers/iio/adc/meson_saradc.c | 164 +++++++++++++++++++++++----------
 1 file changed, 114 insertions(+), 50 deletions(-)

-- 
2.38.4

