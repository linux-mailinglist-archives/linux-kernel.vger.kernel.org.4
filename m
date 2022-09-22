Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A4B5E5FA5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiIVKRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiIVKRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:17:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED64DC125
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 03:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663841818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HUN+JkohV/Hs8Bgw+dUgAx+NhWOZARkb70z2JQQZ/nI=;
        b=J36jiRqvb2ozSFBRgcK8oN4Qrh0RRaaBNOL4BpHru9EkZrMouLEZnZkPqCfxbRQxraWjBE
        Vt0UguDyF3ULSV29Is+aqh/jV4O2h0UTXV+KFzRJekfIJpQ+qdTsJ6tDTfQGChGJaW8B92
        E4f9ExyX/Y9rOZhwAcS75ZiHUJmSfJE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-632-LKBHDsBkOKyYiPooTzZmFw-1; Thu, 22 Sep 2022 06:16:57 -0400
X-MC-Unique: LKBHDsBkOKyYiPooTzZmFw-1
Received: by mail-qk1-f197.google.com with SMTP id v15-20020a05620a0f0f00b006ceab647023so6301890qkl.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 03:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=HUN+JkohV/Hs8Bgw+dUgAx+NhWOZARkb70z2JQQZ/nI=;
        b=n1v+EPh59rgEVD0AHXqvT7qY+ye4CwrcQar+YpBzev/vUXCLWO89DionLeztJ10xNm
         Uk8UPSB0iGqprHU9SIwUlc4i5e7M2xcPDCL5N8eWX4SEtnfOO+tu7JqdclEjGcMhaBMc
         PTFpUitsKtpG9h+OfBqc5yVCNHfLEOZ0p9U9M8uTeVofKBO9Nqc98wAcyds8Zs8eRThA
         jMYOWKYPZDi1aHu8RvwqYqUb6UtV3DAHRCZMdrXWz1e4gh0IJp3S7L83alF4o1vhh6TD
         wwjznBvowWhUNDUPEj/rHvTnCCPjLoN6jrBXSNZS4mBBzDlDwqVLFgXV+da127g5A+G/
         YdsQ==
X-Gm-Message-State: ACrzQf0XthmU/zd3hYyjvaHafUtzeLTbPkekDeYTnHM/7jseYJNisJAv
        uhEZNqWTYX1ZT0otLOHh+pWNkD1v4YJowc3ljOGXpQnJswpb3kRq8SPQKFKIt+6TjrhFRoVgkxi
        bMMjpSdU6pMrfYuO18XFUKOAe
X-Received: by 2002:a05:620a:270b:b0:6ce:8cb:6fbe with SMTP id b11-20020a05620a270b00b006ce08cb6fbemr1539048qkp.180.1663841817130;
        Thu, 22 Sep 2022 03:16:57 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM73G+9fAPdwtQKkuIlIg4O40TPSd+4BP5FUXskdBef464UADVVZDAldqePByMMOO5GV+/zWOg==
X-Received: by 2002:a05:620a:270b:b0:6ce:8cb:6fbe with SMTP id b11-20020a05620a270b00b006ce08cb6fbemr1539036qkp.180.1663841816863;
        Thu, 22 Sep 2022 03:16:56 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-76.dyn.eolo.it. [146.241.104.76])
        by smtp.gmail.com with ESMTPSA id 20-20020ac85654000000b0035bb8168daesm3259946qtt.57.2022.09.22.03.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 03:16:56 -0700 (PDT)
Message-ID: <dbd40afb1f5d9e8c3866f7a3dd98d970f3c76f9a.camel@redhat.com>
Subject: Re: [PATCH net-next v6 8/9] net: marvell: prestera: Add neighbour
 cache accounting
From:   Paolo Abeni <pabeni@redhat.com>
To:     Yevhen Orlov <yevhen.orlov@plvision.eu>, netdev@vger.kernel.org
Cc:     Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>,
        Taras Chornyi <taras.chornyi@plvision.eu>,
        Mickey Rachamim <mickeyr@marvell.com>,
        Serhiy Pshyk <serhiy.pshyk@plvision.eu>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org, Taras Chornyi <tchornyi@marvell.com>,
        Oleksandr Mazur <oleksandr.mazur@plvision.eu>
Date:   Thu, 22 Sep 2022 12:16:52 +0200
In-Reply-To: <20220918194700.19905-9-yevhen.orlov@plvision.eu>
References: <20220918194700.19905-1-yevhen.orlov@plvision.eu>
         <20220918194700.19905-9-yevhen.orlov@plvision.eu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-09-18 at 22:46 +0300, Yevhen Orlov wrote:
> Move forward and use new PRESTERA_FIB_TYPE_UC_NH to provide basic
> nexthop routes support.
> Provide deinitialization sequence for all created router objects.
> 
> Limitations:
> - Only "local" and "main" tables supported
> - Only generic interfaces supported for router (no bridges or vlans)
> 
> Co-developed-by: Taras Chornyi <tchornyi@marvell.com>
> Signed-off-by: Taras Chornyi <tchornyi@marvell.com>
> Co-developed-by: Oleksandr Mazur <oleksandr.mazur@plvision.eu>
> Signed-off-by: Oleksandr Mazur <oleksandr.mazur@plvision.eu>
> Signed-off-by: Yevhen Orlov <yevhen.orlov@plvision.eu>
> ---
>  .../net/ethernet/marvell/prestera/prestera.h  |   1 +
>  .../marvell/prestera/prestera_router.c        | 815 +++++++++++++++++-
>  2 files changed, 813 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera.h b/drivers/net/ethernet/marvell/prestera/prestera.h
> index 2f2f80e7e358..540a36069b79 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera.h
> +++ b/drivers/net/ethernet/marvell/prestera/prestera.h
> @@ -316,6 +316,7 @@ struct prestera_router {
>  	struct rhashtable nh_neigh_ht;
>  	struct rhashtable nexthop_group_ht;
>  	struct rhashtable fib_ht;
> +	struct rhashtable kern_neigh_cache_ht;
>  	struct rhashtable kern_fib_cache_ht;
>  	struct notifier_block inetaddr_nb;
>  	struct notifier_block inetaddr_valid_nb;
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_router.c b/drivers/net/ethernet/marvell/prestera/prestera_router.c
> index a6af3b53838e..771d123345ac 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_router.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_router.c
> @@ -8,11 +8,30 @@
>  #include <net/switchdev.h>
>  #include <linux/rhashtable.h>
>  #include <net/nexthop.h>
> +#include <net/arp.h>
> +#include <linux/if_vlan.h>
> +#include <linux/if_macvlan.h>
>  #include <net/netevent.h>
>  
>  #include "prestera.h"
>  #include "prestera_router_hw.h"
>  
> +struct prestera_kern_neigh_cache_key {
> +	struct prestera_ip_addr addr;
> +	struct net_device *dev;
> +};
> +
> +struct prestera_kern_neigh_cache {
> +	struct prestera_kern_neigh_cache_key key;
> +	struct rhash_head ht_node;
> +	struct list_head kern_fib_cache_list;
> +	/* Hold prepared nh_neigh info if is in_kernel */
> +	struct prestera_neigh_info nh_neigh_info;
> +	/* Indicate if neighbour is reachable by direct route */
> +	bool reachable;
> +	/* Lock cache if neigh is present in kernel */
> +	bool in_kernel;
> +};
>  struct prestera_kern_fib_cache_key {
>  	struct prestera_ip_addr addr;
>  	u32 prefix_len;
> @@ -25,9 +44,15 @@ struct prestera_kern_fib_cache {
>  	struct {
>  		struct prestera_fib_key fib_key;
>  		enum prestera_fib_type fib_type;
> +		struct prestera_nexthop_group_key nh_grp_key;
>  	} lpm_info; /* hold prepared lpm info */
>  	/* Indicate if route is not overlapped by another table */
>  	struct rhash_head ht_node; /* node of prestera_router */
> +	struct prestera_kern_neigh_cache_head {
> +		struct prestera_kern_fib_cache *this;
> +		struct list_head head;
> +		struct prestera_kern_neigh_cache *n_cache;
> +	} kern_neigh_cache_head[PRESTERA_NHGR_SIZE_MAX];
>  	union {
>  		struct fib_notifier_info info; /* point to any of 4/6 */
>  		struct fib_entry_notifier_info fen4_info;
> @@ -35,6 +60,13 @@ struct prestera_kern_fib_cache {
>  	bool reachable;
>  };
>  
> +static const struct rhashtable_params __prestera_kern_neigh_cache_ht_params = {
> +	.key_offset  = offsetof(struct prestera_kern_neigh_cache, key),
> +	.head_offset = offsetof(struct prestera_kern_neigh_cache, ht_node),
> +	.key_len     = sizeof(struct prestera_kern_neigh_cache_key),
> +	.automatic_shrinking = true,
> +};
> +
>  static const struct rhashtable_params __prestera_kern_fib_cache_ht_params = {
>  	.key_offset  = offsetof(struct prestera_kern_fib_cache, key),
>  	.head_offset = offsetof(struct prestera_kern_fib_cache, ht_node),
> @@ -67,6 +99,278 @@ prestera_util_fen_info2fib_cache_key(struct fib_notifier_info *info,
>  	key->kern_tb_id = fen_info->tb_id;
>  }
>  
> +static int prestera_util_nhc2nc_key(struct prestera_switch *sw,
> +				    struct fib_nh_common *nhc,
> +				    struct prestera_kern_neigh_cache_key *nk)
> +{
> +	memset(nk, 0, sizeof(*nk));
> +	if (nhc->nhc_gw_family == AF_INET) {
> +		nk->addr.v = PRESTERA_IPV4;
> +		nk->addr.u.ipv4 = nhc->nhc_gw.ipv4;
> +	} else {
> +		nk->addr.v = PRESTERA_IPV6;
> +		nk->addr.u.ipv6 = nhc->nhc_gw.ipv6;
> +	}
> +
> +	nk->dev = nhc->nhc_dev;
> +	return 0;
> +}
> +
> +static void
> +prestera_util_nc_key2nh_key(struct prestera_kern_neigh_cache_key *ck,
> +			    struct prestera_nh_neigh_key *nk)
> +{
> +	memset(nk, 0, sizeof(*nk));
> +	nk->addr = ck->addr;
> +	nk->rif = (void *)ck->dev;
> +}
> +
> +static bool
> +prestera_util_nhc_eq_n_cache_key(struct prestera_switch *sw,
> +				 struct fib_nh_common *nhc,
> +				 struct prestera_kern_neigh_cache_key *nk)
> +{
> +	struct prestera_kern_neigh_cache_key tk;
> +	int err;
> +
> +	err = prestera_util_nhc2nc_key(sw, nhc, &tk);
> +	if (err)
> +		return false;
> +
> +	if (memcmp(&tk, nk, sizeof(tk)))
> +		return false;
> +
> +	return true;
> +}
> +
> +static int
> +prestera_util_neigh2nc_key(struct prestera_switch *sw, struct neighbour *n,
> +			   struct prestera_kern_neigh_cache_key *key)
> +{
> +	memset(key, 0, sizeof(*key));
> +	if (n->tbl->family == AF_INET) {
> +		key->addr.v = PRESTERA_IPV4;
> +		key->addr.u.ipv4 = *(__be32 *)n->primary_key;
> +	} else {
> +		return -ENOENT;
> +	}
> +
> +	key->dev = n->dev;
> +
> +	return 0;
> +}
> +
> +static bool __prestera_fi_is_direct(struct fib_info *fi)
> +{
> +	struct fib_nh *fib_nh;
> +
> +	if (fib_info_num_path(fi) == 1) {
> +		fib_nh = fib_info_nh(fi, 0);
> +		if (fib_nh->fib_nh_gw_family == AF_UNSPEC)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool prestera_fi_is_direct(struct fib_info *fi)
> +{
> +	if (fi->fib_type != RTN_UNICAST)
> +		return false;
> +
> +	return __prestera_fi_is_direct(fi);
> +}
> +
> +static bool prestera_fi_is_nh(struct fib_info *fi)
> +{
> +	if (fi->fib_type != RTN_UNICAST)
> +		return false;
> +
> +	return !__prestera_fi_is_direct(fi);
> +}
> +
> +static bool __prestera_fi6_is_direct(struct fib6_info *fi)
> +{
> +	if (!fi->fib6_nh->nh_common.nhc_gw_family)
> +		return true;
> +
> +	return false;
> +}
> +
> +static bool prestera_fi6_is_direct(struct fib6_info *fi)
> +{
> +	if (fi->fib6_type != RTN_UNICAST)
> +		return false;
> +
> +	return __prestera_fi6_is_direct(fi);
> +}
> +
> +static bool prestera_fi6_is_nh(struct fib6_info *fi)
> +{
> +	if (fi->fib6_type != RTN_UNICAST)
> +		return false;
> +
> +	return !__prestera_fi6_is_direct(fi);
> +}
> +
> +static bool prestera_fib_info_is_direct(struct fib_notifier_info *info)
> +{
> +	struct fib6_entry_notifier_info *fen6_info =
> +		container_of(info, struct fib6_entry_notifier_info, info);
> +	struct fib_entry_notifier_info *fen_info =
> +		container_of(info, struct fib_entry_notifier_info, info);
> +
> +	if (info->family == AF_INET)
> +		return prestera_fi_is_direct(fen_info->fi);
> +	else
> +		return prestera_fi6_is_direct(fen6_info->rt);
> +}
> +
> +static bool prestera_fib_info_is_nh(struct fib_notifier_info *info)
> +{
> +	struct fib6_entry_notifier_info *fen6_info =
> +		container_of(info, struct fib6_entry_notifier_info, info);
> +	struct fib_entry_notifier_info *fen_info =
> +		container_of(info, struct fib_entry_notifier_info, info);
> +
> +	if (info->family == AF_INET)
> +		return prestera_fi_is_nh(fen_info->fi);
> +	else
> +		return prestera_fi6_is_nh(fen6_info->rt);
> +}
> +
> +/* must be called with rcu_read_lock() */
> +static int prestera_util_kern_get_route(struct fib_result *res, u32 tb_id,
> +					__be32 *addr)
> +{
> +	struct fib_table *tb;
> +	struct flowi4 fl4;
> +	int ret;
> +
> +	/* TODO: walkthrough appropriate tables in kernel
> +	 * to know if the same prefix exists in several tables
> +	 */
> +	tb = fib_new_table(&init_net, tb_id);
> +	if (!tb)
> +		return -ENOENT;
> +
> +	memset(&fl4, 0, sizeof(fl4));
> +	fl4.daddr = *addr;
> +	ret = fib_table_lookup(tb, &fl4, res, FIB_LOOKUP_NOREF);
> +	if (ret)
> +		return ret;

Likely you can use fib_lookup() instead of all the above.

Thanks,

Paolo

