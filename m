Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D1165C767
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239093AbjACTXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbjACTXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:23:01 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824A117069
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:19:56 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id g65so12341426vkh.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 11:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ia/lu5+B5CRXWa8CF3j1BLcFKSU3j2P6kHuicKKTwhM=;
        b=ZqWN8gFUfoVI5wnLUXnodqgP701dqeLd5CSt/RsefZ5Qkl5jGfXYOorD034HuIvB5D
         Ht8gtKf8KI4dn/azdfqIH5esBFN2+qILBHpfWUbepKnmZuifWK677ycRTg3al4Q+XtGT
         msE8MlX8P1FMZr6Yemo2KVXiq2CyfjHgRvf5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ia/lu5+B5CRXWa8CF3j1BLcFKSU3j2P6kHuicKKTwhM=;
        b=vGo4+fyAZJYHaa5BRPbucE3mvTPd2YLGGKTK9e8yI5Y6s8jFVQi1eee4xa2tfMfeD9
         UYm1M3JSd2PvvSVHn3C81ywlg81yXmqtfL6iPD/jrS9cA/X7iI4SWH/ZSdy+3CIklYvl
         M2L5S0uqiprPfZFouS1vBIr2cppYKo5ZcuvM6YcUcKOo3YGdBdjJ0hTn+2Sx+ncxDBH4
         xLXUWG3P8JF4K12sNUeRYgy/cornZgWIDiY8xzex4DP0fIB5Z2RzPeG2VJruy3mptAQe
         UXi6PdQfUIhCYG27HG6ZV5uGXQVPb25Q4ZX8vRCFaZ/TmhVDmQ9ZrlStsBz85bNY9uvG
         A8lQ==
X-Gm-Message-State: AFqh2koAnXjJ6cn1q7pYZ/BWi3EeG8oMJMFtwWuAdNTddghQ3ZcxWT4a
        yZHTg3LOmYMfAuy/S83+Ay0voB8Jx23eDTO8
X-Google-Smtp-Source: AMrXdXsHCijOxUw4xpdRQtIEAsDWJ3ZV/hHkACNuu2MPvTI1zw50uNEeZ/IOxxQK3xWKblDTge7uFQ==
X-Received: by 2002:a1f:3d14:0:b0:3d5:7be8:67ff with SMTP id k20-20020a1f3d14000000b003d57be867ffmr12515304vka.11.1672773595162;
        Tue, 03 Jan 2023 11:19:55 -0800 (PST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id q22-20020a05620a0d9600b006eee3a09ff3sm14059787qkl.69.2023.01.03.11.19.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 11:19:53 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id j16so25333732qtv.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 11:19:53 -0800 (PST)
X-Received: by 2002:ac8:67da:0:b0:3a5:122:fb79 with SMTP id
 r26-20020ac867da000000b003a50122fb79mr1194253qtp.452.1672773592726; Tue, 03
 Jan 2023 11:19:52 -0800 (PST)
MIME-Version: 1.0
References: <20230101162910.710293-1-Jason@zx2c4.com> <20230101162910.710293-3-Jason@zx2c4.com>
 <Y7QIg/hAIk7eZE42@gmail.com> <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
In-Reply-To: <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Jan 2023 11:19:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com>
Message-ID: <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com>
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 3, 2023 at 10:36 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> I have a rather different suggestion: make a special mapping.  Jason,
> you're trying to shoehorn all kinds of bizarre behavior into the core
> mm, and none of that seems to me to belong to the core mm.  Instead,
> have an actual special mapping with callbacks that does the right
> thing.  No fancy VM flags.

I don't disagree, but honestly, my deeper reaction is "this is not worth it".

I think the real issue here is that Jason has to prove that this is
such a big deal that the VM has to be modified *at*all* for this.

Honestly, "getrandom()" performance simply is not important enough to
design VM changes for.

Do some people care? Debatable. Jason cares, sure. But people have
gotten used to doing their own random number implementations if they
*really* care, and yes, they've gotten them wrong, or they've not
performed as well as they could, but on the whole this is still a
really tiny thing, and Jason is trying to micro-optimize something
that THE KERNEL SHOULD NOT CARE ABOUT.

This should all be in libc. Not in the kernel with special magic vdso
support and special buffer allocations. The kernel should give good
enough support that libc can do a good job, but the kernel should
simply *not* take the approach of "libc will get this wrong, so let's
just do all the work for it".

Let user space do their own percpu areas if they really care. And most
(as in 99.9%) of all user space won't care at all, and is perfectly
happy just doing a read() from /dev/urandom or using our existing
"getrandom()" without any super-clever vdso support with magic
temporary buffer handling.

Now, if the magic buffers were something cool that were a generic
concept that a lot of *other* cases would also kill for, that's one
thing. But this is such a small special case that absolutely *nobody*
has asked for, and that nothing else wants.

             Linus
