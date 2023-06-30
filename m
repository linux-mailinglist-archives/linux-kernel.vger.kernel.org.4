Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8156974348E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjF3Fu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjF3FuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C318CEC;
        Thu, 29 Jun 2023 22:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 460F8616BD;
        Fri, 30 Jun 2023 05:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1336BC433C8;
        Fri, 30 Jun 2023 05:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688104221;
        bh=ESK2G48YltYCxadHZpYQGs+sh5/rH0av8mftNPwo74w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zzgSDOpSRmMfnHUxxICmQO7XNFeYAmAZ0dt9gyjPGuUpC4S3Ks+JemIjUHr5Dqcve
         3tMucQ4Z5T9Cd1DlaPFdAumMhO0PnTKuKJpXE2gwLmPVTtmtoBxLcn66PbDFFCg5ny
         yqvmk4YSRWCZ9vyRZGX3xzCZvc0pMjPLGKorh19g=
Date:   Fri, 30 Jun 2023 07:50:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.3 00/29] 6.3.11-rc1 review
Message-ID: <2023063057-viewpoint-bottle-aec6@gregkh>
References: <20230629184151.705870770@linuxfoundation.org>
 <CAEUSe7__cNqH6d1D96m8XriVckS9MnL6CRfd+iTYXnNkqu9nvQ@mail.gmail.com>
 <2023063037-matrix-urologist-030d@gregkh>
 <CAEUSe7-K199dv5_11O877i4pWYtCkaZU2zrsfVo4-QnNPdPQ+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEUSe7-K199dv5_11O877i4pWYtCkaZU2zrsfVo4-QnNPdPQ+A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 11:25:13PM -0600, Daniel Díaz wrote:
> Hello!
> 
> On Thu, 29 Jun 2023 at 23:19, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Thu, Jun 29, 2023 at 03:54:03PM -0600, Daniel Díaz wrote:
> > > Hello!
> > >
> > > Early report of failures.
> > >
> > > Arm64 fails with GCC-11 on the following configurations:
> > > * lkftconfig
> > > * lkftconfig-64k_page_size
> > > * lkftconfig-debug
> > > * lkftconfig-debug-kmemleak
> > > * lkftconfig-kasan
> > > * lkftconfig-kselftest
> > > * lkftconfig-kunit
> > > * lkftconfig-libgpiod
> > > * lkftconfig-perf
> > > * lkftconfig-rcutorture
> > >
> > > lkftconfig is basically defconfig + a few fragments [1]. The suffixes
> > > mean that we're enabling a few other kconfigs.
> > >
> > > Failure:
> > > -----8<-----
> > > /builds/linux/arch/arm64/mm/fault.c: In function 'do_page_fault':
> > > /builds/linux/arch/arm64/mm/fault.c:576:9: error: 'vma' undeclared
> > > (first use in this function); did you mean 'vmap'?
> > >   576 |         vma = lock_mm_and_find_vma(mm, addr, regs);
> > >       |         ^~~
> > >       |         vmap
> > > /builds/linux/arch/arm64/mm/fault.c:576:9: note: each undeclared
> > > identifier is reported only once for each function it appears in
> > > /builds/linux/arch/arm64/mm/fault.c:579:17: error: label 'done' used
> > > but not defined
> > >   579 |                 goto done;
> > >       |                 ^~~~
> > > make[4]: *** [/builds/linux/scripts/Makefile.build:252:
> > > arch/arm64/mm/fault.o] Error 1
> > > make[4]: Target 'arch/arm64/mm/' not remade because of errors.
> > > ----->8-----
> >
> > Is this also failing in Linus's tree?
> 
> (Sorry for the previous top-post.)
> 
> No, only here on 6.3.

Ok, found the problem, will push out a -rc2 now, thanks for the quick
notice!

greg k-h
