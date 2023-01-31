Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB9F683195
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjAaPej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjAaPee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:34:34 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A1F4B4BB;
        Tue, 31 Jan 2023 07:34:33 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 8755D100012;
        Tue, 31 Jan 2023 15:34:26 +0000 (UTC)
Message-ID: <b504f547-a1bf-3ba0-7fce-60bc48d89f65@ghiti.fr>
Date:   Tue, 31 Jan 2023 16:34:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 0/1] riscv: Allow to downgrade paging mode from the
 command line
Content-Language: en-US
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230131151115.1972740-1-alexghiti@rivosinc.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230131151115.1972740-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I forgot the changelog again:

|v4: - Remove the kasan limitation by compiling 'local' fdt functions, 
as done in arm64 by Ard - Remove RB from Björn as the cmdline handling 
changed v3: - Massage commit log to make no4lvl clearer, as asked by 
Conor - Add a note to kernel-parameters.txt regarding the impossibility 
to use those parameters when KASAN is enabled, as suggested by Conor - 
Add RB from Björn v2: - Honor CMDLINE_EXTEND and CMDLINE_FORCE as 
noticed by Björn|

On 1/31/23 16:11, Alexandre Ghiti wrote:
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
>
> Alexandre Ghiti (1):
>    riscv: Allow to downgrade paging mode from the command line
>
>   .../admin-guide/kernel-parameters.txt         |  5 +-
>   arch/riscv/kernel/Makefile                    |  2 +
>   arch/riscv/kernel/pi/Makefile                 | 34 ++++++++++++
>   arch/riscv/kernel/pi/cmdline_early.c          | 52 +++++++++++++++++++
>   arch/riscv/lib/memcpy.S                       |  2 +
>   arch/riscv/lib/memmove.S                      |  2 +
>   arch/riscv/mm/init.c                          | 36 ++++++++++---
>   7 files changed, 126 insertions(+), 7 deletions(-)
>   create mode 100644 arch/riscv/kernel/pi/Makefile
>   create mode 100644 arch/riscv/kernel/pi/cmdline_early.c
>
