Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64651689FE2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbjBCRFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbjBCREy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:04:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5ABE31F914
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:04:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58449C14;
        Fri,  3 Feb 2023 09:05:34 -0800 (PST)
Received: from bogus (unknown [10.57.12.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC3EF3F71E;
        Fri,  3 Feb 2023 09:04:50 -0800 (PST)
Date:   Fri, 3 Feb 2023 17:04:48 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Etienne Carriere <etienne.carriere@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH 2/2] firmware: arm_scmi: optee: use optee system
 invocation
Message-ID: <20230203170448.v5iduw2rhpxc47f3@bogus>
References: <20230130094157.1082712-1-etienne.carriere@linaro.org>
 <20230130094157.1082712-2-etienne.carriere@linaro.org>
 <Y90b6kxAtbookjty@pluto>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y90b6kxAtbookjty@pluto>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 02:36:26PM +0000, Cristian Marussi wrote:
> On Mon, Jan 30, 2023 at 10:41:57AM +0100, Etienne Carriere wrote:
> > Changes SCMI optee transport to enable sys_service capability of
> > its tee context to leverage provisioned system resources in OP-TEE
> > preventing possible deadlock.
> > 
> > Such deadlock could happen when many Linux clients invoke OP-TEE are
> > are all suspended waiting for an OP-TEE RPC request access an SCMI
> > resource through the SCMI OP-TEE PTA service.
> > 
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > ---
> >  drivers/firmware/arm_scmi/optee.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
> > index 2a7aeab40e54..91840345e946 100644
> > --- a/drivers/firmware/arm_scmi/optee.c
> > +++ b/drivers/firmware/arm_scmi/optee.c
> > @@ -559,6 +559,9 @@ static int scmi_optee_service_probe(struct device *dev)
> >  	if (IS_ERR(tee_ctx))
> >  		return -ENODEV;
> >  
> > +	/* SCMI agent can used TEE system service resources */
> > +	tee_ctx->sys_service = true;
> > +
> >  	agent = devm_kzalloc(dev, sizeof(*agent), GFP_KERNEL);
> >  	if (!agent) {
> >  		ret = -ENOMEM;
> 
> LGTM.
> 
> I suppose you'll sync-up with Sudeep for how to queue this whole series.
> 

I thought I had responded to this but not. Anyways since TEE changes are
significant than SCMI, you can route it via TEE tree. In that case,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Let me know if that was not your plan.

-- 
Regards,
Sudeep
