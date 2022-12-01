Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E88663F33C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiLAO46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiLAO4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:56:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF1B1BB7EF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 06:56:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C43CD6E;
        Thu,  1 Dec 2022 06:57:01 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.38.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D75C93F67D;
        Thu,  1 Dec 2022 06:56:52 -0800 (PST)
Date:   Thu, 1 Dec 2022 14:56:49 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
Subject: Re: [PATCH 2/3] arm64: kprobes: Let arch do_page_fault() fix up page
 fault in user handler
Message-ID: <Y4jAsYZOFw6CtYDI@FVFF77S0Q05N>
References: <166990553243.253128.13594802750635478633.stgit@devnote3>
 <166990555186.253128.6694458405311467597.stgit@devnote3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166990555186.253128.6694458405311467597.stgit@devnote3>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 11:39:11PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since arm64's do_page_fault() can handle the page fault correctly
> than kprobe_fault_handler() according to the context, let it handle
> the page fault instead of simply call fixup_exception() in the
> kprobe_fault_handler().
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/probes/kprobes.c |    8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index c9e4d0720285..d2ae37f89774 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -294,14 +294,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
>  		}
>  
>  		break;
> -	case KPROBE_HIT_ACTIVE:
> -	case KPROBE_HIT_SSDONE:
> -		/*
> -		 * In case the user-specified fault handler returned
> -		 * zero, try to fix up.
> -		 */
> -		if (fixup_exception(regs))
> -			return 1;
>  	}
>  	return 0;
>  }
> 
