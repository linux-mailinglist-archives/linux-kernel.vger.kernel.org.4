Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533585B351D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 12:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiIIKXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 06:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiIIKXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:23:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991DC128966
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 03:23:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F93461F6F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 10:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF0FC433D6;
        Fri,  9 Sep 2022 10:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662718996;
        bh=FfE1rJR6SoQbtNJ6+IRKFmVG9deQF+tAuwlWHLSNdJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z7G6M2WYDBnSqeRqMxAyvB+IjoIsFzb27VylT7zTP/mZGNJmZf2dVUmPsjBG0Z05D
         bogYDD7EhkEIOsTtqgPYb8hcuPfUBhrq9OYfJDfupszK4cUtPBrRLy0WE8XlzKUHXd
         fLnxm0g7NbfTxtS83c+mes7Y4R51z1y66zKJsFjY=
Date:   Fri, 9 Sep 2022 12:23:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nam Cao <namcaov@gmail.com>
Cc:     forest@alittletooquiet.net, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: vt6655: use memset to make code clearer
Message-ID: <YxsUEUqbKRW85Z24@kroah.com>
References: <20220909090856.18427-1-namcaov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909090856.18427-1-namcaov@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 11:08:57AM +0200, Nam Cao wrote:
> A line of code sets the entire struct vnt_rdes0 to zero by treating it as
> unsigned int. This works because sizeof(unsigned int) is equal to
> sizeof(struct vnt_rdes0) (4 bytes). However it is not obvious what this
> code is doing. Re-write this using memset to make the code clearer.
> 
> Signed-off-by: Nam Cao <namcaov@gmail.com>
> ---
> v2: re-write commit message because previous message describes a
> non-existent problem.
> 
>  drivers/staging/vt6655/device_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
> index 8e2a976aaaad..a38657769c20 100644
> --- a/drivers/staging/vt6655/device_main.c
> +++ b/drivers/staging/vt6655/device_main.c
> @@ -867,7 +867,7 @@ static bool device_alloc_rx_buf(struct vnt_private *priv,
>  		return false;
>  	}
>  
> -	*((unsigned int *)&rd->rd0) = 0; /* FIX cast */
> +	memset((void *)&rd->rd0, 0, sizeof(rd->rd0));

Why do you have to cast this to (void *)?  That should almost never be
needed.

thanks,

greg k-h
