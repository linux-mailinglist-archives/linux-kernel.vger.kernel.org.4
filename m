Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369E05BD3C8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiISReh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiISRec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:34:32 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2E1B60
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:34:29 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id f193so48515pgc.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=nbeqKeqU+tUuP9XT9zRql4nhIwFjZS/czFo4J2py6fk=;
        b=Nd9P/O4JXfy5MV6T5aozJFl2P2K8ng5xh8qL+RLCJQPl+i1vZk5tU8fCFAcM/IlJ6M
         xyZ2ONC/WReLyOTlhIFCw9B+xR8lFynmR2YGNNl8mTBXNrnzN2YeEvnGgurj1beFPXhW
         UKyaoWjBAZtSm8ODJ2uVVgJ9nWJpK2DCVF2WOg1qNSH2Gr3YzVyrzA42BU9ePq9tYbdS
         QI6kRtv4KzozU08CS3QG+MeozLhf7wciygDPUwDQZ64ay+BLklH0NV33+PPOYLMS22NV
         i6gScaUTCDbLlQsU3hdnY4nkcy+jPCLMg//TZDGNgLk0ShJ7vKW1XtE7sLkMktEk0qtF
         dRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nbeqKeqU+tUuP9XT9zRql4nhIwFjZS/czFo4J2py6fk=;
        b=WKv4i4wgjLtjR7mUzkaqU9b3WbfwAZj10YxAB18glFy/iQY4Ebd11na8yj0N2HJ8F3
         9TLWAkDlmR4RaBgRhUndhMzlozuUwc7UA/cN6AXPF39hlZYr529C8rbN30UsX0kVEXFg
         HyGyUUNAKybOu6I5K4KKOfhHWePFrrWpr1sTt71uiw+hL1wLX4gBdqLNYw3sA/2PxIfe
         BuHlRvcvMO3YhpLphy4ItOdW5A3f81AzGtEqcOd2zimCw3qTeYUntZeebFTZaayvZtTh
         EG76Qdb80OY3kJ8Qk/ai+rG+xNA1mSFd/2U2BsAz1NqPGOHPULnTOn8+CDR/U6PQpugi
         +9Kw==
X-Gm-Message-State: ACrzQf1v9kCoZUncMZBOsx3S+JeRm27P4DJmvleqvwxM0SelK54xdJ39
        cToUTgxeBcsB/E1Vuv2CNH0=
X-Google-Smtp-Source: AMsMyM52ZpcwiFXZ6jg8bIc6f7QSIyDiokWStRV6bcVGjHRvcELy1H0Sukf00Su9ePRl0gRVZKwiYw==
X-Received: by 2002:a05:6a00:198e:b0:541:f85a:6c27 with SMTP id d14-20020a056a00198e00b00541f85a6c27mr19375564pfl.81.1663608868727;
        Mon, 19 Sep 2022 10:34:28 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902680400b001789f6744b8sm2960161plk.214.2022.09.19.10.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 10:34:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 19 Sep 2022 07:34:27 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        parth@linux.ibm.com, qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com
Subject: Re: [PATCH v4 6/8] sched/fair: Add sched group latency support
Message-ID: <YyioI4iBFq8ib9JT@slm.duckdns.org>
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
 <20220916080305.29574-7-vincent.guittot@linaro.org>
 <000c2893-feb4-373d-2234-2ca74be94714@arm.com>
 <CAKfTPtASminP4ogVRhcvQ4R3-x-E+UUzuMaEu-xQU_MtLr9+Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtASminP4ogVRhcvQ4R3-x-E+UUzuMaEu-xQU_MtLr9+Xg@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 05:49:27PM +0200, Vincent Guittot wrote:
> > For `nice` we have `cpu.weight.nice` next to `cpu.weight` in cgroup v2 ?
> 
> If everybody is ok, I can add back the cpu.latency.nice interface in
> the v5 in addition to the cpu.latency

Yeah, that sounds fine to me.

Thanks.

-- 
tejun
