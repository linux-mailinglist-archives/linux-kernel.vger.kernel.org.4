Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1686D3810
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 15:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjDBNQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 09:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBNQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 09:16:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FC15FFA
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 06:16:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1ED6B80E81
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 13:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A22C433EF;
        Sun,  2 Apr 2023 13:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680441372;
        bh=jnibmCt45iklluBfswBTDC0ZgT3EPyw8KU5oBm/VtLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mMXKWtNc6QdQRCKXFeoPGwjiJrBCOu6nqTs8R4fcViysabfnSUE/AKZqbP+7Y3QDv
         QDs88m36vbnL4IrxzQ0XqU91nXvyQ3+SAA7djzL6DpXyFIXo+R92wslErBbfAHIm9x
         1XiC04Sa8yx4cdzXWPeyPuGV4tpVfK7xI4waEDis=
Date:   Sun, 2 Apr 2023 15:16:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Angel Alberto Carretero <angelalbertoc.r@gmail.com>
Cc:     Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: loopback: fix up checkpath macro do
 while error.
Message-ID: <2023040252-racoon-daintily-3589@gregkh>
References: <20230402122550.70682-1-angelalbertoc.r@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230402122550.70682-1-angelalbertoc.r@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2023 at 02:25:51PM +0200, Angel Alberto Carretero wrote:
> Wrap macro in a do-while statement.
> 
> Signed-off-by: Angel Alberto Carretero <angelalbertoc.r@gmail.com>
> ---
>  drivers/staging/greybus/loopback.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
> index d7b39f3bb652..371809770ed0 100644
> --- a/drivers/staging/greybus/loopback.c
> +++ b/drivers/staging/greybus/loopback.c
> @@ -162,9 +162,11 @@ static ssize_t name##_avg_show(struct device *dev,		\
>  static DEVICE_ATTR_RO(name##_avg)
>  
>  #define gb_loopback_stats_attrs(field)				\
> -	gb_loopback_ro_stats_attr(field, min, u);		\
> -	gb_loopback_ro_stats_attr(field, max, u);		\
> -	gb_loopback_ro_avg_attr(field)
> +	do {		\
> +		gb_loopback_ro_stats_attr(field, min, u);		\
> +		gb_loopback_ro_stats_attr(field, max, u);		\
> +		gb_loopback_ro_avg_attr(field);		\
> +	} while (0)
>  
>  #define gb_loopback_attr(field, type)					\
>  static ssize_t field##_show(struct device *dev,				\
> -- 
> 2.40.0
> 
> 

Any specific reason why you did not test build your change before
submitting it?

thanks,

greg k-h
