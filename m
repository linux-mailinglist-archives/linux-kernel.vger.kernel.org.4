Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C626CD94A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjC2MWU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 08:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjC2MWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:22:18 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A12740CA;
        Wed, 29 Mar 2023 05:22:10 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id er13so21452244edb.9;
        Wed, 29 Mar 2023 05:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680092529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4mZrQlf3YJwoCwklWtY3hmHdlb3tmR5YNWYXn4LhmY=;
        b=X34+ERBJUGWhVax7iuzRkVxpd6l4ze1WbE4jp1q663jMVzR4PIVzRpWwYFyv6FI2dI
         7Ul5e+FgfiwXQUsDEyAQRKkYU7cweuonMPb8ocHcm2jEf11L+v1Xh/ml43ACnGBU03uw
         ERvrBqSN4UmVdJxcfHLMHQiDkG7jpIORu0mxQrqbjXxZCXch7hR8ji4bQJ3wpjzj+M7G
         ELMAeLToN9nYQTPE0bapLm9uqMZ3NxMAkfGSfgrC9oawQa6oPg4AhpxqG7kW8NxVD4fC
         qoh8hj1iqHjEssz8wQ0OmMeZDeoAedXudihQR4uZLaK1LHg4OVdC9nfIPd78w102bBBv
         9oQw==
X-Gm-Message-State: AAQBX9fwvBLMEy+PgxdRdLRDNhcWo57qzr3NNQ6Sp7JzAJyMx3hETplN
        IVCmdFf5f8AFbxeE1EK4S0Y9kOQdbZPwoGNIWx8=
X-Google-Smtp-Source: AKy350YTEp8XKGvQ2ZwiDLz/Z1QGJxtivd7JRPsJPOxHEPSr1hbP+zORqJ0wyv5n3aOleGLm9/6aONyncAT0R2Decsw=
X-Received: by 2002:a50:9fe3:0:b0:502:62ba:865b with SMTP id
 c90-20020a509fe3000000b0050262ba865bmr809569edf.3.1680092528650; Wed, 29 Mar
 2023 05:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
 <20230207051105.11575-22-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0hxKg_u4GKMkdGEp-JbvnymEtxSZT7fB2kbhWoQFSK1fw@mail.gmail.com> <20230329001536.GG8958@ranerica-svr.sc.intel.com>
In-Reply-To: <20230329001536.GG8958@ranerica-svr.sc.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Mar 2023 14:21:57 +0200
Message-ID: <CAJZ5v0iHJrXDU=C0oaf-3DJfatWGj4No_J1rwN6PCpRTZMXqyA@mail.gmail.com>
Subject: Re: [PATCH v3 21/24] thermal: intel: hfi: Implement model-specific
 checks for task classification
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 2:04 AM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> On Mon, Mar 27, 2023 at 07:03:08PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Feb 7, 2023 at 6:02 AM Ricardo Neri
> > <ricardo.neri-calderon@linux.intel.com> wrote:
> > >
> > > In Alder Lake and Raptor Lake, the result of thread classification is more
> > > accurate when only one SMT sibling is busy. Classification results for
> > > class 2 and 3 are always reliable.
> > >
> > > To avoid unnecessary migrations, only update the class of a task if it has
> > > been the same during 4 consecutive user ticks.
> > >
> > > Cc: Ben Segall <bsegall@google.com>
> > > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > > Cc: Ionela Voinescu <ionela.voinescu@arm.com>
> > > Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > Cc: Len Brown <len.brown@intel.com>
> > > Cc: Lukasz Luba <lukasz.luba@arm.com>
> > > Cc: Mel Gorman <mgorman@suse.de>
> > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Tim C. Chen <tim.c.chen@intel.com>
> > > Cc: Valentin Schneider <vschneid@redhat.com>
> > > Cc: x86@kernel.org
> > > Cc: linux-pm@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > > ---
> > > Changes since v2:
> > >  * None
> > >
> > > Changes since v1:
> > >  * Adjusted the result the classification of Intel Thread Director to start
> > >    at class 1. Class 0 for the scheduler means that the task is
> > >    unclassified.
> > >  * Used the new names of the IPC classes members in task_struct.
> > >  * Reworked helper functions to use sched_smt_siblings_idle() to query
> > >    the idle state of the SMT siblings of a CPU.
> > > ---
> > >  drivers/thermal/intel/intel_hfi.c | 60 ++++++++++++++++++++++++++++++-
> > >  1 file changed, 59 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> > > index 35d947f47550..fdb53e4cabc1 100644
> > > --- a/drivers/thermal/intel/intel_hfi.c
> > > +++ b/drivers/thermal/intel/intel_hfi.c
> > > @@ -40,6 +40,7 @@
> > >  #include <linux/workqueue.h>
> > >
> > >  #include <asm/msr.h>
> > > +#include <asm/intel-family.h>
> > >
> > >  #include "../thermal_core.h"
> > >  #include "intel_hfi.h"
> > > @@ -209,9 +210,64 @@ static int __percpu *hfi_ipcc_scores;
> > >   */
> > >  #define HFI_UNCLASSIFIED_DEFAULT 1
> > >
> > > +#define CLASS_DEBOUNCER_SKIPS 4
> > > +
> > > +/**
> > > + * debounce_and_update_class() - Process and update a task's classification
> > > + *
> > > + * @p:         The task of which the classification will be updated
> > > + * @new_ipcc:  The new IPC classification
> > > + *
> > > + * Update the classification of @p with the new value that hardware provides.
> > > + * Only update the classification of @p if it has been the same during
> > > + * CLASS_DEBOUNCER_SKIPS consecutive ticks.
> > > + */
> > > +static void debounce_and_update_class(struct task_struct *p, u8 new_ipcc)
> > > +{
> > > +       u16 debounce_skip;
> > > +
> > > +       /* The class of @p changed. Only restart the debounce counter. */
> > > +       if (p->ipcc_tmp != new_ipcc) {
> > > +               p->ipcc_cntr = 1;
> > > +               goto out;
> > > +       }
> > > +
> > > +       /*
> > > +        * The class of @p did not change. Update it if it has been the same
> > > +        * for CLASS_DEBOUNCER_SKIPS user ticks.
> > > +        */
> > > +       debounce_skip = p->ipcc_cntr + 1;
> > > +       if (debounce_skip < CLASS_DEBOUNCER_SKIPS)
> > > +               p->ipcc_cntr++;
> > > +       else
> > > +               p->ipcc = new_ipcc;
> > > +
> > > +out:
> > > +       p->ipcc_tmp = new_ipcc;
> > > +}
> >
> > Why does the code above belong to the Intel HFI driver?  It doesn't
> > look like there is anything driver-specific in it.
>
> That is a good point. This post-processing is specific to the
> implementation of IPCC classes using Intel Thread Director.

Well, the implementation-specific part is the processor model check
whose only contribution is to say whether or not the classification is
valid.  The rest appears to be fairly generic to me.

> Maybe a new file called drivers/thermal/intel/intel_itd.c would be better?

So which part of this code other than the processor model check
mentioned above is Intel-specific?
