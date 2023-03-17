Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0BD6BEAB7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjCQOI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCQOI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:08:26 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D9F12583
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:08:21 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HDk5Yo002807;
        Fri, 17 Mar 2023 09:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=H4ggXK1Md9Bl/gFWgbNqPW1hTdT0QlUPDN7cqK9juWI=;
 b=n4v5zv0M9zrOnUE26M00QfQkUPac50atub66LqY8vWDeKUV/g1T7AeLTAhYxDknJeLUA
 KQOrxH0wDJHF7Mx195dXT4pA+ePcOpABDqAPgbOOpT2GjrEMxXuCWYJK8mo8IbWbznk9
 JmSIzHOtGEx1Hq2yWfr7mcnKf4OBlp2D7DR2R3E+MW+L/OXOCaLfF3DUqsOFfHgoqwuQ
 dB9iWzhmTBHa79a44tgyJBCt1Gxspvpqs6yh+E+7yRrQBuuahSdy3T2QZreJUGXmXluA
 8/moZ0jWjO0hA8QxtoxpvqKSHWH2nShlu0/8QBOugTNd5MgjnO2f2IlMuquB+Rz7/eQU dw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pbs2ntj82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 09:08:08 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Fri, 17 Mar
 2023 09:08:07 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 17 Mar 2023 09:08:07 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3269711D3;
        Fri, 17 Mar 2023 14:08:07 +0000 (UTC)
Date:   Fri, 17 Mar 2023 14:08:07 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 2/2] soundwire: bus: Update sdw_nread/nwrite_no_pm to
 handle page boundaries
Message-ID: <20230317140807.GI68926@ediswmail.ad.cirrus.com>
References: <20230316155734.3191577-1-ckeepax@opensource.cirrus.com>
 <20230316155734.3191577-2-ckeepax@opensource.cirrus.com>
 <447cac77-4cc7-b2a3-23e7-978e1641a401@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <447cac77-4cc7-b2a3-23e7-978e1641a401@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: JMdtH2Aj5Hij6muQ-VxAE3SfVder22uf
X-Proofpoint-ORIG-GUID: JMdtH2Aj5Hij6muQ-VxAE3SfVder22uf
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 01:46:57PM -0500, Pierre-Louis Bossart wrote:
> 
> 
> On 3/16/23 10:57, Charles Keepax wrote:
> > Currently issuing a sdw_nread/nwrite_no_pm across a page boundary
> > will silently fail to write correctly as nothing updates the page
> > registers, meaning the same page of the chip will get rewritten
> > with each successive page of data.
> > 
> > As the sdw_msg structure contains page information it seems
> > reasonable that a single sdw_msg should always be within one
> > page. It is also mostly simpler to handle the paging at the
> > bus level rather than each master having to handle it in their
> > xfer_msg callback.
> > 
> > As such add handling to the bus code to split up a transfer into
> > multiple sdw_msg's when they go across page boundaries.
> 
> This sounds good but we need to clarify that the multiple sdw_msg's will
> not necessarily be sent one after the other, the msg_lock is held in the
> sdw_transfer() function, so there should be no expectation that e.g. one
> big chunk of firmware code can be sent without interruption.
> 

I will update the kdoc for nread/nwrite to specify that
transactions that cross a page boundry are not expected to be
atomic.

> I also wonder if we should have a lower bar than the page to avoid
> hogging the bus with large read/write transactions. If there are
> multiple devices on the same link and one of them signals an alert
> status while a large transfer is on-going, the alert handling will
> mechanically be delayed by up to a page - that's 32k reads/writes, isn't it?
> 

I think its 16k, but I would be inclined to say this is a
separate fix. The current code will tie up the bus for longer
than my fix does, since it only calls sdw_transfer once, and it
will write the wrong registers whilst doing it. Also to be clear
this wasn't found with super large transfers just medium sized
ones that happened to cross a page boundry.

If we want to add some transaction size capping that is really
a new feature, this patch a bug fix. I would also be inclined
to say if we are going to add transaction size capping, we
probably want some property to specify what we are capping to.

Thanks,
Charles

> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> >  drivers/soundwire/bus.c | 47 +++++++++++++++++++++++------------------
> >  1 file changed, 26 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> > index 3c67266f94834..bdd251e871694 100644
> > --- a/drivers/soundwire/bus.c
> > +++ b/drivers/soundwire/bus.c
> > @@ -386,37 +386,42 @@ int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
> >   * Read/Write IO functions.
> >   */
> >  
> > -int sdw_nread_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
> > +static int sdw_ntransfer_no_pm(struct sdw_slave *slave, u32 addr, u8 flags,
> > +			       size_t count, u8 *val)
> >  {
> >  	struct sdw_msg msg;
> > +	size_t size;
> >  	int ret;
> >  
> > -	ret = sdw_fill_msg(&msg, slave, addr, count,
> > -			   slave->dev_num, SDW_MSG_FLAG_READ, val);
> > -	if (ret < 0)
> > -		return ret;
> > +	while (count) {
> > +		// Only handle bytes up to next page boundary
> > +		size = min(count, (SDW_REGADDR + 1) - (addr & SDW_REGADDR));
> >  
> > -	ret = sdw_transfer(slave->bus, &msg);
> > -	if (slave->is_mockup_device)
> > -		ret = 0;
> > -	return ret;
> > +		ret = sdw_fill_msg(&msg, slave, addr, size, slave->dev_num, flags, val);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		ret = sdw_transfer(slave->bus, &msg);
> > +		if (ret < 0 && !slave->is_mockup_device)
> > +			return ret;
> > +
> > +		addr += size;
> > +		val += size;
> > +		count -= size;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +int sdw_nread_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
> > +{
> > +	return sdw_ntransfer_no_pm(slave, addr, SDW_MSG_FLAG_READ, count, val);
> >  }
> >  EXPORT_SYMBOL(sdw_nread_no_pm);
> >  
> >  int sdw_nwrite_no_pm(struct sdw_slave *slave, u32 addr, size_t count, const u8 *val)
> >  {
> > -	struct sdw_msg msg;
> > -	int ret;
> > -
> > -	ret = sdw_fill_msg(&msg, slave, addr, count,
> > -			   slave->dev_num, SDW_MSG_FLAG_WRITE, (u8 *)val);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	ret = sdw_transfer(slave->bus, &msg);
> > -	if (slave->is_mockup_device)
> > -		ret = 0;
> > -	return ret;
> > +	return sdw_ntransfer_no_pm(slave, addr, SDW_MSG_FLAG_WRITE, count, (u8 *)val);
> >  }
> >  EXPORT_SYMBOL(sdw_nwrite_no_pm);
> >  
