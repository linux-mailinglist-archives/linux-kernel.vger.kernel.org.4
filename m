Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131127320A3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 22:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbjFOUKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 16:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjFOUKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 16:10:48 -0400
Received: from s.wrqvtbkv.outbound-mail.sendgrid.net (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A88F12E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:mime-version:to:cc:content-transfer-encoding:
        content-type:cc:content-type:from:subject:to;
        s=s1; bh=If/pDcNZHjKHg2xr7fPICwEYrvkMiPF0Yu0cd9xm+8c=;
        b=GozorMfIUTKX2p3yMPpaBV0J/anZcRNzQgygrAoAMUjiXVA02nBHk2H3MTrL64UPq0dK
        IW61phWauueZvWEkTK4KTjgePv9b92oV9I8Ez81pzG7hub3pPoWkXydF6hbp1N6f6FvJlm
        D+tKbsk6sW4+Y0evTou3YOc+ycEPTDXxcRJbyuBdPty63gSiFnSFM5NshpkYxuT/Cx5SMD
        o5I1gfiEqF9FS56eCG5eB7eNGPrpbsmfLmbM8yMUmz05oEd/GvvYB9gqKHWuOe9vT3twAJ
        0j4CLyM9I/5f6eC8tddHTrMHudrlc6DvtTTsOzKHgLgwbgkiF/34Pn40nODWvSPQ==
Received: by filterdrecv-77869f68cc-lcgp6 with SMTP id filterdrecv-77869f68cc-lcgp6-1-648B7045-14
        2023-06-15 20:10:45.330247636 +0000 UTC m=+3098087.523654011
Received: from bionic.localdomain (unknown)
        by geopod-ismtpd-5 (SG)
        with ESMTP
        id M8m6e9nORhaWVL_Bj7hb3A
        Thu, 15 Jun 2023 20:10:44.821 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/3] iommu: rockchip: Fix discovery table address encoding
Date:   Thu, 15 Jun 2023 20:10:45 +0000 (UTC)
Message-Id: <20230615201042.2291867-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h7eTuGAfP89fgI7Mo?=
 =?us-ascii?Q?5nZ7wt3U4bGdn6ikkP5Zd3dO0neB=2F5LK2JyiBDO?=
 =?us-ascii?Q?u29YKFWbCeBwjYkAy19YoMXMyir3tW3Djs8Cmyd?=
 =?us-ascii?Q?bvTCCbo8Lg1QCFsZ6+tUPrYOuM8SdhbXytKQ3C0?=
 =?us-ascii?Q?9gB+krmM7OAnfyHJYcRjcyFRsjqk6rJeFQEv+0?=
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a re-send of a series sent out in January, see [1].

The address to the discovery table is currently encoded using an
incorrect bit layout when configured into the MMU_DTE_ADDR reg.

This currently do not cause any issue because the discovery and page
tables is allocated in memory below 4GB thanks to the GFP_DMA32 flag.

Testing has shown that the discovery table address should be encoded
using the same bit layout as the page table and memory page addresses.

Removing the GFP_DMA32 on a RK3568 with 8GB of memory will result in:

[    0.907236] rk_iommu fe043e00.iommu: Page fault at 0x00000000ff801000 of type read
[    0.907264] rk_iommu fe043e00.iommu: iova = 0x00000000ff801000: dte_index: 0x3fe pte_index: 0x1 page_offset: 0x0
[    0.907281] rk_iommu fe043e00.iommu: mmu_dte_addr: 0x000000010189a000 dte@0x000000010189aff8: 0x1722101 valid: 1 pte@0x0000000101722004: 0x2c01107 valid: 1 page@0x0000000102c01000 flags: 0x106

This series fixes this by using the existing mk_dtentries instead of the
dma_addr_dte ops to encode the discovery table address, removes unused
ops and finally removes the GFP_DMA32 flag to allow for discovery and
page tables to be allocated in memory above 4GB.

Changes in v2:
- no changes, rebased on next-20230615

This series can also be found at [2].

[1] https://lore.kernel.org/all/20230125221809.3275481-1-jonas@kwiboo.se/
[2] https://github.com/Kwiboo/linux-rockchip/commits/next-20230615-iommu

Jonas Karlman (3):
  iommu: rockchip: Fix discovery table address encoding
  iommu: rockchip: Remove unused variant ops
  iommu: rockchip: Allocate tables from all available memory

 drivers/iommu/rockchip-iommu.c | 45 +++++-----------------------------
 1 file changed, 6 insertions(+), 39 deletions(-)

-- 
2.40.1

