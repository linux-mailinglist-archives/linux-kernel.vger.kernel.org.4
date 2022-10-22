Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62402608B43
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 12:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiJVKHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 06:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiJVKHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 06:07:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D9E32F014;
        Sat, 22 Oct 2022 02:23:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7412560ADF;
        Sat, 22 Oct 2022 08:17:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697FFC433D7;
        Sat, 22 Oct 2022 08:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666426650;
        bh=6Q2uxz1B7vfOOGyexsJzzI/HLQ9fABoGPQ9qwp8rvBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V6dGJEiheLMmdnSNzgyi0y3/G2rjlocKrFCAWE9AEcWwrIWXgdIU+Vv1glszc2Apj
         Ps4HZYMaUlBC0rHRQx1zqyKX/VUgBQPLJOp7bgpuvAVTByuePBtLlqpC03d8GZuBiI
         v0l/aJaF1raSY5rJ2t/qioyfX7y8f223UJMgzWkM=
Date:   Sat, 22 Oct 2022 10:07:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Scott J. Crouch" <scottjcrouch@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        kernel-janitors@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vchiq: add 'static' to function definition
Message-ID: <Y1Okpjbi2kKU2GFz@kroah.com>
References: <20221022043548.1671644-1-scottjcrouch@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221022043548.1671644-1-scottjcrouch@gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 03:35:48PM +1100, Scott J. Crouch wrote:
> This fixes the following sparse error:
> 
>     warning: symbol 'vchiq_platform_init' was not declared. Should it be static?
> 
> Signed-off-by: Scott J. Crouch <scottjcrouch@gmail.com>
> ---
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index dc33490ba7fb..ffa517077b80 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -462,7 +462,7 @@ free_pagelist(struct vchiq_instance *instance, struct vchiq_pagelist_info *pagel
>  	cleanup_pagelistinfo(instance, pagelistinfo);
>  }
>  
> -int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
> +static int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct vchiq_drvdata *drvdata = platform_get_drvdata(pdev);
> -- 
> 2.37.3
> 
> 

Nice try, but this breaks the build in a very horrible and strange way
that no one has been able to figure out yet:

 CC [M]  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.o
In file included from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:16:
In function ‘memcpy_to_page’,
    inlined from ‘free_pagelist’ at drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:433:4,
    inlined from ‘vchiq_complete_bulk’ at drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:648:3:
./include/linux/highmem.h:377:9: error: argument 2 null where non-null expected [-Werror=nonnull]
  377 |         memcpy(to + offset, from, len);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from ./arch/x86/include/asm/string.h:5,
                 from ./include/linux/string.h:20,
                 from ./include/linux/bitmap.h:11,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/cpumask.h:5,
                 from ./arch/x86/include/asm/msr.h:11,
                 from ./arch/x86/include/asm/processor.h:22,
                 from ./arch/x86/include/asm/timex.h:5,
                 from ./include/linux/timex.h:67,
                 from ./include/linux/time32.h:13,
                 from ./include/linux/time.h:60,
                 from ./include/linux/stat.h:19,
                 from ./include/linux/module.h:13,
                 from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:8:
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c: In function ‘vchiq_complete_bulk’:
./arch/x86/include/asm/string_64.h:19:14: note: in a call to function ‘memcpy’ declared ‘nonnull’
   19 | extern void *memcpy(void *to, const void *from, size_t len);
      |              ^~~~~~
In file included from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:16:
In function ‘memcpy_to_page’,
    inlined from ‘free_pagelist’ at drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:440:4,
    inlined from ‘vchiq_complete_bulk’ at drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:648:3:
./include/linux/highmem.h:377:9: error: ‘memcpy’ offset 0 is out of the bounds [0, 0] [-Werror=array-bounds]
  377 |         memcpy(to + offset, from, len);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors


So we can't take this patch.

Also remember to always test-build your patches before sending them.

thanks,

greg k-h
