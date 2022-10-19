Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F894604369
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiJSLiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiJSLhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:37:31 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82394127BFE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:15:30 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so14327608wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EhCVS49eZ1vL9tUXB/h/T8e/hiHTpTUf91wRCrLchQM=;
        b=3gxO9V0tg3MGOZ0HvnZJy8gOgAsjSkvd+78m64mUzI7N/c2LnoyHe+Eoyxf8rFx6Qt
         UmB0GasiusOeIk3jB9IVvZAeTOGF5/Zu9dzbFSkV9INmqPP82xtZm2Q7ludbaCALqDKZ
         gVW+9fkjQq5jOEn8v5F7NWa1sJDdw6GyGw5OWIesRkThmatu1z7jIQdaO/LwXBPTBD9a
         aHMqqqKzcW38x+xuMeACYF7vRKsjn2rfUopdFV4VNvarRSJ+KoJ0OlbyCltOm9tqi+xc
         SvDcAgzreY2jpnTX/y5FeUewBQCZQGQL2oJ8jACUEugIERKQxCgSswjk0p3/uHIGULAO
         RG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhCVS49eZ1vL9tUXB/h/T8e/hiHTpTUf91wRCrLchQM=;
        b=PNYVngf/Ql9w12lp5q/ythVPTe/GzPpu5C58r1PTO1Fbrs7WaTGYMSTm7EgX150HbL
         /qlnTXbgF8cjyaE6KI3JrAgHqNqt1i3rkVkzRMGUeBG8Ign3ZLMaqPD+NCAHWUksgXcB
         6/JjCpSTQAidjma3DddRdSuOP/kcKsdUljP+6uC7/uwKNekl+MvM2yhWD8WdZHmYB4mz
         4Us99N7VWI4gAHSZqn+SO8dgYvZYXhshs3TrJXtac6C5boiJSSnkxJFYvkMgGmzCrcEf
         0D7qC+5gHLKXYhHVuEQunoNQ2h72lAnZVn50+tZ9UmSAQx4NmKFatzD+CwiJdwzqvoI+
         GUHg==
X-Gm-Message-State: ACrzQf3ZJkFUEBZttYuMl3k/oq0z5r2sBzcH7E91+4pDy4+eZr4keY6a
        1vXg4AiDk3uB5CXgNWSJJrjEG3zcnY1wzYyvyYY=
X-Google-Smtp-Source: AMsMyM55dknn5Kzctybq2gvHBBPwyNZ1Dm2AQsRzOIQUmDeZ+cdov4OMdnxLvK4H5+YzUCbh75GmnQ==
X-Received: by 2002:a05:600c:19c9:b0:3c2:7fff:a689 with SMTP id u9-20020a05600c19c900b003c27fffa689mr26655290wmq.85.1666177306112;
        Wed, 19 Oct 2022 04:01:46 -0700 (PDT)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c0a0a00b003a2f2bb72d5sm30633880wmp.45.2022.10.19.04.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 04:01:45 -0700 (PDT)
Date:   Wed, 19 Oct 2022 12:01:43 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     John Stultz <jstultz@google.com>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        Connor O'Brien <connoro@google.com>,
        Rick Yiu <rickyiu@google.com>, John Kacur <jkacur@redhat.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        "J . Avila" <elavila@google.com>
Subject: Re: [RFC PATCH v4 3/3] softirq: defer softirq processing to
 ksoftirqd if CPU is busy with RT
Message-ID: <20221019110143.m4romocqmprkekzw@airbuntu>
References: <20221003232033.3404802-1-jstultz@google.com>
 <20221003232033.3404802-4-jstultz@google.com>
 <20221010160917.p2ftu3eezsrbfdfk@wubuntu>
 <20221017144455.ylmwlgrdoj3tdvbp@wubuntu>
 <CANDhNCo6M8NdLemjhA2sQ941agU+LQHxhRKAVMvr-qg9mQV51Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANDhNCo6M8NdLemjhA2sQ941agU+LQHxhRKAVMvr-qg9mQV51Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(note the change in email)

On 10/17/22 17:04, John Stultz wrote:
> On Mon, Oct 17, 2022 at 7:45 AM Qais Yousef <qais.yousef@arm.com> wrote:
> > This time I paid attention to the average as the best case number for vanilla
> > kernel is better:
> >
> >                    |       vanilla      | with softirq patches v4  |
> > -------------------|--------------------|--------------------------|
> >                    |  #1  |  #2  |  #3  |   #1   |   #2   |   #3   |
> > -------------------|------|------|------|--------|--------|--------|
> > t0 avg delay (us)  |31.59 |22.94 |26.50 | 31.81  | 33.57  | 34.90  |
> > t1 avg delay (us)  |16.85 |16.32 |37.16 | 29.05  | 30.51  | 31.65  |
> > t2 avg delay (us)  |25.34 |32.12 |17.40 | 26.76  | 28.28  | 28.56  |
> >
> > It shows that we largely hover around 30us with the patches compared to 16-26us
> > being more prevalent for vanilla kernels.
> >
> > I am not sure I can draw a concrete conclusion from these numbers. It seems
> > I need to run longer than 4 hours to hit the worst case scenario every run on
> > the vanilla kernel. There's an indication that the worst case scenario is
> > harder to hit, and it looks there's a hit on the average delay.
> 
> Thanks so much for running these tests and capturing these detailed numbers!
> 
> I'll have to look further into the average case going up here.
> 
> > I'm losing access to this system from today. I think I'll wait for more
> > feedback on this RFC; and do another round of testing for longer periods of
> > time once there's clearer sense this is indeed the direction we'll be going
> > for.
> 
> Do you mind sending me the script you used to run the test, and I'll
> try to reproduce on some x86 hardware locally?

I ran that in a personal CI setup. I basically do the following 3 in parallel
'scripts':

cyclictest.sh [1]:

	cyclictest -t 3 -p 99 -D 3600 -i 1000 --json=cyclictest.json

iperf.sh [2]:

	iperf -s -D
	iperf -c localhost -u -b 10g -t 3600 -i 1 -P 3

dd.sh [3]:

	while true
	do
		cyclictest_running=`ps -e | grep cyclictest || true`
		if [ "x$cyclictest_running" == "x" ]; then
			break
		fi

		#
		# Run dd
		#
		file="/tmp/myci.dd.file"
		for i in $(seq 3)
		do
			dd if=/dev/zero  of=$file.$i bs=1M count=2048 &
		done
		wait
		rm -f $file*

		sleep 3
	done

[1] https://github.com/qais-yousef/myci-sched-tests/blob/dev/vars/run_cyclictest.groovy
[2] https://github.com/qais-yousef/myci-sched-tests/blob/dev/vars/run_iperf_parallel.groovy
[3] https://github.com/qais-yousef/myci-sched-tests/blob/dev/vars/run_dd_parallel.groovy


Cheers

--
Qais Yousef
