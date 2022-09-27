Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0675EC11F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbiI0LXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiI0LWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:22:51 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768C513C86E;
        Tue, 27 Sep 2022 04:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1664277701;
  x=1695813701;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h7GywIaLDpaaXMq+bfRFzam8dsivXNekzUyZgu12Jds=;
  b=UeNSzlgIq4jOf6qEanfXMu57mF/IXqYC6rVJRG7HwXpM0gNgdisqXZxU
   12JtbyBrbZO8hMuOALT5rTRPXKTghWBIF8ImvU2redjCbpgrg27VSQooW
   FchmKGkZ/e1sjN96773hqopa4P3e0+dnv6mB4W/F9SpDkQ5YjGimshh33
   ECwpyEdheytthxYuoCQ5J1QDCzz1LkGHQGVPdvRL9i/02V50BOw8fX4pM
   OgZLXFYlz1/Ztx6MJnIgfpTN22yvaBzU6GIcZVGm3EciUdY5hfNmY5fFf
   DwOYAuEylmLe1Vpsi6031tbo3NS/rdvMtIxpWF1CAOJvK+1XDuT6oa51a
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <broonie@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <andi@etezian.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <alim.akhtar@samsung.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 0/4] spi: Fix DMA bugs in (not only) spi-s3c64xx
Date:   Tue, 27 Sep 2022 13:21:13 +0200
Message-ID: <20220927112117.77599-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- Drop merged patch adding new test to spi-loopback-test
- Fix compiler warning in !HAS_DMA builds
- Add support to split transfers to core

This series fixes some bugs I found while running spi-loopback-test with
spi-s3c64xx.  The first problem (which I actually noticed while trying to fix
the second problem with transfers >64KiB) seems to be a generic issue which
affects several drivers so I fixed it in the core.

The series has been tested on ARTPEC-8, which has a version of the IP similar
to Exynos 7 and with 64 byte FIFOs (compatible with "tesla,fsd-spi").

Cc: alim.akhtar@samsung.com
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Vincent Whitchurch (4):
  spi: Save current RX and TX DMA devices
  spi: Fix cache corruption due to DMA/PIO overlap
  spi: Split transfers larger than max size
  spi: s3c64xx: Fix large transfers with DMA

 drivers/spi/spi-s3c64xx.c |   9 +++
 drivers/spi/spi.c         | 137 ++++++++++++++++++++++++++++----------
 include/linux/spi/spi.h   |   4 ++
 3 files changed, 114 insertions(+), 36 deletions(-)

-- 
2.34.1

