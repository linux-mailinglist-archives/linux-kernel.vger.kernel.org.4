Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE80C734306
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 20:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbjFQSZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 14:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbjFQSZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 14:25:48 -0400
Received: from s.wrqvtzvf.outbound-mail.sendgrid.net (s.wrqvtzvf.outbound-mail.sendgrid.net [149.72.126.143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06D91988
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 11:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:mime-version:to:cc:content-transfer-encoding:
        content-type:cc:content-type:from:subject:to;
        s=s1; bh=EZjVZREN01PWnkecDc4m5lCo/JtuKVVXTJsEdeEOdg8=;
        b=hQDnLUHbQZH9KfpZwBRovWXzOu/XVbbjTrf3x1f6Dy5nxloVFie4p2zywi6melbP46GZ
        /fa3V+mdDUVCSeSkF9Fn4PWKGzoonbL/iBsAf0lHvKzJWxGOJbS5LTEn/lya3lNIIhKG38
        KuabaFAJ1KJVyJ9SisKR0BltkU8mpg6G+KGEHEQywZ17ywqFERJPnXQF3Qy3Ja1KmQUpDF
        HGZ/Vq1vJlGASgSp1ASaXO5ILstboC1IyDMnW4GJvA1aFun+8RpL+b5tKdLXFfVRMvxD91
        wbcKS/bYbacqyP/YTrnachADeSsbRQ3P/DP+B6MJup0mmcO+BnJ6FmR4zeilxJqw==
Received: by filterdrecv-d7bbbc8bf-zf9x9 with SMTP id filterdrecv-d7bbbc8bf-zf9x9-1-648DFAA7-10
        2023-06-17 18:25:43.829440288 +0000 UTC m=+3264351.627270026
Received: from bionic.localdomain (unknown)
        by geopod-ismtpd-9 (SG)
        with ESMTP
        id Nw1GHX5WQdWvCqSwbmqvyw
        Sat, 17 Jun 2023 18:25:43.459 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 0/2] iommu: rockchip: Fix directory table address encoding
Date:   Sat, 17 Jun 2023 18:25:44 +0000 (UTC)
Message-Id: <20230617182540.3091374-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h4BqyTv2htkF2lNGw?=
 =?us-ascii?Q?0iSDwD2SgTmfxp5qa7u3fdNgmCQtZ+zr8KKPzgj?=
 =?us-ascii?Q?baUueHLCyyWpIyByEJgWIV0EZo4DoeE64EZlTF6?=
 =?us-ascii?Q?811Y0BSr4NzvT9u=2FI1j=2FXC9k6imxCoAgbAF1BJ5?=
 =?us-ascii?Q?Tlo9TmoyBhVMBIytEB+Scpid+0CN4u8FEXrfKn?=
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The address to the directory table is currently encoded using an
incorrect bit layout when configured into the DTE_ADDR reg on IOMMU v2.

This currently do not cause any issue because the directory and page
tables is allocated in memory below 4GB thanks to the use of the
GFP_DMA32 flag.

Testing has shown that the directory table address should be encoded
using the same bit layout as the page table and memory page addresses.

Only removing the GFP_DMA32 on a RK3568 device with 8GB of memory will
result in a page fault similar to:

[    0.907236] rk_iommu fe043e00.iommu: Page fault at 0x00000000ff801000 of type read
[    0.907264] rk_iommu fe043e00.iommu: iova = 0x00000000ff801000: dte_index: 0x3fe pte_index: 0x1 page_offset: 0x0
[    0.907281] rk_iommu fe043e00.iommu: mmu_dte_addr: 0x000000010189a000 dte@0x000000010189aff8: 0x1722101 valid: 1 pte@0x0000000101722004: 0x2c01107 valid: 1 page@0x0000000102c01000 flags: 0x106

This series fixes this by using the existing mk_dtentries instead of the
dma_addr_dte ops to encode the directory table address, removes unused
ops and finally removes the GFP_DMA32 flag to allow for directory and
page tables to be allocated in memory above 4GB on IOMMU v2.

Changes in v3:
- merge patch 1 and 2
- only remove GFP_DMA32 flag for IOMMU v2

Changes in v2:
- no changes, rebased on next-20230615

This series can also be found at [1].

[1] https://github.com/Kwiboo/linux-rockchip/commits/next-20230616-iommu

Jonas Karlman (2):
  iommu: rockchip: Fix directory table address encoding
  iommu: rockchip: Allocate tables from all available memory for IOMMU
    v2

 drivers/iommu/rockchip-iommu.c | 50 +++++++---------------------------
 1 file changed, 10 insertions(+), 40 deletions(-)

-- 
2.40.1

