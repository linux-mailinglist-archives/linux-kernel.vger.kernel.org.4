Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A6F6BFBCB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 18:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCRRPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 13:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjCRRPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 13:15:33 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D322528E9D;
        Sat, 18 Mar 2023 10:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=t/EnRKvaSnN9nj3FCPFC2n3uFwpintvP56OIP4eUTpc=;
  b=vmKmoiSAsEE7+29gvZm9kauac+0MnkZONYLN5iMTnArlATVW1DevI2S/
   wVODkWnxwZxXhxMEGx7meeRjxEcGYCx3Ie16PE0LcfaFG0kpYTYtHmkix
   vC/rkOfL3LNsTfdKa0h3D8pYx8eXkwEA4ZPTwPI8KNnjuGbJ+LDPBk5BA
   s=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,271,1673910000"; 
   d="scan'208";a="97891427"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 18:14:50 +0100
Date:   Sat, 18 Mar 2023 18:14:50 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Sumitra Sharma <sumitraartsy@gmail.com>
cc:     Marc Dietrich <marvin24@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] Staging: nvec: Change container_of macro to an inline
 function.
In-Reply-To: <20230318170514.GA49181@sumitra.com>
Message-ID: <alpine.DEB.2.22.394.2303181811260.2914@hadrien>
References: <20230318170514.GA49181@sumitra.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Mar 2023, Sumitra Sharma wrote:

> The macro has the drawback that one cannot determine
> what type it applies to by looking at the definition.
> Hence this macro definition is not type-safe.
>
> The inline function gives the same benefits as the
> macro and only accepts the specific type of arguments.
> Use static because the definition only requires it to be
> visible in the current file.

Sumitra,

The subject line and log message could be a little less generic.  For the
subject line, one has the impression that you are changing the definition
of container_of itself.

The log message is also a bit wordy.  Something like the following would
be more concise and still present the issue:

Convert to_nvec_led from a macro to an inline function, to make the
relevant types apparent in the definition and to benefit from the type
checking performed by the compiler at call sites.

julia


>
> Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> ---
>  drivers/staging/nvec/nvec_paz00.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/nvec/nvec_paz00.c b/drivers/staging/nvec/nvec_paz00.c
> index 8b4da95081c8..9573ba762cdd 100644
> --- a/drivers/staging/nvec/nvec_paz00.c
> +++ b/drivers/staging/nvec/nvec_paz00.c
> @@ -14,8 +14,10 @@
>  #include <linux/platform_device.h>
>  #include "nvec.h"
>
> -#define to_nvec_led(led_cdev) \
> -	container_of(led_cdev, struct nvec_led, cdev)
> +static inline struct nvec_led *to_nvec_led(struct led_classdev *led_cdev)
> +{
> +	return container_of(led_cdev, struct nvec_led, cdev);
> +}
>
>  #define NVEC_LED_REQ {'\x0d', '\x10', '\x45', '\x10', '\x00'}
>
> --
> 2.25.1
>
>
>
