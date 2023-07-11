Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2411F74F0EF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbjGKOAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGKOAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:00:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C9CE69
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:00:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69110614F9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 14:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78241C433C8;
        Tue, 11 Jul 2023 14:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689084040;
        bh=hwuogJ3ObcfPVVmSWTKMTekt8luIJ5KDC/wJPa8q7cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MVKpNUtrvulQtO37zr4Pu9uuJI3y/k4cn24YAeUF/aUsrlj1axOER/BibykldFdlw
         qGZEuLPhpNvX/W4R6+WUrZMjHWnYQEDwekAmGQ+oV0s6hnvTRdqtxU/oRQuBXwDWcv
         a3oVQYK4kjNPBNuakiBaIqU12wikFYSL4sX2lfpg=
Date:   Tue, 11 Jul 2023 16:00:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc:     linux-kernel@vger.kernel.org, Nipun.Gupta@amd.com,
        nikhil.agarwal@amd.com, puneet.gupta@amd.com, git@amd.com,
        michal.simek@amd.com,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: Re: [PATCH 3/4] cdx: create sysfs resource files
Message-ID: <2023071148-grievance-gulf-0841@gregkh>
References: <20230711121027.936487-1-abhijit.gangurde@amd.com>
 <20230711121027.936487-4-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711121027.936487-4-abhijit.gangurde@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 05:40:26PM +0530, Abhijit Gangurde wrote:
> Resource files provides the basic MMIO regions info to the
> user-space. Also, resources<x> devices can be used to mmap the
> MMIO regions in the user-space.
> 
> Co-developed-by: Puneet Gupta <puneet.gupta@amd.com>
> Signed-off-by: Puneet Gupta <puneet.gupta@amd.com>
> Co-developed-by: Nipun Gupta <nipun.gupta@amd.com>
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cdx |  15 +++
>  drivers/cdx/cdx.c                       | 139 +++++++++++++++++++++++-
>  include/linux/cdx/cdx_bus.h             |  10 ++
>  3 files changed, 163 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
> index d9e00058471d..6ca47b6442ce 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cdx
> +++ b/Documentation/ABI/testing/sysfs-bus-cdx
> @@ -76,3 +76,18 @@ Description:
>  		For example::
>  
>  		  # echo 1 > /sys/bus/cdx/devices/.../remove
> +
> +What:		/sys/bus/cdx/devices/.../resource
> +Date:		July 2023
> +Contact:	puneet.gupta@amd.com
> +Description:
> +		The resource file contains host addresses of CDX device
> +		resources. Each line of the resource file describes a region
> +		with start, end, and flag fields.

If you documented what this file looked like here, it would be obvious
that this is not an acceptable sysfs file in any sense of the word.

Please do so, and then fix the patch to not do that at all.

thanks,

greg k-h
