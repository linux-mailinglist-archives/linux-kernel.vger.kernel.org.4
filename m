Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB98C742767
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjF2Nbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 09:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjF2Nbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:31:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9BD10FB;
        Thu, 29 Jun 2023 06:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688045493; x=1719581493;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y020DshgdnrNO1wXKnK2PXOgAt0ifI+bDGqZ24iFWSk=;
  b=E3qVfdDhs+0IZazqwkV56cvA0vpswJZkHxZUtVXfDLDTqZ42JA5ERdR0
   RbhHNCbc/96KD1WW6z38kc04B6fF51XiJTYLtGaN2hXX1llNqO0j3J906
   y+eUQYZQgSonykdb/ka+KkRqHShcGwdfbwcfBpcFDD425vBOFUbhuUjWs
   hZcix+22LjaqGeTqjO8oyMyQkM+MmnyMyA9nfkD+vO1HbTfXRJLPKeUa1
   63FuJdy+cEy97tX7wZYhTRgGktbQigJ6T+tCy96ownP9vCoo41ZNRY0uD
   7BflRYBtu84NsByNwBBlTpjDSqI2FF0TwUMAwLIeTNpTrvX5oXnQr+/14
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="341688262"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="341688262"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 06:31:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="782686737"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="782686737"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jun 2023 06:31:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DE55A358; Thu, 29 Jun 2023 16:31:32 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] netlink: Don't use int as bool in netlink_update_socket_mc()
Date:   Thu, 29 Jun 2023 16:31:31 +0300
Message-Id: <20230629133131.83284-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bit operations take boolean parameter and return also boolean
(in test_bit()-like cases). Don't threat booleans as integers when
it's not needed.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 net/netlink/af_netlink.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 9c9df143a2ec..81e4b802f3f9 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1623,9 +1623,10 @@ EXPORT_SYMBOL(netlink_set_err);
 /* must be called with netlink table grabbed */
 static void netlink_update_socket_mc(struct netlink_sock *nlk,
 				     unsigned int group,
-				     int is_new)
+				     bool new)
 {
-	int old, new = !!is_new, subscriptions;
+	int subscriptions;
+	bool old;
 
 	old = test_bit(group - 1, nlk->groups);
 	subscriptions = nlk->subscriptions - old + new;
@@ -2149,7 +2150,7 @@ void __netlink_clear_multicast_users(struct sock *ksk, unsigned int group)
 	struct netlink_table *tbl = &nl_table[ksk->sk_protocol];
 
 	sk_for_each_bound(sk, &tbl->mc_list)
-		netlink_update_socket_mc(nlk_sk(sk), group, 0);
+		netlink_update_socket_mc(nlk_sk(sk), group, false);
 }
 
 struct nlmsghdr *
-- 
2.40.0.1.gaa8946217a0b

