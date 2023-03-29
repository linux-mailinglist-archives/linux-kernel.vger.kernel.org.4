Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCAC6CD924
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjC2MIv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 08:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjC2MIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:08:46 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3749619A6;
        Wed, 29 Mar 2023 05:08:43 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id eh3so62215730edb.11;
        Wed, 29 Mar 2023 05:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680091721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWzS8o2cDqs6eUyJBwx+5Ajp/UM3cNcMfK4e9vgW6Yc=;
        b=0WaDg57zfFrniRueSiMvPO5iIVXzetbTAgrhpMGVA7MClmHcoCTZ+UtsyChujrWQ/X
         W6KQspW+cHaq8jIZtqbj7YLpk+tNuyoI++SJrBOGt++Ckj/cYH4i5LoRTwjfOH5NtOTx
         GUsqjjRUyY0naeNDAnsxesUVMeQS2ijkQBToKXimrJaW7THshhdDfgmpoLv7wiFvcy+M
         g9RhApDs11ucN6dm/pX4E/ohSNz4HTIS397rKKqBy6Ht3173Ka02Vqqi0BVqaBd/t018
         1DyZ3uA6f87hPkQmKODMsGW7tuxkc/nrdrQeHZi0V21RyxYNu8l6G4REQ9dSudt0T65h
         A2hg==
X-Gm-Message-State: AAQBX9dxNW7/bV4VTRhqQTkg5oE5rBa0M8N6zGgMrO3t6lW1aJq9KG+O
        fklfYTSvsiA82hXXeI+f9Hwg6L2PIvwzukvz/GQ=
X-Google-Smtp-Source: AKy350ZYP6W+yADw/tshSfD/CV3BPa2v4C84MxtrAadNdNflYmSY15mCn0xqZqUtnnb58K4BBCXAb08S+jTDAxTTKEU=
X-Received: by 2002:a17:907:d48d:b0:93e:c1ab:ae67 with SMTP id
 vj13-20020a170907d48d00b0093ec1abae67mr8662109ejc.2.1680091721743; Wed, 29
 Mar 2023 05:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
 <20230207051105.11575-14-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0hooaHtM8=KCx6XYZjPFh66kVBSbPTX4GwiMTgovxoVzg@mail.gmail.com> <20230328234315.GD8958@ranerica-svr.sc.intel.com>
In-Reply-To: <20230328234315.GD8958@ranerica-svr.sc.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Mar 2023 14:08:30 +0200
Message-ID: <CAJZ5v0iUg+BBfTkXfkc5X2SFm1icekYOU2Ow+5_4riJjs1v43A@mail.gmail.com>
Subject: Re: [PATCH v3 13/24] thermal: intel: hfi: Store per-CPU IPCC scores
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

On Wed, Mar 29, 2023 at 1:32 AM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> On Mon, Mar 27, 2023 at 06:37:32PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Feb 7, 2023 at 6:02 AM Ricardo Neri
> > <ricardo.neri-calderon@linux.intel.com> wrote:
> > >
> > > The scheduler reads the IPCC scores when balancing load. These reads can
> > > be quite frequent. Hardware can also update the HFI table frequently.
> > > Concurrent access may cause a lot of lock contention. It gets worse as the
> > > number of CPUs increases.
> > >
> > > Instead, create separate per-CPU IPCC scores that the scheduler can read
> > > without the HFI table lock.
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
> > > Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > > ---
> > > Changes since v2:
> > >  * Only create these per-CPU variables when Intel Thread Director is
> > >    supported.
> > >
> > > Changes since v1:
> > >  * Added this patch.
> > > ---
> > >  drivers/thermal/intel/intel_hfi.c | 46 +++++++++++++++++++++++++++++++
> > >  1 file changed, 46 insertions(+)
> > >
> > > diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> > > index 2527ae3836c7..b06021828892 100644
> > > --- a/drivers/thermal/intel/intel_hfi.c
> > > +++ b/drivers/thermal/intel/intel_hfi.c
> > > @@ -29,6 +29,7 @@
> > >  #include <linux/kernel.h>
> > >  #include <linux/math.h>
> > >  #include <linux/mutex.h>
> > > +#include <linux/percpu.h>
> > >  #include <linux/percpu-defs.h>
> > >  #include <linux/printk.h>
> > >  #include <linux/processor.h>
> > > @@ -170,6 +171,43 @@ static struct workqueue_struct *hfi_updates_wq;
> > >  #define HFI_UPDATE_INTERVAL            HZ
> > >  #define HFI_MAX_THERM_NOTIFY_COUNT     16
> > >
> > > +#ifdef CONFIG_IPC_CLASSES
> >
> > It would be good to provide a (concise) description of this variable.
> >
> > > +static int __percpu *hfi_ipcc_scores;
>
> Do you mean hfi_ipcc_scores or CONFIG_IPC_CLASSES?

hfi_ipcc_scores (as the latter is not a variable).
