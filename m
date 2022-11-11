Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B86625DEE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbiKKPJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbiKKPID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:08:03 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E21F46A74A;
        Fri, 11 Nov 2022 07:06:47 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1otVcD-00037d-00; Fri, 11 Nov 2022 16:06:45 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id D41D1C116A; Fri, 11 Nov 2022 16:03:35 +0100 (CET)
Date:   Fri, 11 Nov 2022 16:03:35 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Rongwei Zhang <pudh4418@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Maxim Uvarov <muvarov@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] MIPS: fix duplicate definitions for exported symbols
Message-ID: <20221111150335.GA13465@alpha.franken.de>
References: <Y2JiO+67E1NyFgca@pudh-loong.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2JiO+67E1NyFgca@pudh-loong.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 08:27:39PM +0800, Rongwei Zhang wrote:
> Building with clang-14 fails with:
> 
> AS      arch/mips/kernel/relocate_kernel.o
> <unknown>:0: error: symbol 'kexec_args' is already defined
> <unknown>:0: error: symbol 'secondary_kexec_args' is already defined
> <unknown>:0: error: symbol 'kexec_start_address' is already defined
> <unknown>:0: error: symbol 'kexec_indirection_page' is already defined
> <unknown>:0: error: symbol 'relocate_new_kernel_size' is already defined
> 
> It turns out EXPORT defined in asm/asm.h expands to a symbol definition,
> so there is no need to define these symbols again. Remove duplicated
> symbol definitions.
> 
> Fixes: 7aa1c8f47e7e ("MIPS: kdump: Add support")
> Signed-off-by: Rongwei Zhang <pudh4418@gmail.com>
> ---
>  arch/mips/kernel/relocate_kernel.S | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
