Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C0B608F00
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 20:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJVSen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 14:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiJVSel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 14:34:41 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F02C1F9E5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 11:34:39 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id x15so4053238qvp.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 11:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1e95uf0VzIyXTP1nwyIENyrVuUu1bwwXuPdhByZMPJM=;
        b=ugLhfbDMIgcuwCDeYy9cMtlJzCyjM8bnlZzIZ2Fyon/UUb6zbsAqGKz1ARs4QNJzJN
         6f5kyfiFVSBg+hgOoX/LFAKk812AJ7n/XmK4+aQXWy8mu07eXMTxSys2U3wVHRXXrHXn
         34rdBBfB44W7WtcnW/BlNPFs3MV3KziWtXH9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1e95uf0VzIyXTP1nwyIENyrVuUu1bwwXuPdhByZMPJM=;
        b=RKqjlVTxTUFPvrhROIsZTW+oXM5K5G9ma6/eLXsbVx/wi2e/rYjPyXmoPU5bsWTBld
         zoCrs3kpjxiS985lekeYJib52ItFzvXdlonaBwgBmSNHTOVMB98V1UzUVY4f5LD122yM
         VURZ/iwTm/YwHRoNN40FFBaqEYGtlq5vwrkHvLhmN+tus4kxhVou+LsTfRdL8H04Ebfv
         JytGj916yhY1Q+sO08Emr31+vQgshNNFMSGYo33QobCm8J3Ayg5umjUQZDiQxlj7OIyB
         e9pRKRD024ZvfkYIugldboVB/guXOUQEy7sb0F9VBU8JD9923HBm7epDkgdb5qGVKnWs
         M0cg==
X-Gm-Message-State: ACrzQf1H1E5E6Zou8D3HA6YXvM39d68g9SH8vktUbO9ziuhLqd7E2MyH
        2dnA1Kcj9yrRypCAzK9OBmf1SA==
X-Google-Smtp-Source: AMsMyM67wiEibEuUjzyqH0f0gdHtfWI/O0UjXckudpmGJa/qw/NWFgqZJCS4dbAxSSyKiL7yeYSyyA==
X-Received: by 2002:a05:6214:2aa4:b0:4b3:fcfb:6479 with SMTP id js4-20020a0562142aa400b004b3fcfb6479mr21715985qvb.127.1666463678334;
        Sat, 22 Oct 2022 11:34:38 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id b1-20020ac87fc1000000b0039cc47752casm10502456qtk.77.2022.10.22.11.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 11:34:37 -0700 (PDT)
Date:   Sat, 22 Oct 2022 18:34:37 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Connor O'Brien <connoro@google.com>,
        John Dias <joaodias@google.com>, Rick Yiu <rickyiu@google.com>,
        John Kacur <jkacur@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
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
Subject: Re: [PATCH RFC v4 2/3] sched: Avoid placing RT threads on cores
 handling long softirqs
Message-ID: <Y1Q3vYjlFt/Imu5w@google.com>
References: <20221003232033.3404802-1-jstultz@google.com>
 <20221003232033.3404802-3-jstultz@google.com>
 <Y01NPB4sa8Z98ntK@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <CANDhNCoTGNANDnOQ6touhreG_UEn1-N4T4BktWFxpLPSWVfrdA@mail.gmail.com>
 <Y0+/SAWUNRnhIW9b@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <CANDhNCpQuQn_84yqErF2noAYDwdwNJQF-pr4JKVp1eZzH=+f9w@mail.gmail.com>
 <Y1FDegctcU2LrYGT@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1FDegctcU2LrYGT@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 02:47:54PM +0200, Alexander Gordeev wrote:
> On Wed, Oct 19, 2022 at 03:09:15PM -0700, John Stultz wrote:
> 
> Hi John,
> 
> [...]
> 
> > So I'll go ahead and simplify the check to just the LONG_SOFTIRQ_MASK
> > & (active | pending softirqs) check. This should avoid the need to
> > pull the cpu_rq(cpu)->curr value and simplify things.
> 
> In my reading of your approach if you find a way to additionally
> indicate long softirqs being handled by the remote ksoftirqd, it
> would cover all obvious/not-corner cases.

How will that help? The long softirq executing inside ksoftirqd will disable
preemption and prevent any RT task from executing.

Did I miss something?

thanks,

 - Joel

