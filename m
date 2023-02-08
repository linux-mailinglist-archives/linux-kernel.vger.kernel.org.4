Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8F368EEF2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 13:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjBHM1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 07:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBHM1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 07:27:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC1D65A8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 04:27:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA22D6165E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 12:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9011C433D2;
        Wed,  8 Feb 2023 12:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675859219;
        bh=JINlelHR8QkVhbjd76TSPX+lYSO5CIfrYvCp9C+F3jQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IefwqB6QW5gJuhs74BbnQM0+Yw4HVIuLVo0WY7tKIxiQsd2D6fUQpbxDzxsFqYmSY
         ygxRz/VNJl3xMjr8Z3GxYWfVvVGmIVc3gjEg5U4svfaVWud7Vi/jYP/u9fgOZyhNL9
         M44ilBNostkh2cZIOCT+Fh6lroUGgiP3BXTYiTg4=
Date:   Wed, 8 Feb 2023 13:26:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [char-misc-next v2 1/2] drm/i915/mtl: Define GSC Proxy component
 interface
Message-ID: <Y+OVEGNnQXZSxNdG@kroah.com>
References: <20230205181132.191064-1-tomas.winkler@intel.com>
 <20230205181132.191064-2-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230205181132.191064-2-tomas.winkler@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 08:11:31PM +0200, Tomas Winkler wrote:
> From: Alexander Usyskin <alexander.usyskin@intel.com>
> 
> GSC Proxy component is used for communication between the
> Intel graphics driver and MEI driver.
> 
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
> V2: This patch was missing in the first series.
> 
>  MAINTAINERS                                |  1 +
>  include/drm/i915_component.h               |  3 +-
>  include/drm/i915_gsc_proxy_mei_interface.h | 36 ++++++++++++++++++++++
>  3 files changed, 39 insertions(+), 1 deletion(-)
>  create mode 100644 include/drm/i915_gsc_proxy_mei_interface.h


Why do you add .h files in include/drm/ yet only use them in
drivers/mei/ ?

Shouldn't they just live in the mei subdir?  Especially given that you
also want to maintain them through the mei subsystem as per this change:

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c81bbb771678..2c432b4d8506 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10570,6 +10570,7 @@ S:	Supported
>  F:	Documentation/driver-api/mei/*
>  F:	drivers/misc/mei/
>  F:	drivers/watchdog/mei_wdt.c
> +F:	include/drm/i915_gsc_proxy_mei_interface.h
>  F:	include/linux/mei_aux.h
>  F:	include/linux/mei_cl_bus.h
>  F:	include/uapi/linux/mei.h

And I would need some i915 maintainer acks before I could take this in
my tree.

thanks,

greg k-h
