Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD227114D7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjEYSiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241838AbjEYShm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:37:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D2DE73;
        Thu, 25 May 2023 11:36:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C4F5648CF;
        Thu, 25 May 2023 18:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A077DC433D2;
        Thu, 25 May 2023 18:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039761;
        bh=6JCHwVKxkQsQPrUJDGy2mxc74mHzyJx+YWHEXdPHPCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NJSc4TZKzPMbtoAH8hPMwJ5F1kqeiw/8T47mYaXhwUoxEPPREpQDHqp7H9ZoLaV9z
         QsJv5KqCaXXeKZ9bhorlf8SUokSLuAbICXJIJT70zRTNkf/+0hMCkMO2runxHsF52W
         kzyqNkAt4YSb0wtLW4PEJFhKTAz6rvbUgL99RQei+eLiOln3f2hbd9UY5Ryth93IzM
         MB7H42D5U/mV4PTKo6h1dI4QuVXgntPJ9BTiFXIhsY4dZFvhTgu1tyJTTU2FuM98Ex
         QimvncThsZ5+/9mI3PAEp9NwjQrpTC3Uo8Nai7K+GjycrPrsN6kIpSZcdA4INNxClP
         H717HONKdMWJA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 65/67] ublk: fix AB-BA lockdep warning
Date:   Thu, 25 May 2023 14:31:42 -0400
Message-Id: <20230525183144.1717540-65-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183144.1717540-1-sashal@kernel.org>
References: <20230525183144.1717540-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit ac5902f84bb546c64aea02c439c2579cbf40318f ]

When handling UBLK_IO_FETCH_REQ, ctx->uring_lock is grabbed first, then
ub->mutex is acquired.

When handling UBLK_CMD_STOP_DEV or UBLK_CMD_DEL_DEV, ub->mutex is
grabbed first, then calling io_uring_cmd_done() for canceling uring
command, in which ctx->uring_lock may be required.

Real deadlock only happens when all the above commands are issued from
same uring context, and in reality different uring contexts are often used
for handing control command and IO command.

Fix the issue by using io_uring_cmd_complete_in_task() to cancel command
in ublk_cancel_dev(ublk_cancel_queue).

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Closes: https://lore.kernel.org/linux-block/becol2g7sawl4rsjq2dztsbc7mqypfqko6wzsyoyazqydoasml@rcxarzwidrhk
Cc: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Link: https://lore.kernel.org/r/20230517133408.210944-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/ublk_drv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 41c35ab2c25a1..4db5f1bcac44a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1122,6 +1122,11 @@ static inline bool ublk_queue_ready(struct ublk_queue *ubq)
 	return ubq->nr_io_ready == ubq->q_depth;
 }
 
+static void ublk_cmd_cancel_cb(struct io_uring_cmd *cmd, unsigned issue_flags)
+{
+	io_uring_cmd_done(cmd, UBLK_IO_RES_ABORT, 0, issue_flags);
+}
+
 static void ublk_cancel_queue(struct ublk_queue *ubq)
 {
 	int i;
@@ -1133,8 +1138,8 @@ static void ublk_cancel_queue(struct ublk_queue *ubq)
 		struct ublk_io *io = &ubq->ios[i];
 
 		if (io->flags & UBLK_IO_FLAG_ACTIVE)
-			io_uring_cmd_done(io->cmd, UBLK_IO_RES_ABORT, 0,
-						IO_URING_F_UNLOCKED);
+			io_uring_cmd_complete_in_task(io->cmd,
+						      ublk_cmd_cancel_cb);
 	}
 
 	/* all io commands are canceled */
-- 
2.39.2

