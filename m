Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E1A69F628
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjBVOJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjBVOJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:09:35 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28BB360BF;
        Wed, 22 Feb 2023 06:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677074961; x=1708610961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wpLN1gd73bREF0yIjZJYHMzn1mN4hBeaWGTvbEXlUfo=;
  b=Azq6YuJESvn6/1RIOM074MqvimHijYiaIHM+vAzTYLCGEWrGCbUaKPiE
   DVylxULS9SAsmM6gtlrqpx20Z6ugt6c9g+W965Mb2Nba/ByoldUgqmeMc
   iTtENah/7KrQ2K24iEEQZD2oIRkuloTRbgxv2fx0mbt4ZvEMRY8sAuUte
   5ByxmtFzYPlYvPSOkItKeYvt5ZFFlRGYP0lTnoB9DK/K/LXrT6awl2llN
   HspAu9IYBdSSawvGLCbCyZsei7FuHNrAvm1JlDKB+8EHItQltsjNexQDH
   vOdXlpuUDiG88L/BcbhS5F8MCY9R8Cl+v5D1sxK5gJz8WIUhLPYXEssPu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="313305564"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="313305564"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 06:09:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="781446604"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="781446604"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 22 Feb 2023 06:09:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pUpne-00ARKq-0t;
        Wed, 22 Feb 2023 16:08:50 +0200
Date:   Wed, 22 Feb 2023 16:08:50 +0200
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
        linux-acpi@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v12 03/10] drm/display: Add Type-C switch helpers
Message-ID: <Y/Yh8tBa979G101H@smile.fi.intel.com>
References: <20230221095054.1868277-1-treapking@chromium.org>
 <20230221095054.1868277-4-treapking@chromium.org>
 <Y/SvhxgjTM2cYZa+@smile.fi.intel.com>
 <CAEXTbpcOA06Cf-niurjM4_3Rx6xa9Pi+fuJHUQCKmwaJL2ibmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXTbpcOA06Cf-niurjM4_3Rx6xa9Pi+fuJHUQCKmwaJL2ibmA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 04:53:41PM +0800, Pin-yen Lin wrote:
> On Tue, Feb 21, 2023 at 7:48 PM Andy Shevchenko
> > On Tue, Feb 21, 2023 at 05:50:47PM +0800, Pin-yen Lin wrote:

...

> > >  #include <linux/delay.h>
> > >  #include <linux/i2c.h>
> > > +#include <linux/usb/typec_mux.h>
> >
> > I don't see users of this.
> > But a few forward declarations are missing.
> 
> I can put a `struct typec_mux_dev;` here, but there is also a usage of
> typec_mux_set_fn_t.
> 
> Should I add the typedef into this header file as well?

No, inclusion is fine, it's me who didn't notice the type in use.

-- 
With Best Regards,
Andy Shevchenko


