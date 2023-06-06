Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9B8723B30
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbjFFISw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbjFFISo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:18:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B8211B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:18:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686039522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/XO+0lafkbbOTc9Ohf6++LJZTGdV+3DEsv3tuzHhunU=;
        b=mLuRIdTDj0aXz1KvPIejSWap+ruiLHpHURi275tdQ0BS7UD2Q8lKq2WqyZ3kzWdaKMn34j
        hysepywR0O7hqUqfkVBaCeZSyNhNx5+8a6xRx6EMwQxQGWrY1vgfJA94mWCBVSdIn9szu6
        0SKjwMGLEUjKz3ly3OkENVAIyOLBLxcYshXJ+tcYSUYfoGEECv73vThN9b8YbHdSe0HHJJ
        AfaYvj9098f6/C5mlbyyWA5Pp360tbl222Ic75ifxY29KrfT8/Xaq5miRucBZNbPJS+RzF
        0A532SMFaomnz5IvZ7LIk64RTR3NAVmAOMTpcBx6Cp92fkVUup3VdtwSXO+n3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686039522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/XO+0lafkbbOTc9Ohf6++LJZTGdV+3DEsv3tuzHhunU=;
        b=CslhaFWMsiGYcFLEKNe+FIRm5f/g5NjHAqy6Yb0DWMhlUj8acBkLj20XC7o6lyk6RbbfJt
        rGLbdon+VIZdd8Cw==
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v4 1/2] selftests/clone3: Fix broken test under
 !CONFIG_TIME_NS
In-Reply-To: <1685968410-5412-2-git-send-email-yangtiezhu@loongson.cn>
References: <1685968410-5412-1-git-send-email-yangtiezhu@loongson.cn>
 <1685968410-5412-2-git-send-email-yangtiezhu@loongson.cn>
Date:   Tue, 06 Jun 2023 10:18:41 +0200
Message-ID: <87jzwh3swu.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05 2023 at 20:33, Tiezhu Yang wrote:
> When execute the following command to test clone3 on LoongArch:
>
>   # cd tools/testing/selftests/clone3 && make && ./clone3
>
> we can see the following error info:
>
>   # [5719] Trying clone3() with flags 0x80 (size 0)
>   # Invalid argument - Failed to create new process
>   # [5719] clone3() with flags says: -22 expected 0
>   not ok 18 [5719] Result (-22) is different than expected (0)
>
> This is because if CONFIG_TIME_NS is not set, but the flag
> CLONE_NEWTIME (0x80) is used to clone a time namespace, it
> will return -EINVAL in copy_time_ns().
>
> Here is the related code in include/linux/time_namespace.h:
>
>   #ifdef CONFIG_TIME_NS
>   ...
>   struct time_namespace *copy_time_ns(unsigned long flags,
> 				      struct user_namespace *user_ns,
> 				      struct time_namespace *old_ns);
>   ...
>   #else
>   ...
>   static inline
>   struct time_namespace *copy_time_ns(unsigned long flags,
> 				      struct user_namespace *user_ns,
> 				      struct time_namespace *old_ns)
>   {
> 	  if (flags & CLONE_NEWTIME)
> 		  return ERR_PTR(-EINVAL);
>
> 	  return old_ns;
>   }
>   ...
>   #endif

There is really no point in copying that code into the changelog. The
textual explanation that it returns -EINVAL is good enough.

> Here is the complete call stack:
>
>   clone3()
>     kernel_clone()
>       copy_process()
>         copy_namespaces()
>           create_new_namespaces()
>             copy_time_ns()
>               clone_time_ns()

Uninteresting too.

> If kernel does not support CONFIG_TIME_NS, /proc/self/ns/time
> will be not exist, and then we should skip clone3() test with
> CLONE_NEWTIME.

Correct.

> With this patch under !CONFIG_TIME_NS:
>
>   # cd tools/testing/selftests/clone3 && make && ./clone3
>   ...
>   # Time namespaces are not supported
>   ok 18 # SKIP Skipping clone3() with CLONE_NEWTIME
>   # Totals: pass:17 fail:0 xfail:0 xpass:0 skip:1 error:0

> Fixes: 515bddf0ec41 ("selftests/clone3: test clone3 with CLONE_NEWTIME")
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/testing/selftests/clone3/clone3.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
> index e495f89..c721f8a 100644
> --- a/tools/testing/selftests/clone3/clone3.c
> +++ b/tools/testing/selftests/clone3/clone3.c
> @@ -196,7 +196,12 @@ int main(int argc, char *argv[])
>  			CLONE3_ARGS_NO_TEST);
>  
>  	/* Do a clone3() in a new time namespace */
> -	test_clone3(CLONE_NEWTIME, 0, 0, CLONE3_ARGS_NO_TEST);
> +	if (access("/proc/self/ns/time", F_OK) == 0) {
> +		test_clone3(CLONE_NEWTIME, 0, 0, CLONE3_ARGS_NO_TEST);
> +	} else {
> +		ksft_print_msg("Time namespaces are not supported\n");
> +		ksft_test_result_skip("Skipping clone3() with CLONE_NEWTIME\n");
> +	}

Patch looks good otherwise.

Thanks,

        tglx

