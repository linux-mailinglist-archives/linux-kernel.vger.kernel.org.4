Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00D6740144
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjF0Qc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbjF0QcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:32:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC523595;
        Tue, 27 Jun 2023 09:32:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B36D611D8;
        Tue, 27 Jun 2023 16:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA8FC433C0;
        Tue, 27 Jun 2023 16:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687883536;
        bh=p3EvKGU59+hD5m9qSyESw/ZXbFaiyZSKzEhNI6ZWGL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gWLGnVhWDBHvyqAfkgUtlAd3ilHkpkaHbBFmRiVOjFf3qmweZDmdzxz6NYrfyRdhh
         1gpGzcqDNeWx0ulFx+9eDzml0CN7Bs0imCY52jKXfeD9lJvyjUXnphHkWR/41PLKmJ
         Mr3+DjDcM9varbMfJmFJgUk/z7dMC/Wqs5Fs04h7UJhP+4+L8uzxOCw5OO66V98u3H
         mPXSfnZECFE1/rpHOkTFcN8MFYqG7B1OQTayVz3hM9lrp6hGn2rnEgxTfOjspQb4XG
         56bWfIDMAWbtrsfGwwsAltwW6CYb8UfFhTQ8CsfvsRPAoozWh7J7EOFPFPO11rLdIQ
         1dXWqFuaVH5aw==
Date:   Tue, 27 Jun 2023 09:32:14 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Subject: Re: [PATCH 0/2] Fix cross-compilation issues with Clang
Message-ID: <20230627163214.GA665894@dev-arch.thelio-3990X>
References: <20230627130122.1491765-1-kernel@xen0n.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627130122.1491765-1-kernel@xen0n.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 09:01:20PM +0800, WANG Xuerui wrote:
> From: WANG Xuerui <git@xen0n.name>
> 
> Hi,
> 
> Just some quick fixes to the recently accepted Clang patches, thanks to
> Nathan's followup testing. (I test-compiled natively so didn't notice

It is good to hear that everything works natively as well :)

> that cross-compilation was broken, and by chance the LLVM snapshot I
> used didn't contain the breaking commit either.)

And we can already see this effort making the compiler better! The
problematic LLVM patch is only a week old so we were able to catch it
before it made it into a released version. Thanks again for the work you
have done getting this working so far.

Cheers,
Nathan

> 
> With an additional LLVM patch https://reviews.llvm.org/D153865 the Clang
> builds should now get fixed.
> 
> WANG Xuerui (2):
>   LoongArch: vDSO: Use CLANG_FLAGS instead of filtering out '--target='
>   LoongArch: Include KBUILD_CPPFLAGS in CHECKFLAGS invocation
> 
>  arch/loongarch/Makefile      | 2 +-
>  arch/loongarch/vdso/Makefile | 5 +----
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> -- 
> 2.40.0
> 
