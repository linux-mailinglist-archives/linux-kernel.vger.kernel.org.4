Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBA868BC96
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 13:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjBFMQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 07:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBFMQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 07:16:01 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2131815B;
        Mon,  6 Feb 2023 04:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675685760; x=1707221760;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=/sfAfGJA6/XxqLEnP+hho0W1Nhw3gCWgj1LKpNZa/So=;
  b=XUJKzco//yWIItKBAOwJE0JHvb8VXqeGJlTk7MbDkKaXY8p2851y1hhq
   bax7NGIP0VWi3L5UOA2y4cfeUbesP/x8IwF/AitiMFd1CBg+ESSzQTo0/
   mrbFq75W9xDhevQBowc0zMYKduxez7rUcxR/sYSFAfrbVC42o3IQMQoVN
   Kq1g5b9GK8K7XS3wUjIJJKKgSxrkanyJxPVd5Vpoqo0/XFI99auAXwz8M
   9jqNSHapugPwDyRqz5QjCfHuCgN2/w0Kibu2Occyp40h9VKRCQRHK6des
   zM09r8wA926mbqR5/epRlNrgAh8poBUo0WD/HqmgNdGDRBbuXiuZQ5Rvb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="329206643"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="329206643"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 04:15:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="729990155"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="729990155"
Received: from hayatibx-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.62.213])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 04:15:49 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
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
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Pr?= =?utf-8?Q?ado?= 
        <nfraprado@collabora.com>, Hsin-Yi Wang <hsinyi@chromium.org>,
        devicetree@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>,
        Lyude Paul <lyude@redhat.com>, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>,
        Xin Ji <xji@analogixsemi.com>,
        Stephen Boyd <swboyd@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        chrome-platform@lists.linux.dev,
        Alex Deucher <alexander.deucher@amd.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Imre Deak <imre.deak@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v11 3/9] drm/display: Add Type-C switch helpers
In-Reply-To: <Y+Dtwm39cGQO58xa@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230204133040.1236799-1-treapking@chromium.org>
 <20230204133040.1236799-4-treapking@chromium.org>
 <Y+Dtwm39cGQO58xa@smile.fi.intel.com>
Date:   Mon, 06 Feb 2023 14:15:46 +0200
Message-ID: <87k00vyop9.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Feb 2023, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> On Sat, Feb 04, 2023 at 09:30:34PM +0800, Pin-yen Lin wrote:
>> Add helpers to register and unregister Type-C "switches" for bridges
>> capable of switching their output between two downstream devices.
>> 
>> The helper registers USB Type-C mode switches when the "mode-switch"
>> and the "reg" properties are available in Device Tree.
>
> ...
>
>> +	fwnode_for_each_child_node(port, sw) {
>> +		if (fwnode_property_present(sw, "mode-switch"))
>
> This idiom is being used at least twice (in this code, haven't checked the rest
> of the patches, though), perhaps
>
> #define fwnode_for_each_typec_mode_switch(port, sw)			\
> 	fwnode_for_each_child_node(port, sw)				\
> 		if (!fwnode_property_present(sw, "mode-switch")) {} else
>
> ?

See for_each_if() in drm_util.h.


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
