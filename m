Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18736E5E1F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjDRJ73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjDRJ71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:59:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E51B38A58;
        Tue, 18 Apr 2023 02:58:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63CD0168F;
        Tue, 18 Apr 2023 02:59:33 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 742AE3F587;
        Tue, 18 Apr 2023 02:58:48 -0700 (PDT)
Date:   Tue, 18 Apr 2023 10:58:46 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Nikunj Kela <quic_nkela@quicinc.com>
Cc:     cristian.marussi@arm.com, Sudeep Holla <sudeep.holla@arm.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] firmware: arm_scmi: Augment SMC/HVC to allow
 optional parameter
Message-ID: <20230418095846.4lkncoa4beeih2hj@bogus>
References: <20230409181918.29270-1-quic_nkela@quicinc.com>
 <20230417174401.19563-1-quic_nkela@quicinc.com>
 <20230417174401.19563-3-quic_nkela@quicinc.com>
 <02b34c80-f37e-deee-29cd-de7db902797d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02b34c80-f37e-deee-29cd-de7db902797d@gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 11:01:13AM -0700, Florian Fainelli wrote:
> On 4/17/23 10:44, Nikunj Kela wrote:
> > This patch add support for passing shmem channel address as parameter
> > in smc/hvc call. This patch is useful when multiple scmi instances are
> > using same smc-id and firmware needs to distiguish among the instances.
> 
> Typo: distinguish.
> 
> It really would have been a lot clearer and made a whole lot more sense to
> encode a VM ID/channel number within some of the SMCCC parameters, possibly
> as part of the function ID itself.
>

Yes I was about to suggest this but then remembered one main reason I have
been given in the past against that:
If the system launches high number of VMs then that means loads of FID
needs to be reserved for SCMI and the hypervisor needs to support it.
Basically it is not scalable which I agree but not sure if such large
number of VMs are used in reality with SCMI. But I agree with the technical
reasoning.

The other reason why I preferred the shmem address itself instead of some
custom VM ID/channel number is that it can easily becomes vendor specific
for no real good reason and then we need to add support for each such
different parameters. Nikunj suggested getting them from DT which I really
don't like if the sole reason is just to identify the channel. We don't
have standard SCMI SMC/HVC but allowing such deviations with params from
DT will just explode with various combinations for silly/no reason.


[...]

> > @@ -137,6 +144,8 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
> >   	if (ret < 0)
> >   		return ret;
> > +	if (of_device_is_compatible(dev->of_node, "arm,scmi-smc-param"))
> > +		scmi_info->param = res.start;
>
> There is not even a check that this is going to be part of the kernel's view
> of memory, that seems a bit brittle and possibly a security hole, too. Your
> hypervisor presumably needs to have carved out some amount of memory in
> order for the messages to be written to/read from, and so would the VM
> kernel, so eventually we should have a 'reserved-memory' entry of some sort,
> no?
>

Not disagreeing here. Just checking if my understanding is correct or not.
IIUC, we need reserved-memory if it is part of the memory presented to the
OS right ? You don't need that if it is dedicated memory like part of SRAM
or something similar.

> >   	/*
> >   	 * If there is an interrupt named "a2p", then the service and
> >   	 * completion of a message is signaled by an interrupt rather than by
> > @@ -156,6 +165,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
> >   	}
> >   	scmi_info->func_id = func_id;
> > +	scmi_info->is_smc64 = ARM_SMCCC_IS_64(func_id);
> >   	scmi_info->cinfo = cinfo;
> >   	smc_channel_lock_init(scmi_info);
> >   	cinfo->transport_info = scmi_info;
> > @@ -188,7 +198,20 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
> >   	shmem_tx_prepare(scmi_info->shmem, xfer, cinfo);
> > -	arm_smccc_1_1_invoke(scmi_info->func_id, 0, 0, 0, 0, 0, 0, 0, &res);
> > +#ifdef CONFIG_ARM64
> > +	/*
> > +	 * if SMC32 convention is used, pass 64 bit address in
> > +	 * two parameters
> > +	 */
> > +	if (!scmi_info->is_smc64)
> 
> There is no need for scmi_info to store is_smc64, just check the func_id
> here and declare is_smc64 as a local variable to the function.
>

+1

> Also, another way to approach this would be to encode the parameters region
> in 4KB units such that event on a 32-bit system with LPAE you are guaranteed
> to fit the region into a 32-bit unsigned long. AFAIR virtualization and LPAE
> are indistinguishable on real CPUs?
>

Agree with the idea. But can a single 4kB be used for multiple shmem across
VMs ? IIUC the hypervisor can deal with that, so I prefer it if it is possible
practically.

--
Regards,
Sudeep
