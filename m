Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532BB72E02C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239890AbjFMKzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239539AbjFMKzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:55:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEF61B8;
        Tue, 13 Jun 2023 03:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686653714; x=1718189714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vEktzoBpSkrn0wkyvocbOkW43+YZyv0TA5B13Xrvmd8=;
  b=itOpNpWUXrEfWO1BgmdkTN32G1WQDsq/OSKMRuJdly4DPfBGo8R/qZHJ
   IgFSwQEocnv5Dxa3Ijpl774UBgu1GCTfDU94uzMoKLljkme4VxXcfIPty
   iE+r2KjYAL5GUpETJI8ehUUviaRc9qFrS3bppXmolgBOD8nLCQbEJYp6+
   R41DU9/t9MXPG00Fwmsh0ahGSjqhntOUUTCH2KTWGDGJw4TEUMUY5GsJJ
   /cV/X0UwFN+A4KMmZOPUhx7nTsDu1nsjikaVYuZ1kFnEQULw4dtfytkc4
   S2EKcGNvnKQGl7hzEbWU9Amr92dXr8haJFHBZMhr3ar2a7xVgBMNGw8go
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="444670611"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="444670611"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 03:55:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="885806358"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="885806358"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 03:55:13 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 1A8A711F9D2;
        Tue, 13 Jun 2023 13:55:10 +0300 (EEST)
Date:   Tue, 13 Jun 2023 10:55:10 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: v4l2-core: Fix a potential resource leak in
 v4l2_fwnode_parse_link()
Message-ID: <ZIhLDh567eWqY5vk@kekkonen.localdomain>
References: <2ddd10ec9e009bbb85518355f1e09e1ecd349925.1685340968.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ddd10ec9e009bbb85518355f1e09e1ecd349925.1685340968.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Mon, May 29, 2023 at 08:17:18AM +0200, Christophe JAILLET wrote:
> 'fwnode is known to be NULL, at this point, so fwnode_handle_put() is a
> no-op.
> 
> Release the reference taken from a previous fwnode_graph_get_port_parent()
> call instead.
> 
> Fixes: ca50c197bd96 ("[media] v4l: fwnode: Support generic fwnode for parsing standardised properties")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> /!\  THIS PATCH IS SPECULATIVE  /!\
>          review with care
> ---
>  drivers/media/v4l2-core/v4l2-fwnode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
> index 049c2f2001ea..b7dd467c53fd 100644
> --- a/drivers/media/v4l2-core/v4l2-fwnode.c
> +++ b/drivers/media/v4l2-core/v4l2-fwnode.c
> @@ -571,7 +571,7 @@ int v4l2_fwnode_parse_link(struct fwnode_handle *fwnode,
>  
>  	fwnode = fwnode_graph_get_remote_endpoint(fwnode);
>  	if (!fwnode) {
> -		fwnode_handle_put(fwnode);
> +		fwnode_handle_put(link->local_node);

link->local_node also needs to be non-NULL for the successful case. The
condition should take that into account. Could you send v2 with that?

>  		return -ENOLINK;
>  	}
>  

-- 
Kind regards,

Sakari Ailus
