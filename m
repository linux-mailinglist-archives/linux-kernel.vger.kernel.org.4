Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3105F0BAD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiI3MZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiI3MYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:24:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D1DD6D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 05:24:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1CA262311
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE43DC433D6;
        Fri, 30 Sep 2022 12:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664540691;
        bh=gw4uy+OJSbBCFmLpGyxFPSyMbSJHYjmDGwhUaCPGUQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zP4PMGO0PCU2Ftg77Wpemze2pFkAf3nZSRujTPgACYbgCYqKVxeyge5f2hWLivxew
         vBcQ/G+t/kjlSVGvyCHd+7FOt7h2ooqRrtHcuHgtQ5R5Eq9DnL8ns9UTHXYfDWlFYP
         stnXnFqbQYvFLJoh+OLuNF99xDci+pZLN3TfBCmc=
Date:   Fri, 30 Sep 2022 14:24:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     hsweeten@visionengravers.com, abbotti@mev.co.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] comedi: Convert snprintf() to sysfs_emit()
Message-ID: <YzbgEOA8mC0MmRY8@kroah.com>
References: <YzRK3Ye3FKTe8p4y@octinomon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzRK3Ye3FKTe8p4y@octinomon>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 02:23:41PM +0100, Jules Irenge wrote:
> Coccinnelle reports a warning
> Warning: Use scnprintf or sprintf
> 
> Adding to that, there has been a slow migration from snprintf to scnprintf.
> This LWN article explains the rationale for this change
> 
> https: //lwn.net/Articles/69419/
> ie. snprintf() returns what *would* be the resulting length,
>  while scnprintf() returns the actual length.

None of this is needed or relevant for this change.

> 
> However following the advice on
> https://www.kernel.org/doc/html/latest/filesystems/sysfs.html
> 
> For show(device *...) functions we should only use sysfs_emit() or sysfs_emit_at()
>  especially when formatting the value to be returned to user space.
> 
> Hence here
> We convert to sysfs_emit() that even does better and shorten the code
> using the same rationale of scnprintf()
> 
> Signed-off-by: Jules Irenge <jules.irenge@postgrad.manchester.ac.uk>
> ---
> 
> v2: Replace scnprintf() with sysfs_emit()
> 
>  drivers/comedi/comedi_fops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
> index 55a0cae04b8d..a6017fafcb2a 100644
> --- a/drivers/comedi/comedi_fops.c
> +++ b/drivers/comedi/comedi_fops.c
> @@ -396,7 +396,7 @@ static ssize_t max_read_buffer_kb_show(struct device *csdev,
>  	mutex_unlock(&dev->mutex);
>  
>  	comedi_dev_put(dev);
> -	return snprintf(buf, PAGE_SIZE, "%u\n", size);
> +	return sysfs_emit(buf, "%u\n", size);
>  }
>  
>  static ssize_t max_read_buffer_kb_store(struct device *csdev,

Does not apply to my tree :(

thanks,

greg k-h
