Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10ADC6DF622
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjDLMuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjDLMtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:49:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F99F7AA3;
        Wed, 12 Apr 2023 05:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nwnw2uTfPO5n4Gp8ZTbsCl6BKgatqoYliynKz2+TMOM=; b=WFnv1NjOaGkkXkkj+IrnKd7VMG
        yQnXQFDdQyp/GOGVYk6aypVrAhYvyisIgw2Uo4hCN3Im1JZ7a5ATB9eHTDhr3HnoVI3M/Vayn6QhF
        Sy8EqNZ313UZZkfaKCKT7K1VWQaqm0Z/t8tZHqV9k9wyonlE8+eKAd+0HBKVc5OyKolPFGAec85JG
        zU/03alRPxg/VHUqgbbs74x/cgYOANmiUdSHeTIUcY9C3aJ+9ghiyXHRrhC7jXVn2zu+X13X/gV1F
        5Hze/xTOeJg444vNqcxku6Bplu3ZPCiU8FxDs5uQH6H4JnC432lX260nwmoKXWZyenGZ+GJ1N9C8v
        6D5AB3SA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pmZtu-006s9e-0x; Wed, 12 Apr 2023 12:48:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BCC45300274;
        Wed, 12 Apr 2023 14:48:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ADFD2235CC4A0; Wed, 12 Apr 2023 14:48:36 +0200 (CEST)
Date:   Wed, 12 Apr 2023 14:48:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhao Gongyi <zhaogongyi@bytedance.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] mm: slub: annotate kmem_cache_node->list_lock as
 raw_spinlock
Message-ID: <20230412124836.GF628377@hirez.programming.kicks-ass.net>
References: <20230411130854.46795-1-zhengqi.arch@bytedance.com>
 <c6ea3b17-a89c-6f66-5c86-967f1da601b4@suse.cz>
 <ccaf5e8e-3457-a2cf-b6eb-794cbf1b46f5@bytedance.com>
 <f54cfeb9-f1c3-e656-d344-4cbf97a7c28a@suse.cz>
 <932bf921-a076-e166-4f95-1adb24d544cf@bytedance.com>
 <ZDZG6wlWIE4dzd4W@Boquns-Mac-mini.local>
 <PH0PR11MB58805856C1C47D49D1BA8092DA9B9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <e6a21ac6-939c-c686-387b-20f81ba5be53@suse.cz>
 <29efad1c-5ad4-5d26-b1b9-eeee6119e711@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29efad1c-5ad4-5d26-b1b9-eeee6119e711@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 03:30:20PM +0800, Qi Zheng wrote:
> Maybe we should make CONFIG_PROVE_RAW_LOCK_NESTING depend on
> CONFIG_PREEMPT_RT:
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index f0d5b82e478d..257b170aacb6 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1262,6 +1262,7 @@ config PROVE_LOCKING
>  config PROVE_RAW_LOCK_NESTING
>         bool "Enable raw_spinlock - spinlock nesting checks"
>         depends on PROVE_LOCKING
> +       depends on PREEMPT_RT
>         default n
>         help
>          Enable the raw_spinlock vs. spinlock nesting checks which ensure

No, very much not. The idea is that we want to work towards having this
always enabled (when PROVE_LOCKING) to ensure code gets and stays
PREEMPT_RT clean.
