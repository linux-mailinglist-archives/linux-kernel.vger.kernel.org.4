Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDF86AFFB2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjCHHak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCHHag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:30:36 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E7E8F700;
        Tue,  7 Mar 2023 23:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678260635; x=1709796635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZIms8kfPWeqbx83sb+lLiKBV1UwyL551me+2WJu+04Y=;
  b=HBNX0m6Crxc1n5WKFOchIxCbFVnclrbWxDne6Y4S/d5I7MKTHR4+HOjL
   WvkmufDdBjY8N1/AMe791PFCSgOAwJfxt1qcQQBqdcIBD5RYLAUjDh8wd
   ru6gPTiWwlYDIjWl8zLPo0uVq4m7zY2OLtAAD6TDcm4Ayk2OTXkBnFeDQ
   +eME0F3qSOjg6EbbqL8Zj/k6lj33/iDgq6ClwIfEa+1YmMxU5qH+TdRom
   qUyWvBXV3suDtgOfvKB864z2J/Ih9bQfotlx/gTwzUscfleOGEmJHL9vg
   F8Y+vwuvuvHrJFr0foNQr4mGWKZE2kDU6h914qMyBP4JAh2+jBTe3cmsv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="336104122"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="336104122"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 23:30:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="820094514"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="820094514"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 07 Mar 2023 23:30:20 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 08 Mar 2023 09:30:19 +0200
Date:   Wed, 8 Mar 2023 09:30:19 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Xin Ji <xji@analogixsemi.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Lyude Paul <lyude@redhat.com>, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        chrome-platform@lists.linux.dev,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>, Marek Vasut <marex@denx.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>, devicetree@vger.kernel.org,
        Allen Chen <allen.chen@ite.com.tw>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Stephen Boyd <swboyd@chromium.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v13 01/10] device property: Add remote endpoint to devcon
 matcher
Message-ID: <ZAg5i0thWrx6gf7B@kuha.fi.intel.com>
References: <20230303143350.815623-1-treapking@chromium.org>
 <20230303143350.815623-2-treapking@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303143350.815623-2-treapking@chromium.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 10:33:41PM +0800, Pin-yen Lin wrote:
> From: Prashant Malani <pmalani@chromium.org>
> 
> When searching the device graph for device matches, check the
> remote-endpoint itself for a match.
> 
> Some drivers register devices for individual endpoints. This allows
> the matcher code to evaluate those for a match too, instead
> of only looking at the remote parent devices. This is required when a
> device supports two mode switches in its endpoints, so we can't simply
> register the mode switch with the parent node.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v13:
> - Update the kernel doc of fwnode_connection_find_match
> 
> Changes in v12:
> - Check the availability of the device node in fwnode_graph_devcon_matches
> - Ensured valid access to "matches" in fwnode_graph_devcon_matches
> - Updated the documentation in fwnode_connection_find_match(es)
> - Dropped collected tags due to the new changes
> 
> Changes in v11:
> - Added missing fwnode_handle_put in drivers/base/property.c
> 
> Changes in v10:
> - Collected Reviewed-by and Tested-by tags
> 
> Changes in v6:
> - New in v6
> 
>  drivers/base/property.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 083a95791d3b..4426ac2b16ca 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1243,6 +1243,23 @@ static unsigned int fwnode_graph_devcon_matches(const struct fwnode_handle *fwno
>  			continue;
>  		}
>  
> +		ret = match(node, con_id, data);
> +		fwnode_handle_put(node);
> +		if (ret) {
> +			if (matches)
> +				matches[count] = ret;
> +			count++;
> +
> +			if (matches && count >= matches_len)
> +				break;
> +		}
> +
> +		/*
> +		 * Some drivers may register devices for endpoints. Check
> +		 * the remote-endpoints for matches in addition to the remote
> +		 * port parent.
> +		 */
> +		node = fwnode_graph_get_remote_endpoint(ep);
>  		ret = match(node, con_id, data);
>  		fwnode_handle_put(node);
>  		if (ret) {
> @@ -1293,8 +1310,11 @@ static unsigned int fwnode_devcon_matches(const struct fwnode_handle *fwnode,
>   * @match: Function to check and convert the connection description
>   *
>   * Find a connection with unique identifier @con_id between @fwnode and another
> - * device node. @match will be used to convert the connection description to
> - * data the caller is expecting to be returned.
> + * device node. For fwnode graph connections, the graph endpoints are also
> + * checked. @match will be used to convert the connection description to data
> + * the caller is expecting to be returned.
> + *
> + * Return: The pointer to the matched node, or NULL on error.
>   */
>  void *fwnode_connection_find_match(const struct fwnode_handle *fwnode,
>  				   const char *con_id, void *data,
> @@ -1325,9 +1345,10 @@ EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
>   * @matches_len: Length of @matches
>   *
>   * Find up to @matches_len connections with unique identifier @con_id between
> - * @fwnode and other device nodes. @match will be used to convert the
> - * connection description to data the caller is expecting to be returned
> - * through the @matches array.
> + * @fwnode and other device nodes. For fwnode graph connections, the graph
> + * endpoints are also checked. @match will be used to convert the connection
> + * description to data the caller is expecting to be returned through the
> + * @matches array.
>   * If @matches is NULL @matches_len is ignored and the total number of resolved
>   * matches is returned.
>   *
> -- 
> 2.40.0.rc0.216.gc4246ad0f0-goog

-- 
heikki
