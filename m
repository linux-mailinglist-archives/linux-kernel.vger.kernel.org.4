Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDC3683A3D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 00:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjAaXMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 18:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjAaXMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:12:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838DE13D61
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 15:12:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2766661745
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268AFC433D2;
        Tue, 31 Jan 2023 23:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1675206731;
        bh=UD5aYgT6pPerwqmRX863s/i9h3g4RLRQIlQIVcQeK9k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ve2cEcLbfkgODWpke5wSo2CRG70LKa3nC9kSoeM1J6Qf6HyPThzORd9pAHW+/ObyJ
         vCHmRnUh+D8kgZIyNeYV8qZeoc3ilj+qhFfDGjLQUQZHVm2EV2x3+XEgXDtOKDRtmS
         RAr+qeOOsyKdPonLaBLNkJ9fISBaTBrXqLFvmr5M=
Date:   Tue, 31 Jan 2023 15:12:09 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v4 4/7] mm: replace vma->vm_flags direct modifications
 with modifier calls
Message-Id: <20230131151209.d53ba65c3c065979808d9912@linux-foundation.org>
In-Reply-To: <CAJuCfpHmtkzrKx45SQQ0gXLoybtgHxHmTP5J4L74ChTqSfFA-g@mail.gmail.com>
References: <20230126193752.297968-1-surenb@google.com>
        <20230126193752.297968-5-surenb@google.com>
        <Y9jSFFeHYZE1/yFg@hyeyoo>
        <CAJuCfpEzaVkgQt=C-33jAh1vLVJAjoyM8X5AD9CzyDUJnPDCkw@mail.gmail.com>
        <20230131125355.f07f42af56b23bfa28b2a58c@linux-foundation.org>
        <CAJuCfpHmtkzrKx45SQQ0gXLoybtgHxHmTP5J4L74ChTqSfFA-g@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023 13:08:19 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> On Tue, Jan 31, 2023 at 12:54 PM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > On Tue, 31 Jan 2023 10:54:22 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > > > > -             vma->vm_flags &= ~VM_MAYWRITE;
> > > > > +             vm_flags_clear(vma, VM_MAYSHARE);
> > > > >       }
> > > >
> > > > I think it should be:
> > > >         s/VM_MAYSHARE/VM_MAYWRITE/
> > >
> >
> > I added the fixup.  Much better than resending a seven patch series for a
> > single line change.  Unless you have substantial other changes pending.
> 
> Thanks! That sounds reasonable.
> 
> I'll also need to introduce vm_flags_reset_once() to use in
> replacement of WRITE_ONCE(vma->vm_flags, newflags) case. Should I send
> a separate short patch for that?

That depends on what the patch looks like.  How about you send it
and we'll see?
