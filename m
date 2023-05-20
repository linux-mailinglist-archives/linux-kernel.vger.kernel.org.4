Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD79C70A9BC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjETSTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjETST2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:19:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086DEE7F;
        Sat, 20 May 2023 11:19:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB40660B37;
        Sat, 20 May 2023 18:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94668C433D2;
        Sat, 20 May 2023 18:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684606701;
        bh=OXkMsN4v3FFJULQWV4/kyARqFXtJzpyCewzKLaeiJl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y3x6GOLI7JStr8G9AQR5hFU6UYiGBGCaRg2PLpv2iPhDyavlpXp6VAAjIRNDDOHZo
         2B6a2f/dAM22XfZ587AZjsC0unoFdIOCPdh/y+C69Ja4stJgi+f+Z5gNRcfn82sVLU
         hdyXWmjnUKEfhuHo6pDrz37nZVaAZBNOmXeFarPdF3L7k8jHOwvitw9RUh/iIQqabO
         AM9mpJchRTvdJWH/MY39HM7zl2TdJzaXdzMdnTp9wMv8Yq3pBZMJjz5zO11SkaoTUf
         BeqxJr7PiAPjeedCeC+w/l0qj/JBUbwDtRFPXm0UMatX5qlEJMbsBpPypDClyBX3TD
         Bu1eyfBGFH+ug==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Liming Sun <limings@nvidia.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 10/18] platform/mellanox: fix potential race in mlxbf-tmfifo driver
Date:   Sat, 20 May 2023 14:17:42 -0400
Message-Id: <20230520181750.823365-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520181750.823365-1-sashal@kernel.org>
References: <20230520181750.823365-1-sashal@kernel.org>
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

From: Liming Sun <limings@nvidia.com>

[ Upstream commit 3d43f9f639542fadfb28f40b509bf147a6624d48 ]

This commit adds memory barrier for the 'vq' update in function
mlxbf_tmfifo_virtio_find_vqs() to avoid potential race due to
out-of-order memory write. It also adds barrier for the 'is_ready'
flag to make sure the initializations are visible before this flag
is checked.

Signed-off-by: Liming Sun <limings@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Link: https://lore.kernel.org/r/b98c0ab61d644ba38fa9b3fd1607b138b0dd820b.1682518748.git.limings@nvidia.com
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/mellanox/mlxbf-tmfifo.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 91a077c35b8b8..a79318e90a139 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -784,7 +784,7 @@ static void mlxbf_tmfifo_rxtx(struct mlxbf_tmfifo_vring *vring, bool is_rx)
 	fifo = vring->fifo;
 
 	/* Return if vdev is not ready. */
-	if (!fifo->vdev[devid])
+	if (!fifo || !fifo->vdev[devid])
 		return;
 
 	/* Return if another vring is running. */
@@ -980,9 +980,13 @@ static int mlxbf_tmfifo_virtio_find_vqs(struct virtio_device *vdev,
 
 		vq->num_max = vring->num;
 
+		vq->priv = vring;
+
+		/* Make vq update visible before using it. */
+		virtio_mb(false);
+
 		vqs[i] = vq;
 		vring->vq = vq;
-		vq->priv = vring;
 	}
 
 	return 0;
@@ -1302,6 +1306,9 @@ static int mlxbf_tmfifo_probe(struct platform_device *pdev)
 
 	mod_timer(&fifo->timer, jiffies + MLXBF_TMFIFO_TIMER_INTERVAL);
 
+	/* Make all updates visible before setting the 'is_ready' flag. */
+	virtio_mb(false);
+
 	fifo->is_ready = true;
 	return 0;
 
-- 
2.39.2

