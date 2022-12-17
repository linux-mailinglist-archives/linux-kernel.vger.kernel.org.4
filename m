Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6044864F6AE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 02:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiLQBKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 20:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiLQBK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 20:10:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4E61D303
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 17:10:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA736B81E04
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 01:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A256C433D2;
        Sat, 17 Dec 2022 01:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671239424;
        bh=Qm/lVWvY5E4nVZ/Q+YcB9XTqpC6qJE2EwMv9F0W5Q2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GQAQYkJzdhrp57gPVbOjQRmjth1uLBE320uqyXsqTW0slFz1tg6JqePJD1BavRmIV
         8xt0e+KQ1M/3ewWtrkxSg24JHdLH1C/kckBlDrTxnOKRXDa7jPH4oiBMlULTyxPD7w
         bBrkekdZzbtpsKUA2e2DbaiM8iLneDaOpYRDq6fMN9AcTU0FBjapf88inmErRIj2uq
         A/le4q700JdH3oCLuXrizDFwKZQZfWW+1/jIhJ209lxhCg/kSevhiVhHwjYK6Qqvom
         IQHC2YpwiUAaWj5JrHg2+8cIDDw0sfvAZnurnKgRxvCKupRhURQ5KX+Yzn9iqtj73G
         n7S9XUA5D3AFg==
Received: by pali.im (Postfix)
        id 70565B01; Sat, 17 Dec 2022 02:10:21 +0100 (CET)
Date:   Sat, 17 Dec 2022 02:10:21 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [PATCH v2] powerpc: Pass correct CPU reference to assembler
Message-ID: <20221217011021.zr4k2wqdh5nnryw7@pali>
References: <01fe73614988e2402a7526fb6b6e903bc3777bb5.1671179743.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01fe73614988e2402a7526fb6b6e903bc3777bb5.1671179743.git.christophe.leroy@csgroup.eu>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 December 2022 09:35:50 Christophe Leroy wrote:
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index bf5f0a998273..528452ce80b4 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -201,18 +201,20 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
>  # often slow when they are implemented at all
>  KBUILD_CFLAGS		+= $(call cc-option,-mno-string)
>  
> -cpu-as-$(CONFIG_40x)		+= -Wa,-m405
> -cpu-as-$(CONFIG_44x)		+= -Wa,-m440
>  cpu-as-$(CONFIG_ALTIVEC)	+= $(call as-option,-Wa$(comma)-maltivec)
> -cpu-as-$(CONFIG_PPC_E500)		+= -Wa,-me500
> +
> +ifeq ($(CONFIG_TARGET_CPU),powerpc)
> +cpu-as-$(CONFIG_TARGET_CPU_BOOL)	+= -Wa,-mppc
> +else
> +cpu-as-$(CONFIG_TARGET_CPU_BOOL)	+= -Wa,-m$(CONFIG_TARGET_CPU)
> +endif

This change will break compilation for e500 cores. Kconfig sets
CONFIG_TARGET_CPU to string "8540" for e500 cores because gcc uses
-mcpu=8540 for e500 but GNU AS uses -me500 for e500 cores.
