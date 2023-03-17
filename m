Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2922B6BEA21
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 14:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjCQNed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 09:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjCQNeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 09:34:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6742A6F6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 06:34:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B562FB8255C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:34:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F1EC4339B;
        Fri, 17 Mar 2023 13:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679060067;
        bh=acAFgWVAW9Z16jtQyDLytLmE2NTyzAFRY8egGYSBlpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=henuGGhglknoZ8qup/Rt9WTxF4ivkJWfsz2ImqjDbnJ92C2CgIQGjZrIUn/WKo4QI
         DhZwVK+o0WyqaQ3i2G9eHS4dcAX7rbb8rk4XpomxiFyFAt8mB1OJ+HJgW2QgpFNTjx
         hZoKtVrDEcpsH8BVSowgifyWvH/SHT+fc6slkV1EoWee56IQjCTQg8OXsAmev7VdNK
         faESzw0kkHGJRbAHsFB9xpX5MxYVRdd1I3SdmUgH5GRtihWE+4O/KOv8l2tg33fz4r
         +tGwJyEAwbpvxrjy3XyajTq9a6V9I4lFMX5gwzTofV8RKDNEltIF0LNG9nKr86Zexp
         BYTI3SBRfNRDw==
Date:   Fri, 17 Mar 2023 19:04:23 +0530
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
Subject: Re: [PATCH V6 2/8] soundwire: amd: Add support for AMD Manager driver
Message-ID: <ZBRsX7W4l1HyT44y@matsya>
References: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
 <20230307133135.545952-3-Vijendar.Mukunda@amd.com>
 <ZBGTDXJvVjVuUkiZ@matsya>
 <7a7f5d93-d6ec-5ad1-9927-7ac4b6d9a643@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a7f5d93-d6ec-5ad1-9927-7ac4b6d9a643@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-03-23, 19:28, Mukunda,Vijendar wrote:
> On 15/03/23 15:12, Vinod Koul wrote:
> > On 07-03-23, 19:01, Vijendar Mukunda wrote:

> >> +/**
> >> + * struct amd_sdw_manager - amd manager driver context
> >> + * @bus: bus handle
> >> + * @dev: linux device
> >> + * @mmio: SoundWire registers mmio base
> >> + * @acp_mmio: acp registers mmio base
> >> + * @reg_mask: register mask structure per manager instance
> >> + * @probe_work: SoundWire manager probe workqueue
> >> + * @acp_sdw_lock: mutex to protect acp share register access
> >> + * @num_din_ports: number of input ports
> >> + * @num_dout_ports: number of output ports
> >> + * @cols_index: Column index in frame shape
> >> + * @rows_index: Rows index in frame shape
> >> + * @instance: SoundWire manager instance
> >> + * @quirks: SoundWire manager quirks
> >> + * @wake_en_mask: wake enable mask per SoundWire manager
> >> + * @power_mode_mask: flag interprets amd SoundWire manager power mode
> >> + */
> >> +struct amd_sdw_manager {
> >> +	struct sdw_bus bus;
> >> +	struct device *dev;
> >> +
> >> +	void __iomem *mmio;
> >> +	void __iomem *acp_mmio;
> >> +
> >> +	struct sdw_manager_reg_mask *reg_mask;
> >> +	struct work_struct probe_work;
> >> +	/* mutex to protect acp common register access */
> >> +	struct mutex *acp_sdw_lock;
> >> +
> >> +	int num_din_ports;
> >> +	int num_dout_ports;
> >> +
> >> +	int cols_index;
> >> +	int rows_index;
> >> +
> >> +	u32 instance;
> >> +	u32 quirks;
> >> +	u32 wake_en_mask;
> >> +	u32 power_mode_mask;
> >> +};
> > Does the manager need to be exposed to rest of kernel or users of this
> > driver, is so why?
> Currently, amd_manager structure being used in ACP PCI driver
> (parent driver) and Soundwire DMA driver.
> 
> In ACP PCI driver, IRQ handler we will use amd_manager structure to
> schedule workqueue based on soundwire manager instance.
> In Soundwire DMA driver, we need to retrieve amd_manager instance.
> As per our design, we have fixed mapping. We need to use same set of
> DMA registers based on CPU DAI ID.
>  i.e if AUDIO0 TX port is selected in amd_manager driver
> then we need to use AUDIO0 TX registers for DMA programming.
> we have included comments for describing mapping in amd_manager.h
> file.

Sorry not sure I follow, can you elaborate which members of above struct
are used by PCI driver?

-- 
~Vinod
