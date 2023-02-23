Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7926A0C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbjBWOnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbjBWOnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:43:00 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E937DAD08
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:42:58 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 205991FB;
        Thu, 23 Feb 2023 06:43:41 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25FA23F881;
        Thu, 23 Feb 2023 06:42:57 -0800 (PST)
Date:   Thu, 23 Feb 2023 14:42:54 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     ye.xingchen@zte.com.cn, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>, saravanak@google.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: remove duplicate include header
Message-ID: <20230223144254.c3gwkagdivo3c2u2@bogus>
References: <202302101520071730986@zte.com.cn>
 <Y+Yqhy3zWWOGQLSS@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+Yqhy3zWWOGQLSS@e120937-lin>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 11:29:11AM +0000, Cristian Marussi wrote:
> On Fri, Feb 10, 2023 at 03:20:07PM +0800, ye.xingchen@zte.com.cn wrote:
> > From: Ye Xingchen <ye.xingchen@zte.com.cn>
> > 
> > linux/of.h is included more than once.
> > 
> > Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> > ---
> >  drivers/firmware/arm_scmi/bus.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
> > index 73140b854b31..b2d242178fbc 100644
> > --- a/drivers/firmware/arm_scmi/bus.c
> > +++ b/drivers/firmware/arm_scmi/bus.c
> > @@ -14,7 +14,6 @@
> >  #include <linux/kernel.h>
> >  #include <linux/slab.h>
> >  #include <linux/device.h>
> > -#include <linux/of.h>
> > 
> 
> Hi Ye,
> 
> thanks for this.
> 
> Looking at next-20230210 it seem like the linux/of.h include that you
> removed was added by:
> 
> commit 96da4a99ce507bb98e2ba77018a2f91999c8c12b
> Author: Saravana Kannan <saravanak@google.com>
> Date:   Mon Feb 6 17:42:03 2023 -0800
> 
>     firmware: arm_scmi: Set fwnode for the scmi_device
> 
> ...AND indeed there was already a linux/of.h include added by a preceding
> commit by myself
> 
> commit d3cd7c525fd2ecce3a6c963f314969a54783d211
> Author: Cristian Marussi <cristian.marussi@arm.com>
> Date:   Thu Dec 22 18:50:45 2022 +0000
> 
>     firmware: arm_scmi: Refactor protocol device creation
> 
> ...BUT they both hit next- together so the clash.
> 
> My series is queued for the next merge window on soc/, not sure about the
> state of Saravana series, but if that series will be queued too for v6.3
> we'll need to pick up your fix indeed, Ye.
> 
> Probably better to wait and pick it up in v6.3-rc1 once the situation
> will be more clear as what is going in.
> 
> Up to Sudeep anyway the choice.
> 

Yes I will pick this up once we have the issue(i.e. both the above commit)
in the main upstream branch.

-- 
Regards,
Sudeep
