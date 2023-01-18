Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACC4672C38
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjARXEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjARXEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:04:47 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596183C2B;
        Wed, 18 Jan 2023 15:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674083086; x=1705619086;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LsOWRuvImwjjaHZSnCrTEoQrEF97YyyaWIH9zI+x4Rs=;
  b=YCwQ3v2azCe9y2EKbiTn2fVM5BKzvcMzAgtri9bMK7SDE38iQMVx2mlJ
   oKvzmESRw5KkvlB7FJ8aBq+6XK1t/k/Q4rYEJVlz5gqmjwG9tuEQ5bZgj
   h4SuEuDtqc8aqqDYxL6GO+SNzUsGTbi/5Hc3UsmJFKe+weIA2vZdZ2TcP
   pTs0xpiG6D+Q2Apt3CCOkM7O7fefF0aUeAwymSxue5cYSECMZS3ZcifSX
   KoH/l4lpYZQUt4ZpaGcv2uc7NlswRbKHeMuxsRO3Qxje26ysXe0cNwIAf
   f97XTxPUHA0hvd25sED7A3CgInU4nM1cGGBDJAHlHg1UanNW1BMI6EQPb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="308688174"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="308688174"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 15:04:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="748669327"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="748669327"
Received: from yzeleke-mobl1.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.16.158])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 15:04:45 -0800
Message-ID: <b51ecbb8ac774efc4fb4ac1349585b486303f86f.camel@linux.intel.com>
Subject: Re: [PATCH v5 0/3] Thermal ACPI APIs for generic trip points
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Date:   Wed, 18 Jan 2023 15:04:44 -0800
In-Reply-To: <d6f71181-1de4-7937-eda0-8805d9dfc3b4@linaro.org>
References: <20230113180235.1604526-1-daniel.lezcano@linaro.org>
         <f76c13de-d250-ebc0-d234-ccb3a9ce3c28@linaro.org>
         <2627c37e07dce6b125d3fea3bf38a5f2407ad6a1.camel@intel.com>
         <5aabdd3010a02e361fbbe01f4af0e30d11f0ae6b.camel@linux.intel.com>
         <c7abcce47df0aaa55f1e6c65f501bc691d35eae8.camel@linux.intel.com>
         <c210542f-0a71-15f2-c58f-ec607e60b06d@linaro.org>
         <8547963350fb3bdb09a4693f0eb80c7199ab6f21.camel@linux.intel.com>
         <87627e1f-322c-a195-8ce6-8922d9787ff0@linaro.org>
         <340f3ecdaddb2c422dcbe3df712a082f333eab0d.camel@linux.intel.com>
         <d6f71181-1de4-7937-eda0-8805d9dfc3b4@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-01-18 at 23:14 +0100, Daniel Lezcano wrote:
> On 18/01/2023 22:16, srinivas pandruvada wrote:
> > On Wed, 2023-01-18 at 22:01 +0100, Daniel Lezcano wrote:
> > > On 18/01/2023 21:53, srinivas pandruvada wrote:
> > > > On Wed, 2023-01-18 at 21:00 +0100, Daniel Lezcano wrote:
> > > > > On 18/01/2023 20:16, srinivas pandruvada wrote:
> > > > > 
> > > > > [ ... ]
> > > > > 
> > > > > > > > But we'd better wait for the thermald test result from
> > > > > > > > Srinvias.
> > > > > > > 
> > > > > > > A quick test show that things still work with thermald
> > > > > > > and
> > > > > > > these
> > > > > > > changes.
> > > > > > 
> > > > > > But I have a question. In some devices trip point
> > > > > > temperature
> > > > > > is
> > > > > > not
> > > > > > static. When hardware changes, we get notification. For
> > > > > > example
> > > > > > INT3403_PERF_TRIP_POINT_CHANGED for INT3403 drivers.
> > > > > > Currently get_trip can get the latest changed value. But if
> > > > > > we
> > > > > > preregister, we need some mechanism to update them.
> > > > > 
> > > > > When the notification INT3403_PERF_TRIP_POINT_CHANGED
> > > > > happens, we
> > > > > call
> > > > > int340x_thermal_read_trips() which in turn updates the trip
> > > > > points.
> > > > > 
> > > > 
> > > > Not sure how we handle concurrency here when driver can freely
> > > > update
> > > > trips while thermal core is using trips.
> > > 
> > > Don't we have the same race without this patch ? The thermal core
> > > can
> > > call get_trip_temp() while there is an update, no ?
> > Yes it is. But I can add a mutex locally here to solve.
> > But not any longer.
> > 
> > I think you need some thermal_zone_read_lock/unlock() in core,
> > which
> > can use rcu. Even mutex is fine as there will be no contention as
> > updates to trips will be rare.
> 
> I was planning to provide a thermal_trips_update(tz, trips) and from 
> there handle the locking.
> 
> As the race was already existing, can we postpone this change after
> the 
> generic trip points changes?
I think so.

> 
> There is still a lot of work to do to consolidate the code. One of
> them 
> is to provide a generic function to browse the trip points and ensure
> the code is using it instead of directly inspect the thermal zone 
> internals structure.
> 
> I'm almost there but I need the remaining Intel drivers changes to be
> merged (as well as ACPI which is finished but depending on this
> series).
> 
Sounds good.

You can add my tested by for this.

Thanks,
Srinivas

