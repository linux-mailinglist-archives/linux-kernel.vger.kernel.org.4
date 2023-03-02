Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06686A84B0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjCBOzy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Mar 2023 09:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjCBOzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:55:52 -0500
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C9B1BAF8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:55:25 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id o15so66196172edr.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 06:55:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677768868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mr3NbzrGzPtIlaHFMXoQwIzaRy5Utx9c8BlC7JDkgYo=;
        b=IcpxG520A5VFJJBfcuJaFP8LCjiv5AYoNEetA39k1lm45MamjCQzmNRpC2C1zY8GUm
         d4wpHq1RMDazk2jtzkghTt3KcyxNXSMZn0MTp1WlCQMgjV3EFkZWKGFeLlngk04V0gUv
         hQgO7C5AmZkxC1BIFfpGSE6gABgLgxp0od3oljMy+wKe1RPaYcxsWPRpn9tGUKLft4We
         pgr0tk/u6IHcc7AZLMz7+EId1O1nnW37eQkPJ3sHzIM5E9oTx4PVVL1HGtvUfq71J0W9
         HDuI0hsKvBufc6lnpUooaBGEuum6ZUfArs/4JGVT7invd+9r7KykoLKgK9U3W3bQ6vWg
         yteQ==
X-Gm-Message-State: AO0yUKVoIAo025hqftWJXiTtsmJEffKNe2Su2qHESeJqHZ4vbHKMi8zl
        LBHSeFDvQbUtLM43kCS04I68tMVf/VHt+iylDb4=
X-Google-Smtp-Source: AK7set/7p8sZ0X3SGTS29Aw8869VIs5VbXkLieM5qnnaKRb9dEwhRU6db7orcx2PXHajHuqVh2rYJpE9I79tDXVCFbQ=
X-Received: by 2002:a17:906:2358:b0:877:747d:1108 with SMTP id
 m24-20020a170906235800b00877747d1108mr5046568eja.5.1677768867869; Thu, 02 Mar
 2023 06:54:27 -0800 (PST)
MIME-Version: 1.0
References: <20230211064527.3481754-1-jstultz@google.com> <20230211064527.3481754-2-jstultz@google.com>
 <CAOf5uwnW1u=nfFnj3C8kCVmhgwRaVh6sHZR1RGnXdbrCNpkGVg@mail.gmail.com>
 <87o7porea9.ffs@tglx> <CAOf5uwmhtQ8GXhMiE-Y3-wgL5=xfjOv0Tpq1vqPB8p=LyZHBmw@mail.gmail.com>
 <CAOf5uwmpayJwpAFzUS6qsCgdpyek1f-2t2t9YNr76vnRjSC8=w@mail.gmail.com>
 <87a618qlcp.ffs@tglx> <CAOf5uw=a2RYYFj+4_WOX+KaF_FCXSsUgfM+T2m2XjVuqKMdooA@mail.gmail.com>
 <87sff0ox1a.ffs@tglx> <CANDhNCrfoiz1WdTs+5B8y+TVv8cn4_J-770=bsPqC9Xe=j14hA@mail.gmail.com>
 <CANDhNCq8_Ly9SOwwxrsRCtATotnxpcmkS+5GCnkFVWOWtXfwKQ@mail.gmail.com> <87h6v4ktp5.ffs@tglx>
In-Reply-To: <87h6v4ktp5.ffs@tglx>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Mar 2023 15:54:16 +0100
Message-ID: <CAJZ5v0jtYE+yp57t60szEbtzFVc-kbeMcxAiWuYc-cf1q2HxMA@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] time: alarmtimer: Use TASK_FREEZABLE to cleanup
 freezer handling
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <jstultz@google.com>,
        Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael <michael@mipisi.de>, kernel-team@android.com,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 11:11 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, Feb 27 2023 at 20:06, John Stultz wrote:
> > On Mon, Feb 27, 2023 at 4:03 PM John Stultz <jstultz@google.com> wrote:
> >> > On Mon, Feb 20 2023 at 19:11, Michael Nazzareno Trimarchi wrote:
> >> > +static int alarmtimer_pm_notifier_fn(struct notifier_block *bl, unsigned long state,
> >> > +                                    void *unused)
> >> > +{
> >> > +       switch (state) {
> >> > +       case PM_HIBERNATION_PREPARE:
> >> > +       case PM_POST_HIBERNATION:
> >> > +               atomic_set(&alarmtimer_wakeup, 0);
> >> > +               break;
> >> > +       }
> >> > +       return NOTIFY_DONE;
> >>
> >> But here, we're setting the alarmtimer_wakeup count to zero if we get
> >> PM_HIBERNATION_PREPARE or  PM_POST_HIBERNATION notifications?
> >> And Michael noted we need to add  PM_SUSPEND_PREPARE and
> >> PM_POST_SUSPEND there for this to seemingly work.
>
> Yup. I missed those when sending out that hack.
>
> > So Thomas's notifier method of zeroing at the begining of suspend and
> > tracking any wakeups after that point makes more sense now. It still
> > feels a bit messy, but I'm not sure there's something better.
>
> I'm not enthused about it either.
>
> > My only thought is this feels a little bit like its mirroring what the
> > pm_wakeup_event() logic is supposed to do. Should we be adding a
> > pm_wakeup_event() to alarmtimer_fired() to try to prevent suspend from
> > occuring for 500ms or so after an alarmtimer has fired so there is
> > enough time for it to be re-armed if needed?
>
> The question is whether this can be called unconditionally and how that
> interacts with the suspend logic. Rafael?

The pm_wakeup_event() doesn't need the timeout, but it is conditional
on using /sys/power/wakeup_count.

However, in any case it doesn't guarantee that the target user of the
alarm timer will be able to handle the signal on time AFAICS.  To my
eyes, it is entirely possible for alarmtimer_fired() to run before
/sys/power/wakeup_count is written to while the signal will be sent to
the given task later, in which case there is no guarantee that the
task will not be frozen in the meantime.

Moreover, I'm wondering if all alarm timers should always wake up the
system from sleep or abort suspends in progress?  If the answer is
"no" here, it changes the problem at hand quite a bit.
