Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDF46526EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbiLTT2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbiLTT2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:28:45 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E6A1B9FE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:28:44 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id e190so4539774pgc.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fw9L5PvlNhgs+JU2B0gJjvTGtwLaSX/j7LO3d6/4JY8=;
        b=Nipo4cnzMxjM1/fF09J/PrpMEG8avkMefOHZlj18R9gW0gTj1AZ8Qb0RyOCaNdG4p+
         CcHh7BjLg5GwE+bx0knNlcCJHM9gVqSifHrVkweaczs1u0db9nybsaqBYyzpPxxRsV0s
         SSWX3FFx9MrZQpdLTcyEDB9D1rRLIfMC7JH1tFi4u+g3LKfcDE/AyLT58EpcAlx47TVQ
         gQRzva+qOSHZydPP6K5D34lqFz5DPBN/fJuKSN4r93uFVNvBmjNN4lPPRIXgiyg7lWfR
         bk+jx84BDcqLvMwc7Dd3LmCJcEbG9VyM0+5E3uEcKZXdB2mTdV0Sb8bsj9WGLNaF4K68
         OOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fw9L5PvlNhgs+JU2B0gJjvTGtwLaSX/j7LO3d6/4JY8=;
        b=MsRgk1IeM2DqqlZVr2PMaeF8/Mb3Yn6vXBFyXij/kPl8SgiQ2up2Jaa6H8z5Lk71ad
         H6TstVlize94AORFBvGz28zIq6FgUd/VrbOU13EeT4JKiXXzp2OMUz2PNVtOqjXCG2z4
         7d+vSTxgdzLPJrXFRJgwBQ8KmWEZpVUSpSBHvVWTN28XY0+3bXsUk8g087S7Af5VeWAJ
         lRFQRaEUWBd12Tbp0apl30XKVQDxeOcGxuhQJy58RQkw175Nd7gzNVus/J4N61Ih81Bi
         MrqQulF3Kuyzl9309cnmSNrJeoBZHNFZedrLnuEkd62b4Hia3S3n0jNtlGLuFt+Wnzb7
         HK0g==
X-Gm-Message-State: ANoB5pnMJGvMPlVktHCLgPMud7gRToxm/UlR7dm8PfB4uwJf9y1AvRnA
        kXdIhAElM0zGINSTMr4KvLTyrDc4MhnZ91uKzRxRvQ==
X-Google-Smtp-Source: AA0mqf6SVtpMM9XV/eQmt2Iqi2rbv60D+oVR221wTvytqK2tZLK4mXx1rTadFFKz5PuLWX6DJu+A7oUPDU6n26ly/dU=
X-Received: by 2002:a63:5a57:0:b0:478:ee2f:aad5 with SMTP id
 k23-20020a635a57000000b00478ee2faad5mr8671104pgm.545.1671564523605; Tue, 20
 Dec 2022 11:28:43 -0800 (PST)
MIME-Version: 1.0
References: <20221208075604.811710-1-junxiao.chang@intel.com>
 <BN9PR11MB5370BA8A506EB8519DC879C1ECEA9@BN9PR11MB5370.namprd11.prod.outlook.com>
 <Y6H4zqr8bObRFE1g@linutronix.de>
In-Reply-To: <Y6H4zqr8bObRFE1g@linutronix.de>
From:   Alison Chaiken <achaiken@aurora.tech>
Date:   Tue, 20 Dec 2022 11:28:32 -0800
Message-ID: <CAFzL-7t+Lq3ZJk90w=75yP++DbD1TGo16GRZkDzUNCyKpUH1TA@mail.gmail.com>
Subject: Re: [PATCH] softirq: wake up ktimer thread in softirq context
To:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Cc:     "Chang, Junxiao" <junxiao.chang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Peh, Hock Zhang" <hock.zhang.peh@intel.com>,
        Glenn Elliott <glenn@aurora.tech>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-20 10:44:07 [+0000], Chang, Junxiao wrote:
> > Any comment? This patch is for 6.1-rt, issue could be reproduced with 5.19-rt kernel as well.

On Tue, Dec 20, 2022 at 10:03 AM bigeasy@linutronix.de
<bigeasy@linutronix.de> wrote:
> Thanks for the ping. I did see the initial email and I didn't get to it
> yet. I need to re-test, confirm and then apply.
> The ktimer patch is not in v5.15 and this is currently the latest one
> maintained by the stable team. I don't know which one will be the
> following LTS kernel but this one needs to have this addressed. The
> v5.19 is not receiving any updates.

We backported the timersd patch to 5.15, where is where we have
observed the C-state transition despite pending timers.    The
reported trace sequence does show that __do_softirq() starts just
before the hrtimer_interrupt when the problem occurs:

When the timers are delayed, the trouble appears to begin when the
hrtimer_interrupt results in execution of hrtimer_run_queues() instead
of raise_hrtimer_softirq():
 <userspace>-13534   [007] 16947.069504: enqueue_hrtimer
          <idle>-0       [007] 16947.069547:
hrtimer_next_event_without: 16947.067643167
          <idle>-0       [007] 16947.069553: enqueue_hrtimer
          <idle>-0       [007] 16947.069567: enqueue_hrtimer
          <idle>-0       [007] 16947.069575:
hrtimer_next_event_without: 16947.067643167
          <idle>-0       [007] 16947.069579: enqueue_hrtimer
          <idle>-0       [007] 16947.078270: hrtimer_interrupt
          <idle>-0       [007] 16947.078278: hrtimer_run_queues.
          <idle>-0       [007] 16947.078300: enqueue_hrtimer
       ktimers/7-80      [007] 16947.078308: __do_softirq
     ksoftirqd/7-81      [007] 16947.078338: ksoftirqd_should_run 0
          <idle>-0       [007] 16947.078361:
hrtimer_next_event_without: 16947.067643167
          <idle>-0       [007] 16947.079323: hrtimer_interrupt
          <idle>-0       [007] 16947.079328: hrtimer_run_queues.
          <idle>-0       [007] 16947.079334: enqueue_hrtimer
     ksoftirqd/7-81      [007] 16947.079359: ksoftirqd_should_run 128
     ksoftirqd/7-81      [007] 16947.079360: __do_softirq
     ksoftirqd/7-81      [007] 16947.079361: hrtimer_interrupt
     ksoftirqd/7-81      [007] 16947.079361: raise_hrtimer_softirq.
     ksoftirqd/7-81      [007] 16947.079364: ksoftirqd_should_run 0
          <idle>-0       [007] 16947.079375:
hrtimer_next_event_without: 9223372036854775807
          <idle>-0       [007] 16947.079376:
tick_nohz_get_sleep_length: 86.838 ms
          <idle>-0       [007] 16947.079378: enqueue_hrtimer

Note the bogus value printed by hrtimer_next_event_without().

> Given the current timing, I will look into this in January.
>
> > Regards,
> > Junxiao
>
> Sebastian

-- Alison Chaiken
Aurora Innovation
