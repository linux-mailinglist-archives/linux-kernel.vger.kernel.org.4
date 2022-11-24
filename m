Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BA16380B0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 22:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiKXVez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 16:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKXVex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 16:34:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B9EB8FBA;
        Thu, 24 Nov 2022 13:34:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F321B828FE;
        Thu, 24 Nov 2022 21:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD20CC433C1;
        Thu, 24 Nov 2022 21:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669325690;
        bh=G7tq99AoCNw2Xyp3xJA4Kg8jdEf+0S2KwzmYMu05gZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q1i92Ptk1p413+xx6gb1nSmnsGxUb5Xkqkp95JWpTQ9eg2pXbiOjU0XSXYIXL/MFL
         01fvTBXkG5FiiW6jfAoKUuh7SrtGfcllYKQbX883f8ZpxgYw1R3djENPzwV9nA2hc7
         2TE/mdLfC79dz4ROChtLoAqiV2pNt1YdmgY1cvNoAt9LKhg300t2OuGu4tufIzSDi8
         uWmKuYlWndEQN13vqxr+jlL4t21d9sRYkSbny/xZ6LqGO7jA5p6AOtfQQvGXgJyyAP
         MkEV7JuLXhsvIEk1fytfkIi+QioU2tyjhqxlrs/jVX8SyPLv+fl0sazHR+E60L50K+
         g3SdkzCUNYv+A==
Date:   Thu, 24 Nov 2022 21:34:43 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 7/7] soc: renesas: Add L2 cache management for RZ/Five
 SoC
Message-ID: <Y3/jc1g8uEHdyqwp@spud>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y3/ivrvx4A+OImtW@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3/ivrvx4A+OImtW@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 09:31:42PM +0000, Conor Dooley wrote:
> On Thu, Nov 24, 2022 at 05:22:07PM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> > +	ax45mp_priv->ucctl_ok = ax45mp_cpu_cache_controlable();

> That function name is a typo, should be called ax45mp_cpu_cache_cache_controllable().


And so is my suggestion! s/cache_cache/cache/
