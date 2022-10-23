Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECB66095A7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 20:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiJWSmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 14:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiJWSmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 14:42:44 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5926D85A
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 11:42:43 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id z8so4620265qtv.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 11:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OWr4FkuGllC0yHNxO35w1tRNojSnR4sf5moumCqbAUE=;
        b=aIje3kzSOfYY8rCap1yFq+MGnLWGpVOk8XnEomBCNXZv6Q3wD04VwYx0ou/Ki5V1GP
         1DWrdXB0aDITDamIkeJzO9ikoi1IC3LVd+5qen345VyQiR+gCQTBChrkob9HaGBZ3SWi
         B5dXZc+PaDptKijlaxWCRq3AeFWRqSsNu3zeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OWr4FkuGllC0yHNxO35w1tRNojSnR4sf5moumCqbAUE=;
        b=mvEzrDJbgzcFLk4JhnHioEOYZUHvv+p1eBkfgHeR+vLu8dqWmi5cnlyLtFBOToh6bl
         IyIrUEW0ngRlA0hbGOH508DipL9J1BMC9kNykucWDqxllctRnQFXwEIG7BgcHh9GA5gs
         njS2rM1DAQ26VDFU1tcBxd572We7OJfeZG0efcWZcWEzl4aGWpPAXofrqXCK5UHdtL6u
         nE51bmdVoIjOoxzU0mJ/kAug/FDL4/mb9YGC/dR3FMtbxQufBu3S0v98TmQZEKSdcabD
         gDnAL6bPWzmQ/c7cfECKgz+pne6TCx7MsFprgq2QQuN4VkymLkwk945wEMNIabsR+dlR
         Z2pg==
X-Gm-Message-State: ACrzQf18r9PRUgSuolQEwN1DzgH9JPS64g274KzgqtrT6SkkfkZZu6pb
        BdYRl1xZ91nz/9ey7UzMcX+MQBkZKDy1Uw==
X-Google-Smtp-Source: AMsMyM6ydhxNfBP3aultq7tFLExYp+bx7NROL1Wv4aU/eiMZjhgxtlU4EhmMxXMb/HpsRer8vEFLcg==
X-Received: by 2002:a05:622a:13c6:b0:39c:c34f:29ec with SMTP id p6-20020a05622a13c600b0039cc34f29ecmr24895461qtk.153.1666550562500;
        Sun, 23 Oct 2022 11:42:42 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id h5-20020a05620a284500b006f16148fa96sm3294574qkp.91.2022.10.23.11.42.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 11:42:41 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id j130so8884287ybj.9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 11:42:41 -0700 (PDT)
X-Received: by 2002:a25:84cf:0:b0:6b3:c0c3:19d8 with SMTP id
 x15-20020a2584cf000000b006b3c0c319d8mr24197779ybm.349.1666550561252; Sun, 23
 Oct 2022 11:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <Y1ULKYsASLRoVb7N@zn.tnic> <Y1UPYnju4qOTsusI@zn.tnic>
 <CAHk-=wj0afQB2odHZcfmtymR0q9wJEO8gGQo_Cob+KHgsimG5w@mail.gmail.com> <Y1WEaE7S3M/nptM2@zn.tnic>
In-Reply-To: <Y1WEaE7S3M/nptM2@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 23 Oct 2022 11:42:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=whi1xkXFRu79fOvwu17qaw7J9HkzW1DUV7jTawJZtc6VQ@mail.gmail.com>
Message-ID: <CAHk-=whi1xkXFRu79fOvwu17qaw7J9HkzW1DUV7jTawJZtc6VQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/urgent for 6.1
To:     Borislav Petkov <bp@suse.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
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

On Sun, Oct 23, 2022 at 11:14 AM Borislav Petkov <bp@suse.de> wrote:
>
> I was gonna say, let's have a fixed tag name so that there are no
> multiple tags with the same name, per chance, which would confuse.

Several trees do that already, and jst call the tags "for-linus" or similar.

> But it seems that when you pull a tag, it remains a remote tag and
> doesn't appear in your tree.

I obviously don't want to distribute these temporary tags as tags, no.
That's a git default behavior thing, because it would be very annoying
to get hundreds of irrelevant tags that get distributed with the
kernel.

But the tag name does show up in the commit message itself, so it now
does show up in the logs:

    Merge tag 'x86_urgent_for_v6.0_rc2' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip

    Pull x86 fixes from Borislav Petkov:
     "As usually the case, right after a major release, the tip urgent
      branches accumulate a couple more fixes than normal. And here is the
      x86, a bit bigger, urgent pile.
    ...

and you can see it even more if you do

    git show --show-signature 295dad10bfb5

(or "git cat-file commit 295dad10bfb5) which will show some details
that are normally suppressed by a plain "git log".

And that's the part I mean when I said "Nobody will look at the tag
name afterwards". Yes, there are signs of that incorrect tag name in
there, but it's not like I suspect anybody would have ever even
noticed hadn't you brought it up.

                 Linus
