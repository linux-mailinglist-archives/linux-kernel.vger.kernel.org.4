Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3D26A4693
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjB0P6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjB0P6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:58:33 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978211B2DE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677513510; x=1709049510;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5H0k3qY8U+R+Lr/NVi0+45TqQXSQ5y01pcav2hkOVdg=;
  b=Kz9H49f1b4pYAZVV8t3XTX05SqSM6HBqlW/YYtXyn/hy18nh3bhT5VGv
   dJkaAb43FJ894vnlprBCKUC+Kro1dFgKkw/B2G3BWrfYUNvBBXNK/S/fm
   F4bqAhJAXJzoqlVyOXpYGWViRvZir9f9qMCrU1BptNJ4iuy9RGRBSI2HN
   iCRiMRKjgKuzEKlJwJq1RluzrT/MV4fIBiSYUbY2u2cWb1S6/BqgVh5r+
   9NJGDjH0tgUUJO9o+sXqLIA4BNCC97fVanoIFYFjzirNPF628cSNDJW6w
   HE3BsB39pgWnbw1Fta36TIVJf5mRkOPW8k1jIZiEgyJMoUFGkTnx3pSVF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="314314762"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="314314762"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 07:58:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="919395922"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="919395922"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.113.7]) ([10.212.113.7])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 07:58:30 -0800
Message-ID: <caa8671d-ab6c-dcec-c363-e12e1515f65e@intel.com>
Date:   Mon, 27 Feb 2023 08:58:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] ntb_tool: check null return of devm_kcalloc in
 tool_init_mws
Content-Language: en-US
To:     Kang Chen <void0red@gmail.com>, jdmason@kudzu.us
Cc:     allenbh@gmail.com, ntb@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230226055743.2522819-1-void0red@gmail.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230226055743.2522819-1-void0red@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/23 10:57 PM, Kang Chen wrote:
> devm_kcalloc may fails, tc->peers[pidx].outmws might be null
> and will cause null pointer dereference later.
> 
> Signed-off-by: Kang Chen <void0red@gmail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/ntb/test/ntb_tool.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index 5ee0afa62..eeeb4b1c9 100644
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
