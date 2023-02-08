Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6DD68FB0E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 00:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBHXUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 18:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjBHXUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 18:20:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638A726B7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 15:20:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3B64B81F05
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 23:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9496C43446;
        Wed,  8 Feb 2023 23:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675898415;
        bh=40KDbh9yQUF8FPl1H4ih3NBtJXrxGdDQYYikp1QWG/8=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=lorDt2UYnrxLxu+JIs8ExivCnkceibDIzMwiJP8Ayh4qHx4+9MtJnhbzX9c5TMrkr
         P/mhxJtVHvWTlZMwKfUxbpTNYpKd3O6lD3PHmGBFYL4PqkqKj3E1hbOtwBJnsKx3qo
         j+Su6DnRQsyCswqYku5SaxzOuh/mu2jMNgtkMRLstoeXZNW82RtoINIMWzk2YZ1wJF
         7GooWYmhGxxu8YTLETWbAS1MMGf2oXKoyIqf0dlZaYIabtgodF24XsNIwbj5RSR5Yy
         BePyDnn9erZTiCMDCVpLd7O9tThLoKIVzfagJwqTef0f5veHe+73LBiEpzUup6H+lo
         ADNUZXBs5ZCIw==
Date:   Wed, 08 Feb 2023 23:20:10 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>, palmer@rivosinc.com
CC:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        christoph.muellner@vrull.eu, ajones@ventanamicro.com,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH 1/2] RISC-V: fix ordering of Zbb extension
User-Agent: K-9 Mail for Android
In-Reply-To: <20230208225328.1636017-2-heiko@sntech.de>
References: <20230208225328.1636017-1-heiko@sntech.de> <20230208225328.1636017-2-heiko@sntech.de>
Message-ID: <C32D5495-F772-4887-9CAD-66206ECCFC3F@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Heiko,

On 8 February 2023 22:53:27 GMT, Heiko Stuebner <heiko@sntech=2Ede> wrote:
>From: Heiko Stuebner <heiko=2Estuebner@vrull=2Eeu>
>
>As Andrew reported,
>    Zb* comes after Zi* according 27=2E11 "Subset Naming Convention"
>so fix the ordering accordingly=2E
>
>Reported-by: Andrew Jones <ajones@ventanamicro=2Ecom>
>Signed-off-by: Heiko Stuebner <heiko=2Estuebner@vrull=2Eeu>

The whole "getting it wrong immediately after fixing it up" ;)

Reviewed-by: Conor Dooley <conor=2Edooley@microchip=2Ecom>

>---
> arch/riscv/kernel/cpu=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/riscv/kernel/cpu=2Ec b/arch/riscv/kernel/cpu=2Ec
>index 420228e219f7=2E=2E8400f0cc9704 100644
>--- a/arch/riscv/kernel/cpu=2Ec
>+++ b/arch/riscv/kernel/cpu=2Ec
>@@ -185,9 +185,9 @@ arch_initcall(riscv_cpuinfo_init);
>  * New entries to this struct should follow the ordering rules described=
 above=2E
>  */
> static struct riscv_isa_ext_data isa_ext_arr[] =3D {
>-	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
> 	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
> 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
>+	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
> 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
> 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
