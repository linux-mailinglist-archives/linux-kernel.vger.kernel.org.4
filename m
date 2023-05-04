Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E963A6F7617
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjEDUEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjEDUDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:03:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754C52074B;
        Thu,  4 May 2023 12:52:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FB4263877;
        Thu,  4 May 2023 19:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C42C4339C;
        Thu,  4 May 2023 19:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229861;
        bh=oyC3VBu1GT95DmqeVEJB3ixryq3YgShqX3+9xq4nxTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tq8bOf/omd1tKFI9g2iizIu/P4QU6ZuxWiOkmofW9aoKo4ruDsHRHTcPIsR4hm3v9
         btHtDiH9PKs7k8uT4DketGmMaJhWVV7UgmFUiCbfWjbrPIHjiAwsrtIcMgzsS4fcfd
         569/lLFnmYzQtoosgQ5N2CAMWO7T9OeOQi11kPj1xGA0zAO+9dNfihZn82GF0eFsMT
         Pu+skYLl3wNRJimfaA1B+u70eVxqEgAxSZcpwKiqAPt27maVrKM8DYPtG0Qp1FmRnE
         a5+2jhnFZIiGEDTmSIyQmeBTvUxfa5yeDfsRr7Q8QxUnoadW8G6N2e1KjIG1UzQqkC
         BiABXepwBdThQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nick Child <nnac123@linux.ibm.com>,
        Piotr Raczynski <piotr.raczynski@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, kuniyu@amazon.com,
        liuhangbin@gmail.com, jiri@resnulli.us, andy.ren@getcruise.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 06/18] net: Catch invalid index in XPS mapping
Date:   Thu,  4 May 2023 15:50:28 -0400
Message-Id: <20230504195042.3808716-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504195042.3808716-1-sashal@kernel.org>
References: <20230504195042.3808716-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index 1a4e20c4ba053..2a3b56abd7f47 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2244,6 +2244,8 @@ int __netif_set_xps_queue(struct net_device *dev, const unsigned long *mask,
 	bool active = false;
 	unsigned int nr_ids;
 
+	WARN_ON_ONCE(index >= dev->num_tx_queues);
+
 	if (dev->num_tc) {
 		/* Do not allow XPS on subordinate device directly */
 		num_tc = dev->num_tc;
-- 
2.39.2

