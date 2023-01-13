Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C508266A108
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjAMRql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjAMRpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:45:55 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545B488DE8;
        Fri, 13 Jan 2023 09:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673631251; x=1705167251;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/mLCpdcyLaa16plox8m52Uh9afCDS916L+EggEDx7yA=;
  b=TzgKGfsCcbAbr7z2pEp4ACatwWfmjJnTRlfSzz693hkMjOc5WXYrUSAF
   qa264ntCglpbGn2aDHfKc+ZjODkUcbtTP81LGjc6eQ4ObfdJlTMNxatCz
   HMd+mUwvR+ue6HLZtVIXZjLnzUu2XH6hsUW3kW5Pm7Zy25ogYLMsQUSEt
   d2QvLqFv7OBsRn1fTQCfgvH0BG5qSDK4OT5RRbLyqTupHclW6mo0JaDD8
   /OYYzcTYPnO9Z/36cHpKLrpJ0SzsMskkeXkr83C5qpeoW4UO8S9o6Bux1
   Flzj1tpjvlUaNsedLfV+w0/12Cdw+bi/3D4vI//QSc8cGdfDkJzPZkSZL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="324108970"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="324108970"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 09:34:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="721599716"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="721599716"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 09:34:10 -0800
Message-ID: <6a5ea6ac492d354479f5d340c16588f2f4b3d7c0.camel@linux.intel.com>
Subject: Re: [PATCH 3/3] thermal/drivers/intel: Use generic trip points
 int340x
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "daniel.lezcano@kernel.org" <daniel.lezcano@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>
Date:   Fri, 13 Jan 2023 09:34:09 -0800
In-Reply-To: <35b6549e-a722-4667-c471-907d91d424ce@linaro.org>
References: <20230110151745.2546131-1-daniel.lezcano@linaro.org>
         <20230110151745.2546131-4-daniel.lezcano@linaro.org>
         <4f461027be209156d6d9f26870748f204ff4184b.camel@intel.com>
         <ddcfbd2e-2ea0-9305-96c4-8127181cdd8c@linaro.org>
         <34f9fc91c398f85c0bedaff89adbb33897cb1f62.camel@linux.intel.com>
         <35b6549e-a722-4667-c471-907d91d424ce@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
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

On Fri, 2023-01-13 at 18:21 +0100, Daniel Lezcano wrote:
> 
> Hi Srinivas,
> 
> On 13/01/2023 16:48, srinivas pandruvada wrote:
> > Hi Daniel,
> > 
> > > > > 
> > 
> > [...]
> > 
> > > > > -       status = acpi_evaluate_integer(d->adev->handle,
> > > > > "GTSH",
> > > > > NULL,
> > > > > &hyst);
> > > > > -       if (ACPI_FAILURE(status))
> > > > > -               *temp = 0;
> > > > > -       else
> > > > > -               *temp = hyst * 100;
> > > > 
> > > > The previous code returns hyst * 100.
> > > > But the new API retuurns hyst directly.
> > > > 
> > > > -/sys/class/thermal/thermal_zone2/trip_point_4_hyst:2000
> > > > +/sys/class/the
> > > > rmal/thermal_zone2/trip_point_4_hyst:20
> > > > 
> > > > Is this done on purpose?
> > > 
> > > No, it is an error. The function thermal_acpi_trip_gtsh() should
> > > do:
> > > 
> > >          return deci_kelvin_to_millicelsius(hyst);
> > > 
> > > 
> > 
> > GTSH returns here in tenths of degree Kelvin. For example 15 means
> > 1.5
> > degree K.
> 
> Yes, so the above conversion is correct, right ?
Correct.

Thanks,
Srinivas

> 
> > I would like to test your next series with thermald. If there is a
> > problem, it will break every distro.
> 
> Great, thanks!
> 
> 


