Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5C86C0248
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 15:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjCSONN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 10:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCSONK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 10:13:10 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744E814497
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+bB39nUXZUXpT8dmSspChqOQmmtdTybwZ09z47fWgHc=;
  b=YrWcZpXE2w+Hk0Eew9gV7SHYeUUQuy0nTGdgtp6Pdjc6Z0qUMGKJ9X2G
   8KZNdI/nQ8mF55xcfC+qH6/AZ/CrXnqqI0X0WpI9PkKxLz2fCJN50jBiF
   rGRPqkgK5p+U4IJFAvd44e3ThNmwI7oUrBfa53dtgIiagFwLEyrUSTLBY
   o=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,273,1673910000"; 
   d="scan'208";a="50609676"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 15:13:05 +0100
Date:   Sun, 19 Mar 2023 15:13:04 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        namcaov@gmail.com, straube.linux@gmail.com, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8723bs: include: use inline functions for
 dvobj_to_dev
In-Reply-To: <20230319131030.151170-3-eng.mennamahmoud.mm@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2303191509330.2867@hadrien>
References: <20230319131030.151170-3-eng.mennamahmoud.mm@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How have you chosen the names at the beginning of the subject line?  The
other patches on this file don't have the word "include:" in the subject.
Please see the section "Following the Driver commit style" of the tutorial
to see what to do.


On Sun, 19 Mar 2023, Menna Mahmoud wrote:

> Convert `dvobj_to_dev` macro into static inline function,

"into a static inline function"

But the message is a bit too verbose.  Please see my suggestion on another
similar patch that was recently proposed.

julia

> because it is not great to have macro that use `container_of` macro,
> because from looking at the definition one cannot tell what type it applies to.
>
> One can get the same benefit from an efficiency point of view by making an
> inline function (concretely, typically a static inline function, because
> the definition only needs to be visible in the current file, or in the
> case of a header file in the file that includes the header file).
>
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
> ---
>  drivers/staging/rtl8723bs/include/drv_types.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
> index 82159e1c7f9b..ea6bb44c5e1d 100644
> --- a/drivers/staging/rtl8723bs/include/drv_types.h
> +++ b/drivers/staging/rtl8723bs/include/drv_types.h
> @@ -305,7 +305,11 @@ struct sdio_data intf_data;
>  };
>
>  #define dvobj_to_pwrctl(dvobj) (&(dvobj->pwrctl_priv))
> -#define pwrctl_to_dvobj(pwrctl) container_of(pwrctl, struct dvobj_priv, pwrctl_priv)
> +
> +static inline struct dvobj_priv *pwrctl_to_dvobj(struct pwrctrl_priv *pwrctl_priv)
> +{
> +	return container_of(pwrctl_priv, struct dvobj_priv, pwrctl_priv);
> +}
>
>  static inline struct device *dvobj_to_dev(struct dvobj_priv *dvobj)
>  {
> --
> 2.34.1
>
>
