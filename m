Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90D76ABED8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjCFLzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjCFLzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:55:37 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A77C17F;
        Mon,  6 Mar 2023 03:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678103736; x=1709639736;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xv0rddRhfULApnbd3Ab/QM/Y5xi6oLD/g/1EbXH3o94=;
  b=jntTX/MKuVPYlEVMz8vTrwohC79XNd28s+lIllpvYq5svhE7EBylZT/+
   YimVUWQK2/hQzjbY/dcYdnyNfRPHrPkWEIa5zXKPhwzGnoVk46zZynzSs
   GZbst9YZAgfOqP/wb6kcLt/vchLQNJwW+g6/uE6ASQnnd1pAawQiuUDhn
   YTCK6CfgTZhxBAW2cKnq2xJXXO6XHXUs1+jKZQWpcTBKrxPDGp6momuJd
   t8TzR/xl8NINdJzej6iiL1E+KvzT9mBZyZdyBKRY7+pgYG/M9nvq/ecTs
   JiHxA6JMMIMDG4PGw6sc6gf3MREdKvR2uNF1q9h73zfZFjYhwRC99P0BB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="323843611"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="323843611"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 03:55:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="745031931"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="745031931"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 06 Mar 2023 03:55:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pZ9R6-00GKmb-1k;
        Mon, 06 Mar 2023 13:55:24 +0200
Date:   Mon, 6 Mar 2023 13:55:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
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
Subject: Re: [PATCH v13 07/10] drm/bridge: anx7625: Register Type C mode
 switches
Message-ID: <ZAXUrJDtHmm7+50H@smile.fi.intel.com>
References: <20230303143350.815623-1-treapking@chromium.org>
 <20230303143350.815623-8-treapking@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303143350.815623-8-treapking@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 10:33:47PM +0800, Pin-yen Lin wrote:
> Register USB Type-C mode switches when the "mode-switch" property and
> relevant ports are available in Device Tree. Configure the crosspoint
> switch based on the entered alternate mode for a specific Type-C
> connector.
> 
> Crosspoint switch can also be used for switching the output signal for
> different orientations of a single USB Type-C connector, but the
> orientation switch is not implemented yet. A TODO is added for this.

...

> +	ctx->port_data = devm_kcalloc(
> +		dev, switch_desc->num_typec_switches,
> +		sizeof(struct anx7625_typec_port_data), GFP_KERNEL);

I believe I have commented on this (indentation)...

> +

...and this (blank line).

> +	if (!ctx->port_data) {
> +		ret = -ENOMEM;
> +		goto unregister_mux;
> +	}

...

> +		ctx->port_data[i].orientation = (dp_lanes[0] / 2 == 0) ?
> +			TYPEC_ORIENTATION_REVERSE : TYPEC_ORIENTATION_NORMAL;

I believe that this is an error prone check, you should rather do the opposite,
i.e.  ' % 2  == 0'.

-- 
With Best Regards,
Andy Shevchenko


