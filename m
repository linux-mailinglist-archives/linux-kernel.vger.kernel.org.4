Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C345F7294F9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240905AbjFIJZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241632AbjFIJY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:24:59 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9AC6D4C3D;
        Fri,  9 Jun 2023 02:19:04 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1q7XQE-0004Jv-0C; Fri, 09 Jun 2023 10:24:38 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 73C6EC02EE; Fri,  9 Jun 2023 10:24:23 +0200 (CEST)
Date:   Fri, 9 Jun 2023 10:24:23 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: cpu-features: Use boot_cpu_type for CPU type based
 features
Message-ID: <20230609082423.GM8160@alpha.franken.de>
References: <20230607055122.26175-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607055122.26175-1-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 01:51:22PM +0800, Jiaxun Yang wrote:
> Some CPU feature macros were using current_cpu_type to mark feature
> availability.
> 
> However current_cpu_type will use smp_processor_id, which is prohibited
> under preemptable context.
> 
> Since those features are all uniform on all CPUs in a SMP system, use
> boot_cpu_type instead of current_cpu_type to fix preemptable kernel.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/include/asm/cpu-features.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
> index 2a0b90077b50..8c6d4a87db37 100644
> --- a/arch/mips/include/asm/cpu-features.h
> +++ b/arch/mips/include/asm/cpu-features.h
> @@ -125,7 +125,7 @@
>  ({									\
>  	int __res;							\
>  									\
> -	switch (current_cpu_type()) {					\
> +	switch (boot_cpu_type()) {					\
>  	case CPU_CAVIUM_OCTEON:						\
>  	case CPU_CAVIUM_OCTEON_PLUS:					\
>  	case CPU_CAVIUM_OCTEON2:					\
> @@ -373,7 +373,7 @@
>  ({									\
>  	int __res;							\
>  									\
> -	switch (current_cpu_type()) {					\
> +	switch (boot_cpu_type()) {					\
>  	case CPU_M14KC:							\
>  	case CPU_74K:							\
>  	case CPU_1074K:							\
> -- 
> 2.39.2 (Apple Git-143)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
