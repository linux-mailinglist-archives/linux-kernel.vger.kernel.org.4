Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1808675228
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 11:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjATKOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 05:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjATKO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 05:14:28 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA44E8B745
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 02:14:27 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30K6qOGL008272;
        Fri, 20 Jan 2023 04:14:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=VXW3ZdRjVyLCVgNDVjCBOGupQRcOb3zZOC0nzluO1XA=;
 b=FKhDZqtDlxWXSy+xQI0Oa4l9wqnu2A5cNZUfxdDtWSyFUYhP3i/hlb+KqHVW+0MljeQx
 FRpTcB4nxK+z4wK7oHNs+bb3vH63DAN54ZWURtlFyEkJgn15vWwDGhE027roIjXzzaT+
 Z9Ck6ZRelXwzEpKLShJ1K31YvTy/4Wb3IF9qNGa3R+MYKDxbHf6JONHqVQSyLrPdXqYl
 fOcStvKfnWZfgxxzHJK4v7jnaB/ULReZDOEPmuO4M6mtYo2VIARHtey1UWnqpVHl4OA6
 lq4OZjhpu4lUUNQ8zVE4LHObQp0mgnXmPO+NjiowQISFC0GaWBqP+6kjHu4HaxeusKhw RQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3n3spxavrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 04:14:17 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Fri, 20 Jan
 2023 04:14:15 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Fri, 20 Jan 2023 04:14:15 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 97EC62A1;
        Fri, 20 Jan 2023 10:14:15 +0000 (UTC)
Date:   Fri, 20 Jan 2023 10:14:15 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <vkoul@kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <sanyog.r.kale@intel.com>, <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 1/2] soundwire: bus: Don't filter slave alerts
Message-ID: <20230120101415.GM36097@ediswmail.ad.cirrus.com>
References: <20230119165104.3433290-1-ckeepax@opensource.cirrus.com>
 <db571218-1adb-cb46-5b76-55eaf379f6ca@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <db571218-1adb-cb46-5b76-55eaf379f6ca@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: HGkg0QzR8W8uqHb_mYHONSGI1lZLqLon
X-Proofpoint-ORIG-GUID: HGkg0QzR8W8uqHb_mYHONSGI1lZLqLon
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 11:27:14AM -0600, Pierre-Louis Bossart wrote:
> On 1/19/23 10:51, Charles Keepax wrote:
> > Currently the SoundWire core will loop handling slave alerts but it will
> > only handle those present when the alert was first raised. This causes
> > some issues with the Cadence SoundWire IP, which only generates an IRQ
> > when alert changes state. This means that if a new alert arrives whilst
> > old alerts are being handled it will not be handled in the currently
> > loop and then no further alerts will be processed since alert never
> > changes state to trigger a new IRQ.
> > 
> > Correct this issue by allowing the core to handle all pending alerts in
> > the IRQ handling loop. The code will still only loop up to
> > SDW_READ_INTR_CLEAR_RETRY times, so it shouldn't be possible for it get
> > completely stuck and if you are generating IRQs faster than you can
> > handle them you likely have bigger problems anyway.
> 
> The change makes sense, but it's a bit odd to change the way the
> interrupts are handled because of a specific design. The bus should be
> able to deal with various designs, not force a one-size-fits-all policy
> that may not be quite right in all cases.
> 
> Could we have a new flag at the bus level that says that peripheral
> interrupts are not filtered, and set if for the Intel case?
> 
> We could similarly make the SDW_READ_INTR_CLEAR_RETRY constant
> bus/platform specific. The SoundWire spec mandates that we re-read the
> status after clearing the interrupt, but it doesn't say how to deal with
> recurring interrupts.

Perhaps I should have phrased the commit message differently
here. To be honest I am not really convince the old code makes
a huge amount of sense. So I would prefer not to add a flag
enabling the weird behaviour.

I would be of the opinion that there are really two options
for IRQ handling code like this that make sense:

1) Loop until the IRQs are handled, ie. it is the soundwire
core's responsibility to make sure all the IRQs are handled
before moving on.

2) Just handle the IRQs available when the function is called,
ie. it is the drivers responsibility to keep calling the core
until the IRQs are handled.

That way there is a clearly defined who that is responsible.
The old code is a weird mix of the two where most of the time
it is the soundwire core's responsibly to handle recurring
IRQs unless a new one happens in which case it is the drivers
responsibilty to recall the core.

Also the new code will still work for drivers that have level
IRQs and recall the core, without any modification of those
drivers. So I don't see what anyone would be gaining from the
old system.

Regarding making the clear retries platform specific that makes
sense to me but is clearly a separate patch. I will add it onto
my soundwire todo list.

Thanks,
Charles

> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> >  drivers/soundwire/bus.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> > index 633d411b64f35..daee2cca94a4d 100644
> > --- a/drivers/soundwire/bus.c
> > +++ b/drivers/soundwire/bus.c
> > @@ -1560,7 +1560,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
> >  	unsigned long port;
> >  	bool slave_notify;
> >  	u8 sdca_cascade = 0;
> > -	u8 buf, buf2[2], _buf, _buf2[2];
> > +	u8 buf, buf2[2];
> >  	bool parity_check;
> >  	bool parity_quirk;
> >  
> > @@ -1716,9 +1716,9 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
> >  				"SDW_SCP_INT1 recheck read failed:%d\n", ret);
> >  			goto io_err;
> >  		}
> > -		_buf = ret;
> > +		buf = ret;
> >  
> > -		ret = sdw_nread_no_pm(slave, SDW_SCP_INTSTAT2, 2, _buf2);
> > +		ret = sdw_nread_no_pm(slave, SDW_SCP_INTSTAT2, 2, buf2);
> >  		if (ret < 0) {
> >  			dev_err(&slave->dev,
> >  				"SDW_SCP_INT2/3 recheck read failed:%d\n", ret);
> > @@ -1736,12 +1736,8 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
> >  		}
> >  
> >  		/*
> > -		 * Make sure no interrupts are pending, but filter to limit loop
> > -		 * to interrupts identified in the first status read
> > +		 * Make sure no interrupts are pending
> >  		 */
> > -		buf &= _buf;
> > -		buf2[0] &= _buf2[0];
> > -		buf2[1] &= _buf2[1];
> >  		stat = buf || buf2[0] || buf2[1] || sdca_cascade;
> >  
> >  		/*
