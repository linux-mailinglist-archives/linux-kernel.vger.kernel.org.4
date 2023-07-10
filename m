Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D073474D308
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjGJKLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbjGJKLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:11:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BABF1FD7;
        Mon, 10 Jul 2023 03:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688983740; x=1720519740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NSifHD9K1tJnmVZp0W3A42gQnoOna+v4cQalFbC6suY=;
  b=LkaZC+CCzPp0xZ4S+Dwn0efEd13539ddmxGvCzWYrTTvZ9bD2rjRmrTZ
   KGBG/5yWMI06XTf/4Gzo7fyghI5P9nFzAljDzCfxY+u+w7EnfBEVidjqp
   w1LeywVW0iJnRl/xedbcEJqnIXZtb5ZEpRmiXfNsiDwi0I21AnC1kU/JQ
   +jb5pP7PfwbHKsIXcs+w7ev931ukPQyutzidfQST/mr5AhNSFhkbO23Sa
   GaKG8Q3pzdowyGgOUkyEmO9P/RxNKNUdv1PM+Pok7hAlPM+f+IhsbGEnq
   XNFkplUQI6f8M3g/Mim/aBFrFCL5cPU9VGo1xC/GFS52ndcEfy9INV/RI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="395086173"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="395086173"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 03:08:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="844826096"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="844826096"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 10 Jul 2023 03:08:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2E09F379; Mon, 10 Jul 2023 13:08:35 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next][resend v1 2/2] netlink: Make use of __assign_bit() API
Date:   Mon, 10 Jul 2023 13:08:30 +0300
Message-Id: <20230710100830.89936-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230710100830.89936-1-andriy.shevchenko@linux.intel.com>
References: <20230710100830.89936-1-andriy.shevchenko@linux.intel.com>
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

We have for some time the __assign_bit() API to replace open coded

	if (foo)
		__set_bit(n, bar);
	else
		__clear_bit(n, bar);

Use this API in the code. No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 net/netlink/af_netlink.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index d81e7a43944c..81e4b802f3f9 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1630,10 +1630,7 @@ static void netlink_update_socket_mc(struct netlink_sock *nlk,
 
 	old = test_bit(group - 1, nlk->groups);
 	subscriptions = nlk->subscriptions - old + new;
-	if (new)
-		__set_bit(group - 1, nlk->groups);
-	else
-		__clear_bit(group - 1, nlk->groups);
+	__assign_bit(group - 1, nlk->groups, new);
 	netlink_update_subscriptions(&nlk->sk, subscriptions);
 	netlink_update_listeners(&nlk->sk);
 }
-- 
2.40.0.1.gaa8946217a0b

