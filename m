Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE182719AFA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjFAL3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjFAL27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:28:59 -0400
Received: from mail-m12745.qiye.163.com (mail-m12745.qiye.163.com [115.236.127.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AC818F;
        Thu,  1 Jun 2023 04:28:47 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPV6:240e:3b7:327f:140:e827:966c:49bc:3060])
        by mail-m12745.qiye.163.com (Hmail) with ESMTPA id 94D9E9A0A0F;
        Thu,  1 Jun 2023 19:28:42 +0800 (CST)
From:   Ding Hui <dinghui@sangfor.com.cn>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        pengdonglin@sangfor.com.cn, huangcun@sangfor.com.cn,
        Ding Hui <dinghui@sangfor.com.cn>
Subject: [PATCH net-next] net: ethtool: Fix out-of-bounds copy to user
Date:   Thu,  1 Jun 2023 19:28:39 +0800
Message-Id: <20230601112839.13799-1-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQkxOVkxJGkpOHUxKHUlKT1UTARMWGhIXJBQOD1
        lXWRgSC1lBWUlPSx5BSBlMQUhJTB1BSk9LQR5DSUxBQk1NGEFPQhkYQUhLTUtZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tVS1kG
X-HM-Tid: 0a8876b79570b218kuuu94d9e9a0a0f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OFE6Tgw5FD1CDD4qKhNCKx8Z
        Iw5PCjpVSlVKTUNOTUpDQklISEtNVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlJT0seQUgZTEFISUwdQUpPS0EeQ0lMQUJNTRhBT0IZGEFIS01LWVdZCAFZQUhDTks3Bg++
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we get statistics by ethtool during changing the number of NIC
channels greater, the utility may crash due to memory corruption.

The NIC drivers callback get_sset_count() could return a calculated
length depends on current number of channels (e.g. i40e, igb).

The ethtool allocates a user buffer with the first ioctl returned
length and invokes the second ioctl to get data. The kernel copies
data to the user buffer but without checking its length. If the length
returned by the second get_sset_count() is greater than the length
allocated by the user, it will lead to an out-of-bounds copy.

Fix it by restricting the copy length not exceed the buffer length
specified by userspace.

Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
---
 net/ethtool/ioctl.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 6bb778e10461..82a975a9c895 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1902,7 +1902,7 @@ static int ethtool_self_test(struct net_device *dev, char __user *useraddr)
 	if (copy_from_user(&test, useraddr, sizeof(test)))
 		return -EFAULT;
 
-	test.len = test_len;
+	test.len = min_t(u32, test.len, test_len);
 	data = kcalloc(test_len, sizeof(u64), GFP_USER);
 	if (!data)
 		return -ENOMEM;
@@ -1915,7 +1915,8 @@ static int ethtool_self_test(struct net_device *dev, char __user *useraddr)
 	if (copy_to_user(useraddr, &test, sizeof(test)))
 		goto out;
 	useraddr += sizeof(test);
-	if (copy_to_user(useraddr, data, array_size(test.len, sizeof(u64))))
+	if (test.len &&
+	    copy_to_user(useraddr, data, array_size(test.len, sizeof(u64))))
 		goto out;
 	ret = 0;
 
@@ -1940,10 +1941,10 @@ static int ethtool_get_strings(struct net_device *dev, void __user *useraddr)
 		return -ENOMEM;
 	WARN_ON_ONCE(!ret);
 
-	gstrings.len = ret;
+	gstrings.len = min_t(u32, gstrings.len, ret);
 
 	if (gstrings.len) {
-		data = vzalloc(array_size(gstrings.len, ETH_GSTRING_LEN));
+		data = vzalloc(array_size(ret, ETH_GSTRING_LEN));
 		if (!data)
 			return -ENOMEM;
 
@@ -2055,9 +2056,9 @@ static int ethtool_get_stats(struct net_device *dev, void __user *useraddr)
 	if (copy_from_user(&stats, useraddr, sizeof(stats)))
 		return -EFAULT;
 
-	stats.n_stats = n_stats;
+	stats.n_stats = min_t(u32, stats.n_stats, n_stats);
 
-	if (n_stats) {
+	if (stats.n_stats) {
 		data = vzalloc(array_size(n_stats, sizeof(u64)));
 		if (!data)
 			return -ENOMEM;
@@ -2070,7 +2071,8 @@ static int ethtool_get_stats(struct net_device *dev, void __user *useraddr)
 	if (copy_to_user(useraddr, &stats, sizeof(stats)))
 		goto out;
 	useraddr += sizeof(stats);
-	if (n_stats && copy_to_user(useraddr, data, array_size(n_stats, sizeof(u64))))
+	if (stats.n_stats &&
+	    copy_to_user(useraddr, data, array_size(stats.n_stats, sizeof(u64))))
 		goto out;
 	ret = 0;
 
-- 
2.17.1

