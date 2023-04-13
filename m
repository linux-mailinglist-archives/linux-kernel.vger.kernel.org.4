Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8942C6E1513
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjDMTS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjDMTSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:18:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC2E9753
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YuJJMQ9BX1tzn9aZ2gx7j7BopQgxa5qAMl96jDdfc6k=; b=DZPvmJdXdzDOq2aJfBOFGGUKs5
        Kq18lUDwCjoBjJA3LCTXM/ILveNOH9qpoQ92BG3PLZK/KMUn/w3eg4JBGS3w8kfFAhzMTk7NaHTTo
        gx4RIAhI89wpZWIDnmqgYBYOM8Zn+iylOH9IO9dyYzhNvARHo8iscSpjMGV8Yms3bdazGAOyU+Lv3
        1RHyuaLCxUWeDGjW2KioIEDnMx5Tr0Us8ml3cVhc4uZ4rsnfIA1R3q8viTnxXRwzC1sxxm1ZNvNz0
        E1d80i1SJcMiAfSBKGGToUOXYLJmbEQdvAXA+1K7Mbfw1CTpQkP4kK5fafDut2e1memSelgvYufk4
        g02y7zsQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pn2Ry-00Eou2-0w;
        Thu, 13 Apr 2023 19:17:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D26FA30008D;
        Thu, 13 Apr 2023 21:17:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB697263D7241; Thu, 13 Apr 2023 21:17:40 +0200 (CEST)
Date:   Thu, 13 Apr 2023 21:17:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2 8/9] objtool: Detect missing __noreturn annotations
Message-ID: <20230413191740.GP4253@hirez.programming.kicks-ass.net>
References: <cover.1681325924.git.jpoimboe@kernel.org>
 <0f630a0eb4585ab4114e4eecaa6f166a1fd81d49.1681325924.git.jpoimboe@kernel.org>
 <20230413084801.GI4253@hirez.programming.kicks-ass.net>
 <20230413151936.7ineuo4heqwttugj@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413151936.7ineuo4heqwttugj@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
> new file mode 100644
> index 000000000000..0f5e53fd9e7a
> --- /dev/null
> +++ b/tools/objtool/noreturns.h
> @@ -0,0 +1,27 @@
> +NORETURN(__invalid_creds)
> +NORETURN(__module_put_and_kthread_exit)
> +NORETURN(__reiserfs_panic)
> +NORETURN(__stack_chk_fail)
> +NORETURN(__ubsan_handle_builtin_unreachable)
> +NORETURN(arch_cpu_idle_dead)
> +NORETURN(cpu_bringup_and_idle)
> +NORETURN(cpu_startup_entry)
> +NORETURN(do_exit)
> +NORETURN(do_group_exit)
> +NORETURN(do_task_dead)
> +NORETURN(ex_handler_msr_mce)
> +NORETURN(fortify_panic)
> +NORETURN(kthread_complete_and_exit)
> +NORETURN(kthread_exit)
> +NORETURN(kunit_try_catch_throw)
> +NORETURN(lbug_with_loc)
> +NORETURN(machine_real_restart)
> +NORETURN(make_task_dead)
> +NORETURN(panic)
> +NORETURN(rewind_stack_and_make_dead)
> +NORETURN(sev_es_terminate)
> +NORETURN(snp_abort)
> +NORETURN(stop_this_cpu)
> +NORETURN(usercopy_abort)
> +NORETURN(xen_cpu_bringup_again)
> +NORETURN(xen_start_kernel)

Not as convenient to edit, but much easier to use. A bit of a toss up I
suppose.

