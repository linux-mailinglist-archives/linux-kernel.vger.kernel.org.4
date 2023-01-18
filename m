Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCE66729C2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjARUxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjARUxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:53:34 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8DEA5D4;
        Wed, 18 Jan 2023 12:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674075212; x=1705611212;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l4SONC/Qdtv6CckCiaxSv423aZE7tdp+t6/ZdNoJapo=;
  b=GdcZDIyrHIzwKmZzHuGzNLSz5h/MzRFceBhRsTs2D0uB9cigKeqrBMKq
   ng1jlo/Pp7VKnwaCAxefgPGUpkgk94xAQv8V3B26uVAeMTYmcLy5bn2mj
   jGYlJc5nSBPu9RLt2e7Z6E73mMgU2UDw4Hu9TraUWL7wAbOCRQAYJaj5q
   Zlp3j0AoBkFeRmPnVv/pgw8KJyDVYcms3yVDB4PpLb5c/AYQQUZn3zmP9
   2kbixE/x2ng0CThwdZNDd5k9G9GzEGFmMu2Yx08N0JTjkqzRKZCOvbe9C
   FfKXA/XhmmLdFCEmS9VejKW0ajBSMzt3Zlp2gLCNIVNT7yNvus/++P0Fy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="325149644"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="325149644"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 12:53:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="637432730"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="637432730"
Received: from yzeleke-mobl1.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.16.158])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 12:53:30 -0800
Message-ID: <8547963350fb3bdb09a4693f0eb80c7199ab6f21.camel@linux.intel.com>
Subject: Re: [PATCH v5 0/3] Thermal ACPI APIs for generic trip points
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Date:   Wed, 18 Jan 2023 12:53:31 -0800
In-Reply-To: <c210542f-0a71-15f2-c58f-ec607e60b06d@linaro.org>
References: <20230113180235.1604526-1-daniel.lezcano@linaro.org>
         <f76c13de-d250-ebc0-d234-ccb3a9ce3c28@linaro.org>
         <2627c37e07dce6b125d3fea3bf38a5f2407ad6a1.camel@intel.com>
         <5aabdd3010a02e361fbbe01f4af0e30d11f0ae6b.camel@linux.intel.com>
         <c7abcce47df0aaa55f1e6c65f501bc691d35eae8.camel@linux.intel.com>
         <c210542f-0a71-15f2-c58f-ec607e60b06d@linaro.org>
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

On Wed, 2023-01-18 at 21:00 +0100, Daniel Lezcano wrote:
> On 18/01/2023 20:16, srinivas pandruvada wrote:
> 
> [ ... ]
> 
> > > > But we'd better wait for the thermald test result from
> > > > Srinvias.
> > > 
> > > A quick test show that things still work with thermald and these
> > > changes.
> > 
> > But I have a question. In some devices trip point temperature is
> > not
> > static. When hardware changes, we get notification. For example
> > INT3403_PERF_TRIP_POINT_CHANGED for INT3403 drivers.
> > Currently get_trip can get the latest changed value. But if we
> > preregister, we need some mechanism to update them.
> 
> When the notification INT3403_PERF_TRIP_POINT_CHANGED happens, we
> call 
> int340x_thermal_read_trips() which in turn updates the trip points.
> 

Not sure how we handle concurrency here when driver can freely update
trips while thermal core is using trips.


Thanks,
Srinivas



> 
> 

