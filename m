Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD32676C3F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 12:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjAVLQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 06:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjAVLQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 06:16:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08511B552
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 03:16:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A3C660B9C
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 11:16:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93361C433D2;
        Sun, 22 Jan 2023 11:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674386194;
        bh=AunzTGYzeDZG64eMKvwgrxj6opCJIB+kNltC35V7dE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iKDLgckXZPUfcjT9BWm7RPTZAhExTI2CqG9A/UoTHS0VvCjVAXxSja6QaO8f+lpZf
         4igd4+XCik/q9UVQ4mXh58mG7izQ0wN0cAf6V9g+6t1UdBUxhUzqS3q27xk2Cwtd6f
         rhWmXKs+m8OaCnbxBdcR4IqyCDM9eMTCUZRJdN+Qxkrps3tIm5KGAGagAx7uTNlAic
         k/B7WHFt7zjg6mIHXYZo3jqrlEHgVd2UYon6uHLPmjSYjaqAwSgo4ipeNQL6rJUXlQ
         RR+Iev3Q2UYXVGN/Us7sWDj6Xqg5++QWta0AYOmOyIMwVPZTLu1tn/Tdew9WFiYylh
         HuAjWMj07IS4w==
Received: by pali.im (Postfix)
        id A3FFC93D; Sun, 22 Jan 2023 12:16:31 +0100 (CET)
Date:   Sun, 22 Jan 2023 12:16:31 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Scott Wood <oss@buserror.net>, Sinan Akman <sinan@writeme.com>,
        Martin Kennedy <hurricos@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] powerpc/85xx: p2020: Create one unified machine
 description
Message-ID: <20230122111631.dgw5uwtfjsqack57@pali>
References: <20221224211425.14983-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221224211425.14983-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello! Do you have any comments for this patch series?

On Saturday 24 December 2022 22:14:17 Pali Rohár wrote:
> This patch series unifies all P2020 boards and machine descriptions into
> one generic unified P2020 machine description. With this generic machine
> description, kernel can boot on any P2020-based board with correct DTS
> file.
> 
> Tested on CZ.NIC Turris 1.1 board with has Freescale P2020 processor.
> Kernel during booting correctly detects P2020 and prints:
> [    0.000000] Using Freescale P2020 machine description
> 
> Changes in v2:
> * Added patch "p2020: Move i8259 code into own function" (separated from the next one)
> * Renamed CONFIG_P2020 to CONFIG_PPC_P2020
> * Fixed descriptions
> 
> Link to v1: https://lore.kernel.org/linuxppc-dev/20220819191557.28116-1-pali@kernel.org/
> 
> Pali Rohár (8):
>   powerpc/85xx: Mark mpc85xx_rdb_pic_init() as static
>   powerpc/85xx: Mark mpc85xx_ds_pic_init() as static
>   powerpc/85xx: p2020: Move all P2020 machine descriptions to p2020.c
>   powerpc/85xx: p2020: Move i8259 code into own function
>   powerpc/85xx: p2020: Unify .setup_arch and .init_IRQ callbacks
>   powerpc/85xx: p2020: Define just one machine description
>   powerpc/85xx: p2020: Enable boards by new config option
>     CONFIG_PPC_P2020
>   powerpc: dts: turris1x.dts: Remove "fsl,P2020RDB-PC" compatible string
> 
>  arch/powerpc/boot/dts/turris1x.dts        |   2 +-
>  arch/powerpc/platforms/85xx/Kconfig       |  22 ++-
>  arch/powerpc/platforms/85xx/Makefile      |   1 +
>  arch/powerpc/platforms/85xx/mpc85xx_ds.c  |  25 +--
>  arch/powerpc/platforms/85xx/mpc85xx_rdb.c |  46 +-----
>  arch/powerpc/platforms/85xx/p2020.c       | 193 ++++++++++++++++++++++
>  6 files changed, 215 insertions(+), 74 deletions(-)
>  create mode 100644 arch/powerpc/platforms/85xx/p2020.c
> 
> -- 
> 2.20.1
> 
