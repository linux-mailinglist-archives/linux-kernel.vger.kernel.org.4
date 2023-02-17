Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE8B69AE4A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjBQOsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBQOsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:48:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082305CF15;
        Fri, 17 Feb 2023 06:48:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A99E3B82C4F;
        Fri, 17 Feb 2023 14:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC67C433EF;
        Fri, 17 Feb 2023 14:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676645283;
        bh=NvyEGpHyytRm8bP4ci9/gCEmD/ZBBVaXW612yQ9oNw8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TECzWnZ4KS4UYQ/mvftfOJxSiK7zpyuaEum1nFkITAbXBoOU3si2SOWOW5ONtYO+Z
         1TUy+bZtBMcawGqljtMtiYsBvxqzU/XB8BWYqpLe8um8TzoDb1UDP+ZAUIU0A/q+ud
         ovotTYkp/zrEgAVgtnsrUqzsSYVsP3MSJjIejcgaC0EF85CV2xjVadwng2qWKcJlsL
         kvw1k6dCW4xkNM0RuVshxLT72VACCPGZaXFmrC8lAm0Lho55kaDLibUc6Ny5s8gmpD
         +XPf2YQ5Jgu/dH4eyqGCaeiVLZylgPLkafifT9zf6elkx6dtPWfcgGK7t7kMIaqUGg
         iakJzWYHMklog==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v4 0/1] riscv: Allow to downgrade paging mode from the
 command line
In-Reply-To: <20230131151115.1972740-1-alexghiti@rivosinc.com>
References: <20230131151115.1972740-1-alexghiti@rivosinc.com>
Date:   Fri, 17 Feb 2023 15:48:00 +0100
Message-ID: <87sff4mjq7.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> This new version gets rid of the limitation that prevented KASAN kernels
> to use the newly introduced parameters.
>
> While looking into KASLR, I fell onto commit aacd149b6238 ("arm64: head:
> avoid relocating the kernel twice for KASLR"): it allows to use the fdt
> functions very early in the boot process with KASAN enabled by simply
> compiling a new version of those functions without instrumentation.
>
> I had to change the handling of the command line parsing to make the
> code self-contained in kernel/pi/cmd_early.c to avoid calling too many
> __pi prefixed functions from outside this file.
>
> I'll use this approach like arm64 to handle the extraction of the random
> seedi from the device tree for KASLR.
>
> @Ard: I copied the "pi" name but I have to admit I don't know what it
> means.

__pi_ is for "position-independent" -- KASLR related.

For the (tiny ;-)) series:

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
