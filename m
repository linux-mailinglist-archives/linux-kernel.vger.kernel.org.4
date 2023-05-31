Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8E7718F8E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 02:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjFAAbx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 31 May 2023 20:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjFAAbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 20:31:52 -0400
Received: from mail-b.sr.ht (mail-b.sr.ht [173.195.146.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35CE124;
        Wed, 31 May 2023 17:31:48 -0700 (PDT)
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
        by mail-b.sr.ht (Postfix) with ESMTPSA id B34EA11F0F5;
        Thu,  1 Jun 2023 00:31:47 +0000 (UTC)
From:   ~akihirosuda <akihirosuda@git.sr.ht>
Date:   Wed, 31 May 2023 19:42:49 +0900
Subject: [PATCH linux v2] net/ipv4: ping_group_range: allow GID from
 2147483648 to 4294967294
Message-ID: <168557950756.14226.6470993129419598644-0@git.sr.ht>
X-Mailer: git.sr.ht
Reply-to: ~akihirosuda <suda.kyoto@gmail.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, segoon@openwall.com, kuniyu@amazon.com
Cc:     suda.kyoto@gmail.com, akihiro.suda.cz@hco.ntt.co.jp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        FREEMAIL_FORGED_REPLYTO,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>

With this commit, all the GIDs ("0 4294967294") can be written to the
"net.ipv4.ping_group_range" sysctl.

Note that 4294967295 (0xffffffff) is an invalid GID (see gid_valid() in
include/linux/uidgid.h), and an attempt to register this number will cause
-EINVAL.

Prior to this commit, only up to GID 2147483647 could be covered.
Documentation/networking/ip-sysctl.rst had "0 4294967295" as an example
value, but this example was wrong and causing -EINVAL.

v1->v2: Simplified the patch (Thanks to Kuniyuki Iwashima for suggestion)

Fixes: c319b4d76b9e ("net: ipv4: add IPPROTO_ICMP socket kind")
Signed-off-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
---
 Documentation/networking/ip-sysctl.rst | 4 ++--
 include/net/ping.h                     | 6 +-----
 net/ipv4/sysctl_net_ipv4.c             | 8 ++++----
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 6ec06a33688a..80b8f73a0244 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1352,8 +1352,8 @@ ping_group_range - 2 INTEGERS
 	Restrict ICMP_PROTO datagram sockets to users in the group range.
 	The default is "1 0", meaning, that nobody (not even root) may
 	create ping sockets.  Setting it to "100 100" would grant permissions
-	to the single group. "0 4294967295" would enable it for the world, "100
-	4294967295" would enable it for the users, but not daemons.
+	to the single group. "0 4294967294" would enable it for the world, "100
+	4294967294" would enable it for the users, but not daemons.
 
 tcp_early_demux - BOOLEAN
 	Enable early demux for established TCP sockets.
diff --git a/include/net/ping.h b/include/net/ping.h
index 9233ad3de0ad..bc7779262e60 100644
--- a/include/net/ping.h
+++ b/include/net/ping.h
@@ -16,11 +16,7 @@
 #define PING_HTABLE_SIZE 	64
 #define PING_HTABLE_MASK 	(PING_HTABLE_SIZE-1)
 
-/*
- * gid_t is either uint or ushort.  We want to pass it to
- * proc_dointvec_minmax(), so it must not be larger than MAX_INT
- */
-#define GID_T_MAX (((gid_t)~0U) >> 1)
+#define GID_T_MAX (((gid_t)~0U) - 1)
 
 /* Compatibility glue so we can support IPv6 when it's compiled as a module */
 struct pingv6_ops {
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 40fe70fc2015..bb49d9407c45 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -34,8 +34,8 @@ static int ip_ttl_min = 1;
 static int ip_ttl_max = 255;
 static int tcp_syn_retries_min = 1;
 static int tcp_syn_retries_max = MAX_TCP_SYNCNT;
-static int ip_ping_group_range_min[] = { 0, 0 };
-static int ip_ping_group_range_max[] = { GID_T_MAX, GID_T_MAX };
+static long ip_ping_group_range_min[] = { 0, 0 };
+static long ip_ping_group_range_max[] = { GID_T_MAX, GID_T_MAX };
 static u32 u32_max_div_HZ = UINT_MAX / HZ;
 static int one_day_secs = 24 * 3600;
 static u32 fib_multipath_hash_fields_all_mask __maybe_unused =
@@ -165,7 +165,7 @@ static int ipv4_ping_group_range(struct ctl_table *table, int write,
 {
 	struct user_namespace *user_ns = current_user_ns();
 	int ret;
-	gid_t urange[2];
+	unsigned long urange[2];
 	kgid_t low, high;
 	struct ctl_table tmp = {
 		.data = &urange,
@@ -178,7 +178,7 @@ static int ipv4_ping_group_range(struct ctl_table *table, int write,
 	inet_get_ping_group_range_table(table, &low, &high);
 	urange[0] = from_kgid_munged(user_ns, low);
 	urange[1] = from_kgid_munged(user_ns, high);
-	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
+	ret = proc_doulongvec_minmax(&tmp, write, buffer, lenp, ppos);
 
 	if (write && ret == 0) {
 		low = make_kgid(user_ns, urange[0]);
-- 
2.38.4
