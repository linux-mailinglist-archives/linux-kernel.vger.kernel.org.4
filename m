Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF4B60006C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiJPPJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiJPPJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:09:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AB2E27
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 08:09:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 188C660BEE
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 15:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB13FC433D6;
        Sun, 16 Oct 2022 15:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665932963;
        bh=LkZdo4C2etXIVshfF7HoMh8gk7bTmamu8NWJxVgV6ss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IuWrDb9zRcOdm/rFvubwvMCe9R+XIrTQGZDpQk0LBJ3rSqUro1C1064e1xiwMwzd8
         28JpdeBEGig6elOdA6QNOQVg16Zd5OaI+DjIhaGXT2nu4rBLflOxXuxB5O5BQ4J5fN
         dwB1vZIP7dj5unPXSGSWLbk1bjZ2QsVR0vGfTVLQ=
Date:   Sun, 16 Oct 2022 17:10:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     outreachy@lists.linux.dev, pure.logic@nexus-software.ie,
        johan@kernel.org, elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: loopback: enclose macro statements in
 do-while loop
Message-ID: <Y0we0XPpye+Vjznr@kroah.com>
References: <Y0wS4HQo9m/W/TrQ@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0wS4HQo9m/W/TrQ@debian-BULLSEYE-live-builder-AMD64>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 10:19:12AM -0400, Deepak R Varma wrote:
> Include multiple statements of macro definition inside do-while{0} loop
> to avoid possible partial program execution. Issue reported by
> checkpatch script:
> 
> ERROR: Macros with multiple statements should be enclosed in a do - while loop
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  drivers/staging/greybus/loopback.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
> index 1a61fce98056..37214cb43937 100644
> --- a/drivers/staging/greybus/loopback.c
> +++ b/drivers/staging/greybus/loopback.c
> @@ -163,9 +163,11 @@ static ssize_t name##_avg_show(struct device *dev,		\
>  static DEVICE_ATTR_RO(name##_avg)
> 
>  #define gb_loopback_stats_attrs(field)				\
> +do {								\
>  	gb_loopback_ro_stats_attr(field, min, u);		\
>  	gb_loopback_ro_stats_attr(field, max, u);		\
> -	gb_loopback_ro_avg_attr(field)
> +	gb_loopback_ro_avg_attr(field);				\
> +} while (0)
> 
>  #define gb_loopback_attr(field, type)					\
>  static ssize_t field##_show(struct device *dev,				\
> --
> 2.30.2

Always test-build your changes before sending them out so you do not get
grumpy maintainers asking why you did not test-build your changes.

Also, don't bindly trust that checkpatch is always correct, you need to
read the C code to verify that it is a sane request.

thanks,

greg k-h
