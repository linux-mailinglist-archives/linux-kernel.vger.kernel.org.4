Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AEF63ACE2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiK1Pqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiK1Pqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:46:48 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860401DA61
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 07:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669650407; x=1701186407;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gINwoiYDPzJelD3/jLSEqiZW+JXmK2TqiQoLLwLbUJU=;
  b=dETZB6raCp9OhPXTLQ3zV8dHW5f3YttVLsCpI571rlCuz33iMf4l+c49
   DO/BfsXvsOS+ALZuLKUH5bq8PajSLik5m4XIYyARF3zto2thYMzRzAEC0
   vIUF6x9Fu/W1wYPY6ioUHVkI6nPhuMu/exZlNJ5AxlX+wbfqU2MBJ7+oW
   gCCpzC7Vqr2vDWZFWGMw5vB5y+McPEgROoA004MwHyzwI14nTQYMsKtPS
   lorpryucxy0yZ0pxfw0fHg6aEybm75go5UuLw0bRBpDlmrwT13o5UTP+E
   d64uBZp/tINMpxqBLKbt768ja6+5MRBzMElDN1q0OK/o/Q6x/65I1x7fY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="294565905"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="294565905"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 07:37:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="785672819"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="785672819"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.209.161.118]) ([10.209.161.118])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 07:37:29 -0800
Message-ID: <f27edbcf-91b6-3a9a-7fb3-96298ebb6009@intel.com>
Date:   Mon, 28 Nov 2022 08:37:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH] NTB: ntb_tool: Add check for devm_kcalloc
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, jdmason@kudzu.us,
        allenbh@gmail.com, error27@gmail.com
Cc:     ntb@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221122033244.5777-1-jiasheng@iscas.ac.cn>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221122033244.5777-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/2022 8:32 PM, Jiasheng Jiang wrote:
> As the devm_kcalloc may return NULL pointer,
> it should be better to add check for the return
> value, as same as the others.
> 
> Fixes: 7f46c8b3a552 ("NTB: ntb_tool: Add full multi-port NTB API support")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/ntb/test/ntb_tool.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index 5ee0afa621a9..eeeb4b1c97d2 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -998,6 +998,8 @@ static int tool_init_mws(struct tool_ctx *tc)
>   		tc->peers[pidx].outmws =
>   			devm_kcalloc(&tc->ntb->dev, tc->peers[pidx].outmw_cnt,
>   				   sizeof(*tc->peers[pidx].outmws), GFP_KERNEL);
> +		if (tc->peers[pidx].outmws == NULL)
> +			return -ENOMEM;
>   
>   		for (widx = 0; widx < tc->peers[pidx].outmw_cnt; widx++) {
>   			tc->peers[pidx].outmws[widx].pidx = pidx;
