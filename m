Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD3F66E49A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbjAQRPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbjAQROu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:14:50 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE51A4E51C;
        Tue, 17 Jan 2023 09:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673975616; x=1705511616;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+BBmMXn1zgtdD10z98rWe17Kcp87pYxTLvybL2CPtMM=;
  b=ZTUfIT2CQOXQ/tLbwv66OmcPT1mJCnYg/hnMR5JEkeo+ErR46BhRsIO9
   Nh+mvG2B4BsHb8wHmDlmdzoDMEPRJ7N2ttG5I4WdMtVkwhI+gCyR51oyP
   pDRUTI5P2gS6fBqXYQ2RLqyP7YT4//8ffW8ZsrPHvt3CbvPoXWjArfbgY
   FiixrsqtpLs4gifDkoYdXV/s4Ba8blVqpbt7tYROHVE1jjWlTf5vbqSoH
   dsZA9wGMzJ4/q+JzKCMlSz4Av0EKLs0O8IV6tHEg14xt4vxb87AIrO/bL
   U95EfC9S7I4gQ3ODtplnqNPcLb8kXgosShXJgk6l1LQupzo9E+t4XPI77
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="308319637"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="308319637"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 09:12:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="691662949"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="691662949"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.41.87]) ([10.212.41.87])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 09:12:13 -0800
Message-ID: <021a7ba0-e15a-52b3-51cf-14a5ef850157@intel.com>
Date:   Tue, 17 Jan 2023 10:12:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] cxl/region: Fix null pointer dereference for resetting
 decoder
Content-Language: en-US
To:     Fan Ni <fan.ni@samsung.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20221215170915uscas1p262ccdf32fb2ccd3840189376c2793d06@uscas1p2.samsung.com>
 <20221215170909.2650271-1-fan.ni@samsung.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221215170909.2650271-1-fan.ni@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/15/22 10:09 AM, Fan Ni wrote:
> Not all decoders have a reset callback.
> 
> The CXL specification allows a host bridge with a single root port to
> have no explicit HDM decoders. Currently the region driver assumes there
> are none.  As such the CXL core creates a special pass through decoder
> instance without a commit/reset callback.
> 
> Prior to this patch, the ->reset() callback was called unconditionally when
> calling cxl_region_decode_reset. Thus a configuration with 1 Host Bridge,
> 1 Root Port, and one directly attached CXL type 3 device or multiple CXL
> type 3 devices attached to downstream ports of a switch can cause a null
> pointer dereference.
> 
> Before the fix, a kernel crash was observed when we destroy the region, and
> a pass through decoder is reset.
> 
> The issue can be reproduced as below,
>      1) create a region with a CXL setup which includes a HB with a
>      single root port under which a memdev is attached directly.
>      2) destroy the region with cxl destroy-region regionX -f.
> 
> Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

Makes sense, especially with the emulated decoders coming w/o ->reset().

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/region.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f9ae5ad284ff..3931793a13ac 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -131,7 +131,7 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
>   		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>   		struct cxl_port *iter = cxled_to_port(cxled);
>   		struct cxl_ep *ep;
> -		int rc;
> +		int rc = 0;
>   
>   		while (!is_cxl_root(to_cxl_port(iter->dev.parent)))
>   			iter = to_cxl_port(iter->dev.parent);
> @@ -143,7 +143,8 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
>   
>   			cxl_rr = cxl_rr_load(iter, cxlr);
>   			cxld = cxl_rr->decoder;
> -			rc = cxld->reset(cxld);
> +			if (cxld->reset)
> +				rc = cxld->reset(cxld);
>   			if (rc)
>   				return rc;
>   		}
> @@ -186,7 +187,8 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
>   			     iter = ep->next, ep = cxl_ep_load(iter, cxlmd)) {
>   				cxl_rr = cxl_rr_load(iter, cxlr);
>   				cxld = cxl_rr->decoder;
> -				cxld->reset(cxld);
> +				if (cxld->reset)
> +					cxld->reset(cxld);
>   			}
>   
>   			cxled->cxld.reset(&cxled->cxld);
