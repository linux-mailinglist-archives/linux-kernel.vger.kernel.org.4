Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1130B5E7C7B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiIWOFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiIWOFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:05:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4817E9531
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:05:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82B0E614A4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 14:05:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E24CC433D6;
        Fri, 23 Sep 2022 14:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663941932;
        bh=gG8kc5EGZ32Hzl5KDr5xjlW/0iQb/qxEQ3HLHfN9NHI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GuYPIO0SLHM787PKj6eYLF+tylWGekRgu1nNBBX+OS6VbuUr2vRCS4YVOgIzdjTmS
         uIwWBYRady4gONeZujOxwcGlVYDZTes0wBDlaFOCb49lfZaEyoZ5D5MaXyLuBRHFm/
         y1OROyNBEcfd43g2ywN4krS3m+BYQVYjmSjAqTQzQSOMo6gQWRklz7YpYvZQqDM4xF
         Kv+DIAXioHxqnq61JE1ng1hOay2JfQHCsNHgAsCvyEmn1n4QUdNynd9aN+LmgnP18w
         acra5QC3daAJbJ1W5GG6mAulQy53ESJoKOhFKTdzVmTfYAZLoR2As1UTgtGvCT0BdI
         QCLbX26yQ9ihg==
Date:   Fri, 23 Sep 2022 23:05:27 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Yipeng Zou <zouyipeng@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <rostedt@goodmis.org>, <mingo@redhat.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <zanussi@kernel.org>,
        <liaochang1@huawei.com>, <chris.zjh@huawei.com>
Subject: Re: [PATCH 2/2] tracing: kprobe: make gen test module work in arm
 and riscv
Message-Id: <20220923230527.6e3ac417a749ed22302d42ab@kernel.org>
In-Reply-To: <20220919125629.238242-3-zouyipeng@huawei.com>
References: <20220919125629.238242-1-zouyipeng@huawei.com>
        <20220919125629.238242-3-zouyipeng@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2022 20:56:29 +0800
Yipeng Zou <zouyipeng@huawei.com> wrote:

> For now, this selftest module can only work in x86 because of the
> kprobe cmd was fixed use of x86 registers.
> This patch adapted to register names under arm and riscv, So that
> this module can be worked on those platform.

This also looks good to me. (good & simple solution :))

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> Fixes: 64836248dda2 ("tracing: Add kprobe event command generation test module")
> Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
> ---
>  kernel/trace/kprobe_event_gen_test.c | 47 +++++++++++++++++++++++++---
>  1 file changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/kprobe_event_gen_test.c b/kernel/trace/kprobe_event_gen_test.c
> index e023154be0f8..80e04a1e1977 100644
> --- a/kernel/trace/kprobe_event_gen_test.c
> +++ b/kernel/trace/kprobe_event_gen_test.c
> @@ -35,6 +35,45 @@
>  static struct trace_event_file *gen_kprobe_test;
>  static struct trace_event_file *gen_kretprobe_test;
>  
> +#define KPROBE_GEN_TEST_FUNC	"do_sys_open"
> +
> +/* X86 */
> +#if defined(CONFIG_X86_64) || defined(CONFIG_X86_32)
> +#define KPROBE_GEN_TEST_ARG0	"dfd=%ax"
> +#define KPROBE_GEN_TEST_ARG1	"filename=%dx"
> +#define KPROBE_GEN_TEST_ARG2	"flags=%cx"
> +#define KPROBE_GEN_TEST_ARG3	"mode=+4($stack)"
> +
> +/* ARM64 */
> +#elif defined(CONFIG_ARM64)
> +#define KPROBE_GEN_TEST_ARG0	"dfd=%x0"
> +#define KPROBE_GEN_TEST_ARG1	"filename=%x1"
> +#define KPROBE_GEN_TEST_ARG2	"flags=%x2"
> +#define KPROBE_GEN_TEST_ARG3	"mode=%x3"
> +
> +/* ARM */
> +#elif defined(CONFIG_ARM)
> +#define KPROBE_GEN_TEST_ARG0	"dfd=%r0"
> +#define KPROBE_GEN_TEST_ARG1	"filename=%r1"
> +#define KPROBE_GEN_TEST_ARG2	"flags=%r2"
> +#define KPROBE_GEN_TEST_ARG3	"mode=%r3"
> +
> +/* RISCV */
> +#elif defined(CONFIG_RISCV)
> +#define KPROBE_GEN_TEST_ARG0	"dfd=%a0"
> +#define KPROBE_GEN_TEST_ARG1	"filename=%a1"
> +#define KPROBE_GEN_TEST_ARG2	"flags=%a2"
> +#define KPROBE_GEN_TEST_ARG3	"mode=%a3"
> +
> +/* others */
> +#else
> +#define KPROBE_GEN_TEST_ARG0	NULL
> +#define KPROBE_GEN_TEST_ARG1	NULL
> +#define KPROBE_GEN_TEST_ARG2	NULL
> +#define KPROBE_GEN_TEST_ARG3	NULL
> +#endif
> +
> +
>  /*
>   * Test to make sure we can create a kprobe event, then add more
>   * fields.
> @@ -58,14 +97,14 @@ static int __init test_gen_kprobe_cmd(void)
>  	 * fields.
>  	 */
>  	ret = kprobe_event_gen_cmd_start(&cmd, "gen_kprobe_test",
> -					 "do_sys_open",
> -					 "dfd=%ax", "filename=%dx");
> +					 KPROBE_GEN_TEST_FUNC,
> +					 KPROBE_GEN_TEST_ARG0, KPROBE_GEN_TEST_ARG1);
>  	if (ret)
>  		goto free;
>  
>  	/* Use kprobe_event_add_fields to add the rest of the fields */
>  
> -	ret = kprobe_event_add_fields(&cmd, "flags=%cx", "mode=+4($stack)");
> +	ret = kprobe_event_add_fields(&cmd, KPROBE_GEN_TEST_ARG2, KPROBE_GEN_TEST_ARG3);
>  	if (ret)
>  		goto free;
>  
> @@ -128,7 +167,7 @@ static int __init test_gen_kretprobe_cmd(void)
>  	 * Define the kretprobe event.
>  	 */
>  	ret = kretprobe_event_gen_cmd_start(&cmd, "gen_kretprobe_test",
> -					    "do_sys_open",
> +					    KPROBE_GEN_TEST_FUNC,
>  					    "$retval");
>  	if (ret)
>  		goto free;
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
