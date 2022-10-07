Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05F85F774F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 13:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiJGLVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 07:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJGLVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 07:21:05 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063FECF1A4
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 04:21:02 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id l22so6579576edj.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 04:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7RItsXobtJxVtfZIp/ej9uhwWXKu/qurNMfB/Rd2SAM=;
        b=SUAUup7eXC5yOpfW7ZpI76/HMTOUXvneVoAb0TrIR7KO1RwhpJfznDpsXl62zcTvFH
         VtMmljw3yC2io2iAMRVpqdvC6jCwFR29+suLScqd2JQZsvlzy5Aif0EuA+ydTllYAQKW
         pDhVDfnunWCplfy7IiTT+l4ys5/SXA5RWOsEcdplAGPjamaUSyHkU3Gvms3pbXwsiDgs
         lq4ad6MJdEL+s0DGGqqMrVawMR8t39gJpaj4bhnuzHjClQrCGr+vT98HWlQdJO5F9D2E
         hsiN93H5hiJ0IcBNmpon2Ir6LTEW89kBsh6R++oHB+41N6h3UzSodNF8vchC3149XXLi
         l2IA==
X-Gm-Message-State: ACrzQf3+qSQ0uDWxuVbf5d1ynb4QKD2YPy+VDnI1qk9ZsHdrex7mhcY1
        sJpEnVGOa4ul7+zatUq21jWkeMpvM3/rcqY07sY=
X-Google-Smtp-Source: AMsMyM43V5c75QCTNU8AS/l5sLht2H9BpCZQ6p5iTipH0Qr4TSNmO9MCMvBobyVxuxbMbktoG6lQujBRlPW/pObaSg4=
X-Received: by 2002:a05:6402:518e:b0:452:49bc:179f with SMTP id
 q14-20020a056402518e00b0045249bc179fmr4131354edd.224.1665141660400; Fri, 07
 Oct 2022 04:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-16-ricardo.neri-calderon@linux.intel.com>
 <YzLlk8NL5qkOOxzX@hirez.programming.kicks-ass.net> <20221005235959.GB29251@ranerica-svr.sc.intel.com>
 <Yz6XQHafjIpfkyyY@hirez.programming.kicks-ass.net> <Yz6cjzrmu8HNPhhy@hirez.programming.kicks-ass.net>
 <MN0PR11MB601075B47DC7626876CC91DAE05C9@MN0PR11MB6010.namprd11.prod.outlook.com>
 <Yz7/A62YxHfmgYog@hirez.programming.kicks-ass.net>
In-Reply-To: <Yz7/A62YxHfmgYog@hirez.programming.kicks-ass.net>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 7 Oct 2022 13:20:48 +0200
Message-ID: <CAJvTdKn8qQwTw-BY_Rp=DOi+3is5tQqoJoNWDAH7ub8XTsimbw@mail.gmail.com>
Subject: Re: [RFC PATCH 15/23] thermal: intel: hfi: Report per-cpu
 class-specific performance scores
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Brown, Len" <len.brown@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chen, Tim C" <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 6, 2022 at 6:15 PM Peter Zijlstra <peterz@infradead.org> wrote:

> > That said, it is true that, say, an ADL desktop part that operates
> > with plenty of power and cooling will send the initial table and never
> > have a need to update the table after that.
>
> I have a NUC, so laptop part with limited thermals (the Lenovo P360
> Ultra was announed just after I ordered the P360 Tiny). Still I wasn't
> able to trigger this during normal operation.

To force an update, scribble on the software power limit:

# echo 0 >   /sys/class/powercap/intel-rapl:0/constraint_0_power_limit_uw
# echo 0 >   /sys/class/powercap/intel-rapl:0/constraint_1_power_limit_uw

Note that your P-unit may not instantaneously respond to this stimulus.

> > Upcoming chips are smarter and will give us more dynamic information.
> > We expect the P-unit to send only "meaningful" changes, and that they
> > Shall not occur more often than every 10ms.
>
> Make *very* sure those upcoming chips don't broadcast that interrupt.
> Broadcast interrupts are unconditional crap.
>
> Broadcast interrupts every 10ms is terrifying crap and a good reason for
> people to force disable this stuff.

The package-wide broadcast interrupt is indeed, ugly, and we've
been screaming bloody murder about it from day 1.  Unfortunately
the chip pipeline is long and deep, and so more chips with this issue will
materialize before the broadcast interrupt issue completely goes away.
--
Len Brown, Intel
