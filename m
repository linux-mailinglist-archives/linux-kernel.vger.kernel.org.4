Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431EC70C53B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 20:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjEVScS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 14:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbjEVScL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 14:32:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BA210D
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684780328; x=1716316328;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m2u1Fynpu0Q6HiRGvTPXsGDwoeAMSJbQ90gprxvwMVE=;
  b=DvB0xvSCJx0YTujK2WG9D/2oN7R+FtfXGXQYy0iIZro6cFvJAZQtizF2
   vQBeyYV/x96Hhxbtu3X09PW3lTCTPdIsGV0XfI/ovgFMzv+AR3povwxmP
   08Hgkuov2dUH99hI4FVrnafKNp60flZ07ukjAYxG3b7GL+Q8sAYJENwR9
   PH8ctSMYvIDF/Av8fnf/k7BjJw+XdhTbAvDKA5STw363VxlvtmhMLY1jF
   gCUJZ8OZNYeOJavT0/t36kCBh8xBy/Qocrpft4a4+bxI0pB7QAPpsEbED
   dn2TFWzOQI7HClrhkprYhzNsTrXtgxkPB/GOeJ7YzQjxRXXPTfUPv6j2h
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="356235149"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="356235149"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 11:31:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="697740840"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="697740840"
Received: from ljgreene-mobl.amr.corp.intel.com (HELO [10.209.124.121]) ([10.209.124.121])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 11:31:48 -0700
Message-ID: <42774a4f-ae1e-7d25-6b01-67f5af8400a4@linux.intel.com>
Date:   Mon, 22 May 2023 11:39:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V2 4/9] ASoC: amd: ps: add SoundWire dma driver dma ops
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, mario.limonciello@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230522133122.166841-1-Vijendar.Mukunda@amd.com>
 <20230522133122.166841-5-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230522133122.166841-5-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +union acp_sdw_dma_count {
> +	struct {
> +	u32 low;
> +	u32 high;
> +	} bcount;

indentation seems off?

> +	u64 bytescount;
> +};
> +
> +struct sdw_dma_ring_buf_reg {
> +	u32 reg_dma_size;
> +	u32 reg_fifo_addr;
> +	u32 reg_fifo_size;
> +	u32 reg_ring_buf_size;
> +	u32 reg_ring_buf_addr;
> +	u32 water_mark_size_reg;
> +	u32 pos_low_reg;
> +	u32 pos_high_reg;
>  };
>\
> +static void acp63_config_dma(struct acp_sdw_dma_stream *stream, void __iomem *acp_base,
> +			     u32 stream_id)
> +{
> +	u16 page_idx;
> +	u32 low, high, val;
> +	u32 sdw_dma_pte_offset;
> +	dma_addr_t addr;
> +
> +	addr = stream->dma_addr;
> +	sdw_dma_pte_offset = SDW_PTE_OFFSET(stream->instance);
> +	val = sdw_dma_pte_offset + (stream_id * 256);

what is this 256 magic value? use a defined or << 8 ?
> +
> +	/* Group Enable */
> +	writel(ACP_SDW_SRAM_PTE_OFFSET | BIT(31), acp_base + ACPAXI2AXI_ATU_BASE_ADDR_GRP_2);
> +	writel(PAGE_SIZE_4K_ENABLE, acp_base + ACPAXI2AXI_ATU_PAGE_SIZE_GRP_2);
> +	for (page_idx = 0; page_idx < stream->num_pages; page_idx++) {
> +		/* Load the low address of page int ACP SRAM through SRBM */
> +		low = lower_32_bits(addr);
> +		high = upper_32_bits(addr);
> +
> +		writel(low, acp_base + ACP_SCRATCH_REG_0 + val);
> +		high |= BIT(31);
> +		writel(high, acp_base + ACP_SCRATCH_REG_0 + val + 4);
> +		val += 8;
> +		addr += PAGE_SIZE;
> +	}
> +	writel(0x1, acp_base + ACPAXI2AXI_ATU_CTRL);
> +}
