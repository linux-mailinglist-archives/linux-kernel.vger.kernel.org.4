Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF911667E42
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbjALSj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjALSj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:39:26 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7044D1D9;
        Thu, 12 Jan 2023 10:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673547202; x=1705083202;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B699McMd//oYBG80yC3WWU4NDAkc/4243ug8SV77va4=;
  b=jT/d++iqCbA0SzSPaoMtzlM3VB7jZiihXMwkPoRNqlzGJlcPI6weAvo3
   Q0QzcWY/JBzpugSH2IHwmgxVgkRLpeY6z/sVaU3c68AM0FEWC5pqrwWQb
   LGPLr21nh4qOXiq/hBxgjJU42gw7tLBAzhpsbzRNGjlQwCZY70cm509qv
   CXnvOF0ewgpzPGmkjD/2+z7tzXef9fAqxsO6M+Por4RW7pq11D7yRefS7
   UcKHSw05NHWHwzlYfMq7Dbu1+DvXnia0tqR9+lbEfU+LL3EO0Blx8zODX
   33zRJxENiv4ksd/OnCAxpAV4OZOpdIxowi9dSUk+u0LeCHGKxzP6xtBxT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="325834132"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="325834132"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 10:13:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="659920147"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="659920147"
Received: from rehlert-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.98.252])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 10:13:21 -0800
Message-ID: <444522a792ce9cb55b75d315b7e05901f4a68f05.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/4] powercap: idle_inject: Add prepare/complete
 callbacks
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org
Date:   Thu, 12 Jan 2023 10:13:21 -0800
In-Reply-To: <CAJZ5v0gbNv-SgTEHpjiQEwk7qELg6EkByd-8en0=wZ=abFD2JA@mail.gmail.com>
References: <20221129233419.4022830-1-srinivas.pandruvada@linux.intel.com>
         <20221129233419.4022830-3-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0jSL3bbEHJLxpn_Liu4DcNeMFG=iQJA_AgophmtXpzMGQ@mail.gmail.com>
         <CAJZ5v0gbNv-SgTEHpjiQEwk7qELg6EkByd-8en0=wZ=abFD2JA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-01-12 at 18:25 +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 12, 2023 at 3:53 PM Rafael J. Wysocki <rafael@kernel.org>
> wrote:
> > 
> > On Wed, Nov 30, 2022 at 12:34 AM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > > 
> > > The actual idle percentage can be less than the desired because
> > > of
> > > interrupts.
> > 
> > This is somewhat unclear.
> > 
Will try to make it better.

> > > Since the objective for CPU Idle injection is for thermal
> > > control, there should be some way to compensate for lost idle
> > > percentage.
> > 
> > What does "lost idle percentage" mean here?
User space wants 50% idle, but because of interrupts on target cpus we
were less than 50% idle. This may be because of too many interrupt
wakes. If we measure from the hardware counters, this may say we were
45% idle. So we were 5% less than user desired setting.

> > 
> > > Some architectures provide interface to get actual idle percent
> > > observed
> > > by the hardware. So, the idle percent can be adjusted using the
> > > hardware
> > > feedback. For example, Intel CPUs provides package idle counters,
> > > which
> > > is currently used by intel powerclamp driver to adjust idle time.
> > > 
> > > The only way this can be done currently is by monitoring hardware
> > > idle
> > > percent from a different software thread. This can be avoided by
> > > adding
> > > callbacks.
> > > 
> > > Add a capability to register a prepare and complete callback
> > > during idle
> > > inject registry. Add a new register function
> > > idle_inject_register_full()
> > > which also allows to register callbacks.
> > > 
> > > If they are not NULL, then prepare callback is called before
> > > calling
> > > play_idle_precise() and complete callback is called after calling
> > > play_idle_precise().
> > > 
> > > If prepare callback is present and returns non 0 value then
> > > play_idle_precise() is not called to avoid over compensation.
> > 
> > This mechanism isn't particularly straightforward, but maybe
> > there's
> > no better way.
> > 
> > > Signed-off-by: Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com>
> > > ---
> > > v2
> > > - Replace begin/end with prepare/complete
> > > - Add new interface idle_inject_register_full with callbacks
> > > - Update kernel doc
> > > - Update commit description
> > > 
> > >  drivers/powercap/idle_inject.c | 62
> > > +++++++++++++++++++++++++++++++---
> > >  include/linux/idle_inject.h    |  4 +++
> > >  2 files changed, 62 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/powercap/idle_inject.c
> > > b/drivers/powercap/idle_inject.c
> > > index dfa989182e71..f48e71501429 100644
> > > --- a/drivers/powercap/idle_inject.c
> > > +++ b/drivers/powercap/idle_inject.c
> > > @@ -63,13 +63,31 @@ struct idle_inject_thread {
> > >   * @idle_duration_us: duration of CPU idle time to inject
> > >   * @run_duration_us: duration of CPU run time to allow
> > >   * @latency_us: max allowed latency
> > > + * @prepare: Callback function which is called before calling
> > > + *             play_idle_precise()
> > > + * @complete: Callback function which is called after calling
> > > + *             play_idle_precise()
> > 
> > What about:
> > 
> > @prepare: Optional callback deciding whether or not to skip idle
> > injection in the given cycle.
> > @complete: Optional callback updating the state after idle
> > injection.
Looks good.

> 
> One more thing: ->complete() is not even used by powerclamp AFAICS,
> so
> I wouldn't add it at this time, because it isn't clear if it's going
> to be useful at all.
Sure.

Thanks,
Srinivas

