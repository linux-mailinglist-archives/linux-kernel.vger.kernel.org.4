Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF34B62E5F8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 21:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239843AbiKQUds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 15:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiKQUd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 15:33:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573E1E01;
        Thu, 17 Nov 2022 12:33:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9FA762260;
        Thu, 17 Nov 2022 20:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCE0C433D6;
        Thu, 17 Nov 2022 20:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1668717205;
        bh=J1Zev6kImlFGtY0atk2gzgbyl3HFY7zcz895np01klE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fSBbmNSJwKeF9aaQNye1w0lI2iZo/47DwIU8iqTmIvN10BcHDdcf8jenPtftm2F/Q
         dJUCcsyYiesYxSEtD+AA7cmqXHLXdmlPDbbDR34ZqRI2QIBLt1706qWq3H0MFW0Hol
         Y9J7fyqH2SjeDuhdgth11VoAtDnD5Ob9utHpyz/I=
Date:   Thu, 17 Nov 2022 12:33:24 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, thunder.leizhen@huawei.com,
        frederic@kernel.org, joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Make vmalloc_dump_obj() call in a preemptible
 context
Message-Id: <20221117123324.c3cdad45b3204d57b5f7bc3d@linux-foundation.org>
In-Reply-To: <20221117112520.3942618-1-qiang1.zhang@intel.com>
References: <20221117112520.3942618-1-qiang1.zhang@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022 19:25:20 +0800 Zqiang <qiang1.zhang@intel.com> wrote:

> Currently, the mem_dump_obj() is invoked in call_rcu(), the
> call_rcu() is maybe invoked in non-preemptive code segment,
> for object allocated from vmalloc(), the following scenarios
> may occur:
> 
>         CPU 0
> tasks context
>    spin_lock(&vmap_area_lock)
>           Interrupt context
>               call_rcu()
>                 mem_dump_obj
>                   vmalloc_dump_obj
>                     spin_lock(&vmap_area_lock) <--deadlock
> 
> and for PREEMPT-RT kernel, the spinlock will convert to sleepable
> lock, so the vmap_area_lock spinlock not allowed to get in non-preemptive
> code segment. therefore, this commit make the vmalloc_dump_obj() call in
> a preemptible context.
> 
> ...
>
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1128,7 +1128,9 @@ void mem_dump_obj(void *object)
>  		return;
>  
>  	if (virt_addr_valid(object))
> -		type = "non-slab/vmalloc memory";
> +		type = "non-slab memory";
> +	else if (is_vmalloc_addr(object))
> +		type = "vmalloc memory";
>  	else if (object == NULL)
>  		type = "NULL pointer";
>  	else if (object == ZERO_SIZE_PTR)
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ccaa461998f3..018e417b12d6 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4034,6 +4034,10 @@ bool vmalloc_dump_obj(void *object)
>  	struct vm_struct *vm;
>  	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
>  
> +	if (!is_vmalloc_addr(objp) || ((IS_ENABLED(CONFIG_PREEMPT_RT) &&
> +				!preemptible()) || in_interrupt()))
> +		return false;
> +
>  	vm = find_vm_area(objp);
>  	if (!vm)
>  		return false;

I suggest this be restructured so we can comment each test:

	/* comment goes here */
	if (!is_vmalloc_addr(objp))
		return false;

	/* comment goes here */
	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
		return false;

	/* comment goes here */
	if (in_interrupt()))
		return false;

Where each comment carefully explains why we're performing the test. 
It will generate the same code.

