Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1378364FECA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 12:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiLRLnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 06:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLRLnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 06:43:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDBCBE26
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 03:43:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C79560D2C
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 11:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994CAC433EF;
        Sun, 18 Dec 2022 11:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671363811;
        bh=G4lxT8N0O3pm0OMYLg7tXb0zKAcmSwn3RAxSly4BLRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S+6Ygp7xe0MxYQIyINyKhEiQSb6b4S6P9rDILgVwh806UPWn+XUzPBDeoYuVH0NSo
         C+rVAy89xQQM/6EzPNjuQV6iu4EPOVH65+NupwpuOxipF86NlmSOmNCgSCXtmtRPOd
         r1BMseMpssYxPqdfjfGoM6lNWR1wRuKQr97PpR7w=
Date:   Sun, 18 Dec 2022 12:43:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     linux-kernel@vger.kernel.org, laforge@gnumonks.org, arnd@arndb.de,
        linux@dominikbrodowski.net, baijiaju1990@gmail.com
Subject: Re: [PATCH] Revert "char: pcmcia: cm4000_cs: Replace mdelay with
 usleep_range in set_protocol"
Message-ID: <Y5783zWoitPPyoOG@kroah.com>
References: <20221128053915.90474-1-duoming@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128053915.90474-1-duoming@zju.edu.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 01:39:15PM +0800, Duoming Zhou wrote:
> This reverts commit be826ada52f1fcabed5b5217c94609ebf5967211.
> 
> The function monitor_card() is a timer handler that runs in an
> atomic context, but it calls usleep_range() that can sleep.
> As a result, the sleep-in-atomic-context bugs will happen.
> The process is shown below:
> 
>     (atomic context)
> monitor_card()
>   set_protocol()
>     usleep_range() //sleep
> 
> The origin commit c1986ee9bea3 ("[PATCH] New Omnikey Cardman
> 4000 driver") works fine.
> 
> Fixes: be826ada52f1 ("char: pcmcia: cm4000_cs: Replace mdelay with usleep_range in set_protocol")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
>  drivers/char/pcmcia/cm4000_cs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
> index adaec8fd4b1..7125f89531f 100644
> --- a/drivers/char/pcmcia/cm4000_cs.c
> +++ b/drivers/char/pcmcia/cm4000_cs.c
> @@ -529,7 +529,7 @@ static int set_protocol(struct cm4000_dev *dev, struct ptsreq *ptsreq)
>  			DEBUGP(5, dev, "NumRecBytes is valid\n");
>  			break;
>  		}
> -		usleep_range(10000, 11000);
> +		mdelay(10);
>  	}
>  	if (i == 100) {
>  		DEBUGP(5, dev, "Timeout waiting for NumRecBytes getting "
> @@ -549,7 +549,7 @@ static int set_protocol(struct cm4000_dev *dev, struct ptsreq *ptsreq)
>  			}
>  			break;
>  		}
> -		usleep_range(10000, 11000);
> +		mdelay(10);

Can you add a comment that says "can not sleep as this is atomic
context" for these calls so that this doesn't get changed again in the
future?

thanks,

greg k-h
