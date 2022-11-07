Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A776202A1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbiKGWxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiKGWxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:53:50 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5411DC756
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 14:53:49 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id e15so9164882qvo.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 14:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=21wiiHvcIBdhKiIS3r6/qtlDM55REGd/yjftKkenVRo=;
        b=nBj4Wfd3rL0glEyZ6O0dtIl1fd7ruGU3X/JrJwPB2CTsL1/ifRNFMsAZCT3JBuKEwm
         ygGxuBTUM/uV95zlp27Tddvthc8TOg1rRO0F0kKHDENkIUjWfwJbNuaYDb4T60cW8uQN
         Ybl1aPt7syI29QlsX7TBzoNfTy2euvDWrTjMCZ3GZlpLQdr2wpe8bvjYBKR+FnxTpgoE
         p622dtUO+6Gl8+wnK5Nr96VibHFtJCe8DJS2dW9AWL9KQ5irDxd/dlcUJoxCDNDQjvJk
         LJXqJom5FtFdzcIoqE9XiskjlkIgSSckBvvCyGwWaJOISZDVyciC8oK7SUPhF1nVPO3N
         0m7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21wiiHvcIBdhKiIS3r6/qtlDM55REGd/yjftKkenVRo=;
        b=UqbxJLa/jKX0IAYCajcv3+e/0dW2CSUH7npiu348/dMBxTGvGbfkHvWNomk3wkOIA8
         RSa4lXhhVb45i15Cj+SxgZdtZfi0S12mHh2R19LukvxcK152rIej53kbmGQJhfnezQNS
         0QcxK++B1OkoRCKwNtmJkJ/7jN25kd1RgLG9Y/D5sTwiNnUbeZ4zGtg3Y8odUxP9tuXG
         HriO6b8nzvr3XkDTakHx844yHvhxuk5P8/MVCtVMlVLmCYa6v40Adzsumw/Ne+pBg34P
         e7FHie21zYVIc/Mv3qgNk6hDl3FvH/nUknJeG/P8Glq9pQ0Yif5OQmq9X0gqo/7rT2Dj
         Ol7Q==
X-Gm-Message-State: ACrzQf310vje1ClnRqbLOuPaAOZ11UnXJaKVo0BDWmKgDpqGZiDXpHYy
        Gc3qbrugtzov9b64HpoJCxs/vIhXDgZEkXBfZKgFxw==
X-Google-Smtp-Source: AMsMyM6CzUj86XtAHxzGeXkV8lvKWK370HlG4ueNSlVh4hdkTs7X0dc1hiXZyblGIMI0QFGnxTpdAtY18OBujNBiSQo=
X-Received: by 2002:a05:6214:2528:b0:4b8:2025:5f6e with SMTP id
 gg8-20020a056214252800b004b820255f6emr46887686qvb.88.1667861628171; Mon, 07
 Nov 2022 14:53:48 -0800 (PST)
MIME-Version: 1.0
References: <20221028141220.29217-3-kirill.shutemov@linux.intel.com>
 <b5d04a6c-79b4-bbdc-b613-6958d9f75d53@linux.alibaba.com> <4bfcd256-b926-9b1c-601c-efcff0d16605@intel.com>
 <CAAYXXYy6xPPD0bLz9RrVO6FDWA9d8hiz4Po0hcEe0oupGq=L2g@mail.gmail.com> <ac179589-bd60-a47c-2d3b-78992b6cbea2@intel.com>
In-Reply-To: <ac179589-bd60-a47c-2d3b-78992b6cbea2@intel.com>
From:   Erdem Aktas <erdemaktas@google.com>
Date:   Mon, 7 Nov 2022 14:53:37 -0800
Message-ID: <CAAYXXYw1YpZx1AaOu0TgR9yR9Foi6_jh8XkbGU4ZM2TFTM=nSA@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/tdx: Do not allow #VE due to EPT violation on the
 private memory
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Nakajima, Jun" <jun.nakajima@intel.com>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        kirill.shutemov@linux.intel.com, ak@linux.intel.com, bp@alien8.de,
        dan.j.williams@intel.com, david@redhat.com,
        elena.reshetova@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com,
        x86@kernel.org
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

On Fri, Nov 4, 2022 at 3:50 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 11/4/22 15:36, Erdem Aktas wrote:
> > On Fri, Oct 28, 2022 at 7:12 AM Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> >> +        *
> >> +        * Kernel has no legitimate use-cases for #VE on private memory. It is
> >> +        * either a guest kernel bug (like access of unaccepted memory) or
> >> +        * malicious/buggy VMM that removes guest page that is still in use.
> >> +        *
> >
> > I think this statement is too strong and I have few concerns on this approach.
> > I understand that there is an issue of handling #VEs on private pages
> > but it seems like we are just hiding the problem with this approach
> > instead of fixing it - I do not have any fix in my mind- .
> > First there is a feature of injecting #VE to handle unaccepted pages
> > at runtime and accept them on-demand, now the statement is saying this
> > was an unnecessary feature (why is it there at all then?) at all as
> > there is no legitimate use case.
>
> We're doing on-demand page acceptance.  We just don't need a #VE to
> drive it.  Why is it in the TDX module then?  Inertia?  Because it got
> too far along in the process before anyone asked me or some of the other
> x86 kernel folks to look at it hard.
>
> > I wonder if this will limit how we can implement the lazy TDACCEPT.
> > There are multiple ideas floating now.
> > https://github.com/intel/tdx/commit/9b3ef9655b695d3c67a557ec016487fded8b0e2b
> > has 3 implementation choices where "Accept a block of memory on the
> > first use." option is implemented.  Actually it says "Accept a block
> > of memory on the first use." but it is implemented as "Accept a block
> > of memory on the first allocation".  The comments in this code also
> > raises concerns on the performance.
> >
> > As of now, we do not know which one of those ideas will provide an
> > acceptable performance for booting large size VMs. If the performance
> > overhead is high, we can always implement the lazy TDACCEPT as when
> > the first time a guest accesses an unaccepted memory, #VE can do the TDACCEPT.
>
> Could you please elaborate a bit on what you think the distinction is
> between:
>
>         * Accept on first use
> and
>         * Accept on allocation
>
> Surely, for the vast majority of memory, it's allocated and then used
> pretty quickly.  As in, most allocations are __GFP_ZERO so they're
> allocated and "used" before they even leave the allocator.  So, in
> practice, they're *VERY* close to equivalent.
>
> Where do you see them diverging?  Why does it matter?
>

For a VM with a very large memory size, let's say close to 800G of
memory, it might take a really long time to finish the initialization.
If all allocations are __GFP_ZERO, then I agree it would not matter
but -- I need to run some benchmarks to validate --  what I remember
was, that was not what we were observing. Let me run a few tests to
provide more input on this but meanwhile if you have already run some
benchmarks, that would be great.

What I see in the code is that the "accept_page" function will zero
all the unaccepted pages even if the __GFP_ZERO flag is not set and if
__GFP_ZERO is set, we will again zero all those pages. I see a lot of
concerning comments like "Page acceptance can be very slow.".

What I mean with "Accept on allocation" is leaving the memory
allocation as it is and using the #VE handler to accept pages the
first time they have been accessed.

tLet me come back with some numbers on this which might take some time
to collect.

> > I am not trying to solve the lazy TDACCEPT problem here but all I am
> > trying to say is that, there might be legitimate use cases for #VE on
> > private memory and this patch limits any future improvement we might
> > need to do on lazy TDACCEPT implementation.
>
> The kernel can't take exceptions on arbitrary memory accesses.  I have
> *ZERO* idea how to handle page acceptance on an access to a per-cpu
> variable referenced in syscall entry, or the NMI stack when we've
> interrupted kernel code with a user GSBASE value.
>
> So, we either find *ALL* the kernel memory that needs to be pre-accepted
> at allocation time (like kernel stacks) or we just say that all
> allocated memory needs to be accepted before we let it be allocated.
>
> One of those is really easy.  The other means a boatload of code audits.
>  I know.  I had to do that kind of exercise to get KPTI to work.  I
> don't want to do it again.  It was worth it for KPTI when the world was
> on fire.  TDX isn't that important IMNHO.  There's an easier way.
