Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7300774BE9F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 19:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjGHRjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 13:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGHRjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 13:39:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4016FE4C
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 10:39:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B120560DBD
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 17:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4EAC433C8;
        Sat,  8 Jul 2023 17:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1688837978;
        bh=drHKeMgcNL4TWp9p/P+2PrXQ+fcbGYyaIQwGHCxCj5A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pG41tN/NOuUi9p2O3xHgsxiCZm9Ur7qT6LNK6J41PNluKBPAFAfzwjkUk+IBoOqJ0
         gYvAHLzr7CA3aWA+fO583UTJs0L4X9fZyeJsLRZhqu7fpJiCYldMckz2u+xwpVo7a4
         m8F2vLyJTKNBUlLaocc7+8PhsfdYv6ml1+FfFGnk=
Date:   Sat, 8 Jul 2023 10:39:36 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Suren Baghdasaryan <surenb@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jacob Young <jacobly.alt@gmail.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management <linux-mm@kvack.org>,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Fwd: Memory corruption in multithreaded user space program
 while calling fork
Message-Id: <20230708103936.4f6655cd0d8e8a0478509e25@linux-foundation.org>
In-Reply-To: <CAHk-=whKd05V49AbZGF=inYmhU6H_yNvvw1grWyhQfQ=9+5-VQ@mail.gmail.com>
References: <facbfec3-837a-51ed-85fa-31021c17d6ef@gmail.com>
        <5c7455db-4ed8-b54f-e2d5-d2811908123d@leemhuis.info>
        <CAJuCfpH7BOBYGEG=op09bZrh1x3WA8HMcGBXXRhe6M5RJaen5A@mail.gmail.com>
        <CAJuCfpH7t7gCV2FkctzG2eWTUVTFZD7CtD14-WuHqBqOYBo1jA@mail.gmail.com>
        <2023070359-evasive-regroup-f3b8@gregkh>
        <CAJuCfpF=XPpPYqp2Y1Vu-GUL=RBj4fyhXoXzjBY4EKtBnYE_eQ@mail.gmail.com>
        <2023070453-plod-swipe-cfbf@gregkh>
        <20230704091808.aa2ed3c11a5351d9bf217ac9@linux-foundation.org>
        <CAJuCfpE_WjRQoDT1XnvBghCH-kpqk+pfcBJGyDnK7DZLMVG5Mw@mail.gmail.com>
        <2023070509-undertow-pulverize-5adc@gregkh>
        <7668c45a-70b1-dc2f-d0f5-c0e76ec17145@leemhuis.info>
        <20230705084906.22eee41e6e72da588fce5a48@linux-foundation.org>
        <df1d7d39-56f3-699c-0d0f-fcc8774f182e@leemhuis.info>
        <CAHk-=whKd05V49AbZGF=inYmhU6H_yNvvw1grWyhQfQ=9+5-VQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2023 10:29:42 -0700 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, 8 Jul 2023 at 04:35, Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
> >
> > The plan since early this week is to mark CONFIG_PER_VMA_LOCK as broken;
> > latest patch that does this is this one afaics:
> 
> Bah.
> 
> Both marking it as broken and the pending fix seems excessive.
> 
> Why isn't the trivial fix just to say "yes, fork() gets the mmap_lock
> for writing for a reason, and that reason is that it acts kind of like
> mprotect()".
> 
> And then just do what those functions do.
> 
> IOW, why isn't the fix just to do
> 
>   --- a/kernel/fork.c
>   +++ b/kernel/fork.c
>   @@ -686,6 +686,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>         for_each_vma(old_vmi, mpnt) {
>                 struct file *file;
> 
>   +             vma_start_write(mpnt);
>                 if (mpnt->vm_flags & VM_DONTCOPY) {
>                         vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
>                         continue;
> 
> and be done with this? Yes, we could move it down a bit more, ignoring
> the VM_DONTCOPY vma's, but they are so uncommon as to not matter, so
> who cares?

That was the v1 fix, but after some discussion
(https://lkml.kernel.org/r/20230705063711.2670599-1-surenb@google.com)
it was decided to take the "excessive" approach.

Also, this change needs a couple more updates:
https://lkml.kernel.org/r/20230707043211.3682710-1-surenb@google.com
https://lkml.kernel.org/r/20230707043211.3682710-2-surenb@google.com

So I'm thinking it's best to disable the feature in 6.4.x and reenable
it for 6.5 once all this is sorted out.
