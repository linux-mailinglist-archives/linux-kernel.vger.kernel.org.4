Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD2065B2C7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 14:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjABNl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 08:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjABNl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 08:41:26 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4294D63AB;
        Mon,  2 Jan 2023 05:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672666886; x=1704202886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CX0zuNRoqPw8io4WYHuKdvqgSF3WPmb0FFc7W4rrRCY=;
  b=JxbyP2YCRaNjv0lTwuH/Vzmel6591v3Jjf+OpBX0WNrKTbKZUvDC0+ZP
   GSOzDDhJKgWf9Yj3XpHjiLFSjNzLqqSBO7G8Q/ZHPpyH9sFaoBUfEt4Su
   p+NKXYpd17rrr5YH+Ff/WON3cpTqKnYPVpgm7VlPyn1B+nvMRdVFppxeP
   ghB4CpoPjpUpxar/WjpPnzRgE7cp0B2so8jnwDWNgMSJFVih2fBv08C9K
   7SBSKQd4tftv3H5f4lDm9ZvBylpvAAz857vGJOQ38BdKUHCKRrAKtkJjB
   Gq3B3DQaOnZTQ4z2tutMr0FL2aQoUfvwzsT9+noMWk58KrqBSoneelmzx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="304993109"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="304993109"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 05:41:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="722976220"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="722976220"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 05:41:23 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 3A3F82017A;
        Mon,  2 Jan 2023 15:41:21 +0200 (EET)
Date:   Mon, 2 Jan 2023 13:41:21 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Aleksandr Burakov <a.burakov@rosalinux.ru>
Cc:     Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] staging: media: ipu3: buffer overflow fix in
 imgu_map_node
Message-ID: <Y7LfAR4QdIzp81yW@paasikivi.fi.intel.com>
References: <20221223123025.5948-1-a.burakov@rosalinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223123025.5948-1-a.burakov@rosalinux.ru>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aleksandr,

On Fri, Dec 23, 2022 at 03:30:25PM +0300, Aleksandr Burakov wrote:
> If imgu_node_map[i].css_queue is not equal to css_queue
> then "i" after the loop could be equal to IMGU_NODE_NUM
> that is more than the border value (IMGU_NODE_NUM - 1).
> So imgu_map_node() call may return IMGU_NODE_NUM that is more
> than expected value.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 7fc7af649ca7 ("media: staging/intel-ipu3: Add imgu top level pci device driver")
> Signed-off-by: Aleksandr Burakov <a.burakov@rosalinux.ru>
> ---
>  drivers/staging/media/ipu3/ipu3.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/ipu3/ipu3.c b/drivers/staging/media/ipu3/ipu3.c
> index 0c453b37f8c4..cb09eb3cc227 100644
> --- a/drivers/staging/media/ipu3/ipu3.c
> +++ b/drivers/staging/media/ipu3/ipu3.c
> @@ -60,8 +60,10 @@ unsigned int imgu_map_node(struct imgu_device *imgu, unsigned int css_queue)
>  	for (i = 0; i < IMGU_NODE_NUM; i++)
>  		if (imgu_node_map[i].css_queue == css_queue)
>  			break;
> -
> -	return i;
> +	if (i < IMGU_NODE_NUM)
> +		return i;
> +	else
> +		return (IMGU_NODE_NUM - 1);
>  }
>  
>  /**************** Dummy buffers ****************/

Thanks for the patch. It would require a bug elsewhere in the driver for
this to happen. If some handling for this case is added, it shouldn't be
hiding the issue.

One easy way could be to add WARN_ON() for this, and return some value (as
you do). Zero would do equally well.

I.e.

	return WARN_ON(i >= IMGU_NODE_NUM) ? 0 : i;

-- 
Sakari Ailus
