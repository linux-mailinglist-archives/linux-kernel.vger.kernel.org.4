Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E9E70EA78
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 02:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238752AbjEXAxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 20:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjEXAxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 20:53:04 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A76E5
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 17:53:03 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ac65ab7432so10305ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 17:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684889582; x=1687481582;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R73rQupbGo8gxIgqNUbzX7tFkfS3FdlbSDCX+v9GPFU=;
        b=DSSILEKw2P3DdNCdeOp5B3aoyrmq0ppDsVUFp5fFDhGbt7ZxTpi0cCUJuiVGww+So5
         Vu6jPfkMFhdAoLq5xrc2DEVBGTvy/WT+LQQ5aUEmVfdthzYNZUL4/5lMUPHwZkZ2959Q
         AWN0hu4WIaCF6Lb/FI0NjFr6kjVnCDjGBOXdnCClavOxu0u06cRn8NmUvf4nCSrApzVI
         5ixgebMSLc6ewH9vw5dOVhRVUp2q1EVXFEur32rfm5RHyrQHXTh3tGMM96WaiLoExUX1
         +FXHnum3I4dnd5eKabCsTMxQOtqT1UVnzEt4kp6CRDoInHkbUCJ6S7DQ2GsMm+N1x/vu
         Vbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684889582; x=1687481582;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R73rQupbGo8gxIgqNUbzX7tFkfS3FdlbSDCX+v9GPFU=;
        b=j9JyN4BYbRr6xRe3UgrhUrLpuGUpWi1Ps2ycaqLET/geYxrhpZrYk3d7/c0yEjADON
         XZtN2+1RkdtuFHxj8m6t1JaaUKKzMp+MQQ3IQMJ9WiKKB5WvsNtxo4A79d0HeYFy3VD7
         IVehZgIbDroSGUgnPv0jmImq2Owqs8r5SAq5J7lFzVbROIC/vMT2lC9eZ9fVUrqpxgce
         uh1aQycYIy/XUeDn2PYxR8Mctj8mj6JfO6EiVyImPUPNBTpJiJob2wleu3VNK8aowN7X
         tCHG/hbxxF+g6qdkXHUgIC0t1JpLw4K7hnHRIa52puramOyqVZLjXTY6/fFH08aMiAgD
         rnYw==
X-Gm-Message-State: AC+VfDyGAhTgKwnyuWzIrWEBeTmoqvOzt7ZpAh4gXwMgcoa/Qlqq4S0B
        XJeOW5aZepRrk4HwXiC5Y4fepg==
X-Google-Smtp-Source: ACHHUZ6I8qmYZZpMAWacH6DVYzOZb4ptlZVkc9+WNlpK45yZCweyu1ykaPvSNL11GDYOfC6N/jYtbQ==
X-Received: by 2002:a17:902:d4c2:b0:1aa:ea22:8043 with SMTP id o2-20020a170902d4c200b001aaea228043mr42900plg.7.1684889582328;
        Tue, 23 May 2023 17:53:02 -0700 (PDT)
Received: from [2620:0:1008:11:c789:c1fb:6667:1766] ([2620:0:1008:11:c789:c1fb:6667:1766])
        by smtp.gmail.com with ESMTPSA id 19-20020aa79213000000b00639eae8816asm6282579pfo.130.2023.05.23.17.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 17:53:01 -0700 (PDT)
Date:   Tue, 23 May 2023 17:53:00 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Alex Shi <alexs@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Duyck <alexanderduyck@fb.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, debug: allow suppressing panic on CONFIG_DEBUG_VM
 checks
In-Reply-To: <CAHk-=wi6L6yZnGCYVEmLgQY+KEHNsAW2V69mfdUCMk4qS=GnKA@mail.gmail.com>
Message-ID: <494440e9-b73f-2445-5b1f-0e4d2ab5f487@google.com>
References: <c9abf109-80f2-88f5-4aae-d6fd4a30bcd3@google.com> <b4dce681-e53c-a6fd-2dab-62a82ebc6dff@redhat.com> <53dd9df8-e88f-f466-89f9-3fa141a10267@google.com> <CAHk-=wg+PHQ9PhTeQOb7Fh5Qf3zkzG5J1h3D=eOY-2AsYXhU4Q@mail.gmail.com> <b2bf7ae9-983d-6c20-0781-7f37a4454bfd@google.com>
 <CAHk-=wi6L6yZnGCYVEmLgQY+KEHNsAW2V69mfdUCMk4qS=GnKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2003089352-194657390-1684889581=:163077"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--2003089352-194657390-1684889581=:163077
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 22 May 2023, Linus Torvalds wrote:

> On Mon, May 22, 2023 at 5:52 PM David Rientjes <rientjes@google.com> wrote:
> >
> > Right now kernel.panic_on_warn can either be 0 or 1.  We can keep the
> > lowest bit to be "panic on all warnings" and then bit-1 as "panic on debug
> > VM warnings."  When CONFIG_DEBUG_VM is enabled, set the new bit by
> > default so there's no behavior change.
> 
> So right now CONFIG_DEBUG_VM being off means that there's nothing at
> all - not just no output, but also no code generation.
> 
> I don't think CONFIG_DEBUG_VM in itself should enable that bit-1 behavior.
> 
> That may be what *you* as a VM person wants, but VM people are not
> exactly the common case.
> 
> So I think we've got several cases:
> 
>  (a) the "don't even build it" case (CONFIG_DEBUG_VM being off)
> 
>  (b) the "build it, and it is a WARN_ON_ONCE()" case
> 
>  (c) the *normal* "panic_on_warn=1" case, which by default would panic
> on all warnings, including any warnings from CONFIG_DEBUG_VM
> 
>  (d) the "VM person" case, which might not panic on normal warnings,
> but would panic on the VM warnings.
> 
> and I think the use-cases are for different classes of kernel use:
> 
>  (a) is for people who disable debugging code until they feel it is
> needed (which I think covers a lot of kernel developers - I certainly
> personally tend to not build with debug support unless I'm chasing
> some issue down)
> 
>  (b) would probably be most distros - enable the warning so that the
> distro can report it, but try not to kill the machine of random people
> 
>  (c) would be most cloud use cases, presumably together with reboot-on-panic
> 
>  (d) would be people who are actual VM developers, and basically want
> the *current* behavior of VM_BUG_ON() with a machine that stops
> 
> and I think (d) is the smallest set of cases of all, but is the one
> you're personally interested in.
> 

If we want to change the behavior from today toward something that we 
think is the more common case for enabling CONFIG_DEBUG_VM, that works 
too.  If we fully remove VM_BUG_ON() in favor of VM_WARN_ON() + 
kernel.panic_on_warn=1, then anybody relying on getting kernel panics when 
they qualify new kernels with CONFIG_DEBUG_VM will start getting WARNINGs 
but not panics unless they are already using kernel.panic_on_warn.

I think that's fine, but is a change in behavior.  My use cases work both 
ways.  If we don't set the bit-1 behavior by default on CONFIG_DEBUG_VM 
then I just won't need to clear it.

I'm personally interested in (d) for debugging issues, but the intent of 
this patch was actually to allow for (b) too.  I want to deploy 
CONFIG_DEBUG_VM with WARN_ON_ONCE() behavior to a small set of production 
machines to catch latent kernel issues we don't know about, but without 
impacting the workloads.

That's also very valuable because I want to surface CONFIG_DEBUG_VM checks 
that would never get hit because we panic before it can be, just because 
of some other VM_BUG_ON().  Your idea of WARN_ON_ONCE() will be great for 
that because we can make forward progress and not be too spammy to the 
kernel log.

There seems to be some agreement in the thread for removing VM_BUG_ON() 
and friends in favor of VM_WARN_ON(), so I'll wait a couple days for 
anymore feedback and then send a patch along.

This seems like it will be very clean and allow for (b), which is great.
--2003089352-194657390-1684889581=:163077--
