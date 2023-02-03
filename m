Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8B96897AC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 12:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjBCLYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 06:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjBCLYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:24:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129F04344E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 03:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675423441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zhq1czrHiik5uQQSsmoyIUMKDYlZmq68TjVRMgyrb34=;
        b=IJUksImrncrgsEAhVPyK/QTnsLmsrzFkS3xxy14q4tKFj8bJxQNTTAHy/v3LOFryP0HLFW
        MQ9bZQAowi1nb6lYbOYzmGd+IAZz2qhj4EOnt2BzxiT3TFaxtOBCBEtPug57SjzyvqhvLr
        1KkPFlXhs1rh71qWsEEmqR2RhrTTob4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-43-0deGIQhDMHuogum9riggdQ-1; Fri, 03 Feb 2023 06:23:52 -0500
X-MC-Unique: 0deGIQhDMHuogum9riggdQ-1
Received: by mail-ed1-f69.google.com with SMTP id b6-20020aa7c906000000b004a25542075eso3377882edt.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 03:23:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhq1czrHiik5uQQSsmoyIUMKDYlZmq68TjVRMgyrb34=;
        b=wbknOAIzmHf1fk5XF09InPKDfEa6co/SVwXmzWPudpwhymux0cDsD2eg3jMgIvxXHx
         gVIiGI3BuTd84qouD0GoPkeQy5WuuEQBKg4OXyFtWh4tFvRP4IZW44IDWjlb8iMBsud5
         D03wM8EujDSQlHFwHuu4A2xPZoWc9kZg9tYutWKj6ejvoUW6E0NhhCfY8FxhC4pLRIHQ
         RqazFBZEnGYV3Yv/yxBfk8F2nsShsE0N4JFoGkS2I2tDkk4Vm41zz3yvwUoo7MezZoUT
         MmzA8VDm0kGfSERVHSyHS7ia++mbFGMe+ycTjo+xoVUJENGObCxrgPy0mrjvp1w0lt8q
         Gfkw==
X-Gm-Message-State: AO0yUKX8YhNKhj/FPjaoEIwf510H2txdFq19mKdJPRo8kidxGgY3EAYE
        ZNJANbhqUUjqgDWZE4+lZK6MBvgDXNbg7QEvHCQ6Xf8i454Y2Qx5KaSHWDyPwz7MoUjgX1yf8wp
        yuw2B462gNkADy2WEzhBeLc5G
X-Received: by 2002:a05:6402:3488:b0:494:fae3:c0df with SMTP id v8-20020a056402348800b00494fae3c0dfmr11297756edc.12.1675423430636;
        Fri, 03 Feb 2023 03:23:50 -0800 (PST)
X-Google-Smtp-Source: AK7set8nY/mYe4IFjehPPcHIehD4iLWbJNZBJPDIpsQd+WRYamOnl0xBxHfcd5xtbpoTtyeyxlDqMw==
X-Received: by 2002:a05:6402:3488:b0:494:fae3:c0df with SMTP id v8-20020a056402348800b00494fae3c0dfmr11297740edc.12.1675423430407;
        Fri, 03 Feb 2023 03:23:50 -0800 (PST)
Received: from [10.39.192.185] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id w12-20020a056402268c00b0049e65e4ff20sm984227edd.14.2023.02.03.03.23.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Feb 2023 03:23:49 -0800 (PST)
From:   Eelco Chaudron <echaudro@redhat.com>
To:     Eddy Tao <taoyuan_eddy@hotmail.com>
Cc:     netdev@vger.kernel.org, Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, dev@openvswitch.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 1/1] net:openvswitch:reduce cpu_used_mask
 memory
Date:   Fri, 03 Feb 2023 12:23:49 +0100
X-Mailer: MailMate (1.14r5939)
Message-ID: <ECDAB6E2-EBFE-435C-B5E5-0E27BABA822F@redhat.com>
In-Reply-To: <OS3P286MB2295DC976A51C0087F6FE16BF5D79@OS3P286MB2295.JPNP286.PROD.OUTLOOK.COM>
References: <20230203095118.276261-1-taoyuan_eddy@hotmail.com>
 <OS3P286MB2295DC976A51C0087F6FE16BF5D79@OS3P286MB2295.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3 Feb 2023, at 10:51, Eddy Tao wrote:

> Use actual CPU number instead of hardcoded value to decide the size
> of 'cpu_used_mask' in 'struct sw_flow'. Below is the reason.
>
> 'struct cpumask cpu_used_mask' is embedded in struct sw_flow.
> Its size is hardcoded to CONFIG_NR_CPUS bits, which can be
> 8192 by default, it costs memory and slows down ovs_flow_alloc
>
> To address this, redefine cpu_used_mask to pointer
> append cpumask_size() bytes after 'stat' to hold cpumask
>
> cpumask APIs like cpumask_next and cpumask_set_cpu never access
> bits beyond cpu count, cpumask_size() bytes of memory is enough
>
> Signed-off-by: Eddy Tao <taoyuan_eddy@hotmail.com>

Hi Eddy,

Thanks for this patch, I have one small nit, but the rest looks good.

Acked-by: Eelco Chaudron <echaudro@redhat.com>

> ---
>  net/openvswitch/flow.c       | 9 ++++++---
>  net/openvswitch/flow.h       | 2 +-
>  net/openvswitch/flow_table.c | 8 +++++---
>  3 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
> index e20d1a973417..416976f70322 100644
> --- a/net/openvswitch/flow.c
> +++ b/net/openvswitch/flow.c
> @@ -107,7 +107,8 @@ void ovs_flow_stats_update(struct sw_flow *flow, __=
be16 tcp_flags,
>
>  					rcu_assign_pointer(flow->stats[cpu],
>  							   new_stats);
> -					cpumask_set_cpu(cpu, &flow->cpu_used_mask);
> +					cpumask_set_cpu(cpu,
> +							flow->cpu_used_mask);
>  					goto unlock;
>  				}
>  			}
> @@ -135,7 +136,8 @@ void ovs_flow_stats_get(const struct sw_flow *flow,=

>  	memset(ovs_stats, 0, sizeof(*ovs_stats));
>
>  	/* We open code this to make sure cpu 0 is always considered */
> -	for (cpu =3D 0; cpu < nr_cpu_ids; cpu =3D cpumask_next(cpu, &flow->cp=
u_used_mask)) {
> +	for (cpu =3D 0; cpu < nr_cpu_ids;
> +	     cpu =3D cpumask_next(cpu, flow->cpu_used_mask)) {
>  		struct sw_flow_stats *stats =3D rcu_dereference_ovsl(flow->stats[cpu=
]);
>
>  		if (stats) {
> @@ -159,7 +161,8 @@ void ovs_flow_stats_clear(struct sw_flow *flow)
>  	int cpu;
>
>  	/* We open code this to make sure cpu 0 is always considered */
> -	for (cpu =3D 0; cpu < nr_cpu_ids; cpu =3D cpumask_next(cpu, &flow->cp=
u_used_mask)) {
> +	for (cpu =3D 0; cpu < nr_cpu_ids;
> +	     cpu =3D cpumask_next(cpu, flow->cpu_used_mask)) {
>  		struct sw_flow_stats *stats =3D ovsl_dereference(flow->stats[cpu]);
>
>  		if (stats) {
> diff --git a/net/openvswitch/flow.h b/net/openvswitch/flow.h
> index 073ab73ffeaa..b5711aff6e76 100644
> --- a/net/openvswitch/flow.h
> +++ b/net/openvswitch/flow.h
> @@ -229,7 +229,7 @@ struct sw_flow {
>  					 */
>  	struct sw_flow_key key;
>  	struct sw_flow_id id;
> -	struct cpumask cpu_used_mask;
> +	struct cpumask *cpu_used_mask;
>  	struct sw_flow_mask *mask;
>  	struct sw_flow_actions __rcu *sf_acts;
>  	struct sw_flow_stats __rcu *stats[]; /* One for each CPU.  First one
> diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.=
c
> index 0a0e4c283f02..dc6a174c3194 100644
> --- a/net/openvswitch/flow_table.c
> +++ b/net/openvswitch/flow_table.c
> @@ -87,11 +87,12 @@ struct sw_flow *ovs_flow_alloc(void)
>  	if (!stats)
>  		goto err;
>
> +	flow->cpu_used_mask =3D (struct cpumask *)&flow->stats[nr_cpu_ids];

nit: I would move this up with the other flow structure initialisation.

diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.c
index dc6a174c3194..791504b7f42b 100644
--- a/net/openvswitch/flow_table.c
+++ b/net/openvswitch/flow_table.c
@@ -79,6 +79,7 @@ struct sw_flow *ovs_flow_alloc(void)
                return ERR_PTR(-ENOMEM);

        flow->stats_last_writer =3D -1;
+       flow->cpu_used_mask =3D (struct cpumask *)&flow->stats[nr_cpu_ids=
];

        /* Initialize the default stat node. */
        stats =3D kmem_cache_alloc_node(flow_stats_cache,
@@ -87,7 +88,6 @@ struct sw_flow *ovs_flow_alloc(void)
        if (!stats)
                goto err;

-       flow->cpu_used_mask =3D (struct cpumask *)&flow->stats[nr_cpu_ids=
];
        spin_lock_init(&stats->lock);

>  	spin_lock_init(&stats->lock);
>
>  	RCU_INIT_POINTER(flow->stats[0], stats);
>
> -	cpumask_set_cpu(0, &flow->cpu_used_mask);
> +	cpumask_set_cpu(0, flow->cpu_used_mask);
>
>  	return flow;
>  err:
> @@ -115,7 +116,7 @@ static void flow_free(struct sw_flow *flow)
>  					  flow->sf_acts);
>  	/* We open code this to make sure cpu 0 is always considered */
>  	for (cpu =3D 0; cpu < nr_cpu_ids;
> -	     cpu =3D cpumask_next(cpu, &flow->cpu_used_mask)) {
> +	     cpu =3D cpumask_next(cpu, flow->cpu_used_mask)) {
>  		if (flow->stats[cpu])
>  			kmem_cache_free(flow_stats_cache,
>  					(struct sw_flow_stats __force *)flow->stats[cpu]);
> @@ -1196,7 +1197,8 @@ int ovs_flow_init(void)
>
>  	flow_cache =3D kmem_cache_create("sw_flow", sizeof(struct sw_flow)
>  				       + (nr_cpu_ids
> -					  * sizeof(struct sw_flow_stats *)),
> +					  * sizeof(struct sw_flow_stats *))
> +				       + cpumask_size(),
>  				       0, 0, NULL);
>  	if (flow_cache =3D=3D NULL)
>  		return -ENOMEM;
> -- =

> 2.27.0

