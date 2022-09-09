Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D545B3156
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiIIIIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIIIIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:08:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D4110E859
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 01:08:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DD06B823CB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C10C433C1;
        Fri,  9 Sep 2022 08:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662710894;
        bh=BEEAJt3FrfRKaGdrMeSMHYVN70A8IJdJOsUKIwcPUwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rtLzayYmoSW/4FDm8L9kBBAybnyOAVcg5hrghsFx0+NykW2AKTGHfv2vivvvyteKO
         ijVIsXq7eumnCS21u4EbJUmz9i17BefkMYaFRa4vAgHolMRGWiUaeTHBdIJn4wxbdr
         SgCITPdlO71VGXy8HPx18GC3AOoiaPDvtSAAOCUM=
Date:   Fri, 9 Sep 2022 10:08:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bo Liu <liubo03@inspur.com>
Cc:     sudipm.mukherjee@gmail.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppdev: check ida_simple_get() return value
Message-ID: <Yxr0a3fnLUsPnyJL@kroah.com>
References: <20220907023642.2333-1-liubo03@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907023642.2333-1-liubo03@inspur.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 10:36:42PM -0400, Bo Liu wrote:
> As ida_simple_get() can fail, we should check the return value.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  drivers/char/ppdev.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
> index 38b46c7d1737..13b58b6823ee 100644
> --- a/drivers/char/ppdev.c
> +++ b/drivers/char/ppdev.c
> @@ -300,6 +300,11 @@ static int register_device(int minor, struct pp_struct *pp)
>  	}
>  
>  	index = ida_simple_get(&ida_index, 0, 0, GFP_KERNEL);
> +	if (index < 0) {
> +		rc = index;
> +		goto err;
> +	}
> +
>  	memset(&ppdev_cb, 0, sizeof(ppdev_cb));
>  	ppdev_cb.irq_func = pp_irq;
>  	ppdev_cb.flags = (pp->flags & PP_EXCL) ? PARPORT_FLAG_EXCL : 0;
> -- 
> 2.27.0
> 

You just leaked a memory reference here :(

How did you test this?  What tool caused this to be changed?  Please fix
up your tool to not add problems when it is attempting to fix problems,
as that's a never-ending cycle we do not want to be in :(

thanks,

greg k-h
