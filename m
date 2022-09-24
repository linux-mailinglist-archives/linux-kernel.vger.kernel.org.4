Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0145E8CAC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 14:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiIXMmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 08:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIXMmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 08:42:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148D98C47E
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 05:42:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A764B60B0A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 12:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB10FC433D6;
        Sat, 24 Sep 2022 12:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664023333;
        bh=6iWK7MK63UXpCUFl7W57m3jhiTiWw7+4+ckgt+e0Lts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fjOn8i6tQaf/A+OxVzTK+jqElgTlTWlTxWeN2RIMCAp8qYHIz6ChUbHzcJeHPlgWZ
         H8AG3/5CGf1BxosP3gUgw0V4ZZxlbNIUKzT2m3qvrsed9HAxjZo2bCEIpNCOLEHfg1
         k/TqzXbD0yryl8eaVn5StOaq+Amd9aAYvmI94sBrnkHJ8cVeih73gWCbbXC2ZtbExi
         SkLUuue5oDGgqWgUWwxE3lunOiuiwya2ZRzDioZr0vpwya7lAq8EQArsdD64d+0TOc
         y1Q67VmIO3d8FZALNL1D9knLvTnnXuqoSC52WI5q0VQ8moKLksPk4UnP0NaTMDN35o
         ea8S/1mojVTog==
Received: by pali.im (Postfix)
        id 0F31C8A2; Sat, 24 Sep 2022 14:42:10 +0200 (CEST)
Date:   Sat, 24 Sep 2022 14:42:09 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sinan Akman <sinan@writeme.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] powerpc/85xx: p2020: Create one unified machine
 description
Message-ID: <20220924124209.7vxsvfdoxbtntegs@pali>
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

Hello! Any comments for these patches?

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
> 
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
