Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AB2636A83
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbiKWUI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239515AbiKWUHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:07:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82B51100
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:07:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7020CB82473
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 20:07:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A71C433C1;
        Wed, 23 Nov 2022 20:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669234046;
        bh=s17osRDuFFTXSmbRyj5BL7PHDUQYJZ+NO2AwDclrJjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gLIm4rpxMG2Eps3Rp4NkkcfCzg552JIwtvIzd6FL4D83/bitutNaMOWFrC5zV9gza
         xi1QQMIGsZOWLHKSh0N5aYg2/BMwOS2OsunAjVukN5dCexAnulyWV0yBU7LHc6w6j0
         RWoDrf2jD36kjMDCpxd8dMx3i24FfHTRujvmUyxsw/60BXkRQmzMH3OlWQ011fi3dF
         vjHfXFUJpkd5w+Vbkdz9w//VMwiH9M03rtl2rzeMURUsp8dpVNLRYgnoplRvY7yYpr
         CpGJHK3FnYu4kAnITd0PTZG2nYDP4x/B9tav7Lsn6Qce+UZYLousbNVFo8Jdozc7WW
         gzHMzqZn9zKBQ==
Date:   Wed, 23 Nov 2022 20:07:20 +0000
From:   Conor Dooley <conor@kernel.org>
To:     guoren@kernel.org
Cc:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, suagrfillet@gmail.com, andy.chiu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/5] riscv: ftrace: Fixup panic by disabling preemption
Message-ID: <Y359eOOrm/lpDHjt@spud>
References: <20221123153950.2911981-1-guoren@kernel.org>
 <20221123153950.2911981-2-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123153950.2911981-2-guoren@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 10:39:46AM -0500, guoren@kernel.org wrote:
> From: Andy Chiu <andy.chiu@sifive.com>
> 
> In RISCV, we must use an AUIPC + JALR pair to encode an immediate,
> forming a jump that jumps to an address over 4K. This may cause errors
> if we want to enable kernel preemption and remove dependency from
> patching code with stop_machine(). For example, if a task was switched
> out on auipc. And, if we changed the ftrace function before it was
> switched back, then it would jump to an address that has updated 11:0
> bits mixing with previous XLEN:12 part.
> 
> p: patched area performed by dynamic ftrace
> ftrace_prologue:
> p|      REG_S   ra, -SZREG(sp)
> p|      auipc   ra, 0x? ------------> preempted
> 					...
> 				change ftrace function
> 					...
> p|      jalr    -?(ra) <------------- switched back
> p|      REG_L   ra, -SZREG(sp)
> func:
> 	xxx
> 	ret
> 
> Fixes: fc76b8b8011 ("riscv: Using PATCHABLE_FUNCTION_ENTRY instead of MCOUNT")

==========
verify_fixes - FAILED

Commit: be26b864dac9 ("riscv: ftrace: Fixup panic by disabling preemption")
	Fixes tag: Fixes: fc76b8b8011 ("riscv: Using PATCHABLE_FUNCTION_ENTRY instead of MCOUNT")
	Has these problem(s):
		- Target SHA1 does not exist

This should instead be:
Fixes: afc76b8b8011 ("riscv: Using PATCHABLE_FUNCTION_ENTRY instead of MCOUNT")

Thanks,
Conor.

