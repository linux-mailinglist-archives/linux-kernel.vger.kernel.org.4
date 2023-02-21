Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3F269DF4C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbjBULvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjBULvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:51:18 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B502525B99;
        Tue, 21 Feb 2023 03:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676980265; x=1708516265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dA0UV9DVYzws8NY0piO2Q7OcBlhHBKKb6Y0abZOE/X0=;
  b=dEy9Cg8p1UAZJgIcv4X7J2Czpv3kJMUe9M0XL66zfRsWD4OQ6+MUHUz9
   8TzJqkBwc0U1m4d6/1orcx6TgQeR/SLzJVv981iTdqpr0e+tAhLFh8Ymw
   oHa0mjdKATGwfMJiwsGOQMN8YQI+2jKn1TkKoZLP9O9ICGtDiUahD9FUN
   2FRG1virPz6fLwiCUeWds345GtnQnzJAmp68LNAXJOLRoJl9EK/StMc5L
   SbSjaLtOgXO8gwpCIRJHraa6EU1bFr37KMzAm4gGGXFeP3hrGM2UubHl4
   pOcyRDQMs9yUo93Wet0nxDu6CuoioKzDBEOsx0HwTRcTHJZUcUOJK69ly
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="395092755"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="395092755"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 03:51:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="740377282"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="740377282"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 21 Feb 2023 03:50:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pURAb-009wL4-2S;
        Tue, 21 Feb 2023 13:50:53 +0200
Date:   Tue, 21 Feb 2023 13:50:53 +0200
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
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Marek Vasut <marex@denx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, Xin Ji <xji@analogixsemi.com>,
        Lyude Paul <lyude@redhat.com>,
        Allen Chen <allen.chen@ite.com.tw>, devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>, chrome-platform@lists.linux.dev,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-acpi@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v12 05/10] drm/bridge: anx7625: Check for Type-C during
 panel registration
Message-ID: <Y/SwHSmvvGekA1Ac@smile.fi.intel.com>
References: <20230221095054.1868277-1-treapking@chromium.org>
 <20230221095054.1868277-6-treapking@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221095054.1868277-6-treapking@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 05:50:49PM +0800, Pin-yen Lin wrote:
> The output port endpoints can be connected to USB-C connectors.
> Running drm_of_find_panel_or_bridge() with such endpoints leads to
> a continuous return value of -EPROBE_DEFER, even though there is
> no panel present.
> 
> To avoid this, check for the existence of a "mode-switch" property in
> the port endpoint, and skip panel registration completely if so.

...

> +	port_node = of_graph_get_port_by_id(np, 1);
> +	fwnode_for_each_typec_mode_switch(&port_node->fwnode, fwnode) {
> +		fwnode_handle_put(fwnode);
> +		return 0;
> +	}

With the proposed count API:

	unsigned int count;
	...
	port_node = ...
	count = typec_mode_switch_node_count(&port_node->fwnode);
	if (count == 0)
		return 0;

-- 
With Best Regards,
Andy Shevchenko


