Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501756F7668
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjEDUG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjEDUFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:05:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B9523A33;
        Thu,  4 May 2023 12:52:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20D506385B;
        Thu,  4 May 2023 19:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A87EC433A0;
        Thu,  4 May 2023 19:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229909;
        bh=UPXs4s2DT25fIy4+DRbTtgc7cmejTYlS1uDyKUb3Jw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DHbONe6dYvrzLQXgUDSFAnVOAKaudaOnw+qI2JvnX+eX6Q8AGJJWHiWU20+5vpeea
         DCjSztweyp5wwFrPPbNtD9oBdV5oUAOuAWQHS4xGtgfsFiG6Tq4CXDfzB0Vq5tLqZr
         Brd8FYTlXWooQl94mB2+CuTfUA9EyxAZ2bCbQb5JajLz6Ei02TX2g5B683313W3MHV
         cQg3Ds1sV8E8LaLg7XwfGsrMoGIhhRwdseNluRkNjVjx/dzh1pawBPB/jCoxhe8685
         tWoph03ZAcICDOXQx08evNQs6Fc8AQxmajwgP6JEPkXUTWiKpHYr29Sfqb+u74r5sE
         D2KRogz2XGsJQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nick Child <nnac123@linux.ibm.com>,
        Piotr Raczynski <piotr.raczynski@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, kuniyu@amazon.com,
        liuhangbin@gmail.com, jiri@resnulli.us, andy.ren@getcruise.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 05/13] net: Catch invalid index in XPS mapping
Date:   Thu,  4 May 2023 15:51:22 -0400
Message-Id: <20230504195132.3808946-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504195132.3808946-1-sashal@kernel.org>
References: <20230504195132.3808946-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Child <nnac123@linux.ibm.com>

[ Upstream commit 5dd0dfd55baec0742ba8f5625a0dd064aca7db16 ]

When setting the XPS value of a TX queue, warn the user once if the
index of the queue is greater than the number of allocated TX queues.

Previously, this scenario went uncaught. In the best case, it resulted
in unnecessary allocations. In the worst case, it resulted in
out-of-bounds memory references through calls to `netdev_get_tx_queue(
dev, index)`. Therefore, it is important to inform the user but not
worth returning an error and risk downing the netdevice.

Signed-off-by: Nick Child <nnac123@linux.ibm.com>
Reviewed-by: Piotr Raczynski <piotr.raczynski@intel.com>
Link: https://lore.kernel.org/r/20230321150725.127229-1-nnac123@linux.ibm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index b778f35965433..03903d3f1d695 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2303,6 +2303,8 @@ int __netif_set_xps_queue(struct net_device *dev, const unsigned long *mask,
 	bool active = false;
 	unsigned int nr_ids;
 
+	WARN_ON_ONCE(index >= dev->num_tx_queues);
+
 	if (dev->num_tc) {
 		/* Do not allow XPS on subordinate device directly */
 		num_tc = dev->num_tc;
-- 
2.39.2

