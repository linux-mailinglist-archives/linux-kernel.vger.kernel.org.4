Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDAE61FB23
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbiKGRWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiKGRWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:22:02 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9792315C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:22:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8CA9FCE16E0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 17:21:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B76DC433D7;
        Mon,  7 Nov 2022 17:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667841717;
        bh=I73tNza4oxz8JX4yGvw/47qdbUlRa9qyt36gyUC68qY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Hfq/PCBTSirpCpEvqjM6/q+o3q1tAAJbMNmyPnIGlLcvgwCPVNCQfyjycNO6BXj0K
         FpAPlRG1zH5GQGo8+NvMt0QiZwtqrnPlRUunSiB81PeR1M8yIiNBSjy1CLSK2zF9Sw
         OiqLDSzUjGLZIWqeoLttICGwWzB2Kv89qSq9m1SCsa0suthy9mkD4tWul39OM1nX4l
         yYhhRPWbDjpmPDt6PEb2BReKaJl+oO9K1wprRkZ22anYTQb+qr6Mi+b/UX4fR37U51
         4X22DNjH9fX29+0nOCB+AwuO8o8glPBhUrxbP3wbEpCVlDAWcAMJuqtX9ZmGBrYKKK
         3nlJNfN7LXLoA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Chris Stillson <stillson@rivosinc.com>
Cc:     Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 04/17] riscv: Add vector feature to compile
In-Reply-To: <20220921214439.1491510-4-stillson@rivosinc.com>
References: <20220921214439.1491510-1-stillson@rivosinc.com>
 <20220921214439.1491510-4-stillson@rivosinc.com>
Date:   Mon, 07 Nov 2022 18:21:54 +0100
Message-ID: <87zgd2d6j1.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cropping the huge Cc:-list.]

Chris Stillson <stillson@rivosinc.com> writes:

> From: Guo Ren <guoren@linux.alibaba.com>
>
> This patch adds a new config option which could enable assembler's
> vector feature.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Co-developed-by: Greentime Hu <greentime.hu@sifive.com>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  arch/riscv/Kconfig  | 15 +++++++++++++--
>  arch/riscv/Makefile |  1 +
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index ed66c31e4655..e294d85bfb7d 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -432,7 +432,17 @@ config FPU
>=20=20
>  	  If you don't know what to do here, say Y.
>=20=20
> -endmenu # "Platform type"
> +config VECTOR
> +	bool "VECTOR support"
> +	depends on GCC_VERSION >=3D 120000 || CLANG_VERSION >=3D 130000
> +	default n
> +	help
> +	  Say N here if you want to disable all vector related procedure
> +	  in the kernel.
> +
> +	  If you don't know what to do here, say Y.
> +
> +endmenu

"VECTOR" is not really consistent to how the other configs are named;
RISCV_ISA_V, RISCV_ISA_VECTOR, RISCV_VECTOR?


Bj=C3=B6rn
