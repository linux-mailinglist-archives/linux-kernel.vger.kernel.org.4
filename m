Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9BB6F41F7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbjEBKqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjEBKqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:46:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABBAF193;
        Tue,  2 May 2023 03:46:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59A18C14;
        Tue,  2 May 2023 03:47:26 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E48603F64C;
        Tue,  2 May 2023 03:46:40 -0700 (PDT)
Date:   Tue, 2 May 2023 11:46:38 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Nikunj Kela <quic_nkela@quicinc.com>
Cc:     f.fainelli@gmail.com, cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] firmware: arm_scmi: Augment SMC/HVC to allow
 optional parameters
Message-ID: <20230502104638.kdncvotcuax2db3f@bogus>
References: <20230409181918.29270-1-quic_nkela@quicinc.com>
 <20230418185659.29745-1-quic_nkela@quicinc.com>
 <20230418185659.29745-3-quic_nkela@quicinc.com>
 <6f806e8a-1f12-5793-66eb-d7497839ad14@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f806e8a-1f12-5793-66eb-d7497839ad14@quicinc.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 07:39:29AM -0700, Nikunj Kela wrote:
> Reminder: Please review this patch! Thanks
>

Since the current merge window is open, there is no rush and hence I had put
this on hold until merge window close. Anyways, it looks good in general.
Couple of minor nits below:

> On 4/18/2023 11:56 AM, Nikunj Kela wrote:
> > This patch add support for passing shmem channel address as parameters
> > in smc/hvc call. The address is split into 4KB-page and offset.
> > This patch is useful when multiple scmi instances are using same smc-id
> > and firmware needs to distinguish among the instances.
> >

Drop the term "patch". You can refer it as change. It is not match after
it is applied to the git.

> > Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> > ---
> >   drivers/firmware/arm_scmi/driver.c |  1 +
> >   drivers/firmware/arm_scmi/smc.c    | 14 +++++++++++++-
> >   2 files changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index e7d97b59963b..b5957cc12fee 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -2914,6 +2914,7 @@ static const struct of_device_id scmi_of_match[] = {
> >   #endif
> >   #ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC
> >   	{ .compatible = "arm,scmi-smc", .data = &scmi_smc_desc},
> > +	{ .compatible = "arm,scmi-smc-param", .data = &scmi_smc_desc},
> >   #endif
> >   #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
> >   	{ .compatible = "arm,scmi-virtio", .data = &scmi_virtio_desc},
> > diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
> > index 93272e4bbd12..71e080b70df5 100644
> > --- a/drivers/firmware/arm_scmi/smc.c
> > +++ b/drivers/firmware/arm_scmi/smc.c
> > @@ -20,6 +20,11 @@
> >   #include "common.h"
> > +#define SHMEM_SHIFT 12
> > +#define SHMEM_SIZE (_AC(1, UL) << SHMEM_SHIFT)
> > +#define SHMEM_PAGE(x) ((unsigned long)((x) >> SHMEM_SHIFT))

Since we are dealing with 4kB pages only, I prefer to do:
#define SHMEM_SIZE     (SZ_4K)
#define SHMEM_SHIFT    12
#define SHMEM_PAGE(x) (_UL((x) >> SHMEM_SHIFT))

> > +#define SHMEM_OFFSET(x) ((x) & (SHMEM_SIZE - 1))
> > +

Also it is definitely worth adding comment about supporting just 4kB pages
and limitations associated with it here(e.g. we can support up to 44 bit
address) and also parameters to the SMC call so that others get clear
idea on how to use it if they need that in the future.

> >   /**
> >    * struct scmi_smc - Structure representing a SCMI smc transport
> >    *
> > @@ -30,6 +35,7 @@
> >    * @inflight: Atomic flag to protect access to Tx/Rx shared memory area.
> >    *	      Used when operating in atomic mode.
> >    * @func_id: smc/hvc call function id
> > + * @param: physical address of the shmem channel
> >    */
> >   struct scmi_smc {
> > @@ -40,6 +46,7 @@ struct scmi_smc {
> >   #define INFLIGHT_NONE	MSG_TOKEN_MAX
> >   	atomic_t inflight;
> >   	u32 func_id;
> > +	phys_addr_t param;
> >   };
> >   static irqreturn_t smc_msg_done_isr(int irq, void *data)
> > @@ -137,6 +144,8 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
> >   	if (ret < 0)
> >   		return ret;
> > +	if (of_device_is_compatible(dev->of_node, "arm,scmi-smc-param"))
> > +		scmi_info->param = res.start;
> >   	/*
> >   	 * If there is an interrupt named "a2p", then the service and
> >   	 * completion of a message is signaled by an interrupt rather than by
> > @@ -179,6 +188,8 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
> >   {
> >   	struct scmi_smc *scmi_info = cinfo->transport_info;
> >   	struct arm_smccc_res res;
> > +	unsigned long page = SHMEM_PAGE(scmi_info->param);
> > +	unsigned long offset = SHMEM_OFFSET(scmi_info->param);

While I see you initialise param in smc_chan_setup, I wonder why the page
and offset itself be initialised once and reused instead of computing the
same fixed value on every smc_send_message. You can probably have param_page
and param_offset stashed instead of just single param value ?

> >   	/*
> >   	 * Channel will be released only once response has been
> > @@ -188,7 +199,8 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
> >   	shmem_tx_prepare(scmi_info->shmem, xfer, cinfo);
> > -	arm_smccc_1_1_invoke(scmi_info->func_id, 0, 0, 0, 0, 0, 0, 0, &res);
> > +	arm_smccc_1_1_invoke(scmi_info->func_id, page, offset, 0, 0, 0, 0, 0,
> > +			     &res);
> >   	/* Only SMCCC_RET_NOT_SUPPORTED is valid error code */
> >   	if (res.a0) {

-- 
Regards,
Sudeep
