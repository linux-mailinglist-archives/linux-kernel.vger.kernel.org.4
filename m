Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89000691E28
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjBJL0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBJL0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:26:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE2D6C7E7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 03:26:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85AA461D94
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 11:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DFDC4339E;
        Fri, 10 Feb 2023 11:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676028369;
        bh=AQlWuKp6toHoLgza03+Gx7b3g0pV0/0mKTYxTl8YFhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b+mP8HkhbtmhF5s08T2hM30orJorut8sLG55i29/duuhac3y/PqtUDgRC9Ywfu5sD
         R+jYqoLyGTY02GmuTgUQqx1H0QUaugGMclQGyHEgEYJhbBz1EEo6EZW5oPEq1FSz8m
         Ru0DRW/6FjdmRtjAO9ZfTDv017mN4kuIACrhqLgk=
Date:   Fri, 10 Feb 2023 12:26:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anton Gusev <aagusev@ispras.ru>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] staging/wlan-ng: Check hfa384x_dowmem result in
 hfa384x_drvr_flashdl_write
Message-ID: <Y+YpzpZ7SXOp2Neu@kroah.com>
References: <20230209161836.29991-1-aagusev@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209161836.29991-1-aagusev@ispras.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 07:18:36PM +0300, Anton Gusev wrote:
> In hfa384x_drvr_flashdl_write, hfa384x_dowmem is called in a cycle
> without checking the result. Ignoring an error there may lead to an
> incorrect flash download buffer value during the consequent write.

Did you reproduce this on a running system?

> Found by Linux Verification Center (linuxtesting.org) with SVACE.

How was this tested?  If not tested you HAVE TO SAY SO!  Especially when
dealing with random tools that we know nothing about.

> 
> Signed-off-by: Anton Gusev <aagusev@ispras.ru>
> ---
>  drivers/staging/wlan-ng/hfa384x_usb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/staging/wlan-ng/hfa384x_usb.c b/drivers/staging/wlan-ng/hfa384x_usb.c
> index c7cd54171d99..baac5c02f904 100644
> --- a/drivers/staging/wlan-ng/hfa384x_usb.c
> +++ b/drivers/staging/wlan-ng/hfa384x_usb.c
> @@ -1880,6 +1880,12 @@ int hfa384x_drvr_flashdl_write(struct hfa384x *hw, u32 daddr,
>  						writepage,
>  						writeoffset,
>  						writebuf, writelen);
> +			if (result) {
> +				netdev_err(hw->wlandev->netdev,
> +					   "dowmem(page=%x,offset=%x,data=%p,len=%d) failed, result=%d. Aborting d/l\n",
> +					   writepage, writeoffset, writebuf, writelen, result);
> +				return result;
> +			}
>  		}
>  
>  		/* set the download 'write flash' mode */
> -- 
> 2.39.1
> 
> 

Please fix up your tool, this patch does not follow the pattern of the
rest of the "exit on error" paths in this function so of course I'm not
going to accept this.

At this point, it really really feels like something needs to change
with your submissions, they are not working well :(

{sigh}

greg k-h
