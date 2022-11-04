Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5787B61959B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 12:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbiKDLrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 07:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiKDLrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 07:47:09 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B1F2CDED
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 04:47:07 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n39-20020a05600c3ba700b003cf71011cddso5107000wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 04:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XhZdvW/ncA9z06KEjEplDf8ZILvVWyn6VVn2xqzbkT8=;
        b=xUA321jOEs4yPviRebU8z9/Y2g41TBs4LWz7JWNtyxI99EY26OMBBa0c82o9Y1YkJ0
         Vbg820yuP33VU6BDC3TRsHrIEZiuHVAy5WF2wFcPLQLoiXoqPysX0iaOj/xWAmdvAywn
         iVLWlsvMtxCYb5jaL4FiX8qk1UE4du2NZYa/WN1Q4faSbpT1gFa5Cp7jLZ7H46yojAFV
         Yd/+813TZQ6YVoS02pgfqTizYqASbPgvrEHf7owF9WuRttTmnF/eYrbQc2gn2JFtfdK+
         PMvD250rPAP28LW66w1HyM4jdmUePFp6cRS6RFvmFOzV2M8vxY9xXDPE8Ek89wsC2SEQ
         SpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XhZdvW/ncA9z06KEjEplDf8ZILvVWyn6VVn2xqzbkT8=;
        b=zHVpseqDDnWPeAq5M3AnF94BJAv6WgYS0PJ9e3HMEm5Mjh7GQWfFsxx32MjE+8zZpH
         rymhSETIrjgSIGMt+ax6kpgaSsHC7Uk7bWQwmqW2d8FLP4z/tB+KvRmvldZZB5CSXYzp
         VHw464W5ChRoXZHBCvhLZedL0hCXYEcUaYc8r5ZxkKGXn/3eSc0E441t6TKERYyZNcTd
         +GCq0EIYn9BFysmkrzXqAFss1blRwbXejXU1XPa8UADJ7QahMJvlHQc1wbzW696vCsMI
         xalItV//murRpz13ZTSx0HeiXq1RiQC7IDv2Izy5xgDoJn2LwCTBWpxeKl3X+Ezd4goV
         1npQ==
X-Gm-Message-State: ACrzQf2il4/XHAGQGRmpqdKgyUwjWkaFZD0lCIq7KSdi6xqdZmrOM9aj
        cmooLUZYxJ8dYzlgqOqL8OllgA==
X-Google-Smtp-Source: AMsMyM4IdFqN7wbuqUhRgChBbEwBBIrUhq31nFWOHFh0Y5GzzxSzTFFFVuJlvZWz+GkgLqqbHzZF4Q==
X-Received: by 2002:a05:600c:4586:b0:3c6:fbb0:bf5a with SMTP id r6-20020a05600c458600b003c6fbb0bf5amr34242935wmo.47.1667562425912;
        Fri, 04 Nov 2022 04:47:05 -0700 (PDT)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id i15-20020adfa50f000000b002366c3eefccsm3188833wrb.109.2022.11.04.04.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 04:47:05 -0700 (PDT)
Date:   Fri, 4 Nov 2022 11:47:03 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org
Subject: Re: [PATCH v7 6/9] sched/fair: Add sched group latency support
Message-ID: <20221104114703.cdfzuz3w53o77va3@airbuntu>
References: <20221028093403.6673-1-vincent.guittot@linaro.org>
 <20221028093403.6673-7-vincent.guittot@linaro.org>
 <20221101192848.pjns3um7dnrwrk5p@airbuntu>
 <CAKfTPtA=vJQA_=6Un1CqwzMUaOxMeFGTKUZnj8qyqvqmSdYBAg@mail.gmail.com>
 <20221103142732.m5ibwkuymvhcdxkn@airbuntu>
 <CAKfTPtDu=c-psGnHkoWSPRWoh1Z0VBBfsN++g+krv4B1SJmFjg@mail.gmail.com>
 <CAEXW_YQd2y9=RHw3Sge7ghnhBz0AyR+B-U4zG10LXuSbg5bGSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQd2y9=RHw3Sge7ghnhBz0AyR+B-U4zG10LXuSbg5bGSA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/22 10:14, Joel Fernandes wrote:

> I think the interface solves a different problem which is latency of
> task or cgroup wrt other group. Vincent, you are setting this for a
> “top app” group in android in your tests, and seeing improvement
> correct? AFAICS, this improvement comes because of lower latency
> during *same CPU* competition between different groups by juggling
> around the wakeup-preemption window -- which maybe is good for
> Android.
> 
> OTOH, the “prefer idle” flag in android that Qais is referring to,
> will need a completely different method as I cannot see how a nice
> value can communicate that (that can complement Vincent's changes
> here). And it will need to have a per-task interface as well. We have
> something in ChromeOS as well, which is a proc knob and also
> out-of-tree patch for that [1]. Without [1] we fail Android CTS
> testing on a recent ARM64 ChromeOS device.
> [1] https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/3884575
> The changelog in [1] also has a detailed description of the ChromeOS usecase.
> 
> Qais, any other reason you can see why Vincent's change will not be a
> good thing for Android? Since you 1 CGroup for the whole user-facing
> app (top app), you can just set that to a low "latency_nice" and get
> better wake-up latency for that.

There are two things to consider here:

	1. The interface and its extensibility.
	2. Current use case of improving wake up latency by manipulating
	   vruntime.

(2) looks promising approach, but it's very hard to know if it can be
considered a replacement. So (1) must be spot on to not block adding other
consumers in EAS or anywhere else in the scheduler for what matters.

> 
> (Side rant about latency and CFS -- IMHO a better long term solution
> for lower latency is to use RT but don't throttle -- rather demote. Or
> break CFS into multiple tiers, and apply demotion. This is in a way
> what Vincent is doing, as the task becomes more CPU bound'ish, he's
> taking away the latency boost. Vincent/Qais, somebody was working on
> the RT demotion vs throttling a while back, any idea on the latest on
> that?).

I can see an appetite in the future for userspace to provide more hints about
the characteristics of the tasks to improve performance and power.

I'm starting to lean towards having a framework to encapsulate such description
where latency_nice and potentially new notion of priority or something else can
be part of.

One aspect of prefer_idle in android for instance is that it disables the
packing behavior of EAS. I've seen Prateek showing similar examples in [1]
(FORK_SPREAD).

I don't have a clear idea in my head, but I'm slowly starting to lean towards
the need for a proper QoS/hint framework to describe the characteristic of the
task or a collection of tasks working together. My pony wish for now I guess
:-)

[1] https://lore.kernel.org/lkml/20220910105326.1797-1-kprateek.nayak@amd.com/


Thanks

--
Qais Yousef
