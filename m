Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F2770A361
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 01:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjESXdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 19:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjESXdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 19:33:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2BF1BD;
        Fri, 19 May 2023 16:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684539202; x=1716075202;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O2W8d5W7JoCf0Y8OYXeuJ4e+qlY+zrF4GrseHzBydyY=;
  b=axWQFFktj2I2rGVBr1j45lTC3u0XfEKbsv1O++qkQ0YpUeFMdSoSnDpM
   vuqZdLvgz08Y74FJjXETZUViYpTwkS6ah5KuixbRJFPuHt1sFNml1TY8x
   NG8Fkc0OR0++k+AqWOr3zt2xZzQ4GiLzu+9EoO4n04+nyIDfrLj/ofQoU
   DIxiS0uxOo+8t8vVeM1z11aJKAd9HBGEffl6IyaBSXQjFFjAIFaGrhbGo
   YDxMNx0v1OWYc2UZj/agPkbpfzp4l4bNfSDMSDLXJ2UqTQfQIYzTNW8W7
   k/GWWBPg9LndZnlcrybytOD13tgLGmtTaUYuZkTp5VqzEbhpLDZcqfg+L
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="350021104"
X-IronPort-AV: E=Sophos;i="6.00,178,1681196400"; 
   d="scan'208";a="350021104"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 16:33:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="772456849"
X-IronPort-AV: E=Sophos;i="6.00,178,1681196400"; 
   d="scan'208";a="772456849"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.29.189]) ([10.212.29.189])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 16:33:21 -0700
Message-ID: <09c47829-4c80-fb8b-3b6d-67852ec297a9@intel.com>
Date:   Fri, 19 May 2023 16:33:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH] cxl/port: Fix NULL pointer access in devm_cxl_add_port()
Content-Language: en-US
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230519215436.3394532-1-rrichter@amd.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230519215436.3394532-1-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/23 2:54 PM, Robert Richter wrote:
> In devm_cxl_add_port() the port creation may fail and its associated
> pointer does not contain a valid address. During error message
> generation this invalid port address is used. Fix that wrong address
> access.
> 
> Fixes: f3cd264c4ec1 ("cxl: Unify debug messages when calling devm_cxl_add_port()")
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/port.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index da2068475fa2..e7c284c890bc 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -750,11 +750,10 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
>   
>   	parent_port = parent_dport ? parent_dport->port : NULL;
>   	if (IS_ERR(port)) {
> -		dev_dbg(uport, "Failed to add %s%s%s%s: %ld\n",
> -			dev_name(&port->dev),
> -			parent_port ? " to " : "",
> +		dev_dbg(uport, "Failed to add%s%s%s: %ld\n",
> +			parent_port ? " port to " : "",
>   			parent_port ? dev_name(&parent_port->dev) : "",
> -			parent_port ? "" : " (root port)",
> +			parent_port ? "" : " root port",
>   			PTR_ERR(port));
>   	} else {
>   		dev_dbg(uport, "%s added%s%s%s\n",
> 
> base-commit: e764f12208b99ac7892c4e3f6bf88d71ca71036f
