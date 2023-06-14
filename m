Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BDF72F737
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243387AbjFNIAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243686AbjFNIAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:00:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22E310DA;
        Wed, 14 Jun 2023 01:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686729606; x=1718265606;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=N5PcozdZTKgBDrB77IRIFRCU71kv0AKvj26OTZxaeyk=;
  b=imGRppSBosES1bvHsOeZpsk2ILplEMr+yWtFMZ9F6Z7HYsYE765i+EYV
   eOMoNJf6Lj07AknAQcZ/hnAciST71aDp9VTYONJxbL48wVK0JtBZwIsix
   VSil+VYNwwmMefQdQ1fJHkrduKV+2BrfDvOWK95rfTpBQvN4m0/AsBUzy
   0abjsdyMHZkgZCnnjGbtqJJoY3qSA7MGQlPJp5Mo/TOYrZwse/UNtB+S8
   9l0xhO0kA/+p5CCYFXjp7Oxz4x0AAG8B8XJ4rLxms+6EHfxH/fxU3//Q7
   TCD4l21fMtaozx6oYZVr0VylSsmqz8mTczvNk9epo5Bg8PecyeanvlYE2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="348210181"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="348210181"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 01:00:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="715098845"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="715098845"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 01:00:03 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id E360711F826;
        Wed, 14 Jun 2023 11:00:00 +0300 (EEST)
Date:   Wed, 14 Jun 2023 08:00:00 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: v4l2-core: Fix a potential resource leak in
 v4l2_fwnode_parse_link()
Message-ID: <ZIlzgEZCTHmoMm8c@kekkonen.localdomain>
References: <2ddd10ec9e009bbb85518355f1e09e1ecd349925.1685340968.git.christophe.jaillet@wanadoo.fr>
 <ZIhLDh567eWqY5vk@kekkonen.localdomain>
 <34b714b6-cb49-1a34-58f5-8b5ef0da2714@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34b714b6-cb49-1a34-58f5-8b5ef0da2714@wanadoo.fr>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Tue, Jun 13, 2023 at 07:15:40PM +0200, Christophe JAILLET wrote:
> Le 13/06/2023 à 12:55, Sakari Ailus a écrit :
> > Hi Christophe,
> > 
> > On Mon, May 29, 2023 at 08:17:18AM +0200, Christophe JAILLET wrote:
> > > 'fwnode is known to be NULL, at this point, so fwnode_handle_put() is a
> > > no-op.
> > > 
> > > Release the reference taken from a previous fwnode_graph_get_port_parent()
> > > call instead.
> > > 
> > > Fixes: ca50c197bd96 ("[media] v4l: fwnode: Support generic fwnode for parsing standardised properties")
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > ---
> > > /!\  THIS PATCH IS SPECULATIVE  /!\
> > >           review with care
> > > ---
> > >   drivers/media/v4l2-core/v4l2-fwnode.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
> > > index 049c2f2001ea..b7dd467c53fd 100644
> > > --- a/drivers/media/v4l2-core/v4l2-fwnode.c
> > > +++ b/drivers/media/v4l2-core/v4l2-fwnode.c
> > > @@ -571,7 +571,7 @@ int v4l2_fwnode_parse_link(struct fwnode_handle *fwnode,
> > >   	fwnode = fwnode_graph_get_remote_endpoint(fwnode);
> > >   	if (!fwnode) {
> > > -		fwnode_handle_put(fwnode);
> > > +		fwnode_handle_put(link->local_node);
> > 
> > link->local_node also needs to be non-NULL for the successful case. The
> > condition should take that into account. Could you send v2 with that?
> > 
> > >   		return -ENOLINK;
> > >   	}
> > 
> 
> Hi,
> something like below?

Ah, remote_node must be non-NULL, too, indeed. It was surprisingly broken.

> 
> @@ -568,19 +568,25 @@ int v4l2_fwnode_parse_link(struct fwnode_handle
> *fwnode,
>  	link->local_id = fwep.id;
>  	link->local_port = fwep.port;
>  	link->local_node = fwnode_graph_get_port_parent(fwnode);
> +	if (!link->local_node)
> +		return -ENOLINK;
> 
>  	fwnode = fwnode_graph_get_remote_endpoint(fwnode);
> -	if (!fwnode) {
> -		fwnode_handle_put(fwnode);
> -		return -ENOLINK;
> -	}
> +	if (!fwnode)
> +		goto err_put_local_node;

On error, fwnode needs to be put from this onwards, too.

But you can use a single label: fwnode_handle_put() is NULL-safe.

> 
>  	fwnode_graph_parse_endpoint(fwnode, &fwep);
>  	link->remote_id = fwep.id;
>  	link->remote_port = fwep.port;
>  	link->remote_node = fwnode_graph_get_port_parent(fwnode);
> +	if (!link->remote_node)
> +		goto err_put_local_node;
> 
>  	return 0;
> +
> +err_put_local_node:
> +	fwnode_handle_put(link->local_node);
> +	return -ENOLINK;
>  }
>  EXPORT_SYMBOL_GPL(v4l2_fwnode_parse_link);

-- 
Kind regards,

Sakari Ailus
