Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1886A5231
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 05:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjB1EGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 23:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjB1EGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 23:06:18 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E2D1EBC1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 20:06:17 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-536c02eea4dso237515607b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 20:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmAY+Hlk9CFYhOueiu2dCH9a3KBIlhgMKHrigv+ifQQ=;
        b=BjvWAIAQET6G1oocspN51wgyCYUjs8Ixctvz527cF0kkeQlfJ94sgePcWC+H8mBB4y
         7GZepqQuUqzy9Q/XLK7lidA5V159AaJN/pbHjngo47HtQX/TVCRmIaTrnjUQ9HXElLRf
         CQdcZMD8FD9HT6J1rvOhWw0fu57QgmHIHn+Ta3iqYifUZx/BfK1ycXHH8AlOR3C7ljF6
         K5Z/fN7Lkgyg0enKmJ+9JMJmmoXtwXFJgOMrOqrwX6BKHGhNU4qM40KogaSqrcoQp+3c
         HxDv10PpImrKAvlo+kro4ZMRYCPKzYWD7C7O378rABiz0lQuSsuUpiwfcVgi2IArJcX9
         H5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmAY+Hlk9CFYhOueiu2dCH9a3KBIlhgMKHrigv+ifQQ=;
        b=t7byFjWpwFecHmSCNy/0zsFWyzo3HsKUZn5Qcby3to5cC715JkYM+ZpXpb54zJogsc
         vF4d4s6cLUrj8LIHmS00hm1QAFrC6qA1ycLKMLJvwn8nuzQ5CKgWDLpy2ZG40yb33kTS
         D3z5y5K2nFwKdw7C5kYhoAfP5yJlnf7gNcMIGbYPY1OnL9IBqQ/eyUCErMTWYXqQf1iQ
         ZVSwfUe3c5bIaVCZCFaE4YCg4s1Elbz6lsvCGPhlqo4fE0qgSAhAw1KykflXdXL9KcUf
         nJjs3mhfgGTRIwBZSum0Qgyl/b7zulBFRWfxmyWm+8qsgsHnodppRu4O10b0g82zhj0j
         eEyw==
X-Gm-Message-State: AO0yUKXkiOk46584i9/LOchOFtXw3n/D+kdvRRJzz2pSLYtS7kPDW2Xg
        9l9GWxGiEW3NB7JmRORS7PGpnA5BRfmkyTqw9MsAieJOlNPssXxofg==
X-Google-Smtp-Source: AK7set+J2CBseghVd7hKjx/QtDWYUnE0kT7EUmWgB9ziCDCwUTv7J1ec0FWqE4T7wt+ok5P5RqwjraCk+MPhemmYS7o=
X-Received: by 2002:a81:4416:0:b0:533:9ffb:cb13 with SMTP id
 r22-20020a814416000000b005339ffbcb13mr661355ywa.3.1677557176281; Mon, 27 Feb
 2023 20:06:16 -0800 (PST)
MIME-Version: 1.0
References: <20230211064527.3481754-1-jstultz@google.com> <20230211064527.3481754-2-jstultz@google.com>
 <CAOf5uwnW1u=nfFnj3C8kCVmhgwRaVh6sHZR1RGnXdbrCNpkGVg@mail.gmail.com>
 <87o7porea9.ffs@tglx> <CAOf5uwmhtQ8GXhMiE-Y3-wgL5=xfjOv0Tpq1vqPB8p=LyZHBmw@mail.gmail.com>
 <CAOf5uwmpayJwpAFzUS6qsCgdpyek1f-2t2t9YNr76vnRjSC8=w@mail.gmail.com>
 <87a618qlcp.ffs@tglx> <CAOf5uw=a2RYYFj+4_WOX+KaF_FCXSsUgfM+T2m2XjVuqKMdooA@mail.gmail.com>
 <87sff0ox1a.ffs@tglx> <CANDhNCrfoiz1WdTs+5B8y+TVv8cn4_J-770=bsPqC9Xe=j14hA@mail.gmail.com>
In-Reply-To: <CANDhNCrfoiz1WdTs+5B8y+TVv8cn4_J-770=bsPqC9Xe=j14hA@mail.gmail.com>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 27 Feb 2023 20:06:05 -0800
Message-ID: <CANDhNCq8_Ly9SOwwxrsRCtATotnxpcmkS+5GCnkFVWOWtXfwKQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] time: alarmtimer: Use TASK_FREEZABLE to cleanup
 freezer handling
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael <michael@mipisi.de>, kernel-team@android.com,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Feb 27, 2023 at 4:03=E2=80=AFPM John Stultz <jstultz@google.com> wr=
ote:
> > On Mon, Feb 20 2023 at 19:11, Michael Nazzareno Trimarchi wrote:
> > +static int alarmtimer_pm_notifier_fn(struct notifier_block *bl, unsign=
ed long state,
> > +                                    void *unused)
> > +{
> > +       switch (state) {
> > +       case PM_HIBERNATION_PREPARE:
> > +       case PM_POST_HIBERNATION:
> > +               atomic_set(&alarmtimer_wakeup, 0);
> > +               break;
> > +       }
> > +       return NOTIFY_DONE;
>
> But here, we're setting the alarmtimer_wakeup count to zero if we get
> PM_HIBERNATION_PREPARE or  PM_POST_HIBERNATION notifications?
> And Michael noted we need to add  PM_SUSPEND_PREPARE and
> PM_POST_SUSPEND there for this to seemingly work.
>
> This zeroing out the counter here feels a little sloppy, as it seems
> nothing prevents the notifier from racing with the other added logic.
>
> If the issue is that when we're expiring timers in alarmtimer_fire(),
> a suspend event may come in midway after the alarmtimer_dequeue(),
> while the timer is running but before the alarmtimer_enqueue(),
> causing recurring timers to not be re-armed, it seems we probably
> should do the accounting fully in alarmtimer_fire(), doing an
> atomic_dec(&alarmtimer_wakeup) at the end of that function.  That way
> we avoid suspending while running an alarmtimer, so the recurring
> timers will always be back on the timer list when we do suspend.

Ah. Scratch that. I was testing with my rework of the patch and still
seeing trouble w/ Michael's reproducer.

My apologies, as I was mistaken that the race is in alarmtimer_fired
between the dequeue and the enqueue. It's between the
alarmtimer_fired() and the  posixtimer_rearm() logic, where a suspend
inbetween could prevent the timer from being rearmed.

This is messier as we need to allow the timer to fire and re-arm
itself and block suspend happening inbetween, and since the re-arming
logic is happening at the posixtimers abstraction level above the
alarmtimers, its difficult to totally prevent that.

So Thomas's notifier method of zeroing at the begining of suspend and
tracking any wakeups after that point makes more sense now. It still
feels a bit messy, but I'm not sure there's something better.

My only thought is this feels a little bit like its mirroring what the
pm_wakeup_event() logic is supposed to do. Should we be adding a
pm_wakeup_event() to alarmtimer_fired() to try to prevent suspend from
occuring for 500ms or so after an alarmtimer has fired so there is
enough time for it to be re-armed if needed?

thanks
-john
