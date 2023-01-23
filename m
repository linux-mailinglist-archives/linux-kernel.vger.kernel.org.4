Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4D1677E74
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 15:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjAWOyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 09:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjAWOyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:54:11 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4069745
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 06:54:10 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NAP68i007057;
        Mon, 23 Jan 2023 08:53:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Bx/RMP4XHYqKD8cltwOGavnKoMUm1WeokLMyFEzYkts=;
 b=EnwT3GLekMNE27UUzOrp6DZ2Vjkhi2ZvEpJrI9kkuTY9t8lcMaW6n7KMirCNhT8rjbpR
 UrBiCugy0hOKDvF/Gbl1/ktSCJsBQDPZJaedO7O9ozJu4Hz74zyUCAwav2M1ijubMLur
 PiTj+JB8y8JspEY8MtXDVjGPGibxfvlHw8NLAYk79omkcAo7eL9xhryRneEFdExZ2OmZ
 ykK5dsqNhLOlZO4jUega2QNfmQwkewBf4GQf/+rSYs1OBMD1iKYC6/lJsxjViG89/HRS
 GrDqGIkK7oxchyKAm2Orcx5Di/XU5F6cfAaeaTJkSayFTb8w1YiA+4G4ysiK0iIENIFF LQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3n8eb5u624-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 08:53:55 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Mon, 23 Jan
 2023 08:53:53 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.7 via Frontend Transport; Mon, 23 Jan 2023 08:53:53 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1BD48B06;
        Mon, 23 Jan 2023 14:53:53 +0000 (UTC)
Date:   Mon, 23 Jan 2023 14:53:53 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 2/2] soundwire: bus: Allow SoundWire peripherals to
 register IRQ handlers
Message-ID: <20230123145353.GX36097@ediswmail.ad.cirrus.com>
References: <20230119165104.3433290-1-ckeepax@opensource.cirrus.com>
 <20230119165104.3433290-2-ckeepax@opensource.cirrus.com>
 <c05a6791-96a7-2b10-d353-eb7b316aefc8@linux.intel.com>
 <20230120095941.GL36097@ediswmail.ad.cirrus.com>
 <881088ad-95d7-2462-20d2-72a6a9d3ba68@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <881088ad-95d7-2462-20d2-72a6a9d3ba68@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 3UlUz6r3RxxsCUMhUMY3bY03itKLaihM
X-Proofpoint-ORIG-GUID: 3UlUz6r3RxxsCUMhUMY3bY03itKLaihM
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 10:20:50AM -0600, Pierre-Louis Bossart wrote:
> On 1/20/23 03:59, Charles Keepax wrote:
> > On Thu, Jan 19, 2023 at 11:12:04AM -0600, Pierre-Louis Bossart wrote:
> >> There should be an explanation and something checking that both are not
> >> used concurrently.
> > 
> > I will try to expand the explanation a litte, but I dont see any
> > reason to block calling both handlers, no ill effects would come
> > for a driver having both and it is useful if any soundwire
> > specific steps are needed that arn't on other control buses.
> 
> I think it's problematic if the peripheral tries to wake-up the manager
> from clock-stop with both an in-band wake (i.e. drive the data line
> high) and a separate GPIO-based interrupt. It's asking for trouble IMHO.
> We spent hours in the MIPI team to make sure there were no races between
> the manager-initiated restarts and peripheral-initiated restarts, adding
> a 3rd mechanism in the mix gives me a migraine already.

Apologies but I am struggling see why this has any bearing on
the case of a device that does both an in-band and out-of-band
wake. The code we are adding in this patch will only be called in the
in-band case. handle_nested_irq doesn't do any hardware magic or
schedule any threads, it just calls a function that was provided
when the client called request_threaded_irq. The only guarantee
of atomicity you have on the interrupt_callback is sdw_dev_lock
and that is being held across both calls after the patch.

Could you be a little more specific on what you mean by this
represents a 3rd mechanism, to me this isn't a new mechanism just
an extra callback? Say for example this patch added an
interrupt_callback_early to sdw_slave_ops that is called just
before interrupt_callback.

@@ -1681,6 +1681,9 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
                                struct device *dev = &slave->dev;
                                struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
 
+                         if (drv->ops && drv->ops->interrupt_callback_early)
+                                 drv->ops->interrupt_callback_early(slave);
+
                                if (drv->ops && drv->ops->interrupt_callback) {
                                        slave_intr.sdca_cascade = sdca_cascade;
                                        slave_intr.control_port = clear;

Would that similarly worry you? As in is it the client driver
writer dealing with 2 points of entry that worries you, or
something deeper relating to the IRQs?

Also if it helps I could go over in a little more detail how
the IRQs on our device works and why that means I would prefer
to have the option to use both. There are alternatives but they
arn't really as pretty.

Thanks,
Charles
