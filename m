Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA340719FDE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbjFAO0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbjFAO0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:26:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5BBFC;
        Thu,  1 Jun 2023 07:26:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB10F645BF;
        Thu,  1 Jun 2023 14:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EC7C433D2;
        Thu,  1 Jun 2023 14:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685629590;
        bh=LONUfoM6zYh7zB03i9qk5MT1AVj55WLEaOknk51EKVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h6YlsJQoHZz/v2rrpK9OUxo6itcXgfTzCrqQs4rgAZNlCUSldbRaTKto5jI/RItUX
         hnjP90WKu3jsy7qZlTAMCDc7Slx5Bf2a1gt7bTwEtnqzJIeaoiskW8b35zgx4g/AFL
         A0ZhiRNp5JLKcIpBByQdvjN3+roLb4Chi08Gtsbg=
Date:   Thu, 1 Jun 2023 15:26:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 00/42] 6.1.32-rc1 review
Message-ID: <2023060101-coconut-smugness-4c7a@gregkh>
References: <20230601131939.051934720@linuxfoundation.org>
 <CA+G9fYuHjNhe-5TboAbrOeZrL3xL-CYYSaEnL=8onebLUqDt8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuHjNhe-5TboAbrOeZrL3xL-CYYSaEnL=8onebLUqDt8g@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 07:41:08PM +0530, Naresh Kamboju wrote:
> On Thu, 1 Jun 2023 at 18:57, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.1.32 release.
> > There are 42 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.32-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> 
> Following build errors noticed on 6.1 and 5.15.
> 
> drivers/dma/at_xdmac.c: In function 'atmel_xdmac_resume':
> drivers/dma/at_xdmac.c:2049:9: error: implicit declaration of function
> 'pm_runtime_get_noresume' [-Werror=implicit-function-declaration]
>  2049 |         pm_runtime_get_noresume(atxdmac->dev);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~
> drivers/dma/at_xdmac.c:2049:40: error: 'struct at_xdmac' has no member
> named 'dev'
>  2049 |         pm_runtime_get_noresume(atxdmac->dev);
>       |                                        ^~
> cc1: some warnings being treated as errors
> 
> reported link:
> https://lore.kernel.org/stable/CA+G9fYswtPyrYJbwcGFhc5o7mkRmWZEWCCeSjmR64M+N-odQhQ@mail.gmail.com/
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Ah, the .h file was added by 650b0e990cbd ("dmaengine: at_xdmac: add
runtime pm support"), which isn't needed here.  I'll go add it by hand
and push out some -rc2 releases for this and 5.15.y, thanks!

greg k-h
