Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFD374A8C5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 04:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjGGCHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 22:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGGCHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 22:07:16 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C217B10EA;
        Thu,  6 Jul 2023 19:07:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0Vmmfv85_1688695628;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0Vmmfv85_1688695628)
          by smtp.aliyun-inc.com;
          Fri, 07 Jul 2023 10:07:09 +0800
From:   Dust Li <dust.li@linux.alibaba.com>
To:     Simon Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     netdev@vger.kernel.org, lvs-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org
Subject: [PATCH net-next] ipvs: make ip_vs_svc_table and ip_vs_svc_fwm_table per netns
Date:   Fri,  7 Jul 2023 10:07:08 +0800
Message-Id: <20230707020708.75168-1-dust.li@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiejian Wu <jiejian@linux.alibaba.com>

Current ipvs uses one global mutex "__ip_vs_mutex" to keep the global
"ip_vs_svc_table" and "ip_vs_svc_fwm_table" safe. But when there are
tens of thousands of services from different netns in the table, it
takes a long time to look up the table, for example, using "ipvsadm
-ln" from different netns simultaneously.

We make "ip_vs_svc_table" and "ip_vs_svc_fwm_table" per netns, and we
add "service_mutex" per netns to keep these two tables safe instead of
the global "__ip_vs_mutex" in current version. To this end, looking up
services from different netns simultaneously will not get stuck,
shortening the time consumption in large-scale deployment. Evaluation
methods and results are provided below.

init.sh: #!/bin/bash
for((i=1;i<=4;i++));do
        ip netns add ns$i
        ip netns exec ns$i ip link set dev lo up
        ip netns exec ns$i sh add-services.sh
done

add-services.sh: #!/bin/bash
for((i=0;i<30000;i++)); do
        ipvsadm -A  -t 10.10.10.10:$((80+$i)) -s rr
done

runtest.sh: #!/bin/bash
for((i=1;i<4;i++));do
        ip netns exec ns$i ipvsadm -ln > /dev/null &
done
ip netns exec ns4 ipvsadm -ln > /dev/null

Run "sh init.sh" to initiate the network environment. Then run "time
./runtest.sh" to evaluate the time consumption. Our testbed is a 4-core
Intel Xeon ECS. The result of the original version is around 8 seconds,
while the result of the modified version is only 0.8 seconds.

Signed-off-by: Jiejian Wu <jiejian@linux.alibaba.com>
Co-developed-by: Dust Li <dust.li@linux.alibaba.com>
Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
---
 include/net/ip_vs.h            |  12 ++++
 net/netfilter/ipvs/ip_vs_ctl.c | 109 +++++++++++++++------------------
 2 files changed, 62 insertions(+), 59 deletions(-)

diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index ff406ef4fd4aa..83ab2db4a994b 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -33,6 +33,12 @@
 
 #define IP_VS_HDR_INVERSE	1
 #define IP_VS_HDR_ICMP		2
+/*
+ *	Hash table: for virtual service lookups
+ */
+#define IP_VS_SVC_TAB_BITS 8
+#define IP_VS_SVC_TAB_SIZE (1 << IP_VS_SVC_TAB_BITS)
+#define IP_VS_SVC_TAB_MASK (IP_VS_SVC_TAB_SIZE - 1)
 
 /* Generic access of ipvs struct */
 static inline struct netns_ipvs *net_ipvs(struct net* net)
@@ -1041,6 +1047,12 @@ struct netns_ipvs {
 	 */
 	unsigned int		mixed_address_family_dests;
 	unsigned int		hooks_afmask;	/* &1=AF_INET, &2=AF_INET6 */
+
+	struct mutex service_mutex;
+	/* the service table hashed by <protocol, addr, port> */
+	struct hlist_head ip_vs_svc_table[IP_VS_SVC_TAB_SIZE];
+	/* the service table hashed by fwmark */
+	struct hlist_head ip_vs_svc_fwm_table[IP_VS_SVC_TAB_SIZE];
 };
 
 #define DEFAULT_SYNC_THRESHOLD	3
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 62606fb44d027..c8b30f9ec5106 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -50,6 +50,7 @@
 MODULE_ALIAS_GENL_FAMILY(IPVS_GENL_NAME);
 
 DEFINE_MUTEX(__ip_vs_mutex); /* Serialize configuration with sockopt/netlink */
+static struct lock_class_key __ipvs_service_key;
 
 /* sysctl variables */
 
@@ -294,17 +295,6 @@ ip_vs_use_count_dec(void)
 }
 
 
-/*
- *	Hash table: for virtual service lookups
- */
-#define IP_VS_SVC_TAB_BITS 8
-#define IP_VS_SVC_TAB_SIZE (1 << IP_VS_SVC_TAB_BITS)
-#define IP_VS_SVC_TAB_MASK (IP_VS_SVC_TAB_SIZE - 1)
-
-/* the service table hashed by <protocol, addr, port> */
-static struct hlist_head ip_vs_svc_table[IP_VS_SVC_TAB_SIZE];
-/* the service table hashed by fwmark */
-static struct hlist_head ip_vs_svc_fwm_table[IP_VS_SVC_TAB_SIZE];
 
 
 /*
@@ -359,13 +349,13 @@ static int ip_vs_svc_hash(struct ip_vs_service *svc)
 		 */
 		hash = ip_vs_svc_hashkey(svc->ipvs, svc->af, svc->protocol,
 					 &svc->addr, svc->port);
-		hlist_add_head_rcu(&svc->s_list, &ip_vs_svc_table[hash]);
+		hlist_add_head_rcu(&svc->s_list, &svc->ipvs->ip_vs_svc_table[hash]);
 	} else {
 		/*
 		 *  Hash it by fwmark in svc_fwm_table
 		 */
 		hash = ip_vs_svc_fwm_hashkey(svc->ipvs, svc->fwmark);
-		hlist_add_head_rcu(&svc->f_list, &ip_vs_svc_fwm_table[hash]);
+		hlist_add_head_rcu(&svc->f_list, &svc->ipvs->ip_vs_svc_fwm_table[hash]);
 	}
 
 	svc->flags |= IP_VS_SVC_F_HASHED;
@@ -414,7 +404,7 @@ __ip_vs_service_find(struct netns_ipvs *ipvs, int af, __u16 protocol,
 	/* Check for "full" addressed entries */
 	hash = ip_vs_svc_hashkey(ipvs, af, protocol, vaddr, vport);
 
-	hlist_for_each_entry_rcu(svc, &ip_vs_svc_table[hash], s_list) {
+	hlist_for_each_entry_rcu(svc, &ipvs->ip_vs_svc_table[hash], s_list) {
 		if ((svc->af == af)
 		    && ip_vs_addr_equal(af, &svc->addr, vaddr)
 		    && (svc->port == vport)
@@ -441,7 +431,7 @@ __ip_vs_svc_fwm_find(struct netns_ipvs *ipvs, int af, __u32 fwmark)
 	/* Check for fwmark addressed entries */
 	hash = ip_vs_svc_fwm_hashkey(ipvs, fwmark);
 
-	hlist_for_each_entry_rcu(svc, &ip_vs_svc_fwm_table[hash], f_list) {
+	hlist_for_each_entry_rcu(svc, &ipvs->ip_vs_svc_fwm_table[hash], f_list) {
 		if (svc->fwmark == fwmark && svc->af == af
 		    && (svc->ipvs == ipvs)) {
 			/* HIT */
@@ -1701,7 +1691,7 @@ static int ip_vs_flush(struct netns_ipvs *ipvs, bool cleanup)
 	 * Flush the service table hashed by <netns,protocol,addr,port>
 	 */
 	for(idx = 0; idx < IP_VS_SVC_TAB_SIZE; idx++) {
-		hlist_for_each_entry_safe(svc, n, &ip_vs_svc_table[idx],
+		hlist_for_each_entry_safe(svc, n, &ipvs->ip_vs_svc_table[idx],
 					  s_list) {
 			if (svc->ipvs == ipvs)
 				ip_vs_unlink_service(svc, cleanup);
@@ -1712,7 +1702,7 @@ static int ip_vs_flush(struct netns_ipvs *ipvs, bool cleanup)
 	 * Flush the service table hashed by fwmark
 	 */
 	for(idx = 0; idx < IP_VS_SVC_TAB_SIZE; idx++) {
-		hlist_for_each_entry_safe(svc, n, &ip_vs_svc_fwm_table[idx],
+		hlist_for_each_entry_safe(svc, n, &ipvs->ip_vs_svc_fwm_table[idx],
 					  f_list) {
 			if (svc->ipvs == ipvs)
 				ip_vs_unlink_service(svc, cleanup);
@@ -1732,12 +1722,12 @@ void ip_vs_service_nets_cleanup(struct list_head *net_list)
 	struct net *net;
 
 	/* Check for "full" addressed entries */
-	mutex_lock(&__ip_vs_mutex);
 	list_for_each_entry(net, net_list, exit_list) {
 		ipvs = net_ipvs(net);
+		mutex_lock(&ipvs->service_mutex);
 		ip_vs_flush(ipvs, true);
+		mutex_unlock(&ipvs->service_mutex);
 	}
-	mutex_unlock(&__ip_vs_mutex);
 }
 
 /* Put all references for device (dst_cache) */
@@ -1775,9 +1765,9 @@ static int ip_vs_dst_event(struct notifier_block *this, unsigned long event,
 	if (event != NETDEV_DOWN || !ipvs)
 		return NOTIFY_DONE;
 	IP_VS_DBG(3, "%s() dev=%s\n", __func__, dev->name);
-	mutex_lock(&__ip_vs_mutex);
+	mutex_lock(&ipvs->service_mutex);
 	for (idx = 0; idx < IP_VS_SVC_TAB_SIZE; idx++) {
-		hlist_for_each_entry(svc, &ip_vs_svc_table[idx], s_list) {
+		hlist_for_each_entry(svc, &ipvs->ip_vs_svc_table[idx], s_list) {
 			if (svc->ipvs == ipvs) {
 				list_for_each_entry(dest, &svc->destinations,
 						    n_list) {
@@ -1786,7 +1776,7 @@ static int ip_vs_dst_event(struct notifier_block *this, unsigned long event,
 			}
 		}
 
-		hlist_for_each_entry(svc, &ip_vs_svc_fwm_table[idx], f_list) {
+		hlist_for_each_entry(svc, &ipvs->ip_vs_svc_fwm_table[idx], f_list) {
 			if (svc->ipvs == ipvs) {
 				list_for_each_entry(dest, &svc->destinations,
 						    n_list) {
@@ -1802,7 +1792,7 @@ static int ip_vs_dst_event(struct notifier_block *this, unsigned long event,
 		ip_vs_forget_dev(dest, dev);
 	}
 	spin_unlock_bh(&ipvs->dest_trash_lock);
-	mutex_unlock(&__ip_vs_mutex);
+	mutex_unlock(&ipvs->service_mutex);
 	return NOTIFY_DONE;
 }
 
@@ -1826,14 +1816,14 @@ static int ip_vs_zero_all(struct netns_ipvs *ipvs)
 	struct ip_vs_service *svc;
 
 	for(idx = 0; idx < IP_VS_SVC_TAB_SIZE; idx++) {
-		hlist_for_each_entry(svc, &ip_vs_svc_table[idx], s_list) {
+		hlist_for_each_entry(svc, &ipvs->ip_vs_svc_table[idx], s_list) {
 			if (svc->ipvs == ipvs)
 				ip_vs_zero_service(svc);
 		}
 	}
 
 	for(idx = 0; idx < IP_VS_SVC_TAB_SIZE; idx++) {
-		hlist_for_each_entry(svc, &ip_vs_svc_fwm_table[idx], f_list) {
+		hlist_for_each_entry(svc, &ipvs->ip_vs_svc_fwm_table[idx], f_list) {
 			if (svc->ipvs == ipvs)
 				ip_vs_zero_service(svc);
 		}
@@ -2303,9 +2293,9 @@ static struct ip_vs_service *ip_vs_info_array(struct seq_file *seq, loff_t pos)
 
 	/* look in hash by protocol */
 	for (idx = 0; idx < IP_VS_SVC_TAB_SIZE; idx++) {
-		hlist_for_each_entry_rcu(svc, &ip_vs_svc_table[idx], s_list) {
+		hlist_for_each_entry_rcu(svc, &ipvs->ip_vs_svc_table[idx], s_list) {
 			if ((svc->ipvs == ipvs) && pos-- == 0) {
-				iter->table = ip_vs_svc_table;
+				iter->table = ipvs->ip_vs_svc_table;
 				iter->bucket = idx;
 				return svc;
 			}
@@ -2314,10 +2304,10 @@ static struct ip_vs_service *ip_vs_info_array(struct seq_file *seq, loff_t pos)
 
 	/* keep looking in fwmark */
 	for (idx = 0; idx < IP_VS_SVC_TAB_SIZE; idx++) {
-		hlist_for_each_entry_rcu(svc, &ip_vs_svc_fwm_table[idx],
+		hlist_for_each_entry_rcu(svc, &ipvs->ip_vs_svc_fwm_table[idx],
 					 f_list) {
 			if ((svc->ipvs == ipvs) && pos-- == 0) {
-				iter->table = ip_vs_svc_fwm_table;
+				iter->table = ipvs->ip_vs_svc_fwm_table;
 				iter->bucket = idx;
 				return svc;
 			}
@@ -2340,6 +2330,8 @@ static void *ip_vs_info_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	struct hlist_node *e;
 	struct ip_vs_iter *iter;
 	struct ip_vs_service *svc;
+	struct net *net = seq_file_net(seq);
+	struct netns_ipvs *ipvs = net_ipvs(net);
 
 	++*pos;
 	if (v == SEQ_START_TOKEN)
@@ -2348,7 +2340,7 @@ static void *ip_vs_info_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	svc = v;
 	iter = seq->private;
 
-	if (iter->table == ip_vs_svc_table) {
+	if (iter->table == ipvs->ip_vs_svc_table) {
 		/* next service in table hashed by protocol */
 		e = rcu_dereference(hlist_next_rcu(&svc->s_list));
 		if (e)
@@ -2356,13 +2348,13 @@ static void *ip_vs_info_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 
 		while (++iter->bucket < IP_VS_SVC_TAB_SIZE) {
 			hlist_for_each_entry_rcu(svc,
-						 &ip_vs_svc_table[iter->bucket],
+						 &ipvs->ip_vs_svc_table[iter->bucket],
 						 s_list) {
 				return svc;
 			}
 		}
 
-		iter->table = ip_vs_svc_fwm_table;
+		iter->table = ipvs->ip_vs_svc_fwm_table;
 		iter->bucket = -1;
 		goto scan_fwmark;
 	}
@@ -2375,7 +2367,7 @@ static void *ip_vs_info_seq_next(struct seq_file *seq, void *v, loff_t *pos)
  scan_fwmark:
 	while (++iter->bucket < IP_VS_SVC_TAB_SIZE) {
 		hlist_for_each_entry_rcu(svc,
-					 &ip_vs_svc_fwm_table[iter->bucket],
+					 &ipvs->ip_vs_svc_fwm_table[iter->bucket],
 					 f_list)
 			return svc;
 	}
@@ -2411,7 +2403,7 @@ static int ip_vs_info_seq_show(struct seq_file *seq, void *v)
 
 		if (svc->ipvs != ipvs)
 			return 0;
-		if (iter->table == ip_vs_svc_table) {
+		if (iter->table == ipvs->ip_vs_svc_table) {
 #ifdef CONFIG_IP_VS_IPV6
 			if (svc->af == AF_INET6)
 				seq_printf(seq, "%s  [%pI6]:%04X %s ",
@@ -2733,7 +2725,7 @@ do_ip_vs_set_ctl(struct sock *sk, int cmd, sockptr_t ptr, unsigned int len)
 		return ret;
 	}
 
-	mutex_lock(&__ip_vs_mutex);
+	mutex_lock(&ipvs->service_mutex);
 	if (cmd == IP_VS_SO_SET_FLUSH) {
 		/* Flush the virtual service */
 		ret = ip_vs_flush(ipvs, false);
@@ -2830,7 +2822,7 @@ do_ip_vs_set_ctl(struct sock *sk, int cmd, sockptr_t ptr, unsigned int len)
 	}
 
   out_unlock:
-	mutex_unlock(&__ip_vs_mutex);
+	mutex_unlock(&ipvs->service_mutex);
 	return ret;
 }
 
@@ -2868,7 +2860,7 @@ __ip_vs_get_service_entries(struct netns_ipvs *ipvs,
 	int ret = 0;
 
 	for (idx = 0; idx < IP_VS_SVC_TAB_SIZE; idx++) {
-		hlist_for_each_entry(svc, &ip_vs_svc_table[idx], s_list) {
+		hlist_for_each_entry(svc, &ipvs->ip_vs_svc_table[idx], s_list) {
 			/* Only expose IPv4 entries to old interface */
 			if (svc->af != AF_INET || (svc->ipvs != ipvs))
 				continue;
@@ -2887,7 +2879,7 @@ __ip_vs_get_service_entries(struct netns_ipvs *ipvs,
 	}
 
 	for (idx = 0; idx < IP_VS_SVC_TAB_SIZE; idx++) {
-		hlist_for_each_entry(svc, &ip_vs_svc_fwm_table[idx], f_list) {
+		hlist_for_each_entry(svc, &ipvs->ip_vs_svc_fwm_table[idx], f_list) {
 			/* Only expose IPv4 entries to old interface */
 			if (svc->af != AF_INET || (svc->ipvs != ipvs))
 				continue;
@@ -3058,7 +3050,7 @@ do_ip_vs_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
 		return ret;
 	}
 
-	mutex_lock(&__ip_vs_mutex);
+	mutex_lock(&ipvs->service_mutex);
 	switch (cmd) {
 	case IP_VS_SO_GET_VERSION:
 	{
@@ -3157,7 +3149,7 @@ do_ip_vs_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
 	}
 
 out:
-	mutex_unlock(&__ip_vs_mutex);
+	mutex_unlock(&ipvs->service_mutex);
 	return ret;
 }
 
@@ -3392,9 +3384,9 @@ static int ip_vs_genl_dump_services(struct sk_buff *skb,
 	struct net *net = sock_net(skb->sk);
 	struct netns_ipvs *ipvs = net_ipvs(net);
 
-	mutex_lock(&__ip_vs_mutex);
+	mutex_lock(&ipvs->service_mutex);
 	for (i = 0; i < IP_VS_SVC_TAB_SIZE; i++) {
-		hlist_for_each_entry(svc, &ip_vs_svc_table[i], s_list) {
+		hlist_for_each_entry(svc, &ipvs->ip_vs_svc_table[i], s_list) {
 			if (++idx <= start || (svc->ipvs != ipvs))
 				continue;
 			if (ip_vs_genl_dump_service(skb, svc, cb) < 0) {
@@ -3405,7 +3397,7 @@ static int ip_vs_genl_dump_services(struct sk_buff *skb,
 	}
 
 	for (i = 0; i < IP_VS_SVC_TAB_SIZE; i++) {
-		hlist_for_each_entry(svc, &ip_vs_svc_fwm_table[i], f_list) {
+		hlist_for_each_entry(svc, &ipvs->ip_vs_svc_fwm_table[i], f_list) {
 			if (++idx <= start || (svc->ipvs != ipvs))
 				continue;
 			if (ip_vs_genl_dump_service(skb, svc, cb) < 0) {
@@ -3416,7 +3408,7 @@ static int ip_vs_genl_dump_services(struct sk_buff *skb,
 	}
 
 nla_put_failure:
-	mutex_unlock(&__ip_vs_mutex);
+	mutex_unlock(&ipvs->service_mutex);
 	cb->args[0] = idx;
 
 	return skb->len;
@@ -3605,7 +3597,7 @@ static int ip_vs_genl_dump_dests(struct sk_buff *skb,
 	struct net *net = sock_net(skb->sk);
 	struct netns_ipvs *ipvs = net_ipvs(net);
 
-	mutex_lock(&__ip_vs_mutex);
+	mutex_lock(&ipvs->service_mutex);
 
 	/* Try to find the service for which to dump destinations */
 	if (nlmsg_parse_deprecated(cb->nlh, GENL_HDRLEN, attrs, IPVS_CMD_ATTR_MAX, ip_vs_cmd_policy, cb->extack))
@@ -3630,7 +3622,7 @@ static int ip_vs_genl_dump_dests(struct sk_buff *skb,
 	cb->args[0] = idx;
 
 out_err:
-	mutex_unlock(&__ip_vs_mutex);
+	mutex_unlock(&ipvs->service_mutex);
 
 	return skb->len;
 }
@@ -3916,7 +3908,7 @@ static int ip_vs_genl_set_cmd(struct sk_buff *skb, struct genl_info *info)
 
 	cmd = info->genlhdr->cmd;
 
-	mutex_lock(&__ip_vs_mutex);
+	mutex_lock(&ipvs->service_mutex);
 
 	if (cmd == IPVS_CMD_FLUSH) {
 		ret = ip_vs_flush(ipvs, false);
@@ -4028,7 +4020,7 @@ static int ip_vs_genl_set_cmd(struct sk_buff *skb, struct genl_info *info)
 	}
 
 out:
-	mutex_unlock(&__ip_vs_mutex);
+	mutex_unlock(&ipvs->service_mutex);
 
 	return ret;
 }
@@ -4058,7 +4050,7 @@ static int ip_vs_genl_get_cmd(struct sk_buff *skb, struct genl_info *info)
 	if (!msg)
 		return -ENOMEM;
 
-	mutex_lock(&__ip_vs_mutex);
+	mutex_lock(&ipvs->service_mutex);
 
 	reply = genlmsg_put_reply(msg, info, &ip_vs_genl_family, 0, reply_cmd);
 	if (reply == NULL)
@@ -4126,7 +4118,7 @@ static int ip_vs_genl_get_cmd(struct sk_buff *skb, struct genl_info *info)
 out_err:
 	nlmsg_free(msg);
 out:
-	mutex_unlock(&__ip_vs_mutex);
+	mutex_unlock(&ipvs->service_mutex);
 
 	return ret;
 }
@@ -4243,6 +4235,7 @@ static struct genl_family ip_vs_genl_family __ro_after_init = {
 	.small_ops	= ip_vs_genl_ops,
 	.n_small_ops	= ARRAY_SIZE(ip_vs_genl_ops),
 	.resv_start_op	= IPVS_CMD_FLUSH + 1,
+	.parallel_ops	= 1,
 };
 
 static int __init ip_vs_genl_register(void)
@@ -4411,6 +4404,13 @@ int __net_init ip_vs_control_net_init(struct netns_ipvs *ipvs)
 	int ret = -ENOMEM;
 	int idx;
 
+	/* Initialize service_mutex, svc_table, ip_vs_svc_fwm_table per netns */
+	__mutex_init(&ipvs->service_mutex, "ipvs->service_mutex", &__ipvs_service_key);
+	for (idx = 0; idx < IP_VS_SVC_TAB_SIZE; idx++) {
+		INIT_HLIST_HEAD(&ipvs->ip_vs_svc_table[idx]);
+		INIT_HLIST_HEAD(&ipvs->ip_vs_svc_fwm_table[idx]);
+	}
+
 	/* Initialize rs_table */
 	for (idx = 0; idx < IP_VS_RTAB_SIZE; idx++)
 		INIT_HLIST_HEAD(&ipvs->rs_table[idx]);
@@ -4515,17 +4515,8 @@ void ip_vs_unregister_nl_ioctl(void)
 
 int __init ip_vs_control_init(void)
 {
-	int idx;
 	int ret;
 
-	/* Initialize svc_table, ip_vs_svc_fwm_table */
-	for (idx = 0; idx < IP_VS_SVC_TAB_SIZE; idx++) {
-		INIT_HLIST_HEAD(&ip_vs_svc_table[idx]);
-		INIT_HLIST_HEAD(&ip_vs_svc_fwm_table[idx]);
-	}
-
-	smp_wmb();	/* Do we really need it now ? */
-
 	ret = register_netdevice_notifier(&ip_vs_dst_notifier);
 	if (ret < 0)
 		return ret;
-- 
2.19.1.6.gb485710b

