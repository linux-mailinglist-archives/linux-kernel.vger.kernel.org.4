Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E878673458
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 10:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjASJ07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 04:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjASJ05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:26:57 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ACC7AB2;
        Thu, 19 Jan 2023 01:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674120417; x=1705656417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CMAMmGZK9oCKcRxIz8Vz48WNhapUwOODnM/5yPjQvFg=;
  b=LGRxVIvlQ51q29EuSv+p3wKfXuc3TwFMvoO2mVIQ2wftsVvcBkl1/Wtc
   yiZSovoG2270IQStuhZSvgIvyYWiiXkAakXIuxh88CzCoQ7g2pNjCuCIe
   myI7ErIyamaP+09SUwXZbIFwWamFG1fqRaz5wkrT1NkWmazJ4FUq+xQOY
   q5LlUp4/rWTeCRLZibnK7bZ2LEdBfEQBQh1DRKPkOXPLJSbIDgVlBU83P
   HwvqpxDBElC8eXZTCWMtI0ZC217s+aTHpVbFGgIwwXy2r5Y3GHVBxyGUv
   LqtObML53xGp+r8D79pw9c0GNUlJDlbr9VrraJgPchA0PnVeOp1pOkall
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="322925103"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="322925103"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 01:26:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="802565006"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="802565006"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 19 Jan 2023 01:26:54 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 19 Jan 2023 11:26:53 +0200
Date:   Thu, 19 Jan 2023 11:26:53 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1 1/1] device property: Make
 fwnode_graph_for_each_endpoint() consistent
Message-ID: <Y8kM3bzIBF3dbuZh@kuha.fi.intel.com>
References: <20230117152120.42531-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117152120.42531-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 05:21:20PM +0200, Andy Shevchenko wrote:
> Make fwnode_graph_for_each_endpoint() consistent with the rest of
> for_each_*() definitions in the file, i.e. use the form of
> 
> 	for (iter = func(NULL); iter; \
> 	     iter = func(iter))
> 
> as it's done in all the rest of the similar macro definitions.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

FWIW:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  include/linux/property.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 37179e3abad5..f090419818a2 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -436,9 +436,9 @@ fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
>  unsigned int fwnode_graph_get_endpoint_count(struct fwnode_handle *fwnode,
>  					     unsigned long flags);
>  
> -#define fwnode_graph_for_each_endpoint(fwnode, child)			\
> -	for (child = NULL;						\
> -	     (child = fwnode_graph_get_next_endpoint(fwnode, child)); )
> +#define fwnode_graph_for_each_endpoint(fwnode, child)				\
> +	for (child = fwnode_graph_get_next_endpoint(fwnode, NULL); child;	\
> +	     child = fwnode_graph_get_next_endpoint(fwnode, child))
>  
>  int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
>  				struct fwnode_endpoint *endpoint);
> -- 
> 2.39.0

-- 
heikki
