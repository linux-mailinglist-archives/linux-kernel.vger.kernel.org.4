Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E81621770
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbiKHOxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbiKHOxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:53:45 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F60CCE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 06:53:43 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id r81so11629243iod.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 06:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=md7pq5Y61523ftXLUcPOT58RE3lJ/xJd5Ph3p8iEops=;
        b=ZXZdWEAL1R1ZVFA2P8fuWqcX2rj1JRkf1sp5+gC2XB9VDMVOHlyvW06sVoWrr0JeLS
         tvUZupelkiZrBGHM4LVCUF9TJL0PrccBEvLQqTWDh37RAs+5ZOMQgNgQqZsVeWWTWl20
         pPi2oeRzwQuqwhUBo7egz7jaC5Dx7kiLJrTQYY5RUrSmxRyaebac4H7gxtQ5lFDXRHkr
         sDxMbEHOoBWiIPdLSayctyrYpXiHkqYZePXrc4vmmPCakZrhLAjrSdNFi/rT/bSfGjk/
         fEaa/X6uGH57UhEHgRxznmXcajiDWhf0/RsixaCP39jbo00AGUVbCIRsqQ9c6UeYwnW5
         V0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=md7pq5Y61523ftXLUcPOT58RE3lJ/xJd5Ph3p8iEops=;
        b=Dxu9n0QjnyXSPmUpCZY7edc+6cwjUs5PdkthLDlTRkrX8QQE7xRl8FcWfOYB+AeJrE
         f5MwhAtBWjDURyG176WwNj0YznufCeMt43B4EyNBghq+3L7vAPbpzTEjNNwE6dLqVWAw
         qCNtdQt/siifWss246vWM4QaRO+9U/NcD/ylF4+u5wUg4z2kHB4KPFSQAmQYXKjtwdwB
         ICttC6UOirpF9hhz1cBFj60xJl29Nh9Gh4cqM2C+I8uA78CGSuo3JjbQfHbs1yLORUHu
         ZMn+uSBSfkoheuaHfh6dXIkWdnEu62ANAuFmWlqPUru+2JNMxkvbg21RyfuesA5U51hi
         nh8g==
X-Gm-Message-State: ANoB5pkPK5F7QVz+E5oiqvHUKJ8dqtDuXanAV+5qYdhquzSRPWz7mvjh
        Sh8Xzf8ILmKfi5gtPM6xFapyMlKwEm5XR1CFb1wjPw==
X-Google-Smtp-Source: AA0mqf64FMOjlHNu2kF5bZaWRJmb+rAcbAEZwyePMAW3WnAc6couRpYkD7fasQW1Ra9c+tlJUfPYQqMoNMGd+ru8XS8=
X-Received: by 2002:a6b:b80a:0:b0:6dd:3f5a:32d6 with SMTP id
 i10-20020a6bb80a000000b006dd3f5a32d6mr2104168iof.154.1667919223019; Tue, 08
 Nov 2022 06:53:43 -0800 (PST)
MIME-Version: 1.0
References: <20221107201317.324457-1-jannh@google.com> <3e2f7e2cb4f6451a9ef5d0fb9e1f6080@AcuMS.aculab.com>
In-Reply-To: <3e2f7e2cb4f6451a9ef5d0fb9e1f6080@AcuMS.aculab.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 8 Nov 2022 15:53:07 +0100
Message-ID: <CAG48ez3AGh-R+deQMbNPt6PCQazOz8a96skW+qP3_HmUaANmmQ@mail.gmail.com>
Subject: Re: [PATCH] exit: Put an upper limit on how often we can oops
To:     David Laight <David.Laight@aculab.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Seth Jenkins <sethjenkins@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Tue, Nov 8, 2022 at 10:26 AM David Laight <David.Laight@aculab.com> wrote:
> > Many Linux systems are configured to not panic on oops; but allowing an
> > attacker to oops the system **really** often can make even bugs that look
> > completely unexploitable exploitable (like NULL dereferences and such) if
> > each crash elevates a refcount by one or a lock is taken in read mode, and
> > this causes a counter to eventually overflow.
> >
> > The most interesting counters for this are 32 bits wide (like open-coded
> > refcounts that don't use refcount_t). (The ldsem reader count on 32-bit
> > platforms is just 16 bits, but probably nobody cares about 32-bit platforms
> > that much nowadays.)
> >
> > So let's panic the system if the kernel is constantly oopsing.
>
> I think you are pretty much guaranteed to run out of memory
> (or at least KVA) before any 32bit counter wraps.

Not if you repeatedly take a reference and then oops without dropping
the reference, and the oops path cleans up all the resources that were
allocated for the crashing tasks. In that case, each oops increments
the reference count by 1 without causing memory allocation.

(Also, as a sidenote: To store 2^32 densely packed pointers, you just
need around 8 bytes * (2^32) = 32 GiB of RAM. So on a workstation or
server with a decent amount of RAM, there can already be cases where
you can overflow a 32-bit reference counter with legitimate references
- see <https://bugs.chromium.org/p/project-zero/issues/detail?id=809>.
Another example that needs more RAM is
<https://bugs.chromium.org/p/project-zero/issues/detail?id=1752>, that
needs ~140 GiB. Still probably within the realm of what a beefy server
might have nowadays? Kernel virtual address space is not a meaningful
limit on x86-64 - even with 4-level paging, the kernel has a 64 TiB
virtual memory area (the direct mapping) that is used for slab
allocations and such, see
<https://www.kernel.org/doc/html/latest/x86/x86_64/mm.html>. With
5-level paging it's even more, 32 PiB.)
