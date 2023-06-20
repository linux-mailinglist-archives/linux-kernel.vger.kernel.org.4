Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1FE7377E9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 01:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjFTXTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 19:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjFTXSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 19:18:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C1A1703;
        Tue, 20 Jun 2023 16:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687303126; x=1718839126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q1bkxpygv4LAUMocA4P5yZKR1qZoIrHDfX+FBbKE9ls=;
  b=B5GWuKA4SZotZh+Gd3tYQg4YgDz2G8EjddP1HMfh976RYqOhIeE5Zygc
   Br6HbBA3l0ZS0hfjifQiOui8zqxOJPNJBNcjUbvn2YTI7SpKCCXG6rBZK
   bXGPCWm943cE92HTavR3VbCqcUOaDjEuNkToqK/zhmFBgLTPZv/DiIe+L
   FGP9Bzlaau4CYAX4saS02GBRxo4XdJ/uR9viPD8w6NWOrs6PfELD3/w+e
   xNi3sbfU+LGXb31RZXM1QkLrR8pZX9Vwb+Z1oLnVbauBf/IqjqXxYn8Ix
   9Og6D8gXcnL02+B0/h6hlao+lMR/g9uFKuE5YiC6ESHGa2HEk1lxG6syO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="358879758"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="358879758"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 16:18:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="708479549"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="708479549"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.112.123])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 16:18:44 -0700
Date:   Tue, 20 Jun 2023 16:18:43 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Tarun Sahu <tsahu@linux.ibm.com>
Cc:     nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave.jiang@intel.com,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        aneesh.kumar@linux.ibm.com, jaypatel@linux.ibm.com
Subject: Re: [PATCH] dax/kmem: Pass valid argument to
 memory_group_register_static
Message-ID: <ZJIz07hQiXr/MghO@aschofie-mobl2>
References: <20230620140332.30578-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620140332.30578-1-tsahu@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 07:33:32PM +0530, Tarun Sahu wrote:
> memory_group_register_static takes maximum number of pages as the argument
> while dev_dax_kmem_probe passes total_len (in bytes) as the argument.

This sounds like a fix. An explanation of the impact and a fixes tag
may be needed. Also, wondering how you found it.

Alison

> 
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  drivers/dax/kmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 7b36db6f1cbd..898ca9505754 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -99,7 +99,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  	if (!data->res_name)
>  		goto err_res_name;
>  
> -	rc = memory_group_register_static(numa_node, total_len);
> +	rc = memory_group_register_static(numa_node, PFN_UP(total_len));
>  	if (rc < 0)
>  		goto err_reg_mgid;
>  	data->mgid = rc;
> -- 
> 2.31.1
> 
