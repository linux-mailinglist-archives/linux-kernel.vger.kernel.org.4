Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733A267C16D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjAZAYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjAZAYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:24:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063C443926
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:24:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 568C6616EF
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B02CC433EF;
        Thu, 26 Jan 2023 00:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674692661;
        bh=N0v5l5ZR0YrLLuXkW8rcRAmrAzQT9ot2bUDRvREIlOA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yBfgnLWERC7RJfGt+Vcyq9ihgxPtUxN5ZDIv9T78iTGUTZ2aEZOryZgFk1X9EdABl
         lrQiE4BNvEpCbVdhotoGo5aDtCNiXOfu0mPz54AqvHfY+yWZf+Nd9ue7sLNvJjNzgQ
         WOOjjg1+ziaccQFgXs89KnsVW3vxyXi02Y4i5DoA=
Date:   Wed, 25 Jan 2023 16:24:19 -0800
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
Message-Id: <20230125162419.13379944d6c0d4253d7bc88c@linux-foundation.org>
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

> vm_flags are among VMA attributes which affect decisions like VMA merging
> and splitting. Therefore all vm_flags modifications are performed after
> taking exclusive mmap_lock to prevent vm_flags updates racing with such
> operations. Introduce modifier functions for vm_flags to be used whenever
> flags are updated. This way we can better check and control correct
> locking behavior during these updates.
> 
> ...
>
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> +static inline void init_vm_flags(struct vm_area_struct *vma,
> +static inline void reset_vm_flags(struct vm_area_struct *vma,
> +static inline void set_vm_flags(struct vm_area_struct *vma,
> +static inline void clear_vm_flags(struct vm_area_struct *vma,
> +static inline void mod_vm_flags(struct vm_area_struct *vma,

vm_flags_init(), vm_flags_reset(), etc?

This would be more idiomatic and I do think the most-significant-first
naming style is preferable.

