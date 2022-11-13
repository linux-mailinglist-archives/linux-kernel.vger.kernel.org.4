Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDC5626CD5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 01:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbiKMANv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 19:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiKMANt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 19:13:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F3A63A9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 16:13:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3AA0B80B8F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 00:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD44C433D6;
        Sun, 13 Nov 2022 00:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668298425;
        bh=AYKKSk+NIzy1pXYiJWh3WgsPRSax5Zh0r58tPDd7JT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZvkR3HZthwx5ePtGifqfxyEv01o6VqM6J4nlSVLn9hR2iQB7LNIXAMldT28UJNyPJ
         +ZMurj53ypsyPph0FjgnVaFEtk9verpMLJ7PesL5ZeUN4Ae71QKIo5nKN9y64qyl53
         W6tGwTYYecE4+mqEpoLFp0ld/UXA7Io7nvy48fVAn6vA4j2EitBMg8O2qnw4oepoDg
         qp8THvwtisVsDKjdqkmortY/JbWMRgthsBdAtf9SSSsZ8ln5gWVzGAURVQxcsm5OmC
         eJJtRMwnvdPYwqeIf9+stzEmG/phD3uKwEA4Rw4QELpGvD0pFqhvIWakW+AusBmZmR
         IvDB7YanULmxg==
Date:   Sun, 13 Nov 2022 00:13:40 +0000
From:   Conor Dooley <conor@kernel.org>
To:     debug@rivosinc.com
Cc:     palmer@dabbelt.com, jan.kiszka@siemens.com, kbingham@kernel.org,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux@rivosinc.com
Subject: Re: [PATCH] gdb-script: updated lx_current for riscv
Message-ID: <Y3A2tPFbqcf1DPr5@spud>
References: <20221111195938.1499148-1-debug@rivosinc.com>
 <20221111195938.1499148-2-debug@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111195938.1499148-2-debug@rivosinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 11:59:38AM -0800, debug@rivosinc.com wrote:
> From: Deepak Gupta <debug@rivosinc.com>
> 
> lx_current python gdb command defined in scripts/gdb/cpus.py updated
> to support riscv architecture.

The commit which added support for arm64 gave an explanation of why
SP_EL0 needed to be checked. Would be nice if you could do the same here
for RISC-V. See 526940e39626 ("scripts/gdb: add lx_current support for
arm64") for what I mean.

While you're at it, "scripts/gdb: add support for RISC-V" would appear
to be a more standard $subject for this file.

Thanks,
Conor.

> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  scripts/gdb/linux/cpus.py | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
> index 15fc4626d236..ce6703f1e35a 100644
> --- a/scripts/gdb/linux/cpus.py
> +++ b/scripts/gdb/linux/cpus.py
> @@ -173,6 +173,14 @@ def get_current_task(cpu):
>           else:
>               raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
>                                  "while running in userspace(EL0)")
> +    elif utils.is_target_arch("riscv"):
> +         current_task_addr = gdb.parse_and_eval("$tp")
> +         if((current_task_addr.cast(utils.get_long_type()) >> 63) != 0):
> +             current_task = current_task_addr.cast(task_ptr_type)
> +             return current_task.dereference()
> +         else:
> +             raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
> +                                "while running in userspace")
>      else:
>          raise gdb.GdbError("Sorry, obtaining the current task is not yet "
>                             "supported with this arch")
> -- 
> 2.25.1
> 
