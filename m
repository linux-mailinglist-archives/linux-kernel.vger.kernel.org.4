Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A70A678664
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjAWTb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjAWTb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:31:57 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E57B771;
        Mon, 23 Jan 2023 11:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674502316; x=1706038316;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d0TymjITAt4p1WrJetdkWvEzktXVON3Q9fS07Rfw2Dw=;
  b=BgyzU9ubY6sLTsfSmRRowMLzTINdrQvJbq6Zwr0QgPw7pOo+YRaw8uxc
   qgFdzVKb3xZNi7mO6hBo3X3i3cErYx+MUzvTmn9VdMgSi/wWvsNUr+4GY
   3VyQhk/vwdBsDoM795+6IDbeCfWCE8o524qlP5HgsJLa9OfFuM+kyFcXm
   +W+Hf9niTJ3+eZCl3sWOKSIm+oMGo7QF+NoOFSoQAoDu4lTBB/ZsEVQYs
   hC0TMwPPN1/Hrcz84hafAJ3eIduQst6y7w6qgAJzZUzgvBm+a53u6nhMd
   aJQ8w1Ng4zy85Jpb776k6yshsp/Q8KU/IVbiEes1axZj3UGuFx7IU7Uo1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="328216791"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="328216791"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 11:31:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="750552130"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="750552130"
Received: from mhkirsch-mobl1.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.134.26])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 11:31:55 -0800
Message-ID: <cc1bc78192d2a73b29840a19cf89ea0625fb9aba.camel@linux.intel.com>
Subject: Re: [PATCH 2/3] thermal/drivers/intel: Use generic trip points for
 processor_thermal_device_pci
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>
Date:   Mon, 23 Jan 2023 11:31:54 -0800
In-Reply-To: <7b263423-11f8-d3e8-d040-e045dc2fb74c@linaro.org>
References: <20230118181622.33335-1-daniel.lezcano@linaro.org>
         <20230118181622.33335-2-daniel.lezcano@linaro.org>
         <e7ab0321e8c655836960295987f69c18d940ae52.camel@linux.intel.com>
         <7b263423-11f8-d3e8-d040-e045dc2fb74c@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Mon, 2023-01-23 at 19:02 +0100, Daniel Lezcano wrote:
> 
> Hi Srinivas,
> 
> 
> On 18/01/2023 20:09, srinivas pandruvada wrote:
> > On Wed, 2023-01-18 at 19:16 +0100, Daniel Lezcano wrote:
> > > The thermal framework gives the possibility to register the trip
> > > points with the thermal zone. When that is done, no get_trip_*
> > > ops
> > > are
> > > needed and they can be removed.
> > > 
> > > Convert ops content logic into generic trip points and register
> > > them
> > > with the
> > > thermal zone.
> > > 
> > In this scheme is the assumption is that trip point temperature
> > never
> > changes? If firmware updated the trip temperature, what needs to be
> > done?
> 
> I'm a bit confused about the situation where the firmware can change
> the 
> trip point in the back of the OSPM.
> 
> Does the firmware send a notification about the trip change? Or does
> it 
> assume the OSPM will be reading the trip point while
> monitoring/polling 
> the thermal zone ?
Firmware sends an ACPI notification. For example INT3403.

https://elixir.bootlin.com/linux/latest/C/ident/INT3403_PERF_TRIP_POINT_CHANGED


> 
> Is the question for this particular driver?
This PCH driver trips are not changed by firmware hence we don't have
to worry about here.

Thanks,
Srinivas

> 
> If the trip point is changed by the userspace (via sysfs), 
> thermal_zone_set_trip() is used which in turn changes the thermal
> trip 
> temperature directly in the generic structure and then calls the back
> set_trip_temp.
> 



