Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D9770E491
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbjEWSYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbjEWSYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:24:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC3C11D
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 11:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684866276; x=1716402276;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bH9DkjwQCDbz6P1wuCe1exqA+AW9HUfS0R7iBFyxoBA=;
  b=Ci49o+FGUZEufeNagu5T8evfgUuCC3dFmDVfCjASdQN25nhA2plWpdrg
   MIMv98B+jIWvHpIKF+kgd9U9zIZfe0WKop9fjrLn61P8/bve2qt7qEAE4
   13rIn4HRcaAQ7OtM2P0vOuphcrxfoGfehnsmavRnGb37wAwheewyDuRdm
   Gsc40Gz5A7dNHCVBJqHFVihdeiBAEZiDYAIe/fNpy7ShObQzACZiCm8fh
   MxpEGVIh1Rq9sAAz9xJgO8owKphyfepUthiuK9D9R1b8Up1682GFUhVIh
   LzU0d1AWrwEpePyWEMUenTVH2AWLMTVBhria/UFNEcepH+pFkPAqWwT9v
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="342786228"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="342786228"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 11:24:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="736974292"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="736974292"
Received: from srusakov-mobl.amr.corp.intel.com (HELO [10.209.35.87]) ([10.209.35.87])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 11:24:35 -0700
Message-ID: <d1baccf7-c689-fc40-d616-855c253021fc@linux.intel.com>
Date:   Tue, 23 May 2023 09:34:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V2 2/9] ASoC: amd: ps: handle SoundWire interrupts in acp
 pci driver
Content-Language: en-US
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, mario.limonciello@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230522133122.166841-1-Vijendar.Mukunda@amd.com>
 <20230522133122.166841-3-Vijendar.Mukunda@amd.com>
 <134a2efd-648a-fb4b-4b61-154173b97f04@linux.intel.com>
 <2e8d3af4-7d54-becf-1084-c9b07a3436d0@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <2e8d3af4-7d54-becf-1084-c9b07a3436d0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>>  static void acp63_disable_interrupts(void __iomem *acp_base)
>>> @@ -102,23 +103,55 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
>>>  {
>>>  	struct acp63_dev_data *adata;
>>>  	struct pdm_dev_data *ps_pdm_data;
>>> -	u32 val;
>>> +	struct amd_sdw_manager *amd_manager;
>>> +	u32 ext_intr_stat, ext_intr_stat1;
>>> +	u16 irq_flag = 0;
>>>  	u16 pdev_index;
>>>  
>>>  	adata = dev_id;
>>>  	if (!adata)
>>>  		return IRQ_NONE;
>>> +	ext_intr_stat = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
>>> +	if (ext_intr_stat & ACP_SDW0_STAT) {
>>> +		writel(ACP_SDW0_STAT, adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
>> [1]
>>
>> this is confusing, if this is w1c, should this be:
>>
>> writel(ext_intr_stat, adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
>>
>> Otherwise you may be clearing fields that have not been set?
> As per our register spec, writing zero to register fields doesn't
> have any effect. Only writing 1 to register bit will clear that
> interrupt.
> We are handling bit by bit irq check and clearing the irq mask
> based on irq bit and take an action related to that particular irq
> bit.

Right, maybe an explanation in the commit message would help.
