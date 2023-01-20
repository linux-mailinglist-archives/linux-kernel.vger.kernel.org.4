Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8BC6751EA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 11:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjATKAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 05:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjATKAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 05:00:36 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5468A6E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 02:00:35 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30K8gQRw007463;
        Fri, 20 Jan 2023 03:59:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=4ZhltC5XkT3xq+h4gV46Df660Zw9sjdJbXS/hZwDjXU=;
 b=pk5ouTUVz/GKGfecv0KNSJxn9PyEL8PmiWLPctWvNVHcqpgsiPbwA3EVQAQqqV0r18bv
 l0gp2j97Ba1hIJ69c4fxFo6iZxWsMym9Fq2PDUzcz+0NgkDOKWz+ybfKahQGRcJBGmFR
 mVHssy8qsZgLQfTatvYrD1txATN0ndZWLJBPyhV5LBycSZmqpVAmyd2IvI9O7IoLlVud
 qL/r5JfogtZrtKlZOBcG24ql7Hbjy1kNWqft+4qr4bmB1QUbPtfJUZiQIU0hXUhdVa79
 M9qWW937qOYnOVoi2fCA8ZGmQ87A9f+oojB6KbYy+a4rMPJQcD0hP4V6wt5EnshaFIjr dg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3n3spxav70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 03:59:49 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Fri, 20 Jan
 2023 03:59:41 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Fri, 20 Jan 2023 03:59:41 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6CD392C5;
        Fri, 20 Jan 2023 09:59:41 +0000 (UTC)
Date:   Fri, 20 Jan 2023 09:59:41 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 2/2] soundwire: bus: Allow SoundWire peripherals to
 register IRQ handlers
Message-ID: <20230120095941.GL36097@ediswmail.ad.cirrus.com>
References: <20230119165104.3433290-1-ckeepax@opensource.cirrus.com>
 <20230119165104.3433290-2-ckeepax@opensource.cirrus.com>
 <c05a6791-96a7-2b10-d353-eb7b316aefc8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c05a6791-96a7-2b10-d353-eb7b316aefc8@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: jVzS_Wxi9q3c2euPYcRb1QHHmuQ-Q92L
X-Proofpoint-ORIG-GUID: jVzS_Wxi9q3c2euPYcRb1QHHmuQ-Q92L
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 11:12:04AM -0600, Pierre-Louis Bossart wrote:
> No objection on this addition, just a couple of comments to improve it:
> 
> >  EXPORT_SYMBOL(sdw_bus_master_add);
> > @@ -158,6 +183,8 @@ static int sdw_delete_slave(struct device *dev, void *data)
> >  	mutex_lock(&bus->bus_lock);
> >  
> >  	if (slave->dev_num) { /* clear dev_num if assigned */
> > +		irq_dispose_mapping(irq_find_mapping(bus->domain, slave->dev_num));
> > +
> 
> could this be done conditionally. e.g.
> 
> if (slave->prop.irq)
>     irq_dispose_mapping(irq_find_mapping(bus->domain, slave->dev_num));
> 
> > +			slave->irq = irq_create_mapping(bus->domain, dev_num);
> > +			if (!slave->irq) {
> > +				dev_err(bus->dev, "Failed to map IRQ\n");
> > +				return -EINVAL;
> > +			}
> 
> ...and here....
> 
> if (slave->prop.irq) {
> 	slave->irq = irq_create_mapping(bus->domain, dev_num);
> 	if (!slave->irq) {
> 		dev_err(bus->dev, "Failed to map IRQ\n");
> 		return -EINVAL;
> 	}
> }
> 

Yeah I am happy to make those conditional, I guess it is cleaner
to not map IRQs if they wont be used.

> > @@ -369,6 +371,7 @@ struct sdw_dpn_prop {
> >   * @clock_reg_supported: the Peripheral implements the clock base and scale
> >   * registers introduced with the SoundWire 1.2 specification. SDCA devices
> >   * do not need to set this boolean property as the registers are required.
> > + * @irq: call actual IRQ handler on slave, as well as callback
> >   */
> >  struct sdw_slave_prop {
> >  	u32 mipi_revision;
> > @@ -393,6 +396,7 @@ struct sdw_slave_prop {
> >  	u8 scp_int1_mask;
> >  	u32 quirks;
> >  	bool clock_reg_supported;
> > +	bool irq;
> 
> this can be confused with the 'wake_capable' property.
> 
> maybe 'out_of_band_irq' ?
> 

Yes I struggle on the name a bit and then just gave up and
went with plain "irq", hard to know what to call it. Not sure
out_of_band is quite right since it not really out of band,
handle_nested_irq pretty much basically boils down to a function
call really. Maybe something like "map_irq", or "use_domain_irq"?

> There should be an explanation and something checking that both are not
> used concurrently.

I will try to expand the explanation a litte, but I dont see any
reason to block calling both handlers, no ill effects would come
for a driver having both and it is useful if any soundwire
specific steps are needed that arn't on other control buses.

Thanks,
Charles
