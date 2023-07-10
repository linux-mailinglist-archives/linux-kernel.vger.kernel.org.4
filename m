Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A350974D2ED
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjGJKJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbjGJKJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:09:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0A13AA1;
        Mon, 10 Jul 2023 03:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688983646; x=1720519646;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fncQgPJyZlG3ZquqvS8Jh6fj4kqURBf5+wPFnw5/rT8=;
  b=fO2qwEr5xzcSDJHPxsU2H8aTIjoLroXiLVFUcvcEbZBhZSahtC0+RXAC
   UYUw35i0GJ0j2uQy2Bp2cEq4uJk96i5p/WIC4k7Bj5XewuU01QM3TYhI0
   w1fNl+DMoPCEYBh7ezGcWhRxk85rIRk6oKAtrUcyNG6Pw99RjuNLsssCd
   x/TQjEtke97oTp1nv3RpAummDvGM2D8awm+XtdcY9OP/uIfNlnWRDvUh8
   hOy0PkdSQ3l/XV2U9hpWDfXM+rAXoG7AyzuYnQnPk5oR3aGsvd6o5TVMg
   dTM4aCSiNa71X6IE4lbh1hJLGMLIiCYppMtI1dTWucBrsnZdMEY+5mTZM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="395085738"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="395085738"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 03:06:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="844825327"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="844825327"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 10 Jul 2023 03:06:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 203E81FC; Mon, 10 Jul 2023 13:06:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next][resend v1 1/1] netlink: Don't use int as bool in netlink_update_socket_mc()
Date:   Mon, 10 Jul 2023 13:06:24 +0300
Message-Id: <20230710100624.87836-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 383631873748..d81e7a43944c 100644
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
@@ -2152,7 +2153,7 @@ void __netlink_clear_multicast_users(struct sock *ksk, unsigned int group)
 	struct netlink_table *tbl = &nl_table[ksk->sk_protocol];
 
 	sk_for_each_bound(sk, &tbl->mc_list)
-		netlink_update_socket_mc(nlk_sk(sk), group, 0);
+		netlink_update_socket_mc(nlk_sk(sk), group, false);
 }
 
 struct nlmsghdr *
-- 
2.40.0.1.gaa8946217a0b

