Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197DD6A66E3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 05:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjCAEHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 23:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjCAEHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 23:07:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF2037F01;
        Tue, 28 Feb 2023 20:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=wTzrU1b2VU/9KO6F3r7jF+0UGYQdMsP3S0Os+LS4+r8=; b=ANhG6SOIucTOXdovj53NA67xfA
        aB9MRv3XlUuL8GhZEawGp6i5xgUkx6YbRGUdpt2LMrSNvLp7CzWkeUMq0H0h+6EDCXaYPfoCmaJjg
        KU/EcVw7j9tJKvf/geTixSjMaELq3AClU8+CJQhqRA0yaINn/WCJpHvDvvJU5JI5P6U8Aioxbk46a
        kiWan6OupnAjcT7htwskg4AUKq1qb59LvfcnLP0cGGZkY4w+SQnFvcGmhRdem4iA7YzgizXSEXcEU
        kMWYEJc+OG6tFfm8VMeGTcjRoHFDbDCWKrPn7AzH/QUU8vP3J67TO08pWKBV/4ERlzKF0C0LfSw3K
        3nCOD9Pg==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXDkb-00F4OS-3U; Wed, 01 Mar 2023 04:07:33 +0000
Message-ID: <42446784-a88b-df09-41e9-5f685b4df6ee@infradead.org>
Date:   Tue, 28 Feb 2023 20:07:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 0/3] Add RISC-V 32 NOMMU support
To:     Jesse Taube <mr.bossman075@gmail.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yimin Gu <ustcymgu@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <20230301002657.352637-1-Mr.Bossman075@gmail.com>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230301002657.352637-1-Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 2/28/23 16:26, Jesse Taube wrote:
> This patch-set aims to add NOMMU support to RV32.
> Many people want to build simple emulators or HDL
> models of RISC-V this patch makes it possible to
> run linux on them.
> 
> Yimin Gu is the original author of this set.
> Submitted here:
> https://lists.buildroot.org/pipermail/buildroot/2022-November/656134.html
> 
> Though Jesse T rewrote the Dconf.

Dconf?

> 
> The new set:
> https://lists.buildroot.org/pipermail/buildroot/2022-December/658258.html
> ---
> V1->V2:
>  - Add Conor's clock patch for implicit div64
>  - Fix typo in commit title 3/3
>  - Fix typo in commit description 2/3
> V2->V3
>  - Change from defconfig file to a PHONY config
> ---

Is this 'rv32_nommu_virt_defconfig' target the only build target
that is supported?

I ask because I applied the 3 patches and did 25 randconfig builds.
5 of them failed the same way:

riscv32-linux-ld: drivers/soc/canaan/k210-sysctl.o: in function `k210_soc_early_init':
k210-sysctl.c:(.init.text+0x78): undefined reference to `k210_clk_early_init'

because
# CONFIG_COMMON_CLK_K210 is not set


Maybe SOC_CANAAN needs some more selects for required code?

> Conor Dooley (1):
>   clk: k210: remove an implicit 64-bit division
> 
> Jesse Taube (1):
>   riscv: configs: Add nommu PHONY defconfig for RV32
> 
> Yimin Gu (1):
>   riscv: Kconfig: Allow RV32 to build with no MMU
> 
>  arch/riscv/Kconfig     | 5 ++---
>  arch/riscv/Makefile    | 4 ++++
>  drivers/clk/clk-k210.c | 2 +-
>  3 files changed, 7 insertions(+), 4 deletions(-)
> 

-- 
~Randy
