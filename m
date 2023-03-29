Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325146CDBA1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjC2OKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjC2OKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:10:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D8735A7;
        Wed, 29 Mar 2023 07:09:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A7A0B8233F;
        Wed, 29 Mar 2023 14:09:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B24C433EF;
        Wed, 29 Mar 2023 14:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680098955;
        bh=9lynLMkfJlpl0/geEJFWUVNSLRtWY6ohBkQxzVnlj/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ksIIuM1TVGDnKQZDp8EN6vjridqEQSGdUgFoC8Hei1O98taVwxIya366RuoQbCnR6
         Xni9pPcmfvnieMsKaCDZSye7bksr5RGFzTXz/1MlqOO9waUSlI+TrjC8t+UaEZUh57
         0p8SysMAcXnSg4SiqMivHP3y4/Cu18htLpu9sQkw=
Date:   Wed, 29 Mar 2023 16:09:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     corbet@lwn.net, conor@kernel.org,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: driver-api: firmware_loader: fix missing argument
 in usage example
Message-ID: <ZCRGiSyMuXrk9yCI@kroah.com>
References: <20230329123425.4177084-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329123425.4177084-1-conor.dooley@microchip.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 01:34:26PM +0100, Conor Dooley wrote:
> By the time firmware-upload support landed in commit 97730bbb242c
> ("firmware_loader: Add firmware-upload support"), the arguments for
> firmware_upload_register() had changed, and while this is automagically
> represented in the kernel doc bits, the usage example was not kept in
> sync.
> Add the missing argument as per the driver.
> 
> Fixes: 97730bbb242c ("firmware_loader: Add firmware-upload support")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> >From skimming the threads adding this stuff, looks like THIS_MODULE was
> always needed, so either I'm missing something or the doc stuff wasn't
> matching in any of the submitted versions.
> 
> CC: Jonathan Corbet <corbet@lwn.net>
> CC: Russ Weight <russell.h.weight@intel.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Tianfei zhang <tianfei.zhang@intel.com>
> CC: Luis Chamberlain <mcgrof@kernel.org>
> CC: linux-doc@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  Documentation/driver-api/firmware/fw_upload.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/firmware/fw_upload.rst b/Documentation/driver-api/firmware/fw_upload.rst
> index 76922591e446..edf1d0c5e7c3 100644
> --- a/Documentation/driver-api/firmware/fw_upload.rst
> +++ b/Documentation/driver-api/firmware/fw_upload.rst
> @@ -57,7 +57,8 @@ function calls firmware_upload_unregister() such as::
>  		len = (truncate) ? truncate - fw_name : strlen(fw_name);
>  		sec->fw_name = kmemdup_nul(fw_name, len, GFP_KERNEL);
>  
> -		fwl = firmware_upload_register(sec->dev, sec->fw_name, &m10bmc_ops, sec);
> +		fwl = firmware_upload_register(THIS_MODULE, sec->dev, sec->fw_name,
> +					       &m10bmc_ops, sec);

Good catch.  As this touches the firmware documentation, I can take it
in my tree, thanks!

greg k-h
