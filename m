Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C1E706AA6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjEQOLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjEQOLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:11:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F077676A9
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684332702; x=1715868702;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pzFo4Z6t1V727ENInzSFlGTCw9zVEOcwoyprjyInogA=;
  b=d2XmCaxuVw2To2HTbP+mWBNYh1jRaODFgtsMW6S9DCnvDztnYE+iYF+6
   CCH57FMmNoDe95EYAfab0LYP5YC3I33c/FdUyNP29KUROc9m1wyfLWTfC
   TqUroXW6jSUmvHG7xUlxJPvlpOqs8ZSxHmLOE/mh30q/JQrtkxcLnSVLt
   Gxfi4PEMR+2WmLEtxG4dVLr5XnrRk75h426Ibb7Wz+7imam714aJLqq1W
   hRZ6azeVfye3stn8JIboIlnWgJ/WNNRN+MuI7UEyiU4T0cpuicEWQ2I40
   fC9pPs6yJZuDS/kpGdW7AyFHlH6O2PNn4aReC/KaalfdTNQ+7WemV/trI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="349273423"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="349273423"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 07:11:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="734709684"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="734709684"
Received: from rdealba-mobl.amr.corp.intel.com (HELO [10.209.16.101]) ([10.209.16.101])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 07:11:41 -0700
Message-ID: <0714fa41-b77d-6735-2abb-17d93c41ca51@linux.intel.com>
Date:   Wed, 17 May 2023 08:36:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 2/9] ASoC: amd: ps: handle soundwire interrupts in acp pci
 driver
Content-Language: en-US
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230516103543.2515097-1-Vijendar.Mukunda@amd.com>
 <20230516103543.2515097-3-Vijendar.Mukunda@amd.com>
 <bc58e1b1-8bce-3894-f840-57dd2d802932@linux.intel.com>
 <fea77516-72ab-afa1-2336-ae9174e7bd7f@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <fea77516-72ab-afa1-2336-ae9174e7bd7f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +	if (ext_intr_stat & BIT(ACP_ERROR_IRQ_MASK)) {
>>> +		writel(BIT(ACP_ERROR_IRQ_MASK), adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
>>> +		writel(0, adata->acp63_base + ACP_SW0_I2S_ERROR_REASON);
>>> +		writel(0, adata->acp63_base + ACP_SW1_I2S_ERROR_REASON);
>>> +		writel(0, adata->acp63_base + ACP_ERROR_STATUS);
>>> +		irq_flag = 1;
>> it's not clear what this does? Looks like just filtering out interrupts
>> without doing anything about the interrupt source?
> When ACP error interrupt is raised, As per our design, ACP IRQ handler will clear
> the error interrupt by clearing ACP_ERROR_IRQ bit in ACP_EXTERNAL_INTR_STAT.
> 
> To know the error source reason, we need to read the ACP_ERROR_STATUS,
> ACP_SW0_I2S_ERROR_REASON, ACP_SW1_I2S_ERROR_REASON registers.
> After reading the Error registers, we need to clear these registers.
> Currently, we haven't added read register operations for error reason registers.
> This is for debugging purpose only.
> 
> In Current context, we refer ACP_SW0_I2S_ERROR_REASON  register to know errors like
> Sound Wire Bus clash detections, Command and Response Errors, BRA mode errors,
> FIFO underflow/overflow errors detected for SoundWire Manager -0 instance.
> Similarly, ACP_SW1_I2S_ERROR_REASON register referred to know errors detected for
> SoundWire Manager instance - 1.

If you didn't add the code to deal with the errors, a comment would be
welcome to clarify that the interrupts are cleared without looking for
the root cause.

It's hard when reviewing code to understand if there's a miss or
something that's intentionally omitted or to be added later.
