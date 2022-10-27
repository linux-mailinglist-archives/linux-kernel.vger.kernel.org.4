Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033F061028D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 22:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbiJ0UTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 16:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236919AbiJ0USz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 16:18:55 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911428BBBA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:18:54 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id q9so8006077ejd.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hTysIpFYJUBcMNr4EXsnhkk3sI9WXgWzp1PfMF4nyjI=;
        b=gXA3qq29nbOOdmaipimOP8hH3HbXGON2sEJhSqFqHOP2UR3GYqBX0PT0iPyjO/vQFb
         VKzPYAa339CnKE/c3mVCI8ZOQBz+roooGBnWcL8Vcl+cdm6xu63GJEIzefCaJnWQ7/hO
         zEVu/lUM8dWeLcFATuPzZJD39xQD94u7DKENUy7MWKUooNuavM2O+WkOlLNKSF4p9Ew2
         c2vyByEoxPhPfVogBFaQ3Gz+dBNXVmCWrdA3KA/On71JksD89UiPFjUurunCCdKM0W34
         DXS5soPr/XR6KFTQMj9ZVxH7Gh9fVsfQmLUZlvNjoXoSTvpVRl0uRRQHF7XKsT2jD6Ja
         dTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hTysIpFYJUBcMNr4EXsnhkk3sI9WXgWzp1PfMF4nyjI=;
        b=wi6+HyxgHfIFVlfO2ed1oURf/bXJt7f/IuTD5uZWa1juX4eRm5U434sqY91M+ogBiO
         OggK4c5wrbV0csjDs3BSjdh8QVnc6o12AD12bN4vTQbr2Vr1q3mDzIU4oSxSFd1o94WE
         BhTbJ0wSEzm4MwtKaKvZX0dVBsIVsH+/qg2IOnZKBxl3nPfFX8B4/Tiueq0Cs+0TQHH4
         PAwa8BG4HpZUmUzpxw2cisis5Rfz7uEjxiOCs2Q3k5WvFF8JaV6ZipKgOU3uJFbEitAG
         SqmbsJAxYhC+xXP+I9+WEsPcZl4SYv11lXlzNXbJRqXUYFvzSBHIGNOw0oNBqetpx6nO
         7xiA==
X-Gm-Message-State: ACrzQf3KCjnqjZ5Nso8c5v9g5OiZ+9BRjn3XtpsPPtlMI6dvxSXIYJJo
        mDY5NqOScj1MNF3wOm4zyZ4StM2tijaK3RmUs2D6yGREM2qchA==
X-Google-Smtp-Source: AMsMyM4LuHYwu1QXak/PczA7sZ7KKhhZa+59ickhkj3ZFoyjGOI3bvjOa7qThDjnVu4ebZBi3e8SqMMhRiByT32DZfw=
X-Received: by 2002:a17:907:6d84:b0:78d:f2b0:14c8 with SMTP id
 sb4-20020a1709076d8400b0078df2b014c8mr42793569ejc.749.1666901933009; Thu, 27
 Oct 2022 13:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220930170058.2645213-1-tzukui@google.com> <5be617ad-0652-642f-aff8-7b7734f33973@redhat.com>
In-Reply-To: <5be617ad-0652-642f-aff8-7b7734f33973@redhat.com>
From:   Ryan Huang <tzukui@google.com>
Date:   Thu, 27 Oct 2022 13:18:41 -0700
Message-ID: <CA+Jga0JauDYSwwL0dTTVkUyXrWQo=H2LAPwgF7yprNKJvZY5rA@mail.gmail.com>
Subject: Re: [PATCH] lockdep: Allow tuning tracing keys constant.
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org
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

Sorry for the late reply.

Our use case is we will create workqueue for each ptr in one device abc
(Rename to abc here without leaking any information)

  ptr->wq = alloc_workqueue("abc_x_%d_y_%d_ptr_%d", WQ_HIGHPRI, 1, x, y, ptr);

where x is 0~7, y is 0~127, ptr is 0~4, and we have a maximum of 8 devices.
So there is a maximum 8x128x5x8=40960 workqueue.
I found the lockdep key is filled with

  register_lock_class: nr_lock_classes=2498, name=_rs.lock
  register_lock_class: nr_lock_classes=2499, name=semaphore->lock
  register_lock_class: nr_lock_classes=2500,
name=(wq_completion)abc_x_0_y_0_ptr_1
  register_lock_class: nr_lock_classes=2501,
name=(work_completion)(&wp->write_work)
  register_lock_class: nr_lock_classes=2502,
name=(wq_completion)abc_x_0_y_0_ptr_2
  register_lock_class: nr_lock_classes=2503,
name=(wq_completion)abc_x_0_y_0_ptr_3
  ...
  register_lock_class: nr_lock_classes=8189,
name=(wq_completion)abc_x_0_y_110_ptr_2
  register_lock_class: nr_lock_classes=8190,
name=(wq_completion)abc_x_0_y_110_ptr_3
  register_lock_class: nr_lock_classes=8191,
name=(wq_completion)abc_x_0_y_110_ptr_4
  register_lock_class: nr_lock_classes=8192,
name=(wq_completion)abc_x_0_y_110_ptr_5

It seems when we queue_work on one workqueue, it will occupy one lock
class. That's why 8k is not enough for our use case.

Regarding my patch, I just move the hard code value into config.
Increasing the value just increase one byte for the held_lock structure,
and 48 bytes for task_struct structure (around 6 u64 variables) in DEBUG
mode.

Let me know if you have a better way!

Thanks
Ryan


On Fri, Sep 30, 2022 at 10:34 AM Waiman Long <longman@redhat.com> wrote:
>
>
> On 9/30/22 13:00, Ryan Huang wrote:
> > Tetsuo Handa made a change for tuning lockdep tracing capacity constants
> > [1]. He created following tracing config constants:
> >    - LOCKDEP_BITS
> >    - LOCKDEP_CHAINS_BITS
> >    - LOCKDEP_STACK_TRACE_BITS
> > However there is a missing one for LOCKDEP_KEYS_BITS. We can see this is
> > also hitting the upper limits in [2].
> >
> > [1] https://github.com/torvalds/linux/commit/5dc33592e95534dc8455ce3e9baaaf3dae0fff82
> > [2] https://syzkaller.appspot.com/bug?id=df466e1151a7e45dd880d8c7033f1ad48acebfb4
> >
> > Fixes: 5dc33592e955 ("lockdep: Allow tuning tracing capacity constants.")
> > Signed-off-by: Ryan Huang <tzukui@google.com>
> > ---
> >   include/linux/lockdep.h | 2 +-
> >   lib/Kconfig.debug       | 8 ++++++++
> >   2 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> > index 1f1099dac3f05..3bb1740296559 100644
> > --- a/include/linux/lockdep.h
> > +++ b/include/linux/lockdep.h
> > @@ -82,7 +82,7 @@ struct lock_chain {
> >       u64                             chain_key;
> >   };
> >
> > -#define MAX_LOCKDEP_KEYS_BITS                13
> > +#define MAX_LOCKDEP_KEYS_BITS                CONFIG_LOCKDEP_KEYS_BITS
> >   #define MAX_LOCKDEP_KEYS            (1UL << MAX_LOCKDEP_KEYS_BITS)
> >   #define INITIAL_CHAIN_KEY           -1
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index d3e5f36bb01e0..d15024bd14f1d 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1398,6 +1398,14 @@ config LOCKDEP_CHAINS_BITS
> >       help
> >         Try increasing this value if you hit "BUG: MAX_LOCKDEP_CHAINS too low!" message.
> >
> > +config LOCKDEP_KEYS_BITS
> > +     int "Bitsize for MAX_LOCKDEP_KEYS"
> > +     depends on LOCKDEP && !LOCKDEP_SMALL
> > +     range 10 30
> > +     default 13
> > +     help
> > +       Try increasing this value if you hit "BUG: MAX_LOCKDEP_KEYS too low!" message.
> > +
> >   config LOCKDEP_STACK_TRACE_BITS
> >       int "Bitsize for MAX_STACK_TRACE_ENTRIES"
> >       depends on LOCKDEP && !LOCKDEP_SMALL
>
> The lockdep key is embedded in a bit field within the held_lock
> structure to utilize all the 32 bits of an integer. Changing its size
> will require adjusting other bit fields or expand the bit field size
> from 32 bits to 64 bits. 13 bits allows up to 8k unique lock classes.
> Unless there is good evidence that we are going to run out of that, we
> shouldn't change it.
>
> Thanks,
> Longman
>
