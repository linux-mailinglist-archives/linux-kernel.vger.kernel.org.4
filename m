Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B643738A0C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbjFUPpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjFUPpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:45:36 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE8691;
        Wed, 21 Jun 2023 08:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687362334; x=1718898334;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fShmEjl8Wh4baxLKMYHpBk3MTQgN6MNwn0v6pEROKsg=;
  b=koFfURn08Rt6aECoS9uF0FYElM8830jbBfaxeIxKaWrndfA0y63/SA8Y
   YYVVvhCkyI6iBDiccGsnJ+yM51u8cC65Fq6zkiKpYAtMcBMS4cN2ojdHB
   aA/LRN2Vwrgpx0bKL17Rp4MsmGsHNpkRGTQ2GQ5ldhkvR+mdxBA2xYu4E
   y6mDIkeT8I5K+p+gk+A5372GEhxeoDhYPD7gZ+9ZIopk16oqHZtAA+1rv
   0AGcQq9Ef+lJpspv2eaQqvCHGxAUq6aQkKvSY8E3i92qmeZKn1bf8Gfxm
   A0wYDIqb62qZxQB4+6HzDaoxWzC9sEwZ1Y1uLjEQktfHrZoI2v0cCxSil
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="423876538"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="423876538"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 08:45:10 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="748744954"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="748744954"
Received: from lfrecald-mobl2.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.26.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 08:45:10 -0700
Message-ID: <13fbb134dda72f979b9a02e6abec12ebac18aef8.camel@linux.intel.com>
Subject: Re: [PATCH 0/7] thermal: processor_thermal: Suport workload hint
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 21 Jun 2023 08:45:10 -0700
In-Reply-To: <CAJZ5v0jGp_Rsu6S+znmrKhQ+y88Mqf9PLf66Ec-SffdFdyH_4g@mail.gmail.com>
References: <20230620230150.3068704-1-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0jGp_Rsu6S+znmrKhQ+y88Mqf9PLf66Ec-SffdFdyH_4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-06-21 at 16:58 +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 21, 2023 at 1:01 AM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > Add support for Meteor Lake workload hints. Before adding this
> > support,
> > some reorganization and clean up is required.
> > First four changes are for clean up and to reorganize code to add
> > support for workload hint. The last patch adds a test program as
> > part
> > of self tests.
> > 
> > Srinivas Pandruvada (7):
> >   thermal: int340x: processor_thermal: Move mailbox code to common
> >     module
> >   thermal: int340x: processor_thermal: Add interrupt configuration
> >   thermal: int340x: processor_thermal: Use non MSI interrupts
> >   thermal/drivers/int340x: Remove PROC_THERMAL_FEATURE_WLT_REQ for
> >     Meteor Lake
> >   thermal: int340x: processor_thermal: Add workload type hint
> >   thermal/drivers/int340x: Support workload hint interrupts
> >   selftests/thermel/intel: Add test to read workload hint
> > 
> >  .../driver-api/thermal/intel_dptf.rst         |  38 +++
> >  .../thermal/intel/int340x_thermal/Makefile    |   2 +
> >  .../processor_thermal_device.c                |  17 +-
> >  .../processor_thermal_device.h                |  21 +-
> >  .../processor_thermal_device_pci.c            |  76 ++++--
> >  .../processor_thermal_device_pci_legacy.c     |   3 +-
> >  .../int340x_thermal/processor_thermal_mbox.c  | 179 ++++---------
> >  .../processor_thermal_wlt_hint.c              | 239
> > ++++++++++++++++++
> >  .../processor_thermal_wlt_req.c               | 137 ++++++++++
> >  .../testing/selftests/thermal/intel/Makefile  |  16 ++
> >  .../thermal/intel/workload_hint_test.c        | 114 +++++++++
> >  11 files changed, 680 insertions(+), 162 deletions(-)
> >  create mode 100644
> > drivers/thermal/intel/int340x_thermal/processor_thermal_wlt_hint.c
> >  create mode 100644
> > drivers/thermal/intel/int340x_thermal/processor_thermal_wlt_req.c
> >  create mode 100644 tools/testing/selftests/thermal/intel/Makefile
> >  create mode 100644
> > tools/testing/selftests/thermal/intel/workload_hint_test.c
> > 
> > --
> 
> Because of the timing of the first posting, I'm going to treat this
> series as 6.6 material.
That is fine. Just review is important, so that it can be back ported
to Chrome kernel.

Thanks,
Srinivas

