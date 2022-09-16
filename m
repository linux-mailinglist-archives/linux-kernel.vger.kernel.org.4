Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C605BAC9A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiIPLkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiIPLj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:39:57 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058E329CAA;
        Fri, 16 Sep 2022 04:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663328395;
  x=1694864395;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vf3z5znW0KooHgZEWacieLyXs7JGdr3NGOK/5vrCD1M=;
  b=eFy+FW6CHrDWf1kO4Y3dIcd4NPx0J4mm+wXoPThFKfHkvERl1A7zD7ij
   3b1SFjJ0lcT2R39ytQ5GY4vnH6GEzbUPo4/T+Ytn4Rc6W31WEMm1pkUey
   mivygkCkkv0oJun6VFxS4W3YuCo1MvCNtqr+Zr+kfOUGmKLPDJiZN8Zs3
   UaINdzhG4flDqT5HlI3Q5sE30KNAnizc5oEPEHnAI2aFKxbTkEsYUbmwM
   /vfPauScaAR/FYcg+BAf36ZwiXaLgSdjdv13icUCY3AIR7+XtkOSiSwuq
   Fb9PPmBsLtkhBGDNeOHHnh1ShJdVwltxvFKAZjOlOVSnrtS5HuASMbRF+
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <broonie@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <andi@etezian.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <alim.akhtar@samsung.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/4] spi: Fix DMA bugs in (not only) spi-s3c64xx
Date:   Fri, 16 Sep 2022 13:39:47 +0200
Message-ID: <20220916113951.228398-1-vincent.whitchurch@axis.com>
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
  spi: spi-loopback-test: Add test to trigger DMA/PIO mixing
  spi: Save current RX and TX DMA devices
  spi: Fix cache corruption due to DMA/PIO overlap
  spi: s3c64xx: Fix large transfers with DMA

 drivers/spi/spi-loopback-test.c |  27 +++++++
 drivers/spi/spi-s3c64xx.c       |  10 +++
 drivers/spi/spi.c               | 126 +++++++++++++++++++++++---------
 include/linux/spi/spi.h         |   4 +
 4 files changed, 131 insertions(+), 36 deletions(-)

-- 
2.34.1

