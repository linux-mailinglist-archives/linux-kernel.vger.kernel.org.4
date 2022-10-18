Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6AC601E11
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 02:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiJRAE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 20:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJRAEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 20:04:25 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5B3A44D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 17:04:23 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id j4so20127957lfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 17:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WnYlEs3EZk1xPhzcEuoMhzmLfS8Qhk3Ay/ao9Jd31eM=;
        b=DMlZvigCc94SZYyPbg0qYNEnDXje+xQpALw0VqQEoPxtsLJydfYkBmQqo2EFjY/+gK
         NjvmBwVGRhqqvFWcP6UDp7yeAVlsDnXagSfK9AVz4zz/x1pYthwqt7qfpkI0v9veIlFC
         8+zv+ebZJBy38Q+zLBLU0VOirgnEel9elGv9iFviRYKNaGI7Ib+5IrdO7mAYH2jpcwZM
         THpSzSEYpt797kOdhOu7OazgfUB/nAtoMsKnojD93vP9iMYMQVSZikpOfDNYsH2aEjSj
         hSZLZfndVIGzp+7FCmD+v2DJYHmst8ck6Xnxvz4FugtAZ6PN4AIgtkfk96XbU24XTG27
         s4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WnYlEs3EZk1xPhzcEuoMhzmLfS8Qhk3Ay/ao9Jd31eM=;
        b=jfqNZtHAOWUIeWDkGExh+1K/PWUoRbkE3ZM5SB/ymxNgGffjhHNJ0ewez2u5Kks2TF
         VTM3kAE3Ng8QCb802g5yd2CLvUXh6VPEzimu0Qlum7sFcKwBL0oKNgrp+z+l4uQGGzDm
         sEDlbFeRVzIqZOth6ZlIv1luOBrVgo6f4FN0lj9rJ6oqZotVJxIq8hSApYmKKrVBcesz
         yh79LLrFT9navGFXsDPKRlsWEaazKWOy8kHLZSVIcgiyM4a7BOV01FBe8QFm6mkB1Czp
         oAnCF5Qzt9HwODCULaPjAfyfyAO6cqApo/rh93mGxNn4c/YNx7y4GStPNzCUa18G+w/0
         0Pog==
X-Gm-Message-State: ACrzQf0WrMBjHnfQo7+RXWpyRwbg9XygYVmg/1qyXhHhXIqLifFPX6Ir
        XZiXmzeNNcUI3cnRuBJcvCtYokHjN72uoAFk9WLq
X-Google-Smtp-Source: AMsMyM7MR2Ti5+jxGIkKK9muyJ9aH7Q7tLdx2UVUoa7qEmr7uCHPtM3VIzGFgqWdmAwQAwyb9DOEmGuGRWbP3bG7wq8=
X-Received: by 2002:a19:7704:0:b0:4a4:5d9d:2f66 with SMTP id
 s4-20020a197704000000b004a45d9d2f66mr49097lfc.515.1666051461519; Mon, 17 Oct
 2022 17:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221003232033.3404802-1-jstultz@google.com> <20221003232033.3404802-4-jstultz@google.com>
 <20221010160917.p2ftu3eezsrbfdfk@wubuntu> <20221017144455.ylmwlgrdoj3tdvbp@wubuntu>
In-Reply-To: <20221017144455.ylmwlgrdoj3tdvbp@wubuntu>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 17 Oct 2022 17:04:09 -0700
Message-ID: <CANDhNCo6M8NdLemjhA2sQ941agU+LQHxhRKAVMvr-qg9mQV51Q@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/3] softirq: defer softirq processing to ksoftirqd
 if CPU is busy with RT
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        "Connor O'Brien" <connoro@google.com>,
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

On Mon, Oct 17, 2022 at 7:45 AM Qais Yousef <qais.yousef@arm.com> wrote:
> This time I paid attention to the average as the best case number for vanilla
> kernel is better:
>
>                    |       vanilla      | with softirq patches v4  |
> -------------------|--------------------|--------------------------|
>                    |  #1  |  #2  |  #3  |   #1   |   #2   |   #3   |
> -------------------|------|------|------|--------|--------|--------|
> t0 avg delay (us)  |31.59 |22.94 |26.50 | 31.81  | 33.57  | 34.90  |
> t1 avg delay (us)  |16.85 |16.32 |37.16 | 29.05  | 30.51  | 31.65  |
> t2 avg delay (us)  |25.34 |32.12 |17.40 | 26.76  | 28.28  | 28.56  |
>
> It shows that we largely hover around 30us with the patches compared to 16-26us
> being more prevalent for vanilla kernels.
>
> I am not sure I can draw a concrete conclusion from these numbers. It seems
> I need to run longer than 4 hours to hit the worst case scenario every run on
> the vanilla kernel. There's an indication that the worst case scenario is
> harder to hit, and it looks there's a hit on the average delay.

Thanks so much for running these tests and capturing these detailed numbers!

I'll have to look further into the average case going up here.

> I'm losing access to this system from today. I think I'll wait for more
> feedback on this RFC; and do another round of testing for longer periods of
> time once there's clearer sense this is indeed the direction we'll be going
> for.

Do you mind sending me the script you used to run the test, and I'll
try to reproduce on some x86 hardware locally?

thanks
-john
