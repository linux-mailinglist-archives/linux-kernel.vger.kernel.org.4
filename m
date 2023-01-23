Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEEF678292
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjAWRH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjAWRHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:07:55 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3159744
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:07:53 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NAP6G4007057;
        Mon, 23 Jan 2023 11:07:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Bypk8m0B4ClrOqlNPEZdWHWuLQ2YgA0UrBqYq4ljdFs=;
 b=FRHblMtJ7yjNbdGP+/ItfSm78VVOtgAzYKziZhe8CJ5OJyobd2ZXUc8/GxY0AwRP6FnY
 HtaDkPJHd1/xtymk6XhL3dDCjsdcB+yAvNOhaFgX2QDafhq7alOv0REODueeAeSkE1Dh
 bws4GEVM4SqDSML3tvZOy8kYDUBNEOwhiL6peUjqNlNwzLHgvjO+k3FHNRBU+RDxhbQv
 YqePpzzy8GBvaLrnu5P9rA8WL0DM28y7SEOX25FXUg/c3wHUiFqwnguPRCdpDlfpqobR
 Pp9NUiIampq/FVIQJFdqgBHrYgbtu1pWaG6wki8ZH6L+NC7eGwG/ueYBCJtHvu63lkfa og== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3n8eb5ucr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 11:07:41 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Mon, 23 Jan
 2023 11:07:39 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.7 via Frontend Transport; Mon, 23 Jan 2023 11:07:39 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2477011CB;
        Mon, 23 Jan 2023 17:07:39 +0000 (UTC)
Date:   Mon, 23 Jan 2023 17:07:39 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <vkoul@kernel.org>,
        <sanyog.r.kale@intel.com>, <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 2/2] soundwire: bus: Allow SoundWire peripherals to
 register IRQ handlers
Message-ID: <20230123170739.GZ36097@ediswmail.ad.cirrus.com>
References: <20230119165104.3433290-1-ckeepax@opensource.cirrus.com>
 <20230119165104.3433290-2-ckeepax@opensource.cirrus.com>
 <c05a6791-96a7-2b10-d353-eb7b316aefc8@linux.intel.com>
 <20230120095941.GL36097@ediswmail.ad.cirrus.com>
 <881088ad-95d7-2462-20d2-72a6a9d3ba68@linux.intel.com>
 <20230123145353.GX36097@ediswmail.ad.cirrus.com>
 <034245f8-50b7-e801-7961-58c77dbc00b1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <034245f8-50b7-e801-7961-58c77dbc00b1@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 6yliXTqvAPLsr3X1LppXAYUUHQe5QsKw
X-Proofpoint-ORIG-GUID: 6yliXTqvAPLsr3X1LppXAYUUHQe5QsKw
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 09:50:15AM -0600, Pierre-Louis Bossart wrote:
> On 1/23/23 08:53, Charles Keepax wrote:
> > On Fri, Jan 20, 2023 at 10:20:50AM -0600, Pierre-Louis Bossart wrote:
> >> On 1/20/23 03:59, Charles Keepax wrote:
> >>> On Thu, Jan 19, 2023 at 11:12:04AM -0600, Pierre-Louis Bossart wrote:
> >>>> There should be an explanation and something checking that both are not
> >>>> used concurrently.
> >>>
> >>> I will try to expand the explanation a litte, but I dont see any
> >>> reason to block calling both handlers, no ill effects would come
> >>> for a driver having both and it is useful if any soundwire
> >>> specific steps are needed that arn't on other control buses.
> >>
> >> I think it's problematic if the peripheral tries to wake-up the manager
> >> from clock-stop with both an in-band wake (i.e. drive the data line
> >> high) and a separate GPIO-based interrupt. It's asking for trouble IMHO.
> >> We spent hours in the MIPI team to make sure there were no races between
> >> the manager-initiated restarts and peripheral-initiated restarts, adding
> >> a 3rd mechanism in the mix gives me a migraine already.
> > 
> > Apologies but I am struggling see why this has any bearing on
> > the case of a device that does both an in-band and out-of-band
> > wake. The code we are adding in this patch will only be called in the
> > in-band case. handle_nested_irq doesn't do any hardware magic or
> > schedule any threads, it just calls a function that was provided
> > when the client called request_threaded_irq. The only guarantee
> > of atomicity you have on the interrupt_callback is sdw_dev_lock
> > and that is being held across both calls after the patch.
> > 
> > Could you be a little more specific on what you mean by this
> > represents a 3rd mechanism, to me this isn't a new mechanism just
> > an extra callback? Say for example this patch added an
> > interrupt_callback_early to sdw_slave_ops that is called just
> > before interrupt_callback.
> 
> Well, the main concern is exiting the clock-stop. That is handled by the
> manager and could be done
> a) as the result of the framework deciding that something needs to be
> done (typically as a result of user/applications starting a stream)
> b) by the device with an in-band wake in case of e.g. jack detection or
> acoustic events detected
> c) same as b) but with a separate out-of-band interrupt.
> 
> I'd like to make sure b) and c) are mutually-exclusive options, and that
> the device will not throw BOTH an in-band wake and an external interrupt.

I think this is the bit I don't follow why does this patch have
anything to do with whether b) and c) are mutually-exclusive
options?

This patch lets you register an IRQ handler to the in-band IRQs,
it has nothing to do with whether you register an IRQ handler to
some out of band IRQ and there is nothing in the current
framework that will prevent someone doing that. Adding a
check that forces someone to choose between using
handle_nested_irq or interrupt_callback will also have no
bearing on whether they attach an IRQ handler to an out-of-band
IRQ.

Thanks,
Charles
