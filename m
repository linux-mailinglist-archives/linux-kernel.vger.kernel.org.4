Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5C26F6E62
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjEDO4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjEDOz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:55:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC179EE9
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 07:54:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53AE26301C
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 14:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC219C433D2;
        Thu,  4 May 2023 14:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683212052;
        bh=TmACzxlSeb+WERvLsvXQwELOey/j51OsQ52OPnlwneM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RGc7/jfZgBMqdOT/Q8ZklvtXELuPyC9G8Adup84Tf9khzhzWdDv88vQQ9IDmJm1Sf
         1n4pccodaWrjOOxU2AuhH0AhIf+m75+vtQOctPrO6jmPvVaoQPuaazFvTkDj3ZNCcs
         KxlZJowPBY61AortnBGbZBlPSZKNmF2RT4k+MD6kTJmdctso3MMxdpxf+KgWg7YI3t
         h7TvpRp4hQ3t65AbR3jzyG4LkkR10bddkOijzbDvowHKWwjpWhdRqbA1jpg/nWKPh7
         p91/odYPl18phx6XoRXPLc0MerVB7Vh/KE/eL4BlsoeVvQy/kkeOMc6FRbd/DjbBIr
         ANWGE77uzyqFQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1puaLc-0004eW-Oc; Thu, 04 May 2023 16:54:21 +0200
Date:   Thu, 4 May 2023 16:54:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jacopo Mondi <jacopo.mondi@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: staging: greybus: fix GPF issue in
 gb_camera_capture
Message-ID: <ZFPHHImqiVRRV5Cd@hovoldconsulting.com>
References: <20230504135841.1566958-1-dzm91@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504135841.1566958-1-dzm91@hust.edu.cn>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 09:58:41PM +0800, Dongliang Mu wrote:
> In gb_camera_capture(), it does not check the value of settings
> before dereferencing it. And gb_camera_debugfs_capture calls
> gb_camera_capture with the 6th parameter settings as NULL.

Looks like you just broke gb_camera_debugfs_capture() which relies on
passing NULL as settings.

> Fix this by checking the value of setting at the starting of
> gb_camera_capture.
> 
> Fixes: 3265edaf0d70 ("greybus: Add driver for the camera class protocol")
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  drivers/staging/greybus/camera.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
> index cdbb42cd413b..5a4b26e7f645 100644
> --- a/drivers/staging/greybus/camera.c
> +++ b/drivers/staging/greybus/camera.c
> @@ -659,7 +659,7 @@ static int gb_camera_capture(struct gb_camera *gcam, u32 request_id,
>  	size_t req_size;
>  	int ret;
>  
> -	if (settings_size > GB_CAMERA_MAX_SETTINGS_SIZE)
> +	if (settings_size > GB_CAMERA_MAX_SETTINGS_SIZE || !settings)
>  		return -EINVAL;
>  
>  	req_size = sizeof(*req) + settings_size;

Johan
