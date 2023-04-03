Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A58F6D4D5A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjDCQRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjDCQRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:17:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A181723
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:17:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1777861652
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 16:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F11FC433D2;
        Mon,  3 Apr 2023 16:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680538660;
        bh=n7zG9i+G0oJqHAkYUbqTXe1DM4QRG8s3OB/teNAHDMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0SrBk35/VutKtNvwUKP86QW6ZcAgWYk6PohLh6o7XBf4l1Ey6FI4jebMX5cdcIy0C
         f0NhUQj/pVCKPyPRY4onkN3b0jBsfLFGAiZ3XVtrODgX4Jpjm6bvJNX+xXwg6v/snp
         l21CLXYakurexNduzHz0F0f5vZanpcDB2+LRBAhU=
Date:   Mon, 3 Apr 2023 18:17:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     linux-kernel@vger.kernel.org, nikhil.agarwal@amd.com, git@amd.com,
        michal.simek@amd.com, pieter.jansen-van-vuuren@amd.com
Subject: Re: [PATCH] cdx: change struct bus_type for sysfs rescan callback as
 constant
Message-ID: <2023040325-dehydrate-pectin-92fe@gregkh>
References: <20230403140416.28183-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403140416.28183-1-nipun.gupta@amd.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 07:34:16PM +0530, Nipun Gupta wrote:
> As store prototype in struct bus_attribute has been updated
> to have bus_type as constant, change the CDX sysfs entries to
> follow the same.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> ---
> 
> The bus attributes are marked as constant in patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=75cff725d9566699a670a02b3cfd1c6e9e9ed53e
> 
>  drivers/cdx/cdx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> index 67c32cb2c006..38511fd36325 100644
> --- a/drivers/cdx/cdx.c
> +++ b/drivers/cdx/cdx.c
> @@ -363,7 +363,7 @@ static struct attribute *cdx_dev_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(cdx_dev);
>  
> -static ssize_t rescan_store(struct bus_type *bus,
> +static ssize_t rescan_store(const struct bus_type *bus,
>  			    const char *buf, size_t count)
>  {
>  	struct cdx_controller *cdx;
> -- 
> 2.17.1
> 

Thanks, I'll hold onto this for the -rc1 merge.

greg k-h
