Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312575EBA55
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 08:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiI0GG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 02:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiI0GG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 02:06:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F84A59BC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 23:06:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC116B81992
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B9BC433D6;
        Tue, 27 Sep 2022 06:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664258782;
        bh=ELNhhCi+S5ZqZBiReMIGnz1u6k1WzveV05AquK4V1+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uR1U/UyeXKZJ+AHBMQ+Bo5NnTdVRBKl8zqiteJ+kUZLmiGYaqK+ez9vr1POdJBj4U
         8ss5ugOXkdibUQgT4vnsW+AtxT9wWNTNN5yCOUGTnKEqvgcsTWpEPTy9PuTUuw/DpE
         RV6WoNHgA3A+b65zzjRaXNHAmMeLzKsIwxVOr/Fo=
Date:   Tue, 27 Sep 2022 08:06:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] comedi: Convert snprintf() to scnprintf()
Message-ID: <YzKS/3z2cQsFFfxD@kroah.com>
References: <YzHxcb5VzWeSNKo0@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzHxcb5VzWeSNKo0@fedora>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 07:37:37PM +0100, Jules Irenge wrote:
> Coccinnelle reports a warning
> Warning: Use scnprintf or sprintf
> Adding to that, there has been a slow migration from snprintf to scnprintf.
> This LWN article explains the rationale for this change
> https: //lwn.net/Articles/69419/
> Ie. snprintf() returns what *would* be the resulting length,
> while scnprintf() returns the actual length.
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  drivers/comedi/comedi_fops.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
> index 55a0cae04b8d..e8a0142d5894 100644
> --- a/drivers/comedi/comedi_fops.c
> +++ b/drivers/comedi/comedi_fops.c
> @@ -396,7 +396,7 @@ static ssize_t max_read_buffer_kb_show(struct device *csdev,
>  	mutex_unlock(&dev->mutex);
>  
>  	comedi_dev_put(dev);
> -	return snprintf(buf, PAGE_SIZE, "%u\n", size);
> +	return scnprintf(buf, PAGE_SIZE, "%u\n", size);

Ick, no, you should use sysfs_emit() if you really want to change these
functions to "do the right thing".

thanks,

greg k-h
