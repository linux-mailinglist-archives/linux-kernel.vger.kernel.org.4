Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A3667C191
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbjAZA2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjAZA22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:28:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B81F64687
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:28:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E943F616ED
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EDCC433EF;
        Thu, 26 Jan 2023 00:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674692893;
        bh=Rts4+1Au/Ll1O1kl9uisvJrfAICueoMmMPvZ7zzpAqw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KuBUX56vtogE4UJe6QcxCQYV1fnGIIAVDRHmEfVf7Io28I7Qne+FMKR+WO3/aPVQ9
         +q9b0nfdwqAjtDr4j+Krm5O7RMTO6yhEukGdW/S9RprylHXNKdIq2CXUQIL16AJEf+
         a+rdH26novPowhDFg08/Fuj5XWuEI0u+LyTNj48k=
Date:   Wed, 25 Jan 2023 16:28:10 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 2/7] mm: introduce vma->vm_flags wrapper functions
Message-Id: <20230125162810.ec222773d13cd26c55991fde@linux-foundation.org>
In-Reply-To: <20230125233554.153109-3-surenb@google.com>
References: <20230125233554.153109-1-surenb@google.com>
        <20230125233554.153109-3-surenb@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jan 2023 15:35:49 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -491,7 +491,15 @@ struct vm_area_struct {
>  	 * See vmf_insert_mixed_prot() for discussion.
>  	 */
>  	pgprot_t vm_page_prot;
> -	unsigned long vm_flags;		/* Flags, see mm.h. */
> +
> +	/*
> +	 * Flags, see mm.h.
> +	 * To modify use {init|reset|set|clear|mod}_vm_flags() functions.
> +	 */
> +	union {
> +		const vm_flags_t vm_flags;
> +		vm_flags_t __private __vm_flags;
> +	};

Typically when making a change like this we'll rename the affected
field/variable/function/etc.  This will reliably and deliberately break
unconverted usage sites.

This const trick will get us partway there, by breaking setters.  But
renaming it will break both setters and getters.

