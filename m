Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DF1686E9E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjBATFe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Feb 2023 14:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBATF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:05:27 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65457DAF;
        Wed,  1 Feb 2023 11:05:25 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pNIQ7-000zP1-12; Wed, 01 Feb 2023 20:05:23 +0100
Received: from p57bd9464.dip0.t-ipconnect.de ([87.189.148.100] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pNIQ6-0004hu-Mn; Wed, 01 Feb 2023 20:05:22 +0100
Message-ID: <2f10003fcf3671ccdd285952ba76153f5c2d5307.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] maple: remove unneeded maple_bus_uevent() callback.
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 01 Feb 2023 20:05:21 +0100
In-Reply-To: <20230201125642.624255-1-gregkh@linuxfoundation.org>
References: <20230201125642.624255-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.148.100
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg!

On Wed, 2023-02-01 at 13:56 +0100, Greg Kroah-Hartman wrote:
> The driver core recently changed the uevent bus callback to take a const
> pointer, and the maple_bus_uevent() was not correctly fixed up.  Instead
> of fixing the function parameter types, just remove the callback
> entirely as it does not do anything, so it is not necessary.
> 
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Fixes: 2a81ada32f0e ("driver core: make struct bus_type.uevent() take a const *")
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> sh maintainers, I'll take this through my tree as that's where the
> offending commit is that causes the build breakage.
> 
>  drivers/sh/maple/maple.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
> index e24e220e56ee..e05473c5c267 100644
> --- a/drivers/sh/maple/maple.c
> +++ b/drivers/sh/maple/maple.c
> @@ -760,12 +760,6 @@ static int maple_match_bus_driver(struct device *devptr,
>  	return 0;
>  }
>  
> -static int maple_bus_uevent(struct device *dev,
> -			    struct kobj_uevent_env *env)
> -{
> -	return 0;
> -}
> -
>  static void maple_bus_release(struct device *dev)
>  {
>  }
> @@ -782,7 +776,6 @@ static struct maple_driver maple_unsupported_device = {
>  struct bus_type maple_bus_type = {
>  	.name = "maple",
>  	.match = maple_match_bus_driver,
> -	.uevent = maple_bus_uevent,
>  };
>  EXPORT_SYMBOL_GPL(maple_bus_type);

Through which tree is this supposed to be picked up?

FWIW, we have set up a new SH tree now, but I am not designated as an official
SH maintainer yet which is what I would like to become in order to support
Rich Felker.

Adrian 

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
