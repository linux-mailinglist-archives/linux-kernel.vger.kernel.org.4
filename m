Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64D263348C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 05:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbiKVEv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 23:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiKVEv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 23:51:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E9527B13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 20:51:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83968B81964
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 04:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF99C433C1;
        Tue, 22 Nov 2022 04:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669092683;
        bh=izAiYpr0FJNO6aLxkL3dB9GN7oXjpy9Mg8r0NpTkbUc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MhKfDAy1039lotfhH6RGPl+KOIp6mP3E/izoIZwhea2Hl8b5A+vCrpmfP55jttBkf
         AmU5l8K97OChqZuWecQrp6qLdpDH8IH/xwtdwhddaZupiGr+Ced2sPymRyXIDTPb2e
         LBKlrLSAmeayWmJF53AU6XMTwZ518nADPGNFUNKCuNynz8gTntv71pNQiKBNec/s5d
         vDYELos/22rzSwtno4rt4Q2iPBOl+nSZlHNsVibm5aCVKW0np4wMabNDiMMKBGvRvt
         MbEP73GH/GLWQrX6rJ8pr1lC5BoF0DT72+zeMwyuieYJ2HnatAkhj2CvxHGpCHJnH3
         1nWyweXZ0y98A==
Date:   Tue, 22 Nov 2022 13:51:19 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Li Hua <hucool.lihua@huawei.com>
Cc:     <rostedt@goodmis.org>, <akpm@linux-foundation.org>,
        <nathan@kernel.org>, <ananth@in.ibm.com>,
        <linux-kernel@vger.kernel.org>, <weiyongjun1@huawei.com>,
        <yusongping@huawei.com>
Subject: Re: [PATCH] test_kprobes: Fix implicit declaration error of
 test_kprobes
Message-Id: <20221122135119.2755825442e46e81be72e592@kernel.org>
In-Reply-To: <20221121030620.63181-1-hucool.lihua@huawei.com>
References: <20221121030620.63181-1-hucool.lihua@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022 11:06:20 +0800
Li Hua <hucool.lihua@huawei.com> wrote:

> If KPROBES_SANITY_TEST and ARCH_CORRECT_STACKTRACE_ON_KRETPROBE is enabled, but
> STACKTRACE is not set. Build failed as below:
> 
> lib/test_kprobes.c: In function ‘stacktrace_return_handler’:
> lib/test_kprobes.c:228:8: error: implicit declaration of function ‘stack_trace_save’; did you mean ‘stacktrace_driver’? [-Werror=implicit-function-declaration]
>   ret = stack_trace_save(stack_buf, STACK_BUF_SIZE, 0);
>         ^~~~~~~~~~~~~~~~
>         stacktrace_driver
> cc1: all warnings being treated as errors
> scripts/Makefile.build:250: recipe for target 'lib/test_kprobes.o' failed
> make[2]: *** [lib/test_kprobes.o] Error 1
> 
> To fix this error, Select STACKTRACE if ARCH_CORRECT_STACKTRACE_ON_KRETPROBE is enabled.

Good catch!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> 
> Fixes: 1f6d3a8f5e39 ("kprobes: Add a test case for stacktrace from kretprobe handler")
> Signed-off-by: Li Hua <hucool.lihua@huawei.com>
> ---
>  lib/Kconfig.debug | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index c3c0b077ade3..a1005415f0f4 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2107,6 +2107,7 @@ config KPROBES_SANITY_TEST
>  	depends on DEBUG_KERNEL
>  	depends on KPROBES
>  	depends on KUNIT
> +	select STACKTRACE if ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
>  	default KUNIT_ALL_TESTS
>  	help
>  	  This option provides for testing basic kprobes functionality on
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
