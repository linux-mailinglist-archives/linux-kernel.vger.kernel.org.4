Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46EB6FD175
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbjEIVbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjEIVbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:31:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C596983EE;
        Tue,  9 May 2023 14:29:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37C3463739;
        Tue,  9 May 2023 21:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23501C4339C;
        Tue,  9 May 2023 21:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683667219;
        bh=q2LTFwgKTWP+0shwsSHRrltK0hob6a/X7kEhfefcrlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hd9EZgc+Od8DtKXiPzqNMUtalzOxk4kxmwDDNKvWlcWcjsR3dLp9rtClg6JNvhf7T
         R45HvJko6k2ARK5xZ6dy2jiHdLq2TbNRXPv7KdY6ntUpwvuqpVfIVidBAT+zSbML7K
         qGJ06Tcq62fRIvKD/TYeWM6cjGv4Hix1gPPsy3LARz9d06kHbDZl+2mktkvIM9G3rx
         EG9HZkUw0ITUsxJ9mltnP6u/fOaydlqKhmUUgaj6GSbopWlY8cii+Q+c3LS07Ia30e
         aNlQk75JhFKBPZaawx3osnceDuJxT1Wj9qH7ol1TGj/czOOQQkkPp7VcCepH8DQ40n
         3+mI81iCudqYg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Avihai Horon <avihaih@nvidia.com>, Shay Drory <shayd@nvidia.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>, saeedm@nvidia.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, tariqt@nvidia.com, maxtram95@gmail.com,
        gal@nvidia.com, afaris@nvidia.com, dtatulea@nvidia.com,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 16/18] RDMA/mlx5: Remove pcie_relaxed_ordering_enabled() check for RO write
Date:   Tue,  9 May 2023 17:19:54 -0400
Message-Id: <20230509211958.21596-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509211958.21596-1-sashal@kernel.org>
References: <20230509211958.21596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avihai Horon <avihaih@nvidia.com>

[ Upstream commit ed4b0661cce119870edb1994fd06c9cbc1dc05c3 ]

pcie_relaxed_ordering_enabled() check was added to avoid a syndrome when
creating a MKey with relaxed ordering (RO) enabled when the driver's
relaxed_ordering_{read,write} HCA capabilities are out of sync with FW.

While this can happen with relaxed_ordering_read, it can't happen with
relaxed_ordering_write as it's set if the device supports RO write,
regardless of RO in PCI config space, and thus can't change during
runtime.

Therefore, drop the pcie_relaxed_ordering_enabled() check for
relaxed_ordering_write while keeping it for relaxed_ordering_read.
Doing so will also allow the usage of RO write in VFs and VMs (where RO
in PCI config space is not reported/emulated properly).

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Link: https://lore.kernel.org/r/7e8f55e31572c1702d69cae015a395d3a824a38a.1681131553.git.leon@kernel.org
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/mr.c                     | 6 +++---
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c | 3 +--
 drivers/net/ethernet/mellanox/mlx5/core/en_common.c | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 053fe946e45ae..8c4df71379bf3 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -67,11 +67,11 @@ static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
 	MLX5_SET(mkc, mkc, lw, !!(acc & IB_ACCESS_LOCAL_WRITE));
 	MLX5_SET(mkc, mkc, lr, 1);
 
-	if ((acc & IB_ACCESS_RELAXED_ORDERING) &&
-	    pcie_relaxed_ordering_enabled(dev->mdev->pdev)) {
+	if (acc & IB_ACCESS_RELAXED_ORDERING) {
 		if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write))
 			MLX5_SET(mkc, mkc, relaxed_ordering_write, 1);
-		if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read))
+		if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read) &&
+		    pcie_relaxed_ordering_enabled(dev->mdev->pdev))
 			MLX5_SET(mkc, mkc, relaxed_ordering_read, 1);
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 4ad19c9812944..8dbcffccee400 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -857,8 +857,7 @@ static void mlx5e_build_rx_cq_param(struct mlx5_core_dev *mdev,
 static u8 rq_end_pad_mode(struct mlx5_core_dev *mdev, struct mlx5e_params *params)
 {
 	bool lro_en = params->packet_merge.type == MLX5E_PACKET_MERGE_LRO;
-	bool ro = pcie_relaxed_ordering_enabled(mdev->pdev) &&
-		MLX5_CAP_GEN(mdev, relaxed_ordering_write);
+	bool ro = MLX5_CAP_GEN(mdev, relaxed_ordering_write);
 
 	return ro && lro_en ?
 		MLX5_WQ_END_PAD_MODE_NONE : MLX5_WQ_END_PAD_MODE_ALIGN;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
index 68f19324db93c..c7271f614fb30 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
@@ -43,7 +43,7 @@ void mlx5e_mkey_set_relaxed_ordering(struct mlx5_core_dev *mdev, void *mkc)
 	bool ro_read = MLX5_CAP_GEN(mdev, relaxed_ordering_read);
 
 	MLX5_SET(mkc, mkc, relaxed_ordering_read, ro_pci_enable && ro_read);
-	MLX5_SET(mkc, mkc, relaxed_ordering_write, ro_pci_enable && ro_write);
+	MLX5_SET(mkc, mkc, relaxed_ordering_write, ro_write);
 }
 
 int mlx5e_create_mkey(struct mlx5_core_dev *mdev, u32 pdn, u32 *mkey)
-- 
2.39.2

