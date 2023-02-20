Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A394B69C68B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 09:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjBTIXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 03:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjBTIXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 03:23:18 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BB8729F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 00:23:16 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id cq23so1076033edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 00:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rCRRyUNPgvz/yQmNCDswK+Gid/P+jM0/uiuW+eQnlho=;
        b=ZSmTxxENfd2ODRDZpX9yPdnC2+raT2sTJ5dmL/zgKQWmFvLULtEYTDDJnnXslK54iS
         KJQx731bJJf2AKexIevXFt0jBu5+/fAVlZWvq1u2wtEJc98uZRwP1jWGcngoDe53GQcq
         t8V8KdlIhyHPP1n66z+MtJfHQvJKBMumZDaoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCRRyUNPgvz/yQmNCDswK+Gid/P+jM0/uiuW+eQnlho=;
        b=dz52RkIiZbVl6YN7+H+ck6vXQBQL8pPwWt21+NuBHxWeWT7R9nFLtzdt9wYOEO2J2r
         4dKrT3ScCwU5CgnN23Q+/FiBNtWZR47/6+d+SxvVH5G5wF+FaZL120+K8iMsQaNVc+SZ
         QJiv3QzoS2WJdckcFqcr2L2kg1JVUlK/NXQtAoQuGPMSFviw3x31IJ9GA+z+xV7WvlDq
         emNQRGM4v+6j0bFZHD6gYLYUpHAhrvoQl/j4gF5C73aiao3+Bo9oyHWDyah07JMkN0+O
         7HmS2ndehVq4zcAjAp/a/iK5MCXpoIkVyunmjvxhmcouvFPFJR5qxp2z6eMpmeWpBKJ4
         BC9A==
X-Gm-Message-State: AO0yUKU2qci564J81FTNZPCQ6XfS5UDcJn903P5MDagkCEDjQkBayUSh
        aSeOVe4I4rF3ebsSNq2PblGX8yGvTLaU6stPlOVpgA==
X-Google-Smtp-Source: AK7set/4Ib4BKkM4N+b3ZJ34eUJ33v1bgPA6MgtXX96rRxePj0ouGdkOwspzvQ0r6iZ81FvUXk8tiIgSj49iwpxyF3k=
X-Received: by 2002:a50:ce5a:0:b0:49d:ec5d:28b4 with SMTP id
 k26-20020a50ce5a000000b0049dec5d28b4mr1112478edj.6.1676881395347; Mon, 20 Feb
 2023 00:23:15 -0800 (PST)
MIME-Version: 1.0
References: <20230211064527.3481754-1-jstultz@google.com> <20230211064527.3481754-2-jstultz@google.com>
 <CAOf5uwnW1u=nfFnj3C8kCVmhgwRaVh6sHZR1RGnXdbrCNpkGVg@mail.gmail.com> <87o7porea9.ffs@tglx>
In-Reply-To: <87o7porea9.ffs@tglx>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Mon, 20 Feb 2023 09:23:04 +0100
Message-ID: <CAOf5uwmhtQ8GXhMiE-Y3-wgL5=xfjOv0Tpq1vqPB8p=LyZHBmw@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] time: alarmtimer: Use TASK_FREEZABLE to cleanup
 freezer handling
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael <michael@mipisi.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas

On Mon, Feb 20, 2023 at 8:23 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sat, Feb 18 2023 at 15:56, Michael Nazzareno Trimarchi wrote:
> >
> > I have changed the alarm test to check some corner case
>
> Could you tell us please which test did you change and what the change is?
>

  if (timer_create(CLOCK_REALTIME_ALARM, &se, &tm1) == -1) {
       printf("timer_create failed, %s unsupported?\n",
       clockstring(alarm_clock_id));
       exit(1);
  }

  clock_gettime(alarm_clock_id, &start_time);
  printf("Start time (%s): %ld:%ld\n", clockstring(alarm_clock_id),
                                start_time.tv_sec, start_time.tv_nsec);
  printf("Setting alarm for every %i seconds\n", SUSPEND_SECS);
  its1.it_value = start_time;
  its1.it_value.tv_sec += 4;
  /* Empiric value for get in between a freeze task and fire of the timer */
  its1.it_value.tv_nsec += 132079666;
  its1.it_interval.tv_sec = 4;
  its1.it_interval.tv_nsec = 0;

  timer_settime(tm1, TIMER_ABSTIME, &its1, &its2);

  printf("Starting suspend loops\n");
  while (1) {
      int ret;
      sleep(4);
      system("echo mem > /sys/power/state");
  }

> > periodic_alarm
> > Start time (CLOCK_REALTIME_ALARM)[   85.624819] alarmtimer_enqueue: called
> > : 94:865096467
> > Setting alarm for every 4 seconds
> > Starting suspend loops
> > [   89.674127] PM: suspend entry (deep)
> > [   89.714916] Filesystems sync: 0.037 seconds
> > [   89.733594] Freezing user space processes
> > [   89.740680] Freezing user space processes completed (elapsed 0.002 seconds)
> > [   89.748593] OOM killer disabled.
> > [   89.752257] Freezing remaining freezable tasks
> > [   89.756807] alarmtimer_fired: called
> > [   89.756831] alarmtimer_dequeue: called <---- HERE
> >
> > I have the dequeue but not an enquee of the periodic alarm. I was
> > thinking that create a periodic time of 4 seconds
> > and have the first alarm on suspend will always guarantee the re-arm
> > it but it's not working as I expect
>
> Again. You are not telling what you expect. It depends on how the timer
> is set up whether the timer is self rearmed or not.
>

Posted the pseudo code. As far as I understand, the timer periodic is
re-armed in get_signal
do_work_pending->do_signal()->get_signal(), then in the posix timer
code the enqueue_alarm is called. All the timers
used from suspend are coming from the expiration list that contains
only the enqueue alarm

My test case is a single core, arm and with only one REAL_TIME_ALARM
periodic timer created.

Michael

> Thanks,
>
>         tglx
