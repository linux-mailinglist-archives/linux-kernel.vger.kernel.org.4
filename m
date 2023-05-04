Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2FB6F67DB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjEDI6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjEDI6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:58:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2B5358A
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:58:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E30C63286
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 08:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3D0C433D2;
        Thu,  4 May 2023 08:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683190695;
        bh=WB9OO+EBIif8Ny5uYVvpRmtEyUuGxpVYXQ0OMAFnMXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EYnHKq5p6hmHN85ndecCLdeeKIY6uFQJe+9XBPB2LZTISgCBMGWRmxf3Ffo3T26Rh
         Ykfz4aR4Isg3spKhZggzoY0M3LIOXoS9qANMYVn5SKBSudBEZR2EE8YtSa0I+NfwTU
         0Z5xIi3GyhmrS2v39oss9UonSbn/NjUBSoifX6IY=
Date:   Thu, 4 May 2023 17:58:10 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rafael@kernel.org, andriy.shevchenko@linux.intel.com,
        hdegoede@redhat.com, jgg@ziepe.ca, saravanak@google.com,
        keescook@chromium.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, abel.vesa@linaro.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] devres: provide API devm_kstrndup
Message-ID: <2023050413-margin-devotedly-468d@gregkh>
References: <20230504075754.372780-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504075754.372780-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 03:57:54PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> This patch introduces devm_kstrndup API so that the
> device's driver can allocate memory and copy string.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/base/devres.c  | 28 ++++++++++++++++++++++++++++
>  include/linux/device.h |  1 +
>  2 files changed, 29 insertions(+)

We can not add apis with no users, please submit this at the same time a
driver needs it.

And what driver would need to copy a string?


> 
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index 5c998cfac335..87e2965e5bab 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -963,6 +963,34 @@ char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp)
>  }
>  EXPORT_SYMBOL_GPL(devm_kstrdup);
>  
> +/**
> + * devm_kstrndup - Allocate resource managed space and
> + *                copy an existing string into that.
> + * @dev: Device to allocate memory for
> + * @s: the string to duplicate
> + * @max: max length to duplicate
> + * @gfp: the GFP mask used in the devm_kmalloc() call when allocating memory
> + * RETURNS:
> + * Pointer to allocated string on success, NULL on failure.
> + */
> +char *devm_kstrndup(struct device *dev, const char *s, size_t max, gfp_t gfp)
> +{
> +	size_t len;
> +	char *buf;
> +
> +	if (!s)
> +		return NULL;
> +
> +	len = strnlen(s, max);
> +	buf = devm_kmalloc(dev, len + 1, gfp);
> +	if (buf) {
> +		memcpy(buf, s, len);
> +		buf[len] = '\0';

Why not use kstrndup() instead of copying the same logic here?

thanks,

greg k-h
