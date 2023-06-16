Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15065732E53
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345000AbjFPKbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344650AbjFPK3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:29:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8617D49EC;
        Fri, 16 Jun 2023 03:27:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D3986364D;
        Fri, 16 Jun 2023 10:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43656C433C8;
        Fri, 16 Jun 2023 10:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911228;
        bh=dl9c9airJ9gRrweXyC7jRYfXSh1NGAcASrPhlq6/GFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HDATrFEDv3iXRdO+/KL/HsDIbzUQIwdjVtcLIbrX8SPIrbN9BJOPH9K54YFyhcUFG
         hZ5uOY2bFWpl+XIPyWFEkZhKwtb+Eb/Lk8x3JE/0wPTjEslkP/TDwewtEf05kBlD9x
         F3upd8Aq1mliIk/+Tqssw/3AIz9cYOhDNgbZ+eRdt8y/r/XQVNhd0AFj/O1IEXrC/H
         /1KtlxL8wnp4cNGcPuDleGNP5w9sEsrYm3p9mbEsPm4NjJjE17Dk3RJEBZSht4LK4n
         r+GYzLwg/kOWAye/U9g8t/zyYBPvzMJH3Hk+oeARvWpl1Ze1WHVkXCkgIyuCh1xsSS
         IRGuPpB4JLD9w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nitesh Shetty <nj.shetty@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        kch@nvidia.com, bvanassche@acm.org,
        damien.lemoal@opensource.wdc.com, johannes.thumshirn@wdc.com,
        vincent.fu@samsung.com, akinobu.mita@gmail.com,
        shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 19/26] null_blk: Fix: memory release when memory_backed=1
Date:   Fri, 16 Jun 2023 06:26:16 -0400
Message-Id: <20230616102625.673454-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102625.673454-1-sashal@kernel.org>
References: <20230616102625.673454-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.34
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nitesh Shetty <nj.shetty@samsung.com>

[ Upstream commit 8cfb98196cceec35416041c6b91212d2b99392e4 ]

Memory/pages are not freed, when unloading nullblk driver.

Steps to reproduce issue
  1.free -h
        total        used        free      shared  buff/cache   available
Mem:    7.8Gi       260Mi       7.1Gi       3.0Mi       395Mi       7.3Gi
Swap:      0B          0B          0B
  2.modprobe null_blk memory_backed=1
  3.dd if=/dev/urandom of=/dev/nullb0 oflag=direct bs=1M count=1000
  4.modprobe -r null_blk
  5.free -h
        total        used        free      shared  buff/cache   available
Mem:    7.8Gi       1.2Gi       6.1Gi       3.0Mi       398Mi       6.3Gi
Swap:      0B          0B          0B

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Link: https://lore.kernel.org/r/20230605062354.24785-1-nj.shetty@samsung.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/null_blk/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index c45d09a9a9421..e8cb914223cdf 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2194,6 +2194,7 @@ static void null_destroy_dev(struct nullb *nullb)
 	struct nullb_device *dev = nullb->dev;
 
 	null_del_dev(nullb);
+	null_free_device_storage(dev, false);
 	null_free_dev(dev);
 }
 
-- 
2.39.2

