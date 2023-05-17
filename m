Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C3E705C6D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 03:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjEQB3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 21:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjEQB3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 21:29:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BE919BC;
        Tue, 16 May 2023 18:29:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E728164066;
        Wed, 17 May 2023 01:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50943C433EF;
        Wed, 17 May 2023 01:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684286955;
        bh=5RKCwxJDo9EQclpO78JO5uI/uYUKj54SVloQgoIY9xI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K5hlA64RW5lD9H50Jt1pB/ywejrlk5tnOLdETUYzf+K/wRO599AQBtRf7KpbtZPYk
         8oSmRx107szAmh801/x3BwPsJ0bOzjvLdj/JYWOI+jD7zpREJ9efDn4pbQhzlX6hXU
         A5SAlL9MdZI/2mTpMGkid05BmohI0qFJ2ezGtUY2DnaXbRXlCLgIWuR7zMABVH9Gur
         j0rohHCbZQi3B0ntGucRXAa0I0zZYxHJ0yQvS1mPAFwiaGPb67WHpbkU3UCSToXbol
         2qZq8hdFJSsorE02uMoEM+7PetvZ/MaAYNUlirlWEQKcDd626PdiNlkw6l2dulJZPm
         AI01wS5RiaLfw==
Date:   Wed, 17 May 2023 10:29:10 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 05/16] ARM: kprobes: avoid missing-declaration warnings
Message-Id: <20230517102910.753251be84c5156476d7c105@kernel.org>
In-Reply-To: <20230516154605.517690-6-arnd@kernel.org>
References: <20230516154605.517690-1-arnd@kernel.org>
        <20230516154605.517690-6-arnd@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 17:45:54 +0200
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> checker_stack_use_t32strd() and kprobe_handler() can be made static since
> they are not used from other files, while coverage_start_registers()
> and __kprobes_test_case() are used from assembler code, and just need
> a declaration to avoid a warning with the global definition.
> 
> arch/arm/probes/kprobes/checkers-common.c:43:18: error: no previous prototype for 'checker_stack_use_t32strd'
> arch/arm/probes/kprobes/core.c:236:16: error: no previous prototype for 'kprobe_handler'
> arch/arm/probes/kprobes/test-core.c:723:10: error: no previous prototype for 'coverage_start_registers'
> arch/arm/probes/kprobes/test-core.c:918:14: error: no previous prototype for '__kprobes_test_case_start'
> arch/arm/probes/kprobes/test-core.c:952:14: error: no previous prototype for '__kprobes_test_case_end_16'
> arch/arm/probes/kprobes/test-core.c:967:14: error: no previous prototype for '__kprobes_test_case_end_32'
> 
> Fixes: 6624cf651f1a ("ARM: kprobes: collects stack consumption for store instructions")
> Fixes: 454f3e132d05 ("ARM/kprobes: Remove jprobe arm implementation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thank you for fixing warnings!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> ---
>  arch/arm/probes/kprobes/checkers-common.c | 2 +-
>  arch/arm/probes/kprobes/core.c            | 2 +-
>  arch/arm/probes/kprobes/opt-arm.c         | 2 --
>  arch/arm/probes/kprobes/test-core.c       | 2 +-
>  arch/arm/probes/kprobes/test-core.h       | 4 ++++
>  5 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/probes/kprobes/checkers-common.c b/arch/arm/probes/kprobes/checkers-common.c
> index 4d720990cf2a..eba7ac4725c0 100644
> --- a/arch/arm/probes/kprobes/checkers-common.c
> +++ b/arch/arm/probes/kprobes/checkers-common.c
> @@ -40,7 +40,7 @@ enum probes_insn checker_stack_use_imm_0xx(probes_opcode_t insn,
>   * Different from other insn uses imm8, the real addressing offset of
>   * STRD in T32 encoding should be imm8 * 4. See ARMARM description.
>   */
> -enum probes_insn checker_stack_use_t32strd(probes_opcode_t insn,
> +static enum probes_insn checker_stack_use_t32strd(probes_opcode_t insn,
>  		struct arch_probes_insn *asi,
>  		const struct decode_header *h)
>  {
> diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
> index 88999ed2cfc4..3ee0e3024ff0 100644
> --- a/arch/arm/probes/kprobes/core.c
> +++ b/arch/arm/probes/kprobes/core.c
> @@ -233,7 +233,7 @@ singlestep(struct kprobe *p, struct pt_regs *regs, struct kprobe_ctlblk *kcb)
>   * kprobe, and that level is reserved for user kprobe handlers, so we can't
>   * risk encountering a new kprobe in an interrupt handler.
>   */
> -void __kprobes kprobe_handler(struct pt_regs *regs)
> +static void __kprobes kprobe_handler(struct pt_regs *regs)
>  {
>  	struct kprobe *p, *cur;
>  	struct kprobe_ctlblk *kcb;
> diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
> index dbef34ed933f..7f65048380ca 100644
> --- a/arch/arm/probes/kprobes/opt-arm.c
> +++ b/arch/arm/probes/kprobes/opt-arm.c
> @@ -145,8 +145,6 @@ __arch_remove_optimized_kprobe(struct optimized_kprobe *op, int dirty)
>  	}
>  }
>  
> -extern void kprobe_handler(struct pt_regs *regs);
> -
>  static void
>  optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
>  {
> diff --git a/arch/arm/probes/kprobes/test-core.c b/arch/arm/probes/kprobes/test-core.c
> index c562832b8627..171c7076b89f 100644
> --- a/arch/arm/probes/kprobes/test-core.c
> +++ b/arch/arm/probes/kprobes/test-core.c
> @@ -720,7 +720,7 @@ static const char coverage_register_lookup[16] = {
>  	[REG_TYPE_NOSPPCX]	= COVERAGE_ANY_REG | COVERAGE_SP,
>  };
>  
> -unsigned coverage_start_registers(const struct decode_header *h)
> +static unsigned coverage_start_registers(const struct decode_header *h)
>  {
>  	unsigned regs = 0;
>  	int i;
> diff --git a/arch/arm/probes/kprobes/test-core.h b/arch/arm/probes/kprobes/test-core.h
> index 56ad3c0aaeea..c7297037c162 100644
> --- a/arch/arm/probes/kprobes/test-core.h
> +++ b/arch/arm/probes/kprobes/test-core.h
> @@ -454,3 +454,7 @@ void kprobe_thumb32_test_cases(void);
>  #else
>  void kprobe_arm_test_cases(void);
>  #endif
> +
> +void __kprobes_test_case_start(void);
> +void __kprobes_test_case_end_16(void);
> +void __kprobes_test_case_end_32(void);
> -- 
> 2.39.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
