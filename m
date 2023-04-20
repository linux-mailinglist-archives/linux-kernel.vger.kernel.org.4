Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74656E9AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjDTRiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjDTRiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:38:16 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A93249E6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:37:47 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f1728c2a57so8973605e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1682012266; x=1684604266;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gCVZE62afJZFmC75qXVC+FO1EicLuXe429Fqzwpsky0=;
        b=UjioxuA7BSpUKJIGyGKOuS4I7JoSBL+HTWbQwUoJHc2Fi8MBL9R9kLA5g8HYTyqSve
         el935rsNbft1K/ppnsY0QoLb3uubPx6+wjUfPLUYlys6hEbt8CKikjQ4MDbxLIsFrTUK
         gClEcq76SWa4XfY19OMWiH4iX8g8ZXiaeDAQc7yQI3MX1tIUyATCx4SjEQ+6kKAm8BEq
         KW8RUrijFAcWmGC7Kj88uZwHyEePKWGUfB5fKPm4UQs/jSYcx42uh8AA5eBIqvvTDtdn
         LgwlfRQcHKDcW5INyKfYP3oW93n8TM5aCzaC25cG0wN78JxEoSSyMnMXFJLKpHLBPJmP
         es0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682012266; x=1684604266;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCVZE62afJZFmC75qXVC+FO1EicLuXe429Fqzwpsky0=;
        b=Mg2HDIESh8BSaE/Z4L1Z3OOr9Lk7XN0YmRASVik21hofdqAE/4wb/PdNVbESjMVM4W
         CadiEv52shbddzUUxd+bt6Hked38cynJ2WP/UPQ6J8TVKf3FrEhLDcXHdv9UnOgyfVel
         c0Isk/KoXKF4wDtQb9C26Nd0STDOj16x2m2NlqsSjDVlyNFtwkuZiCVsX7UpFpJUixaq
         HCMXfBdLxABBpZnCz2BOyQ/0zzFQMWMokRTVoVtradOj5u+PrpIltOoErvjaACdez7PA
         rf+gC0urEiE7w7NRWUyNXNszh92aXWgjz1bArEzbEBPdhzqBDOcvFJMauf3FPB2XIKuv
         kZrg==
X-Gm-Message-State: AAQBX9drsgoiZxBSru30vj46O3P7H+TDMyhaOgrI0DI9x6Y9ecWF4G+X
        9e3hBds+a6ePgRO0tRbgj4prqw==
X-Google-Smtp-Source: AKy350bRJgwY1ZYcTjQHWcQ94drz3jS6G+JuJwOq8HqAmMo0Q8kLrvxak5v6V6XPkPWOumJgTx5r2w==
X-Received: by 2002:a5d:5960:0:b0:2f9:9f6f:e4d with SMTP id e32-20020a5d5960000000b002f99f6f0e4dmr1648965wri.39.1682012265954;
        Thu, 20 Apr 2023 10:37:45 -0700 (PDT)
Received: from airbuntu (host109-154-46-114.range109-154.btcentralplus.com. [109.154.46.114])
        by smtp.gmail.com with ESMTPSA id h3-20020a5d5043000000b002c70ce264bfsm2452189wrt.76.2023.04.20.10.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 10:37:45 -0700 (PDT)
Date:   Thu, 20 Apr 2023 18:37:44 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        David Dai <davidai@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Qais Yousef <qyousef@google.com>,
        Quentin Perret <qperret@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1] sched/uclamp: Introduce
 SCHED_FLAG_RESET_UCLAMP_ON_FORK flag
Message-ID: <20230420173744.klscv7yli27uid6w@airbuntu>
References: <20230416213406.2966521-1-davidai@google.com>
 <d83950c4-7458-aeea-f341-327c163704a8@arm.com>
 <CABN1KC+_HDi_i2zzpZVbqiUP5-QB9YrE5wzLqr==_wOemaCXzA@mail.gmail.com>
 <bf8f21be-7249-fc27-9704-211d0f5a12b1@arm.com>
 <CAGETcx9RGnW_Bq49yVogFo3Eys4UczmXP-6bkZh1q=u+M-_bDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx9RGnW_Bq49yVogFo3Eys4UczmXP-6bkZh1q=u+M-_bDg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/20/23 09:22, Saravana Kannan wrote:
> On Thu, Apr 20, 2023 at 2:37 AM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
> >
> > On 20/04/2023 03:11, David Dai wrote:
> > > On Tue, Apr 18, 2023 at 10:18 PM Dietmar Eggemann
> > > <dietmar.eggemann@arm.com> wrote:
> > >>
> > >
> > > Hi Dietmar, thanks for your time,
> > >
> > >> On 16/04/2023 23:34, David Dai wrote:
> > >>> A userspace service may manage uclamp dynamically for individual tasks and
> > >>> a child task will unintentionally inherit a pesudo-random uclamp setting.
> > >>> This could result in the child task being stuck with a static uclamp value
> > >>
> > >> Could you explain this with a little bit more detail? Why isn't the
> > >> child task also managed by the userspace service?
> > >
> > > See Qais’ reply that contains more detail on how it’s being used in
> > > Android. In general, if a dynamic userspace service will adjust uclamp
> > > on the fly for a given task, but has no knowledge or control over if
> > > or when a task forks. Depending on the timing of the fork, a child
> > > task may inherit a very large or a small uclamp_min or uclamp_max
> > > value. The intent of this patch is to provide more flexibility to the
> > > uclamp APIs such that child tasks do not get stuck with a poor uclamp
> > > value when spawned while retaining other sched attributes. When
> > > RESET_ON_FORK is set on the parent task, it will reset uclamp values
> > > for the child but also reset other sched attributes as well.
> >
> > OK, in this case, why not just change behavior and always reset the
> > uclamp values at fork?
> 
> Personally, I'd have preferred uclamp was never inherited in the first
> place, but wouldn't that be considered as breaking UAPI if we change
> it now?

Why is it okay to inherit priority but not uclamp? I see this is hacky and
setting a policy in the kernel. Let's not tailor it to specific use cases only
please.


--
Qais Yousef
