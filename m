Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67975F1119
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiI3Rpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiI3Rpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:45:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652C913DDB8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 10:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664559938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e7wHbpY/fMhY8329hLlHMY08yHa14XLI1wEYquCaKE0=;
        b=A7VkieR8DLw5K7gs+znRJwVEJiXIiJvWCwHKBfNdji/0MBYlDpaXBKLYUUqTcJ31Sk1Ege
        zZ1qFDVcvSMEOEmRIT/++CXa64DZYwv55WTZW3d37qTnbZI3cQaoBpy8eUbDymt2y+4SW2
        RQqhNUXPQfgMxcMXF4lxeOzFnFBGuZE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-ucb7vFpYO_WEFb58egvarQ-1; Fri, 30 Sep 2022 13:45:27 -0400
X-MC-Unique: ucb7vFpYO_WEFb58egvarQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B6852A5954A;
        Fri, 30 Sep 2022 17:45:27 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.10.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E1B4492CA2;
        Fri, 30 Sep 2022 17:45:26 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     linux-audit@redhat.com
Cc:     boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        eparis@redhat.com, linux-kernel@vger.kernel.org,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: Re: [PATCH 1/3] audit: cache ctx->major in audit_filter_syscall()
Date:   Fri, 30 Sep 2022 13:45:26 -0400
Message-ID: <8171459.NyiUUSuA9g@x2>
Organization: Red Hat
In-Reply-To: <20220927225944.2254360-2-ankur.a.arora@oracle.com>
References: <20220927225944.2254360-1-ankur.a.arora@oracle.com> <20220927225944.2254360-2-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks for the detailed notes on this investigation. It really is  a lot of 
good information backing this up. However, there will come a day when someone 
sees this "major = ctx->major" and they will send a patch to "fix" this 
unnecessary assignment. If you are sending a V2 of this set, I would suggest 
adding some comment in the code that this is for a performance improvement 
and to see the commit message for additional info.

Thanks,
-Steve

On Tuesday, September 27, 2022 6:59:42 PM EDT Ankur Arora wrote:
> ctx->major contains the current syscall number. This is, of course, a
> constant for the duration of the syscall. Unfortunately, GCC's alias
> analysis cannot prove that it is not modified via a pointer in the
> audit_filter_syscall() loop, and so always loads it from memory.
> 
> In and of itself the load isn't very expensive (ops dependent on the
> ctx->major load are only used to determine the direction of control flow
> and have short dependence chains and, in any case the related branches
> get predicted perfectly in the fastpath) but still cache ctx->major
> in a local for two reasons:
> 
> * ctx->major is in the first cacheline of struct audit_context and has
>   similar alignment as audit_entry::list audit_entry. For cases
>   with a lot of audit rules, doing this reduces one source of contention
>   from a potentially busy cache-set.
> 
> * audit_in_mask() (called in the hot loop in audit_filter_syscall())
>   does cast manipulation and error checking on ctx->major:
> 
>      audit_in_mask(const struct audit_krule *rule, unsigned long val):
>              if (val > 0xffffffff)
>                      return false;
> 
>              word = AUDIT_WORD(val);
>              if (word >= AUDIT_BITMASK_SIZE)
>                      return false;
> 
>              bit = AUDIT_BIT(val);
> 
>              return rule->mask[word] & bit;
> 
>   The clauses related to the rule need to be evaluated in the loop, but
>   the rest is unnecessarily re-evaluated for every loop iteration.
>   (Note, however, that most of these are cheap ALU ops and the branches
>    are perfectly predicted. However, see discussion on cycles
>    improvement below for more on why it is still worth hoisting.)
> 
> On a Skylakex system change in getpid() latency (aggregated over
> 12 boot cycles):
> 
>              Min     Mean  Median     Max       pstdev
>             (ns)     (ns)    (ns)    (ns)
> 
>  -        201.30   216.14  216.22  228.46      (+- 1.45%)
>  +        196.63   207.86  206.60  230.98      (+- 3.92%)
> 
> Performance counter stats for 'bin/getpid' (3 runs) go from:
>     cycles               836.89  (  +-   .80% )
>     instructions        2000.19  (  +-   .03% )
>     IPC                    2.39  (  +-   .83% )
>     branches             430.14  (  +-   .03% )
>     branch-misses          1.48  (  +-  3.37% )
>     L1-dcache-loads      471.11  (  +-   .05% )
>     L1-dcache-load-misses  7.62  (  +- 46.98% )
> 
>  to:
>     cycles               805.58  (  +-  4.11% )
>     instructions        1654.11  (  +-   .05% )
>     IPC                    2.06  (  +-  3.39% )
>     branches             430.02  (  +-   .05% )
>     branch-misses          1.55  (  +-  7.09% )
>     L1-dcache-loads      440.01  (  +-   .09% )
>     L1-dcache-load-misses  9.05  (  +- 74.03% )
> 
> (Both aggregated over 12 boot cycles.)
> 
> instructions: we reduce around 8 instructions/iteration because some of
> the computation is now hoisted out of the loop (branch count does not
> change because GCC, for reasons unclear, only hoists the computations
> while keeping the basic-blocks.)
> 
> cycles: improve by about 5% (in aggregate and looking at individual run
> numbers.) This is likely because we now waste fewer pipeline resources
> on unnecessary instructions which allows the control flow to
> speculatively execute further ahead shortening the execution of the loop
> a little. The final gating factor on the performance of this loop
> remains the long dependence chain due to the linked-list load.
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  kernel/auditsc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 79a5da1bc5bb..533b087c3c02 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -843,13 +843,14 @@ static void audit_filter_syscall(struct task_struct
> *tsk, {
>  	struct audit_entry *e;
>  	enum audit_state state;
> +	unsigned long major = ctx->major;
> 
>  	if (auditd_test_task(tsk))
>  		return;
> 
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(e, &audit_filter_list[AUDIT_FILTER_EXIT], 
list) {
> -		if (audit_in_mask(&e->rule, ctx->major) &&
> +		if (audit_in_mask(&e->rule, major) &&
>  		    audit_filter_rules(tsk, &e->rule, ctx, NULL,
>  				       &state, false)) {
>  			rcu_read_unlock();




