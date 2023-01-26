Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620A767C149
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjAZADH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjAZADG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:03:06 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6FE62D37;
        Wed, 25 Jan 2023 16:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674691380; x=1706227380;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GPaRQ79iFc5dVxB25ki374pEeK248SYwNjKLwiAk40o=;
  b=O3X3o3oN3lHdT4/iaxDsSEQ9aRUDSxuXt1h1nGvVlT2duYgHgzCfcGcT
   CXqIcMqSm5Gfr07HE5dbOe2kol/l+3FXZNg9okfzNS2W05jL34L7HRFXv
   O4PzuZCrrcdDz7ipo2K7bmAVh0JUgao9ECK5be19I+gWDlhqYAluwRcYa
   38B2cuYyVsEmXd5F4tFYOKFfq2WPI48b6KqmXZeFyRhNhGd1mrkPNuwmc
   G3pQiS/MgYzcF9+6ynYn3/K+vjooPcoEiOTaiEaTeQwPs4aIpA5keu386
   2AsZI6ZfDMiUY3UKsNek+JkFUtIzHRaigDjeiA90SNsECACwoyZScZn8j
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="310294419"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="310294419"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 16:02:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="640125719"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="640125719"
Received: from habushar-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.122.234])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 16:02:59 -0800
Message-ID: <10ad845597c47b8b7d1ba1aa9fe93825d249f56e.camel@linux.intel.com>
Subject: Re: [PATCH v1 0/3] thermal: intel: int340x: Use generic trip points
 table
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date:   Wed, 25 Jan 2023 16:02:59 -0800
In-Reply-To: <CAJZ5v0iVqGoVq1TVvYoQLxRWnP1nTPe7seeQvbVPancxH_6J1g@mail.gmail.com>
References: <5665899.DvuYhMxLoT@kreacher>
         <CAJZ5v0iVqGoVq1TVvYoQLxRWnP1nTPe7seeQvbVPancxH_6J1g@mail.gmail.com>
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

Hi Rafael,


On Wed, 2023-01-25 at 16:20 +0100, Rafael J. Wysocki wrote:
> Hi Srinivas,
> 
> On Wed, Jan 25, 2023 at 3:55 PM Rafael J. Wysocki <rjw@rjwysocki.net>
> wrote:
> > 
> > Hi All,
> > 
> > This series replaces the following patch:
> > 
> > https://patchwork.kernel.org/project/linux-pm/patch/2147918.irdbgypaU6@kreacher/
> > 
> > but it has been almost completely rewritten, so I've dropped all
> > tags from it.
> > 
> > 

[...]

> > The series is on top of this patch:
> > 
> > https://patchwork.kernel.org/project/linux-pm/patch/2688799.mvXUDI8C0e@kreacher/
> > 
> > which applies on top of the linux-next branch in linux-pm.git from
> > today.
> 
> There are two additional branches in linux-pm.git:
> 
> thermal-intel-fixes
On two systems test, no issues are observed.

> thermal-intel-testing
branch: thermal-intel-test

No issues, but number of trips are not same as invalid trips are not
registered.
Not sure if this is correct. At boot up they may be invalid, but
firmware may update later (Not aware of such scenario).

For example, the hot is not registered.

Current:

thermal_zone9/trip_point_0_type:critical
thermal_zone9/trip_point_0_temp:125050
thermal_zone9/trip_point_0_hyst:0

thermal_zone9/trip_point_1_type:hot
thermal_zone9/trip_point_1_temp:-273250
thermal_zone9/trip_point_1_hyst:0

thermal_zone9/trip_point_2_type:passive
thermal_zone9/trip_point_2_temp:103050
thermal_zone9/trip_point_2_hyst:0

thermal_zone9/trip_point_3_type:active
thermal_zone9/trip_point_3_temp:103050
thermal_zone9/trip_point_3_hyst:0

thermal_zone9/trip_point_4_type:active
thermal_zone9/trip_point_4_temp:101050
thermal_zone9/trip_point_4_hyst:0

thermal_zone9/trip_point_5_type:active
thermal_zone9/trip_point_5_temp:100050
thermal_zone9/trip_point_5_hyst:0


thermal_zone9/trip_point_6_type:active
thermal_zone9/trip_point_6_temp:98550
thermal_zone9/trip_point_6_hyst:0

thermal_zone9/trip_point_7_type:active
thermal_zone9/trip_point_7_temp:97050
thermal_zone9/trip_point_7_hyst:0


with 6.3-rc1 changes

thermal_zone9/trip_point_0_type:critical
thermal_zone9/trip_point_0_temp:125050
thermal_zone9/trip_point_0_hyst:0

thermal_zone9/trip_point_1_type:passive
thermal_zone9/trip_point_1_temp:103050
thermal_zone9/trip_point_1_hyst:0

thermal_zone9/trip_point_2_type:active
thermal_zone9/trip_point_2_temp:103050
thermal_zone9/trip_point_2_hyst:0

thermal_zone9/trip_point_3_type:active
thermal_zone9/trip_point_3_temp:101050
thermal_zone9/trip_point_3_hyst:0

thermal_zone9/trip_point_4_type:active
thermal_zone9/trip_point_4_temp:100050
thermal_zone9/trip_point_4_hyst:0

thermal_zone9/trip_point_5_type:active
thermal_zone9/trip_point_5_temp:98550
thermal_zone9/trip_point_5_hyst:0


thermal_zone9/trip_point_6_hyst:0
thermal_zone9/trip_point_6_temp:97050
thermal_zone9/trip_point_6_type:active

Thanks,
Srinivas


> 
> The former is just fixes to go on top of 6.2-rc5 and the latter -
> this
> series on top of those and the current thermal-intel branch I have
> locally with the Intel thermal drivers changes for 6.3.
> 
> I would appreciate giving each of them a go in your test setup.
> 
> Cheers!

