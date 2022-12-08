Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240576472D7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiLHP02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLHP00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:26:26 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 597D0A468
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:26:25 -0800 (PST)
Received: (qmail 729470 invoked by uid 1000); 8 Dec 2022 10:26:24 -0500
Date:   Thu, 8 Dec 2022 10:26:24 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: storage: Add check for kcalloc
Message-ID: <Y5ICIG0z93TwcjQ9@rowland.harvard.edu>
References: <20221208110058.12983-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208110058.12983-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 07:00:58PM +0800, Jiasheng Jiang wrote:
> As kcalloc may return NULL pointer, the return value should
> be checked and return error if fails as same as the ones in
> alauda_read_map.
> 
> Fixes: e80b0fade09e ("[PATCH] USB Storage: add alauda support")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/storage/alauda.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
> index 747be69e5e69..5e912dd29b4c 100644
> --- a/drivers/usb/storage/alauda.c
> +++ b/drivers/usb/storage/alauda.c
> @@ -438,6 +438,8 @@ static int alauda_init_media(struct us_data *us)
>  		+ MEDIA_INFO(us).blockshift + MEDIA_INFO(us).pageshift);
>  	MEDIA_INFO(us).pba_to_lba = kcalloc(num_zones, sizeof(u16*), GFP_NOIO);
>  	MEDIA_INFO(us).lba_to_pba = kcalloc(num_zones, sizeof(u16*), GFP_NOIO);
> +	if (MEDIA_INFO(us).pba_to_lba == NULL || MEDIA_INFO(us).lba_to_pba == NULL)
> +		return USB_STOR_TRANSPORT_ERROR;
>  
>  	if (alauda_reset_media(us) != USB_STOR_XFER_GOOD)
>  		return USB_STOR_TRANSPORT_ERROR;
> -- 
> 2.25.1
> 
