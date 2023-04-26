Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510336EF0F2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbjDZJT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240159AbjDZJTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:19:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D4746A2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682500645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jvxWHN4pleINQbtviEy41ebpqPZsaL76Dfbg3weAJmg=;
        b=GD/KPR/KjRiLaRm9b5HnJTw9zbyHa0eXg0cFe7i3lEM3srnTuqbWbZapWqcQDTi366jn7F
        wsgGJoGDpPr3clYs2B8cw+ZzZXBRvH98zbHnmPe2gsAT6mCHBnW9lxSoactXiQKsHZutr7
        8eTUDHpur7gcQ3yB/M/skxSXvrJqfYQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-0K4z3M3CMxiSmAMXooe1Ww-1; Wed, 26 Apr 2023 05:17:23 -0400
X-MC-Unique: 0K4z3M3CMxiSmAMXooe1Ww-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f168827701so26243285e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682500642; x=1685092642;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvxWHN4pleINQbtviEy41ebpqPZsaL76Dfbg3weAJmg=;
        b=C18Qklp513+VclHyI1JdBsblByjQWECb33tnbyPkSmZJJAQs6rCDki+8DIgkM8hsja
         qu1vByTTv1eHD+TpTcpcksCOTKngWMcqSNiwnyNRWRKp1FXYv6FgP5IMqftg5pzHW2v8
         e0DIRV0waTa4wtjb0xVmJi1aCe8IOuCn2skaZFfRWD2Et7MUYY42lrlD9nVunT+2FEx/
         TAXOT1U0CxQ1M+p2zzvSsJFk+nYZ/dqqkol3RisuWDxTQmPoafzwMiA0cj9+8Gg9I1FV
         eE34ANKv40qgj2i5yS6eGAUcf3a88Uo+Zij2KBqnW/rDBBAHX+GzZAzRTB2ChC7TdCsp
         3W3g==
X-Gm-Message-State: AAQBX9dodoDqyzCqKR7WlPkQMlQsNuwebb2ayrYoFOC5cMVhEf3eEy1/
        K2862P/5ixn1j6yG4R60Ei3p4rRkkI6xYHpg5LgI6u5YB1vpJ5Qog7XBhLYxKi/iu1mKZ+UMl8y
        rrYveozv5rauxLKOZcdNUXFCz
X-Received: by 2002:a05:600c:2194:b0:3f0:9ff5:79fb with SMTP id e20-20020a05600c219400b003f09ff579fbmr11935224wme.39.1682500642726;
        Wed, 26 Apr 2023 02:17:22 -0700 (PDT)
X-Google-Smtp-Source: AKy350awKZ4trDCLRlRhqFdRT9vYeVZysXcN5ybDgFx6g7OwgLKTxEoxuH/fYZLPrZLtisim1Kn5MQ==
X-Received: by 2002:a05:600c:2194:b0:3f0:9ff5:79fb with SMTP id e20-20020a05600c219400b003f09ff579fbmr11935192wme.39.1682500642398;
        Wed, 26 Apr 2023 02:17:22 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c4f4600b003ee5fa61f45sm20899093wmq.3.2023.04.26.02.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 02:17:21 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>,
        Pawel Chmielewski <pawel.chmielewski@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Gal Pressman <gal@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Barry Song <baohua@kernel.org>
Subject: Re: [PATCH v2 3/8] sched/topology: add for_each_numa_cpu() macro
In-Reply-To: <ZEi3dLvlg/35DUrM@yury-ThinkPad>
References: <20230420051946.7463-1-yury.norov@gmail.com>
 <20230420051946.7463-4-yury.norov@gmail.com>
 <xhsmh4jp4l21j.mognet@vschneid.remote.csb>
 <ZEi3dLvlg/35DUrM@yury-ThinkPad>
Date:   Wed, 26 Apr 2023 10:17:20 +0100
Message-ID: <xhsmhv8hjj93z.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/23 22:32, Yury Norov wrote:
> On Tue, Apr 25, 2023 at 10:54:48AM +0100, Valentin Schneider wrote:
>> On 19/04/23 22:19, Yury Norov wrote:
>> > +/**
>> > + * for_each_numa_cpu - iterate over cpus in increasing order taking into account
>> > + *		       NUMA distances from a given node.
>> > + * @cpu: the (optionally unsigned) integer iterator
>> > + * @hop: the iterator variable, must be initialized to a desired minimal hop.
>> > + * @node: the NUMA node to start the search from.
>> > + * @mask: the cpumask pointer
>> > + *
>> > + * Requires rcu_lock to be held.
>> > + */
>> > +#define for_each_numa_cpu(cpu, hop, node, mask)					\
>> > +	for ((cpu) = 0, (hop) = 0;						\
>> > +		(cpu) = sched_numa_find_next_cpu((mask), (cpu), (node), &(hop)),\
>> > +		(cpu) < nr_cpu_ids;						\
>> > +		(cpu)++)
>> > +
>> 
>> I think we can keep sched_numa_find_next_cpu() as-is, but could we make
>> that macro use cpu_possible_mask by default? We can always add a variant
>> if/when we need to feed in a different mask.
>
> As mentioned in discussion to the driver's patch, all that numa things
> imply only online CPUs, so cpu_possible_mask may mislead to some extent. 
>
> Anyways, can you elaborate what you exactly want? Like this?
>
>  #define for_each_numa_online_cpu(cpu, hop, node)       \
>         for_each_numa_cpu(cpu, hop, node, cpu_online_mask)

Yeah, something like that. Like you said, the NUMA cpumasks built by the
scheduler reflect the online topology, so s/possible/online/ shouldn't
change much here.

