Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D89D74D309
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbjGJKLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjGJKL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:11:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7839D210C;
        Mon, 10 Jul 2023 03:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688983741; x=1720519741;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JBVx5Ym2vAExG1tYB6c4UHYbnpcxSOc+rFilPNsQ0VI=;
  b=lk/Suc337OGwPgfAoFO7iOVyb56riT1lOoxkKAZ6uoIxzhCuAE89Xzck
   H5Qsxdl0fKuclF47aPfEfhgeej20uuOSLLOB+A28BNpHuYJpJ6xk+2NPl
   HP8sg78ZgsDfYNzk5I+xygFLVL4TvyQR9LxeNDbODdFdksIln0cMPVrI3
   rDQdDu47Qgw3D38tEog4e8RJ6sv7Sa2hiDqCke9YTXrSgJMXp5LgtSit+
   MuErwhXIJdqb+xnok0zXy0fi8GWHWEaPuKMbRZIru2Y47mamPvAbbPOH3
   i3sXDanTY+4uob7ICsNDAuItFbcV7hiDZlgn+eqhAN3DOh5RnGKY2jZvX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="395086180"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="395086180"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 03:08:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="844826094"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="844826094"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 10 Jul 2023 03:08:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 186A21FC; Mon, 10 Jul 2023 13:08:34 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next][resend v1 1/2] net/core: Make use of assign_bit() API
Date:   Mon, 10 Jul 2023 13:08:29 +0300
Message-Id: <20230710100830.89936-1-andriy.shevchenko@linux.intel.com>
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

We have for some time the assign_bit() API to replace open coded

	if (foo)
		set_bit(n, bar);
	else
		clear_bit(n, bar);

Use this API in the code. No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 net/core/dev.c  |  8 ++------
 net/core/sock.c | 15 +++------------
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 69a3e544676c..d6e1b786c5c5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6316,12 +6316,8 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
 	 * softirq mode will happen in the next round of napi_schedule().
 	 * This should not cause hiccups/stalls to the live traffic.
 	 */
-	list_for_each_entry(napi, &dev->napi_list, dev_list) {
-		if (threaded)
-			set_bit(NAPI_STATE_THREADED, &napi->state);
-		else
-			clear_bit(NAPI_STATE_THREADED, &napi->state);
-	}
+	list_for_each_entry(napi, &dev->napi_list, dev_list)
+		assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
 
 	return err;
 }
diff --git a/net/core/sock.c b/net/core/sock.c
index 9370fd50aa2c..ab1e8d1bd5a1 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1244,17 +1244,11 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_PASSCRED:
-		if (valbool)
-			set_bit(SOCK_PASSCRED, &sock->flags);
-		else
-			clear_bit(SOCK_PASSCRED, &sock->flags);
+		assign_bit(SOCK_PASSCRED, &sock->flags, valbool);
 		break;
 
 	case SO_PASSPIDFD:
-		if (valbool)
-			set_bit(SOCK_PASSPIDFD, &sock->flags);
-		else
-			clear_bit(SOCK_PASSPIDFD, &sock->flags);
+		assign_bit(SOCK_PASSPIDFD, &sock->flags, valbool);
 		break;
 
 	case SO_TIMESTAMP_OLD:
@@ -1358,10 +1352,7 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_PASSSEC:
-		if (valbool)
-			set_bit(SOCK_PASSSEC, &sock->flags);
-		else
-			clear_bit(SOCK_PASSSEC, &sock->flags);
+		assign_bit(SOCK_PASSSEC, &sock->flags, valbool);
 		break;
 	case SO_MARK:
 		if (!sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
-- 
2.40.0.1.gaa8946217a0b

