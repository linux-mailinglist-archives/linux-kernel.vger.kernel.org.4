Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8376D0411
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjC3L4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjC3L4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:56:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE676114
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680177347; x=1711713347;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HnAIjzzdx2lB/b8PHKZcY6z2HpfZD2oCVe+1dUZS8So=;
  b=Xy9POb6w6YKvh43PIP7/VV5pAm2bKY3kIaPhAyUyXjU2qhsL/uaw3gfz
   Fd7Mn/1mzpXHqq65T5mwPrr+1KDrsg+JG7UrRAEDySYuzG8hrzbbspoET
   pMo1TlddsXumXIgqH+CauZ9qro/S/Opiu0zq95yNev941wJQrwdPpycLp
   FerxL3ksVb00+WLQdPeIo1Wzn3eX4udlhNT/B/8RSvRobJeGbuCUR9q2V
   yBrVrNXJpSduOsh+8PzbHnszxJwN101DvPyzEFc+8INJmcx8ULqjUybhw
   fk49KsEEAdU2nbYvcaQyKWa0wMYMurmVJHv8GghaspBgAEClQ9dosyTAB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="325069296"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="325069296"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 04:54:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="717285299"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="717285299"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 04:54:01 -0700
Message-ID: <8d0d0478-1e45-ea52-f1b7-910b747d6282@linux.intel.com>
Date:   Thu, 30 Mar 2023 13:53:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v10] ASoC: tas2781: Add tas2781 driver
Content-Language: en-US
To:     Shenghao Ding <13916275206@139.com>, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com
Cc:     kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com
References: <20230329100107.8181-1-13916275206@139.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20230329100107.8181-1-13916275206@139.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/2023 12:01 PM, Shenghao Ding wrote:
> Create tas2781 driver.
> 
> Signed-off-by: Shenghao Ding <13916275206@139.com>
> 
> ---
> Changes in v10:
>   - using be16_to_cpu and be32_to_cpu instead of SMS_HTONS and SMS_HTONL
>   - optimize and reduce the boundary checks
>   - Add comments on some kmemdup instead of kzalloc+memcpy
>   Changes to be committed:
> 	modified:   sound/soc/codecs/Kconfig
> 	modified:   sound/soc/codecs/Makefile
> 	new file:   sound/soc/codecs/tas2781-dsp.c
> 	new file:   sound/soc/codecs/tas2781-dsp.h
> 	new file:   sound/soc/codecs/tas2781-i2c.c
> 	new file:   sound/soc/codecs/tas2781.h
> ---

...

> +
> +static int fw_parse_block_data_kernel(struct tasdevice_fw *tas_fmw,
> +	struct tasdev_blk *block, const struct firmware *fmw, int offset)
> +{
> +	const unsigned char *data = fmw->data;
> +
> +	if (offset + 16 > fmw->size) {
> +		dev_err(tas_fmw->dev, "%s: File Size error\n", __func__);
> +		offset = -EINVAL;
> +		goto out;
> +	}
> +	block->type = be32_to_cpup((__be32 *)&data[offset]);

Wouldn't just be32_to_cpu(data[offset]) work instead of be32_to_cpup? 
Same in other cases.


