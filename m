Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC4E74D9E1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjGJP2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjGJP2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:28:21 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD29F4;
        Mon, 10 Jul 2023 08:28:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0Vn53M3h_1689002889;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0Vn53M3h_1689002889)
          by smtp.aliyun-inc.com;
          Mon, 10 Jul 2023 23:28:10 +0800
Date:   Mon, 10 Jul 2023 23:28:09 +0800
From:   Dust Li <dust.li@linux.alibaba.com>
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Jiejian Wu <jiejian@linux.alibaba.com>,
        Simon Horman <horms@verge.net.au>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
        lvs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH net-next] ipvs: make ip_vs_svc_table and
 ip_vs_svc_fwm_table per netns
Message-ID: <20230710152809.GD6751@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20230707020708.75168-1-dust.li@linux.alibaba.com>
 <28a87ee9-5f94-2506-3cb9-8a19144e2061@ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28a87ee9-5f94-2506-3cb9-8a19144e2061@ssi.bg>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2023 at 08:45:19PM +0300, Julian Anastasov wrote:
>
>	Hello,
>
>On Fri, 7 Jul 2023, Dust Li wrote:
>
>> From: Jiejian Wu <jiejian@linux.alibaba.com>
>> 
>> Current ipvs uses one global mutex "__ip_vs_mutex" to keep the global
>> "ip_vs_svc_table" and "ip_vs_svc_fwm_table" safe. But when there are
>> tens of thousands of services from different netns in the table, it
>> takes a long time to look up the table, for example, using "ipvsadm
>> -ln" from different netns simultaneously.
>> 
>> We make "ip_vs_svc_table" and "ip_vs_svc_fwm_table" per netns, and we
>> add "service_mutex" per netns to keep these two tables safe instead of
>> the global "__ip_vs_mutex" in current version. To this end, looking up
>> services from different netns simultaneously will not get stuck,
>> shortening the time consumption in large-scale deployment. Evaluation
>> methods and results are provided below.
>> 
>> init.sh: #!/bin/bash
>> for((i=1;i<=4;i++));do
>>         ip netns add ns$i
>>         ip netns exec ns$i ip link set dev lo up
>>         ip netns exec ns$i sh add-services.sh
>> done
>> 
>> add-services.sh: #!/bin/bash
>> for((i=0;i<30000;i++)); do
>>         ipvsadm -A  -t 10.10.10.10:$((80+$i)) -s rr
>> done
>> 
>> runtest.sh: #!/bin/bash
>> for((i=1;i<4;i++));do
>>         ip netns exec ns$i ipvsadm -ln > /dev/null &
>> done
>> ip netns exec ns4 ipvsadm -ln > /dev/null
>> 
>> Run "sh init.sh" to initiate the network environment. Then run "time
>> ./runtest.sh" to evaluate the time consumption. Our testbed is a 4-core
>> Intel Xeon ECS. The result of the original version is around 8 seconds,
>> while the result of the modified version is only 0.8 seconds.
>> 
>> Signed-off-by: Jiejian Wu <jiejian@linux.alibaba.com>
>> Co-developed-by: Dust Li <dust.li@linux.alibaba.com>
>> Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
>> ---
>>  include/net/ip_vs.h            |  12 ++++
>>  net/netfilter/ipvs/ip_vs_ctl.c | 109 +++++++++++++++------------------
>>  2 files changed, 62 insertions(+), 59 deletions(-)
>> 
>> diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
>> index ff406ef4fd4aa..83ab2db4a994b 100644
>> --- a/include/net/ip_vs.h
>> +++ b/include/net/ip_vs.h
>> @@ -33,6 +33,12 @@
>>  
>>  #define IP_VS_HDR_INVERSE	1
>>  #define IP_VS_HDR_ICMP		2
>> +/*
>> + *	Hash table: for virtual service lookups
>> + */
>> +#define IP_VS_SVC_TAB_BITS 8
>> +#define IP_VS_SVC_TAB_SIZE (1 << IP_VS_SVC_TAB_BITS)
>> +#define IP_VS_SVC_TAB_MASK (IP_VS_SVC_TAB_SIZE - 1)
>>  
>>  /* Generic access of ipvs struct */
>>  static inline struct netns_ipvs *net_ipvs(struct net* net)
>> @@ -1041,6 +1047,12 @@ struct netns_ipvs {
>>  	 */
>>  	unsigned int		mixed_address_family_dests;
>>  	unsigned int		hooks_afmask;	/* &1=AF_INET, &2=AF_INET6 */
>> +
>> +	struct mutex service_mutex;
>> +	/* the service table hashed by <protocol, addr, port> */
>> +	struct hlist_head ip_vs_svc_table[IP_VS_SVC_TAB_SIZE];
>> +	/* the service table hashed by fwmark */
>> +	struct hlist_head ip_vs_svc_fwm_table[IP_VS_SVC_TAB_SIZE];
>
>	Can we use svc_table and svc_fwm_table for the table names?
>

Sure, will do.

>>  };
>>  
>>  #define DEFAULT_SYNC_THRESHOLD	3
>> diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
>> index 62606fb44d027..c8b30f9ec5106 100644
>> --- a/net/netfilter/ipvs/ip_vs_ctl.c
>> +++ b/net/netfilter/ipvs/ip_vs_ctl.c
>
>> @@ -414,7 +404,7 @@ __ip_vs_service_find(struct netns_ipvs *ipvs, int af, __u16 protocol,
>>  	/* Check for "full" addressed entries */
>>  	hash = ip_vs_svc_hashkey(ipvs, af, protocol, vaddr, vport);
>>  
>> -	hlist_for_each_entry_rcu(svc, &ip_vs_svc_table[hash], s_list) {
>> +	hlist_for_each_entry_rcu(svc, &ipvs->ip_vs_svc_table[hash], s_list) {
>>  		if ((svc->af == af)
>>  		    && ip_vs_addr_equal(af, &svc->addr, vaddr)
>>  		    && (svc->port == vport)
>> @@ -441,7 +431,7 @@ __ip_vs_svc_fwm_find(struct netns_ipvs *ipvs, int af, __u32 fwmark)
>>  	/* Check for fwmark addressed entries */
>>  	hash = ip_vs_svc_fwm_hashkey(ipvs, fwmark);
>>  
>> -	hlist_for_each_entry_rcu(svc, &ip_vs_svc_fwm_table[hash], f_list) {
>> +	hlist_for_each_entry_rcu(svc, &ipvs->ip_vs_svc_fwm_table[hash], f_list) {
>>  		if (svc->fwmark == fwmark && svc->af == af
>>  		    && (svc->ipvs == ipvs)) {
>
>	__ip_vs_service_find and __ip_vs_svc_fwm_find: match
>by svc->ipvs is not needed anymore. There are other svc->ipvs == ipvs
>checks in this file.
>

Yes, will remove the check in the next version.

>> @@ -1732,12 +1722,12 @@ void ip_vs_service_nets_cleanup(struct list_head *net_list)
>>  	struct net *net;
>>  
>>  	/* Check for "full" addressed entries */
>> -	mutex_lock(&__ip_vs_mutex);
>>  	list_for_each_entry(net, net_list, exit_list) {
>>  		ipvs = net_ipvs(net);
>> +		mutex_lock(&ipvs->service_mutex);
>>  		ip_vs_flush(ipvs, true);
>> +		mutex_unlock(&ipvs->service_mutex);
>>  	}
>> -	mutex_unlock(&__ip_vs_mutex);
>
>	This reverts speedups from commit 5d5a0815f854 but with some
Yes :)

>reordering we probably can remove the mutex completely as part from
>further optimizations.
>

Agree. It is not a frequently called routine, so we kept it here.


>>  }
>>  
>>  /* Put all references for device (dst_cache) */
>> @@ -1775,9 +1765,9 @@ static int ip_vs_dst_event(struct notifier_block *this, unsigned long event,
>>  	if (event != NETDEV_DOWN || !ipvs)
>>  		return NOTIFY_DONE;
>>  	IP_VS_DBG(3, "%s() dev=%s\n", __func__, dev->name);
>> -	mutex_lock(&__ip_vs_mutex);
>> +	mutex_lock(&ipvs->service_mutex);
>
>	Looks like with global notifier we have a problem where 
>ip_vs_dst_event() can not know if net->ipvs is not in process
>of freeing from another CPU. The global __ip_vs_mutex helped
>to avoid the problem, if we see svc then svc->ipvs is valid.
>But now even the ipvs->dest_trash_lock access looks under risk.
>Probably, we should switch to register_netdevice_notifier_net,
>so that ip_vs_dst_event() can safely work with the ipvs struct.
>At first look, unregister_netdevice_notifier_net() should be
>called in ip_vs_control_net_cleanup() just after the
>ip_vs_trash_cleanup() call. A drawback is that when we unregister
>from netns exit context __unregister_netdevice_notifier_net()
>still calls call_netdevice_unregister_net_notifiers, something
>that we do not want. May be we can silence these events with
>some new wrapper/parameter.
>
>> @@ -2303,9 +2293,9 @@ static struct ip_vs_service *ip_vs_info_array(struct seq_file *seq, loff_t pos)
>>  
>>  	/* look in hash by protocol */
>>  	for (idx = 0; idx < IP_VS_SVC_TAB_SIZE; idx++) {
>> -		hlist_for_each_entry_rcu(svc, &ip_vs_svc_table[idx], s_list) {
>> +		hlist_for_each_entry_rcu(svc, &ipvs->ip_vs_svc_table[idx], s_list) {
>>  			if ((svc->ipvs == ipvs) && pos-- == 0) {
>> -				iter->table = ip_vs_svc_table;
>> +				iter->table = ipvs->ip_vs_svc_table;
>
>	We can change iter->table to int table_id, 0 (ip_vs_svc_table)
>and 1 (ip_vs_svc_fwm_table), for all these ip_vs_info_* funcs.

Sorry, I don't get this. Why do we need to change this ?

>
>>  				iter->bucket = idx;
>>  				return svc;
>>  			}
>> @@ -2314,10 +2304,10 @@ static struct ip_vs_service *ip_vs_info_array(struct seq_file *seq, loff_t pos)
>>  
>>  	/* keep looking in fwmark */
>>  	for (idx = 0; idx < IP_VS_SVC_TAB_SIZE; idx++) {
>> -		hlist_for_each_entry_rcu(svc, &ip_vs_svc_fwm_table[idx],
>> +		hlist_for_each_entry_rcu(svc, &ipvs->ip_vs_svc_fwm_table[idx],
>>  					 f_list) {
>>  			if ((svc->ipvs == ipvs) && pos-- == 0) {
>> -				iter->table = ip_vs_svc_fwm_table;
>> +				iter->table = ipvs->ip_vs_svc_fwm_table;
>>  				iter->bucket = idx;
>>  				return svc;
>>  			}
>
>> @@ -3058,7 +3050,7 @@ do_ip_vs_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
>>  		return ret;
>>  	}
>>  
>> -	mutex_lock(&__ip_vs_mutex);
>> +	mutex_lock(&ipvs->service_mutex);
>>  	switch (cmd) {
>>  	case IP_VS_SO_GET_VERSION:
>>  	{
>> @@ -3157,7 +3149,7 @@ do_ip_vs_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
>>  	}
>>  
>>  out:
>> -	mutex_unlock(&__ip_vs_mutex);
>> +	mutex_unlock(&ipvs->service_mutex);
>>  	return ret;
>>  }
>>  
>> @@ -3392,9 +3384,9 @@ static int ip_vs_genl_dump_services(struct sk_buff *skb,
>>  	struct net *net = sock_net(skb->sk);
>>  	struct netns_ipvs *ipvs = net_ipvs(net);
>>  
>> -	mutex_lock(&__ip_vs_mutex);
>> +	mutex_lock(&ipvs->service_mutex);
>
>	While do_ip_vs_get_ctl is a reader that can block we
>can not use RCU but in ip_vs_genl_dump_services() we can replace
>the __ip_vs_mutex with rcu_read_lock because we just fill the skb.
>

I think we can replace mutex in ip_vs_genl_dump_services() by RCU.
Do you prefer replacing it in this patch or later ?


>>  	for (i = 0; i < IP_VS_SVC_TAB_SIZE; i++) {
>> -		hlist_for_each_entry(svc, &ip_vs_svc_table[i], s_list) {
>> +		hlist_for_each_entry(svc, &ipvs->ip_vs_svc_table[i], s_list) {
>>  			if (++idx <= start || (svc->ipvs != ipvs))
>>  				continue;
>>  			if (ip_vs_genl_dump_service(skb, svc, cb) < 0) {
>> @@ -3405,7 +3397,7 @@ static int ip_vs_genl_dump_services(struct sk_buff *skb,
>>  	}
>>  
>>  	for (i = 0; i < IP_VS_SVC_TAB_SIZE; i++) {
>> -		hlist_for_each_entry(svc, &ip_vs_svc_fwm_table[i], f_list) {
>> +		hlist_for_each_entry(svc, &ipvs->ip_vs_svc_fwm_table[i], f_list) {
>>  			if (++idx <= start || (svc->ipvs != ipvs))
>>  				continue;
>>  			if (ip_vs_genl_dump_service(skb, svc, cb) < 0) {
>> @@ -3416,7 +3408,7 @@ static int ip_vs_genl_dump_services(struct sk_buff *skb,
>>  	}
>>  
>>  nla_put_failure:
>> -	mutex_unlock(&__ip_vs_mutex);
>> +	mutex_unlock(&ipvs->service_mutex);
>>  	cb->args[0] = idx;
>>  
>>  	return skb->len;
>> @@ -3605,7 +3597,7 @@ static int ip_vs_genl_dump_dests(struct sk_buff *skb,
>>  	struct net *net = sock_net(skb->sk);
>>  	struct netns_ipvs *ipvs = net_ipvs(net);
>>  
>> -	mutex_lock(&__ip_vs_mutex);
>> +	mutex_lock(&ipvs->service_mutex);
>
>	In ip_vs_genl_dump_dests() we can use RCU too but there
>will be probably double rcu_read_lock in ip_vs_genl_parse_service(),
>so rcu_read_lock can be moved into the top caller.

Yes.

>
>>  
>>  	/* Try to find the service for which to dump destinations */
>>  	if (nlmsg_parse_deprecated(cb->nlh, GENL_HDRLEN, attrs, IPVS_CMD_ATTR_MAX, ip_vs_cmd_policy, cb->extack))
>> @@ -3630,7 +3622,7 @@ static int ip_vs_genl_dump_dests(struct sk_buff *skb,
>>  	cb->args[0] = idx;
>>  
>>  out_err:
>> -	mutex_unlock(&__ip_vs_mutex);
>> +	mutex_unlock(&ipvs->service_mutex);
>>  
>>  	return skb->len;
>>  }
>
>> @@ -4058,7 +4050,7 @@ static int ip_vs_genl_get_cmd(struct sk_buff *skb, struct genl_info *info)
>>  	if (!msg)
>>  		return -ENOMEM;
>>  
>> -	mutex_lock(&__ip_vs_mutex);
>> +	mutex_lock(&ipvs->service_mutex);
>
>	ip_vs_genl_get_cmd is another place that we can use RCU.
>

OK

>>  
>>  	reply = genlmsg_put_reply(msg, info, &ip_vs_genl_family, 0, reply_cmd);
>>  	if (reply == NULL)
>> @@ -4126,7 +4118,7 @@ static int ip_vs_genl_get_cmd(struct sk_buff *skb, struct genl_info *info)
>>  out_err:
>>  	nlmsg_free(msg);
>>  out:
>> -	mutex_unlock(&__ip_vs_mutex);
>> +	mutex_unlock(&ipvs->service_mutex);
>>  
>>  	return ret;
>>  }
>
>	Note that ip_vs_est.c uses __ip_vs_mutex too, it should be
>changed to service_mutex. Do not keep __ip_vs_mutex anymore.

OK, will fix in the next version.

>
>	Also, there is more work if we want independent
>namespaces and to give power to users:
>
>- account memory: GFP_KERNEL -> GFP_KERNEL_ACCOUNT
>
>- the connections table is still global but it should be possible
>to make all tables per-net and to grow on load from NULL to max bits
>
>- convert GENL_ADMIN_PERM -> GENL_UNS_ADMIN_PERM and make
>sysctls visible to other namespaces
>
>	If the plan is to have multiple netns loaded with many
>conns may be I can follow your patch with more optimization
>patches.

Yes, we do missed those details. I think moving those into different
netns is good, besides we already have netns supported. So why not do
it more completely ?

If it is convenient for you to do more optimizations, we would greatly
appreciate it !

Best regards,
Dust


>
>Regards
>
>--
>Julian Anastasov <ja@ssi.bg>
