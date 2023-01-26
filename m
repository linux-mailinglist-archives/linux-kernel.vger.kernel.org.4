Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDE967C165
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjAZAWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjAZAWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:22:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E96F5142D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:22:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42A44B81B3E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40041C4339C;
        Thu, 26 Jan 2023 00:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674692521;
        bh=jgiR0d8hUFYk52IUlDU+5+WUlWzBEfGIiyIxt9qM28M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ULxhZQ8c8CFbkpJnZkQWozl7DcYVx5jaXu3rzUm9YEUVUUBF3LoSFC62/+TJOYZaR
         XqOGcbMw9b1nL+CccygWmx/zE9bKSUO+vNPz8Irpn2cZdIGClGOwo3gE90ADY2+Gol
         bLVO3uhuoeYOQb1698Ohp0oHoLXvcFQkBDfiZnyc=
Date:   Wed, 25 Jan 2023 16:21:59 -0800
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
Subject: Re: [PATCH v3 1/7] kernel/fork: convert vma assignment to a memcpy
Message-Id: <20230125162159.a66e5ef05fecb405e85ffec9@linux-foundation.org>
In-Reply-To: <20230125233554.153109-2-surenb@google.com>
References: <20230125233554.153109-1-surenb@google.com>
        <20230125233554.153109-2-surenb@google.com>
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

On Wed, 25 Jan 2023 15:35:48 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> Convert vma assignment in vm_area_dup() to a memcpy() to prevent compiler
> errors when we add a const modifier to vma->vm_flags.
> 
> ...
>
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -482,7 +482,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
>  		 * orig->shared.rb may be modified concurrently, but the clone
>  		 * will be reinitialized.
>  		 */
> -		*new = data_race(*orig);
> +		memcpy(new, orig, sizeof(*new));

The data_race() removal is unchangelogged?

>  		INIT_LIST_HEAD(&new->anon_vma_chain);
>  		dup_anon_vma_name(orig, new);
>  	}

