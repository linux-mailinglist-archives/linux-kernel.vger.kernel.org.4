Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E11F6D266B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjCaRJS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 13:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjCaRJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:09:15 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F17918810;
        Fri, 31 Mar 2023 10:09:08 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id t10so92146571edd.12;
        Fri, 31 Mar 2023 10:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680282547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHkZbyJ3qMi2ptOA6zEl8FUqKHDPucYizXoSCDQyJHw=;
        b=T8w/yZGORaejOl+LW6hAlaFU0Jyxe/5pkCfms/HiU9mnhMG9L90uMuHiG9khPRH4Xw
         cvLOsSipd/SmTZ1ihcv6b+Zng0xzNqO3bD53y3Th0hgNaeBdtLdpnOED1NxwOr7Q2atw
         gBB2AIlYhJnVz2QDi6vW7wmOH+KAUctr5YK5m7FAbW2+99RvAb7xxiOrzwHwULjL19cQ
         N3roQvm12T3ak1K+ha0kEmAiW6K9qBg8mblJzKvbia2SdVoSDbscILPAGXHyRZMX/f45
         Whh/Ew5w5CSmViO8E9c6Xx6azLurAiZNRqqpkOgEee5h8OKSTd9GA/yz1qBcG0MdCy+V
         T9cQ==
X-Gm-Message-State: AAQBX9dZ2MhcE39Mn4jM1Jft8A1yHIcU4OMmGXSDRs4zh+pd1wxmxq6N
        cg6yhgRpfRZBSOg2FgigMz4gBYOqPhCzrc4z9I8=
X-Google-Smtp-Source: AKy350aYHVVjZqpo+lU1LvdtaeIO6o6c/gqzLGZ3mOevVz8DwFjUBDSgV6s9VVtyobQTtQ1ex/F0b1gubuzXZJ5JrXw=
X-Received: by 2002:a17:907:160e:b0:946:a095:b314 with SMTP id
 hb14-20020a170907160e00b00946a095b314mr7871671ejc.2.1680282546797; Fri, 31
 Mar 2023 10:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
 <20230207051105.11575-22-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0hxKg_u4GKMkdGEp-JbvnymEtxSZT7fB2kbhWoQFSK1fw@mail.gmail.com>
 <20230329001536.GG8958@ranerica-svr.sc.intel.com> <CAJZ5v0iHJrXDU=C0oaf-3DJfatWGj4No_J1rwN6PCpRTZMXqyA@mail.gmail.com>
 <20230330024157.GD26315@ranerica-svr.sc.intel.com>
In-Reply-To: <20230330024157.GD26315@ranerica-svr.sc.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Mar 2023 19:08:55 +0200
Message-ID: <CAJZ5v0jqC=0pSU79heEypXK6SjP8TbYZfwSscrezs3bbPx-nyQ@mail.gmail.com>
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

On Thu, Mar 30, 2023 at 4:31 AM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> On Wed, Mar 29, 2023 at 02:21:57PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Mar 29, 2023 at 2:04 AM Ricardo Neri
> > <ricardo.neri-calderon@linux.intel.com> wrote:
> > >
> > > On Mon, Mar 27, 2023 at 07:03:08PM +0200, Rafael J. Wysocki wrote:
> > > > On Tue, Feb 7, 2023 at 6:02 AM Ricardo Neri
> > > > <ricardo.neri-calderon@linux.intel.com> wrote:
> > > > >
> > > > > In Alder Lake and Raptor Lake, the result of thread classification is more
> > > > > accurate when only one SMT sibling is busy. Classification results for
> > > > > class 2 and 3 are always reliable.
> > > > >
> > > > > To avoid unnecessary migrations, only update the class of a task if it has
> > > > > been the same during 4 consecutive user ticks.
> > > > >
> > > > > Cc: Ben Segall <bsegall@google.com>
> > > > > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > > > > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > > > > Cc: Ionela Voinescu <ionela.voinescu@arm.com>
> > > > > Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > Cc: Len Brown <len.brown@intel.com>
> > > > > Cc: Lukasz Luba <lukasz.luba@arm.com>
> > > > > Cc: Mel Gorman <mgorman@suse.de>
> > > > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > > Cc: Tim C. Chen <tim.c.chen@intel.com>
> > > > > Cc: Valentin Schneider <vschneid@redhat.com>
> > > > > Cc: x86@kernel.org
> > > > > Cc: linux-pm@vger.kernel.org
> > > > > Cc: linux-kernel@vger.kernel.org
> > > > > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > > > > ---
> > > > > Changes since v2:
> > > > >  * None
> > > > >
> > > > > Changes since v1:
> > > > >  * Adjusted the result the classification of Intel Thread Director to start
> > > > >    at class 1. Class 0 for the scheduler means that the task is
> > > > >    unclassified.
> > > > >  * Used the new names of the IPC classes members in task_struct.
> > > > >  * Reworked helper functions to use sched_smt_siblings_idle() to query
> > > > >    the idle state of the SMT siblings of a CPU.
> > > > > ---
> > > > >  drivers/thermal/intel/intel_hfi.c | 60 ++++++++++++++++++++++++++++++-
> > > > >  1 file changed, 59 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> > > > > index 35d947f47550..fdb53e4cabc1 100644
> > > > > --- a/drivers/thermal/intel/intel_hfi.c
> > > > > +++ b/drivers/thermal/intel/intel_hfi.c
> > > > > @@ -40,6 +40,7 @@
> > > > >  #include <linux/workqueue.h>
> > > > >
> > > > >  #include <asm/msr.h>
> > > > > +#include <asm/intel-family.h>
> > > > >
> > > > >  #include "../thermal_core.h"
> > > > >  #include "intel_hfi.h"
> > > > > @@ -209,9 +210,64 @@ static int __percpu *hfi_ipcc_scores;
> > > > >   */
> > > > >  #define HFI_UNCLASSIFIED_DEFAULT 1
> > > > >
> > > > > +#define CLASS_DEBOUNCER_SKIPS 4
> > > > > +
> > > > > +/**
> > > > > + * debounce_and_update_class() - Process and update a task's classification
> > > > > + *
> > > > > + * @p:         The task of which the classification will be updated
> > > > > + * @new_ipcc:  The new IPC classification
> > > > > + *
> > > > > + * Update the classification of @p with the new value that hardware provides.
> > > > > + * Only update the classification of @p if it has been the same during
> > > > > + * CLASS_DEBOUNCER_SKIPS consecutive ticks.
> > > > > + */
> > > > > +static void debounce_and_update_class(struct task_struct *p, u8 new_ipcc)
> > > > > +{
> > > > > +       u16 debounce_skip;
> > > > > +
> > > > > +       /* The class of @p changed. Only restart the debounce counter. */
> > > > > +       if (p->ipcc_tmp != new_ipcc) {
> > > > > +               p->ipcc_cntr = 1;
> > > > > +               goto out;
> > > > > +       }
> > > > > +
> > > > > +       /*
> > > > > +        * The class of @p did not change. Update it if it has been the same
> > > > > +        * for CLASS_DEBOUNCER_SKIPS user ticks.
> > > > > +        */
> > > > > +       debounce_skip = p->ipcc_cntr + 1;
> > > > > +       if (debounce_skip < CLASS_DEBOUNCER_SKIPS)
> > > > > +               p->ipcc_cntr++;
> > > > > +       else
> > > > > +               p->ipcc = new_ipcc;
> > > > > +
> > > > > +out:
> > > > > +       p->ipcc_tmp = new_ipcc;
> > > > > +}
> > > >
> > > > Why does the code above belong to the Intel HFI driver?  It doesn't
> > > > look like there is anything driver-specific in it.
> > >
> > > That is a good point. This post-processing is specific to the
> > > implementation of IPCC classes using Intel Thread Director.
> >
> > Well, the implementation-specific part is the processor model check
> > whose only contribution is to say whether or not the classification is
> > valid.  The rest appears to be fairly generic to me.
>
> I meant to say that we use Intel Thread Director and the HFI driver to
> implement the interfaces defined in patch 2. Other architectures may
> implement those interfaces differently.
>
> For Intel, we may even need different filters and debouncers for different
> models.
>
> >
> > > Maybe a new file called drivers/thermal/intel/intel_itd.c would be better?
> >
> > So which part of this code other than the processor model check
> > mentioned above is Intel-specific?
>
> debounce_and_update_class() is needed for Intel processors, other
> architectures may not need it or have a different solution.

IMV, one general problem with this approach is that it is making a
more-or-less random thermal driver operate on task structure
internals, while drivers/thermal/ is not a usual place to look for CPU
scheduler code.

I'm not sure why it has to be done this way and none of the above
explains that IIUC.

Is it really the role of the thermal HFI driver to implement a task
classification algorithm?  I'm not convinced about that.  Personally,
I would probably introduce some proper arch code doing that and using
input from the HFI driver.
