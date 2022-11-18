Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6661C62F2A0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbiKRKdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241499AbiKRKdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:33:14 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D33922EE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ery4e7DXynGUHcFDdPwXSq/cHJt8hNQ6mXrrfbI6xLk=; b=EIGeQOPHkYWExKKZj8puEdHFeG
        3uF7oA7oIK4hx+OZebNmAvZGuL3ecRuBR9gvsGIjdiUJ4yC4uURrDvGR5k+ITrfnIN4oHVlgyPR5I
        D9nZ0xZyxdjb+JrMOYqCiin876QRJQN+hx3l3Kdd7sf95yKGzo+idh+uVVmFnzn/hzMNR5/urvAlT
        dI0QMG5YBg+sT7jGX8Y/UcIR9S5TIJaVeN4N+oByK2TayIcf1aO/CQna0NxS+JOnz/bXR8zP7S7nx
        rwBIlkL8NIzGToNjO6PMoZIv2z3mfsN649W0Rk7hDNd6kOEMR2AtDQYZ3UWuq2cV9hf8p6LN//MVv
        nrWWxBEQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovyg3-001x27-EE; Fri, 18 Nov 2022 10:32:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6F817300462;
        Fri, 18 Nov 2022 11:32:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 527C520C9821C; Fri, 18 Nov 2022 11:32:54 +0100 (CET)
Date:   Fri, 18 Nov 2022 11:32:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Marco Elver <elver@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kasan-dev <kasan-dev@googlegroups.com>, X86 ML <x86@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, regressions@lists.linux.dev,
        lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>
Subject: Re: WARNING: CPU: 0 PID: 0 at arch/x86/include/asm/kfence.h:46
 kfence_protect
Message-ID: <Y3dfVtYINF/u7Sar@hirez.programming.kicks-ass.net>
References: <CA+G9fYuFxZTxkeS35VTZMXwQvohu73W3xbZ5NtjebsVvH6hCuA@mail.gmail.com>
 <Y3Y+DQsWa79bNuKj@elver.google.com>
 <4208866d-338f-4781-7ff9-023f016c5b07@intel.com>
 <Y3bCV6VckVUEF7Pq@elver.google.com>
 <41ac24c4-6c95-d946-2679-c1be2cb20536@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41ac24c4-6c95-d946-2679-c1be2cb20536@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 03:54:21PM -0800, Dave Hansen wrote:
> On 11/17/22 15:23, Marco Elver wrote:
> > Yes - it's the 'level != PG_LEVEL_4K'.
> 
> That plus the bisect made it pretty easy to find, thanks for the effort!
> 
> Could you double-check that the attached patch fixes it?  It seemed to
> for me.
> 
> The issue was that the new "No changes, easy!" check in the suspect
> commit didn't check the cpa->force_split option.  It didn't split down
> to 4k and then all hell broke loose.
> 
> Oh, and I totally misread the kfence ability to tolerate partial TLB
> flushes.  Sorry for the noise there!

> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 220361ceb997..9b4e2ad957f6 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -1727,7 +1727,8 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int primary)
>  	/*
>  	 * No changes, easy!
>  	 */
> -	if (!(pgprot_val(cpa->mask_set) | pgprot_val(cpa->mask_clr)))
> +	if (!(pgprot_val(cpa->mask_set) | pgprot_val(cpa->mask_clr))
> +	    && !cpa->force_split)

(operators go at the end of the previous line)

>  		return ret;
>  
>  	while (rempages) {

Urgh.. sorry about that.

