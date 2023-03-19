Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899F66C0616
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 23:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjCSWju convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 19 Mar 2023 18:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCSWjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 18:39:40 -0400
Received: from pio-pvt-msa3.bahnhof.se (pio-pvt-msa3.bahnhof.se [79.136.2.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27B11B541;
        Sun, 19 Mar 2023 15:39:37 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 9F96E3F3B7;
        Sun, 19 Mar 2023 23:39:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_FAIL,
        SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OY0vT4vyatet; Sun, 19 Mar 2023 23:39:34 +0100 (CET)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 1736D3F39F;
        Sun, 19 Mar 2023 23:39:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 962118EBD3;
        Sun, 19 Mar 2023 22:39:26 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yI31fl9Supw9; Sun, 19 Mar 2023 22:39:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 7C0CF8EBB8;
        Sun, 19 Mar 2023 22:39:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Vio5i0WGLQvN; Sun, 19 Mar 2023 22:39:20 +0000 (UTC)
Received: from rack-server-1.dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id 26FFC8EBB4;
        Sun, 19 Mar 2023 22:39:20 +0000 (UTC)
From:   =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, pgoudagunta@nvidia.com,
        hns@goldelico.com, jic23@kernel.org, lars@metafoo.de,
        =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
Subject: [PATCH 0/3] iio: adc: palmas_gpadc: add iio events
Date:   Sun, 19 Mar 2023 23:39:05 +0100
Message-Id: <20230319223908.108540-1-risca@dalakolonin.se>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These changes are based on [1] and [2].

The palmas gpadc block has support for monitoring up to 2 ADC channels
and issue an interrupt if they reach past a set threshold. This can be
configured statically with device tree todayi, but it only gets enabled
when reaching sleep mode. Also, it doesn't look like anyone is using it.

Instead of this one special case, change the code so userspace can
configure the ADC channels to their own needs through the iio events
subsystem.

Thresholds and events were tested on omap5-uevm board. It should still
be possible to wake up from sleep mode on events, but my board don't
like sleep. A userspace tool for monitoring events and adjusting
thresholds can be found at [3].

[1] https://patchwork.kernel.org/project/linux-iio/patch/20230318163039.56115-1-jic23@kernel.org/
[2] https://patchwork.kernel.org/project/linux-iio/patch/20230313205029.1881745-1-risca@dalakolonin.se/
[3] https://github.com/Risca/pyra_vol_mon


Patrik Dahlström (3):
  iio: adc: palmas_gpadc: add support for iio threshold events
  iio: adc: palmas_gpadc: remove adc_wakeupX_data
  iio: adc: palmas_gpadc: remove palmas_adc_wakeup_property

 drivers/iio/adc/palmas_gpadc.c | 527 +++++++++++++++++++++++++++------
 include/linux/mfd/palmas.h     |   8 -
 2 files changed, 434 insertions(+), 101 deletions(-)


base-commit: 37fd83916da2e4cae03d350015c82a67b1b334c4
prerequisite-patch-id: 9b1f55610800b91b721d042bf7f33b58179237d1
prerequisite-patch-id: b0418c707db13f514400956596e9ebe91c25bba0
-- 
2.25.1

