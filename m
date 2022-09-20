Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26ED5BE982
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiITPB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiITPBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:01:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BD02F67C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:01:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5BAEB81F47
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 15:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC41C433D6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 15:01:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fZCFCgOO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663686107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O1KVv36rT+AM0D+ZUZs83LI00Db5G4J3BZXf8gO0vBo=;
        b=fZCFCgOOpRb5gllnskbCMZQpA1x1dzj6SFIptobT8lSImJpKhL1UniYkLxO9TqjfIN+EyP
        SFTmAQLD1WC2gA30Fs3r+bZh376/PESPzT+35b/L8mBoJxka1IM1JPbLDbVYRC+DF9as5b
        39saCymHJjxyh6lLVtAEo9/3ID+5hyM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d5847fa0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 20 Sep 2022 15:01:46 +0000 (UTC)
Received: by mail-vk1-f175.google.com with SMTP id g27so1556651vkl.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:01:46 -0700 (PDT)
X-Gm-Message-State: ACrzQf2hq1J8z9nPOY3krQ+K159xyQKF8CcINO8daY8fvXGe2SI04rYF
        /DFOqr6f/WN2dOAOjQ6jy8x7iSQOftW/dRowVa8=
X-Google-Smtp-Source: AMsMyM43THQNX4fFnsKbk5jo6qHQ5DcQscSSLPDT0beVCHJ62Z7573OuUa1YwhdcHAB5n51g9hqxYYi+EQs/lXIkROY=
X-Received: by 2002:a1f:6ecd:0:b0:39e:b8bb:b16d with SMTP id
 j196-20020a1f6ecd000000b0039eb8bbb16dmr8449083vkc.37.1663686104792; Tue, 20
 Sep 2022 08:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220729154716.429964-1-bigeasy@linutronix.de>
 <20220729154716.429964-3-bigeasy@linutronix.de> <YuRtSGCfe2qxHrqT@zx2c4.com>
 <YueBnnnnvpxxjE4N@linutronix.de> <YueeIgPGUJgsnsAh@linutronix.de>
In-Reply-To: <YueeIgPGUJgsnsAh@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 20 Sep 2022 17:01:33 +0200
X-Gmail-Original-Message-ID: <CAHmME9rZj9S62RngnYhkvj7is6Qi4wx0St-PiOwrLON-cW0OoA@mail.gmail.com>
Message-ID: <CAHmME9rZj9S62RngnYhkvj7is6Qi4wx0St-PiOwrLON-cW0OoA@mail.gmail.com>
Subject: Re: [PATCH 2/2 v3] lib/vsprintf: Initialize vsprintf's pointer hash
 once the random core is ready.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 1, 2022 at 11:34 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> The printk code invokes vnsprintf in order to compute the complete
> string before adding it into its buffer. This happens in an IRQ-off
> region which leads to a warning on PREEMPT_RT in the random code if the
> format strings contains a %p for pointer printing. This happens because
> the random core acquires locks which become sleeping locks on PREEMPT_RT
> which must not be acquired with disabled interrupts and or preemption
> disabled.
> By default the pointers are hashed which requires a random value on the
> first invocation (either by printk or another user which comes first.
>
> One could argue that there is no need for printk to disable interrupts
> during the vsprintf() invocation which would fix the just mentioned
> problem. However printk itself can be invoked in a context with
> disabled interrupts which would lead to the very same problem.
>
> Move the initialization of ptr_key into a worker and schedule it from
> subsys_initcall(). This happens early but after the workqueue subsystem
> is ready. Use get_random_bytes() to retrieve the random value if the RNG
> core is ready, otherwise schedule a worker in two seconds and try again.
>
> Reported-by: Mike Galbraith <efault@gmx.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v2=E2=80=A6v3:
>    - schedule a worker every two seconds if the RNG core is not ready.
>
>  lib/vsprintf.c |   46 +++++++++++++++++++++++++++-------------------
>  1 file changed, 27 insertions(+), 19 deletions(-)
>
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -751,31 +751,39 @@ static int __init debug_boot_weak_hash_e
>  early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
>
>  static bool filled_random_ptr_key;
> +static siphash_key_t ptr_key __read_mostly;
> +static void fill_ptr_key_workfn(struct work_struct *work);
> +static DECLARE_DELAYED_WORK(fill_ptr_key_work, fill_ptr_key_workfn);
> +
> +static void fill_ptr_key_workfn(struct work_struct *work)
> +{
> +       if (!rng_is_initialized()) {
> +               queue_delayed_work(system_unbound_wq, &fill_ptr_key_work,=
 HZ  * 2);
> +               return;
> +       }
> +
> +       get_random_bytes(&ptr_key, sizeof(ptr_key));
> +
> +       /* Pairs with smp_rmb() before reading ptr_key. */
> +       smp_wmb();
> +       WRITE_ONCE(filled_random_ptr_key, true);
> +}
> +
> +static int __init vsprintf_init_hashval(void)
> +{
> +       fill_ptr_key_workfn(NULL);
> +       return 0;
> +}
> +subsys_initcall(vsprintf_init_hashval)
>
>  /* Maps a pointer to a 32 bit unique identifier. */
>  static inline int __ptr_to_hashval(const void *ptr, unsigned long *hashv=
al_out)
>  {
> -       static siphash_key_t ptr_key __read_mostly;
>         unsigned long hashval;
>
> -       if (!READ_ONCE(filled_random_ptr_key)) {
> -               static bool filled =3D false;
> -               static DEFINE_SPINLOCK(filling);
> -               unsigned long flags;
> -
> -               if (!rng_is_initialized() ||
> -                   !spin_trylock_irqsave(&filling, flags))
> -                       return -EAGAIN;
> -
> -               if (!filled) {
> -                       get_random_bytes(&ptr_key, sizeof(ptr_key));
> -                       /* Pairs with smp_rmb() before reading ptr_key. *=
/
> -                       smp_wmb();
> -                       WRITE_ONCE(filled_random_ptr_key, true);
> -                       filled =3D true;
> -               }
> -               spin_unlock_irqrestore(&filling, flags);
> -       }
> +       if (!READ_ONCE(filled_random_ptr_key))
> +               return -EBUSY;
> +
>         /* Pairs with smp_wmb() after writing ptr_key. */
>         smp_rmb();
>

As we discussed at Plumbers, it seems like this is the least-awful way
forward. If we wind up with another case sufficiently similar to this,
I'll add back a notifier to random.c. But while there's only this one
special case, the ugly timer thing will have to do.

So Petr - feel free to queue this up this v3, with my objection now removed=
.

Jason
