Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2FC6C04C5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 21:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjCSUWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 16:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjCSUV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 16:21:57 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4DF1C58F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 13:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=x+ow5H6ZRwxY3FT/gO9W5VcrbplwcdLAEUZd96OYdCo=;
  b=N2z7sVO6Bc/h9gYAwrT9PCjWZ+fWVIdbw1VlH7Gao4LzIV2j0RiRilxz
   FiCuI7DN15n+7mFr/WiezdM5zsLKxHsCxIVQe+GdFK4LnPn3E6jHrr0EZ
   eIxv2CLfdkBYpua9cfT7GrAl+6dSNVTE331UaiB+/arYDKUrU7/2jXxg8
   8=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,274,1673910000"; 
   d="scan'208";a="97959289"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 21:21:54 +0100
Date:   Sun, 19 Mar 2023 21:21:53 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH] staging: greybus: use inline function for macros
In-Reply-To: <20230319201324.253874-1-eng.mennamahmoud.mm@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2303192121170.2867@hadrien>
References: <20230319201324.253874-1-eng.mennamahmoud.mm@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Mar 2023, Menna Mahmoud wrote:

> Convert `to_gbphy_dev` and `to_gbphy_driver` macros into a
> static inline functions.
>
> it is not great to have macro that use `container_of` macro,
> because from looking at the definition one cannot tell what type
> it applies to.
>
> One can get the same benefit from an efficiency point of view
> by making an inline function.
>
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
> ---
>  drivers/staging/greybus/gbphy.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/greybus/gbphy.h b/drivers/staging/greybus/gbphy.h
> index 1de510499480..42c4e3fe307c 100644
> --- a/drivers/staging/greybus/gbphy.h
> +++ b/drivers/staging/greybus/gbphy.h
> @@ -16,7 +16,10 @@ struct gbphy_device {
>  	struct device dev;
>  };
>

You have made the patch against your previous patch that added a newline
here.  It should be against Greg's tree.

julia

> -#define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
> +static inline struct gbphy_device *to_gbphy_dev(const struct device *d)
> +{
> +	return container_of(d, struct gbphy_device, dev);
> +}
>
>  static inline void *gb_gbphy_get_data(struct gbphy_device *gdev)
>  {
> @@ -45,7 +48,10 @@ struct gbphy_driver {
>  	struct device_driver driver;
>  };
>
> -#define to_gbphy_driver(d) container_of(d, struct gbphy_driver, driver)
> +static inline struct gbphy_driver *to_gbphy_driver(struct device_driver *d)
> +{
> +	return container_of(d, struct gbphy_driver, driver);
> +}
>
>  int gb_gbphy_register_driver(struct gbphy_driver *driver,
>  			     struct module *owner, const char *mod_name);
> --
> 2.34.1
>
>
