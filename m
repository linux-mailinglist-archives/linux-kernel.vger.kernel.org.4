Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD87641C6E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 11:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiLDKy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 05:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiLDKyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 05:54:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC602BEA
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 02:54:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4812960E00
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 10:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B6EC433D6;
        Sun,  4 Dec 2022 10:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670151291;
        bh=X4A+RwjSy9Fvo9Pl+xfw+79UYV7LUSUA43XMnWFe9Yo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F2gRcFHCRvSYMXkIe40sYa8qSNGMfe5Pmqvuyorym/wMll96cwRVNwNB+TogVM8a5
         P/znLwN+F6u1UyOyiMNSIGsFrzE/tBvLqL+wv7we3k+0LR5UdUd+MIpm6A6xv0Rno1
         X9m/v3T/83LOsq6Wsae+il7NtaJh8q8dcgTV8FExMv+vWiUSy8Lp6PsNKflYYcjflB
         Ne/TFg8ZlA6MFnmyaKC2eh5nQe19oYKC9Xbd+nSi3ou6x4RAaH8QwOk4M1SD4zbncC
         5Jp/Mbm/g+ZFPU6EEEpnM622YFnG3D16MSyqFgp81LlTLB1UfBgoCWFo1XMOU7Z4Sc
         +ygcuETtg1rig==
Received: by pali.im (Postfix)
        id 5EB17895; Sun,  4 Dec 2022 11:54:48 +0100 (CET)
Date:   Sun, 4 Dec 2022 11:54:48 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>, Sinan Akman <sinan@writeme.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] powerpc/85xx: p2020: Create one unified machine
 description
Message-ID: <20221204105448.twotgo4rjd4uk32x@pali>
References: <20220819191557.28116-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220819191557.28116-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 August 2022 21:15:50 Pali Rohár wrote:
> This patch series unifies all P2020 boards and machine descriptions into
> one generic unified P2020 machine description. With this generic machine
> description, kernel can boot on any P2020-based board with correct DTS
> file.
> 
> Tested on CZ.NIC Turris 1.1 board with has Freescale P2020 processor.
> Kernel during booting correctly detects P2020 and prints:
> [    0.000000] Using Freescale P2020 machine description
> 
> Pali Rohár (7):
>   powerpc/85xx: Mark mpc85xx_rdb_pic_init() as static
>   powerpc/85xx: Mark mpc85xx_ds_pic_init() as static
>   powerpc/85xx: p2020: Move all P2020 machine descriptions to p2020.c
>   powerpc/85xx: p2020: Unify .setup_arch and .init_IRQ callbacks
>   powerpc/85xx: p2020: Define just one machine description
>   powerpc/85xx: p2020: Enable boards by new config option CONFIG_P2020
>   powerpc: dts: turris1x.dts: Remove "fsl,P2020RDB-PC" compatible string

Christophe, could you please summarize for me what is needed to change /
fix / adjust in this patch series? We had discussion about all patches
in this thread but I have not received reply for every my reaction. And
I'm not sure what to do and what not. So I can prepare a V2 version.

>  arch/powerpc/boot/dts/turris1x.dts            |   2 +-
>  arch/powerpc/platforms/85xx/Kconfig           |  22 ++-
>  arch/powerpc/platforms/85xx/Makefile          |   1 +
>  arch/powerpc/platforms/85xx/mpc85xx_ds.c      |  25 +--
>  arch/powerpc/platforms/85xx/mpc85xx_rdb.c     |  46 +-----
>  .../platforms/85xx/{mpc85xx_ds.c => p2020.c}  | 144 +++++++-----------
>  6 files changed, 75 insertions(+), 165 deletions(-)
>  copy arch/powerpc/platforms/85xx/{mpc85xx_ds.c => p2020.c} (53%)
> 
> -- 
> 2.20.1
> 
