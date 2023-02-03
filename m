Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5CE68A3CC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 21:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjBCUsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 15:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjBCUst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 15:48:49 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 8BEE5945D5
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 12:48:48 -0800 (PST)
Received: (qmail 575339 invoked by uid 1000); 3 Feb 2023 15:48:47 -0500
Date:   Fri, 3 Feb 2023 15:48:47 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Karina Yankevich <k.yankevich@omp.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] usb: storage: sddr55: avoid integer overflow
Message-ID: <Y91zL8OWTUd8iTXt@rowland.harvard.edu>
References: <20230203201821.483477-1-k.yankevich@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203201821.483477-1-k.yankevich@omp.ru>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 11:18:21PM +0300, Karina Yankevich wrote:
> We're possibly losing information by shifting an int.
> Fix it by adding the necessary cast.

Nonsense.  The card's _total_ capacity is no larger than 128 MB, so a 
page address can't possibly overflow an int.

Alan Stern

> Found by OMP on behalf of Linux Verification Center
> (linuxtesting.org) with SVACE.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Karina Yankevich <k.yankevich@omp.ru>
> ---
>  drivers/usb/storage/sddr55.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/storage/sddr55.c b/drivers/usb/storage/sddr55.c
> index 15dc25801cdc..4aeff73de147 100644
> --- a/drivers/usb/storage/sddr55.c
> +++ b/drivers/usb/storage/sddr55.c
> @@ -236,7 +236,7 @@ static int sddr55_read_data(struct us_data *us,
>  			memset (buffer, 0, len);
>  		} else {
>  
> -			address = (pba << info->blockshift) + page;
> +			address = ((unsigned long)pba << info->blockshift) + page;
>  
>  			command[0] = 0;
>  			command[1] = LSB_of(address>>16);
> @@ -411,7 +411,7 @@ static int sddr55_write_data(struct us_data *us,
>  			command[4] = 0x40;
>  		}
>  
> -		address = (pba << info->blockshift) + page;
> +		address = ((unsigned long)pba << info->blockshift) + page;
>  
>  		command[1] = LSB_of(address>>16);
>  		command[2] = LSB_of(address>>8); 
> -- 
> 2.39.1
> 
