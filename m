Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD43721079
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 16:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjFCOgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 10:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjFCOgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 10:36:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97718185;
        Sat,  3 Jun 2023 07:36:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16B9D61422;
        Sat,  3 Jun 2023 14:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98DAC433EF;
        Sat,  3 Jun 2023 14:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685802967;
        bh=B+VdiPG1FamBWIcbL30jkM0gvYJcncxHC7Q7s8oufQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0jY4nmSgiELJKYg4YCDn9bXebdz06ax8y8CzYZvrdNYupY+uwwQtxj67CJgz3d4pY
         EsrI/O6jlYkqzgwFoQYxVqXPvny7sCRSm8MSEdZd1gjT3F3E/b14yvabxfPuq0kASa
         zTU0z2EdtQwg1tfPBt3WveI8rK4kSk0/OGgnRkCE=
Date:   Sat, 3 Jun 2023 16:36:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.15 00/37] 5.15.115-rc2 review
Message-ID: <2023060350-mountable-deploy-09bd@gregkh>
References: <20230601143331.405588582@linuxfoundation.org>
 <CAEUSe7-qcYwBbeFGKAOvf-rPMdgAMfE6t42Urnhjam9nWN-gFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEUSe7-qcYwBbeFGKAOvf-rPMdgAMfE6t42Urnhjam9nWN-gFg@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 10:17:48PM -0600, Daniel Díaz wrote:
> Hello!
> 
> On Thu, 1 Jun 2023 at 08:36, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.15.115 release.
> > There are 37 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 03 Jun 2023 14:33:22 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.115-rc2.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Build failures on System/390:
> -----8<-----
>   /builds/linux/arch/s390/kernel/uv.c: In function
> 'should_export_before_import':
>   /builds/linux/arch/s390/kernel/uv.c:204:40: error: 'mm_context_t'
> has no member named 'protected_count'
>     204 |         return atomic_read(&mm->context.protected_count) > 1;
>         |                                        ^
>   /builds/linux/arch/s390/kernel/uv.c:205:1: error: control reaches
> end of non-void function [-Werror=return-type]
>     205 | }
>         | ^
> ----->8-----
> 
> That's with defconfig and GCC-8, GCC-12, Clang-16.

Thanks, I've dropped the broken patches now and will push out a -rc3.

greg k-h
