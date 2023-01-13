Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E149B669D01
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjAMP56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjAMP5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:57:32 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7032990E53;
        Fri, 13 Jan 2023 07:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673624940; x=1705160940;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T44IkxO1oGhpft8V3zmtoEVIR4F6V8En4z3hWLh6jrk=;
  b=css6Gh1CH4QRKlZaUjdQU1P+wUOBI0QupWCPFJAfj4G6NxgMTNURkV7F
   knTPHyuie0j4CIaI20L3IrOX3jvm1fhStvrnym4EuGFZoGNOTlZJs7iFW
   yiyq4Br66c4+XhzGMBJQKEDEnP3Ep/dz2+EkSt2Is0fevwLiK+EhIfxDj
   nMHiHahDwAywjEqYowkTFJZWlKtge97xsVqsZc3cFl7yBPcIJr8Pp+HNh
   z6LoMsca5YxsRy7oYCTkp2YNFAJbTHk9pbjUIzAgQYPjOG4PyMV7X46vL
   HFhe4SxXK8VlqRNJ8FznoLWvoitJU2tTeDPmsfSkDmVtcJ1cvEkRQfsbB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="303715310"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="303715310"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 07:49:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="746969933"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="746969933"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 07:48:59 -0800
Message-ID: <34f9fc91c398f85c0bedaff89adbb33897cb1f62.camel@linux.intel.com>
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
Date:   Fri, 13 Jan 2023 07:48:59 -0800
In-Reply-To: <ddcfbd2e-2ea0-9305-96c4-8127181cdd8c@linaro.org>
References: <20230110151745.2546131-1-daniel.lezcano@linaro.org>
         <20230110151745.2546131-4-daniel.lezcano@linaro.org>
         <4f461027be209156d6d9f26870748f204ff4184b.camel@intel.com>
         <ddcfbd2e-2ea0-9305-96c4-8127181cdd8c@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

> > > 

[...]

> > > -       status = acpi_evaluate_integer(d->adev->handle, "GTSH",
> > > NULL,
> > > &hyst);
> > > -       if (ACPI_FAILURE(status))
> > > -               *temp = 0;
> > > -       else
> > > -               *temp = hyst * 100;
> > 
> > The previous code returns hyst * 100.
> > But the new API retuurns hyst directly.
> > 
> > -/sys/class/thermal/thermal_zone2/trip_point_4_hyst:2000
> > +/sys/class/the
> > rmal/thermal_zone2/trip_point_4_hyst:20
> > 
> > Is this done on purpose?
> 
> No, it is an error. The function thermal_acpi_trip_gtsh() should do:
> 
>         return deci_kelvin_to_millicelsius(hyst);
> 
> 

GTSH returns here in tenths of degree Kelvin. For example 15 means 1.5
degree K.

I would like to test your next series with thermald. If there is a
problem, it will break every distro.

Thanks,
Srinivas


> 
> 


