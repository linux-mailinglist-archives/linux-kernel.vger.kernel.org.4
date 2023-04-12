Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1946DF7D4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjDLN55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDLN54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:57:56 -0400
X-Greylist: delayed 440 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Apr 2023 06:57:55 PDT
Received: from utopia.booyaka.com (utopia.booyaka.com [74.50.51.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C68173A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:57:55 -0700 (PDT)
Received: (qmail 18260 invoked by uid 526); 12 Apr 2023 13:50:32 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Apr 2023 13:50:32 -0000
Date:   Wed, 12 Apr 2023 13:50:32 +0000 (UTC)
From:   Paul Walmsley <paul@booyaka.com>
To:     Evan Green <evan@rivosinc.com>
cc:     Palmer Dabbelt <palmer@rivosinc.com>, heiko@sntech.de,
        linux-doc@vger.kernel.org,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        vineetg@rivosinc.com, Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>, slewis@rivosinc.com,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v6 4/6] RISC-V: hwprobe: Support probing of misaligned
 access performance
In-Reply-To: <20230407231103.2622178-5-evan@rivosinc.com>
Message-ID: <alpine.DEB.2.21.999.2304121350020.17765@utopia.booyaka.com>
References: <20230407231103.2622178-1-evan@rivosinc.com> <20230407231103.2622178-5-evan@rivosinc.com>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Apr 2023, Evan Green wrote:

> This allows userspace to select various routines to use based on the
> performance of misaligned access on the target hardware.
> 
> Rather than adding DT bindings, this change taps into the alternatives
> mechanism used to probe CPU errata. Add a new function pointer alongside
> the vendor-specific errata_patch_func() that probes for desirable errata
> (otherwise known as "features"). Unlike the errata_patch_func(), this
> function is called on each CPU as it comes up, so it can save
> feature information per-CPU.
> 
> The T-head C906 has fast unaligned access, both as defined by GCC [1],
> and in performing a basic benchmark, which determined that byte copies
> are >50% slower than a misaligned word copy of the same data size (source
> for this test at [2]):
> 
> bytecopy size f000 count 50000 offset 0 took 31664899 us
> wordcopy size f000 count 50000 offset 0 took 5180919 us
> wordcopy size f000 count 50000 offset 1 took 13416949 us
> 
> [1] https://github.com/gcc-mirror/gcc/blob/master/gcc/config/riscv/riscv.cc#L353
> [2] https://pastebin.com/EPXvDHSW
> 
> Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Evan Green <evan@rivosinc.com>
> Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> Tested-by: Heiko Stuebner <heiko.stuebner@vrull.eu>

Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>


- Paul
