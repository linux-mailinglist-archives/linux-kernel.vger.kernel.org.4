Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC2E6E5933
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjDRGQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjDRGQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:16:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6596F468E;
        Mon, 17 Apr 2023 23:16:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6B2162CFF;
        Tue, 18 Apr 2023 06:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91A2C433D2;
        Tue, 18 Apr 2023 06:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681798583;
        bh=jhLgevMsu3orYKO8vXOQraEaEey0j/z79iJrpMSNtIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cBWc+iUpVGUGQD/aR4PEGnf83S8CFqvFgivV5AVttJOkhmWpqpFO+1pBrFf+kh2sT
         f3cFO9ha6aVk1uMbvp7SDR/vnBuJR6xUcTcQpoEyMPFkW2Oof4PmA4BHiedl9n2Uct
         wbFRNzPrH9DRQ05og/8hRasp1Ka5lYjnsACnXV+Q=
Date:   Tue, 18 Apr 2023 08:16:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maxim Korotkov <korotkov.maxim.s@gmail.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] usb: typec: fix potential NULL dereference
Message-ID: <ZD41tLi3sMB71Xf2@kroah.com>
References: <20230417195003.19504-1-korotkov.maxim.s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417195003.19504-1-korotkov.maxim.s@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 10:50:03PM +0300, Maxim Korotkov wrote:
> The pointer 'adev' was being dereferenced before being checked for NULL
> in the 'type_alt mode_enter()' and 'type_alt mode_exit()' functions.
> Although this is a hypothetical issue, it's better to move the pointer
> assignment after the NULL check to avoid any potential problems.
> 
> Found by Linux Verification Center with Svace static analyzer.
> 
> Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
> Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>
> ---
>  drivers/usb/typec/bus.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
> index 098f0efaa58d..ae0aca8f33db 100644
> --- a/drivers/usb/typec/bus.c
> +++ b/drivers/usb/typec/bus.c
> @@ -125,13 +125,16 @@ EXPORT_SYMBOL_GPL(typec_altmode_notify);
>   */
>  int typec_altmode_enter(struct typec_altmode *adev, u32 *vdo)
>  {
> -	struct altmode *partner = to_altmode(adev)->partner;
> -	struct typec_altmode *pdev = &partner->adev;
> +	struct altmode *partner;
> +	struct typec_altmode *pdev;
>  	int ret;
>  
>  	if (!adev || adev->active)
>  		return 0;
>  
> +	partner = to_altmode(adev)->partner;
> +	pdev = &partner->adev;

As you point out, the original code is still fine here, we check before
we actually use these values.

Also, can adev every actually be NULL?  In looking at the code paths, I
can't see how that could happen.

thanks,

greg k-h
