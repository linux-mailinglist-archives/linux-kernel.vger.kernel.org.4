Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7C360CEC6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbiJYOTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbiJYOS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:18:58 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AE313CF9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:18:57 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id q75so638871iod.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tYduAKOaNAny9MQJ4fO8rjwMRKFCq+OYJTarNsbUmcc=;
        b=b9nMU8xuokJYf96EjprqccecIqVi4LtY3NFELQACDNkjVNyYV5P7dus7/1w2YDJwgK
         ffsiW3uQSUh69VSxmzuUBqiEKAqZ922NLo4YDQsIN5UVsgRKFvNffrkjhK1Y0lYXP84H
         jg9uBRwVgmb6fpFxQV7l1maCPUEy+bliJmEeRE7BJgrXGF9+sJwNsL8BKrafOFyXptA2
         65j6ZKttleyPBv02B1gf7tuDyQQcBJsBqNWzQTr/WU2tEv2wHNTODsMQaujRGUhbb6DD
         X6spe92iE48FoTkqnAvohe4EBX7WyUeIl9CiG/5wmbV22hNWSJEK3Ddx7Bxhf5YiWGTC
         QRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tYduAKOaNAny9MQJ4fO8rjwMRKFCq+OYJTarNsbUmcc=;
        b=gEahyl9TT9e+Ft5QQ6/wBIlkxwIYNJbJzsU5CIgE4NszkmGp244sz2ugMUt3i6N//U
         70Onb4oqPG8PV+9A6hzxOhVKqnWQGa/EMXdJkrITEUz8aZbz6I+QYoCTPHXPsPkp4fzz
         djxyzO8rGhK5zfhMKXAMhdD+ZuaPR0pJTLH/7ssmq/FQiIek+258D1RsQmMqYtCuiThs
         wxZY1jwWrzayDgn6QH6I0VCEck6/cj7ntj4NCpFLIb2upfu0CJXxKQ16MdIbIHngSR4R
         G3fIW4PFv1mq6V549s24GMHXQzyqSX5KCAY3Kyurcr2jjLQ3baJuasL78SB/973+KC7S
         ke8Q==
X-Gm-Message-State: ACrzQf002Dhc2cilQpka/V4fwl3UE4MrV4TDU/rjT1GSDHfBRVsK1tbS
        SegEf7WybzsO/0bOx2oTA2DA1kQsQxAnFsfzgWjouw==
X-Google-Smtp-Source: AMsMyM7kgc8WOeDtEkSpzZEDfe3c6j9gRL+T2Jhn7Z9EiLOLURzVvAcjowE4b4X9Dv6gjSpOsHeaOGc+YH0eodTP438=
X-Received: by 2002:a6b:690b:0:b0:6bc:4d2a:e60a with SMTP id
 e11-20020a6b690b000000b006bc4d2ae60amr22450717ioc.56.1666707536652; Tue, 25
 Oct 2022 07:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20221022111403.531902164@infradead.org> <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com> <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com> <Y1fsYwshJ93FT21r@hirez.programming.kicks-ass.net>
In-Reply-To: <Y1fsYwshJ93FT21r@hirez.programming.kicks-ass.net>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 25 Oct 2022 16:18:20 +0200
Message-ID: <CAG48ez3VE+3dVdUMK+Pg_942gR+h_TCcSaFxGwCbNfh3W+mfOA@mail.gmail.com>
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     John Hubbard <jhubbard@nvidia.com>, x86@kernel.org,
        willy@infradead.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 4:02 PM Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Oct 24, 2022 at 09:58:07PM +0200, Jann Horn wrote:
>
> > Unless I'm completely misunderstanding what's going on here, the whole
> > "remove_table" thing only happens when you "remove a table", meaning
> > you free an entire *pagetable*. Just zapping PTEs doesn't trigger that
> > logic.
>
> Aah; yes true. OTOH even it that were not so, I think it would still be
> broken because the current code relies on the TLB flush to have
> completed, whereas the RCU scheme is effectively async and can be
> considered pending until the callback runs.
>
> Hurmph... easiest fix is probably to dis-allow kvm_flush_tlb_multi()
> for i386-pae builds.
>
> Something like so... nobody in his right mind should care about i386-pae
> virt performance much.

I think Xen and HyperV have similar codepaths.
hyperv_flush_tlb_multi() looks like it uses remote flush hypercalls,
xen_flush_tlb_multi() too.

On top of that, I think that theoretically, Linux doesn't even ensure
that you have a TLB flush in between tearing down one PTE and
installing another PTE (see
https://lore.kernel.org/all/CAG48ez1Oz4tT-N2Y=Zs6jumu=zOp7SQRZ=V2c+b5bT9P4retJA@mail.gmail.com/),
but I haven't tested that, and if it is true, I'm also not entirely
sure if it's correct (in the sense that it only creates incoherent-TLB
states when userspace is doing something stupid like racing
MADV_DONTNEED and page faults on the same region).

I think the more clearly correct fix would be to get rid of the split
loads and use CMPXCHG16B instead (probably destroying the performance
of GUP-fast completely), but that's complicated because some of the
architectures that use the split loads path don't have cmpxchg_double
(or at least don't have it wired up).
