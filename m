Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9192A6BEA32
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 14:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjCQNgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 09:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjCQNgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 09:36:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218AEC97C1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 06:36:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50CC5622A4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237CAC433EF;
        Fri, 17 Mar 2023 13:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679060200;
        bh=YgG7M48NvWPG+IFwKYlrFn+aDHqVaEcxa+91zb5zoFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S+O7dUCRCgL8N+k2Q7Dt5nePQ8LGHCHNdjxt9Mpn+l3tynShAX5zGFGm1wVcSkJ8S
         WAl2fjYnDcqDDc8rwGTj6EtIMhVgfwVf6HTOxtn33ycfnKnu5jvf+4BO7NfIq0b7JL
         41b8LCiCMzHNQdC+ZLm8jaBBJUjTaHUCGfGBRCXMiXhMEuAlQZdHUmsRe0YYTlET9z
         kOB/7wfj/3c1ZVpdxUwfGTqHSfLQcn+EHbNm391sSZ8SFhNWZ+oS7N9MEuZRj5mgQU
         x+A7lH3IoR1L96XkFdNP9AZ5RpK0RnK62CCV4diqjchhj04UbT6gDDan5RX+VwQHUx
         MKnv4FdVOTFWQ==
Date:   Fri, 17 Mar 2023 19:06:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, amadeuszx.slawinski@linux.intel.com,
        Mastan.Katragadda@amd.com, Arungopal.kondaveeti@amd.com,
        claudiu.beznea@microchip.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 5/8] soundwire: amd: add SoundWire manager interrupt
 handling
Message-ID: <ZBRs5LAXRQ2S1Htc@matsya>
References: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
 <20230307133135.545952-6-Vijendar.Mukunda@amd.com>
 <ZBGYubOYyu7E8ueo@matsya>
 <3aa704b0-1142-8afe-b0f1-28bd2a254cc2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aa704b0-1142-8afe-b0f1-28bd2a254cc2@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-03-23, 22:34, Mukunda,Vijendar wrote:
> On 15/03/23 15:36, Vinod Koul wrote:
> > On 07-03-23, 19:01, Vijendar Mukunda wrote:

> >> +static void amd_sdw_update_slave_status_work(struct work_struct *work)
> >> +{
> >> +	struct amd_sdw_manager *amd_manager =
> >> +		container_of(work, struct amd_sdw_manager, amd_sdw_work);
> >> +	int retry_count = 0;
> >> +
> >> +	if (amd_manager->status[0] == SDW_SLAVE_ATTACHED) {
> >> +		acp_reg_writel(0, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
> >> +		acp_reg_writel(0, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
> >> +	}
> >> +
> >> +update_status:
> >> +	sdw_handle_slave_status(&amd_manager->bus, amd_manager->status);
> >> +	/*
> >> +	 * During the peripheral enumeration sequence, the SoundWire manager interrupts
> >> +	 * are masked. Once the device number programming is done for all peripherals,
> >> +	 * interrupts will be unmasked. Read the peripheral device status from ping command
> >> +	 * and process the response. This sequence will ensure all peripheral devices enumerated
> >> +	 * and initialized properly.
> >> +	 */
> >> +	if (amd_manager->status[0] == SDW_SLAVE_ATTACHED) {
> >> +		if (retry_count++ < SDW_MAX_DEVICES) {
> >> +			acp_reg_writel(AMD_SDW_IRQ_MASK_0TO7, amd_manager->mmio +
> >> +				       ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
> >> +			acp_reg_writel(AMD_SDW_IRQ_MASK_8TO11,
> >> +				       amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
> >> +			amd_sdw_read_and_process_ping_status(amd_manager);
> >> +			goto update_status;
> > goto are mostly used for error handling, i dont thing case here deserves
> > a goto, can you please change this...
> I agree. goto statements will be used mostly for error handling.
> But this is a different scenario. We have used goto statement to call sdw_handle_slave_status()
> from if statement to make sure all peripheral devices are enumerated and initialized properly.
> Please let us know if you are expecting code to be modified as mentioned below.
> 
> sdw_handle_slave_status(&amd_manager->bus, amd_manager->status);
> 
> if (amd_manager->status[0] == SDW_SLAVE_ATTACHED) {
> 	acp_reg_writel(AMD_SDW_IRQ_MASK_0TO7, amd_manager->mmio +
> 		       ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
> 	acp_reg_writel(AMD_SDW_IRQ_MASK_8TO11,
> 		       amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
> 	amd_sdw_read_and_process_ping_status(amd_manager);
> 	sdw_handle_slave_status(&amd_manager->bus, amd_manager->status);
> }
> 
> We have to check any race conditions occurs or not if we implement code as mentioned
> above.

what race are you talking about

> IMHO, it is still good to go with goto statement implementation.

Since you keep checking, essentially this seems to be a loop?

-- 
~Vinod
