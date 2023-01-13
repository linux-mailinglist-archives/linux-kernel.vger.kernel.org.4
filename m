Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BC76693FA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241061AbjAMKXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241024AbjAMKW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:22:59 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25BE1788F
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673605366; x=1705141366;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CDcpGc14MxwljMRrNGGaJzjMrvUpcw8OYXg9rqQznUQ=;
  b=jlUoylVARX8BXNVQfSrQBU9qkKD6NzTVLKuZwVhDCzLdhj9Bk9xkhDWE
   8GzM/75eI1ET83xYDp5L9iFaXHbu8EZlmAtvSQeSRp+zCzTQfi44q1Dal
   O4HwExhxFEkPJ68dT+zg6UV9uU8MK7INI+UZowLD+J+CHrDW4mLP27Ztl
   qEmSR1w8wf5p08B14zYMDP94fBj0oTVJ+4fTAPHI7iO20l2Cfdy4jErvE
   /1ijIz3jJ5uHQO2QNWQ6xNnl9G1gfPCpKeRqOnuB8YEP+Diuw3uAktMft
   iTvK1i0rquBUSff9X4k5eKhavEuTRo9TGxvCwvUqq+X66yj3/RNy6GKkD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="324024194"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="324024194"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 02:22:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="721473464"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="721473464"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 02:22:32 -0800
Message-ID: <d2c6f43a-e166-a201-4662-ba726347f2da@linux.intel.com>
Date:   Fri, 13 Jan 2023 11:22:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/5] soundwire: stream: uniquify dev_err() logs
Content-Language: en-US
To:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org,
        bard.liao@intel.com, linux-kernel@vger.kernel.org
References: <20230113093532.3872113-1-yung-chuan.liao@linux.intel.com>
 <20230113093532.3872113-2-yung-chuan.liao@linux.intel.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20230113093532.3872113-2-yung-chuan.liao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/2023 10:35 AM, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> There are a couple of duplicate logs which makes harder than needed to
> follow the error flows. Add __func__ or make the log unique.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>   drivers/soundwire/stream.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index df3b36670df4..e0eae0b98267 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -1389,7 +1389,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream,
>   
>   	ret = do_bank_switch(stream);
>   	if (ret < 0) {
> -		dev_err(bus->dev, "Bank switch failed: %d\n", ret);
> +		dev_err(bus->dev, "do_bank_switch failed: %d\n", ret);
>   		goto restore_params;
>   	}

This one seems bit unrelated to the change and makes error message 
inconsistent with:
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git/tree/drivers/soundwire/stream.c?h=next&id=545c365185a47672b1d5cc13c84057a1e874993c#n1498
and
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git/tree/drivers/soundwire/stream.c?h=next&id=545c365185a47672b1d5cc13c84057a1e874993c#n1575
which actually brings me to another suggestion, can this error message 
perhaps be just moved into do_bank_switch() function itself, instead of 
being duplicated multiple times or alternatively just also prefix all of 
them with function name?

