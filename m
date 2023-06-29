Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07806741E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 04:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjF2CZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 22:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjF2CZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 22:25:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC592682
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 19:25:33 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qs2NT5Y5RzqSqY;
        Thu, 29 Jun 2023 10:25:13 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 10:25:31 +0800
Subject: Re: [PATCH v2] kallsyms: strip LTO-only suffixes from promoted global
 functions
To:     Yonghong Song <yhs@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Petr Mladek <pmladek@suse.com>, Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     Fangrui Song <maskray@google.com>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
References: <20230628181926.4102448-1-yhs@fb.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <0bcb9470-4b39-1fe1-fcab-4d945f10fe7b@huawei.com>
Date:   Thu, 29 Jun 2023 10:25:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230628181926.4102448-1-yhs@fb.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/29 2:19, Yonghong Song wrote:
> Commit 6eb4bd92c1ce ("kallsyms: strip LTO suffixes from static functions")
> stripped all function/variable suffixes started with '.' regardless
> of whether those suffixes are generated at LTO mode or not. In fact,
> as far as I know, in LTO mode, when a static function/variable is
> promoted to the global scope, '.llvm.<...>' suffix is added.
> 
> The existing mechanism breaks live patch for a LTO kernel even if
> no <symbol>.llvm.<...> symbols are involved. For example, for the following
> kernel symbols:
>   $ grep bpf_verifier_vlog /proc/kallsyms
>   ffffffff81549f60 t bpf_verifier_vlog
>   ffffffff8268b430 d bpf_verifier_vlog._entry
>   ffffffff8282a958 d bpf_verifier_vlog._entry_ptr
>   ffffffff82e12a1f d bpf_verifier_vlog.__already_done
> 'bpf_verifier_vlog' is a static function. '_entry', '_entry_ptr' and
> '__already_done' are static variables used inside 'bpf_verifier_vlog',
> so llvm promotes them to file-level static with prefix 'bpf_verifier_vlog.'.
> Note that the func-level to file-level static function promotion also
> happens without LTO.
> 
> Given a symbol name 'bpf_verifier_vlog', with LTO kernel, current mechanism will
> return 4 symbols to live patch subsystem which current live patching
> subsystem cannot handle it. With non-LTO kernel, only one symbol
> is returned.
> 
> In [1], we have a lengthy discussion, the suggestion is to separate two
> cases:
>   (1). new symbols with suffix which are generated regardless of whether
>        LTO is enabled or not, and
>   (2). new symbols with suffix generated only when LTO is enabled.
> 
> The cleanup_symbol_name() should only remove suffixes for case (2).
> Case (1) should not be changed so it can work uniformly with or without LTO.
> 
> This patch removed LTO-only suffix '.llvm.<...>' so live patching and
> tracing should work the same way for non-LTO kernel.
> The cleanup_symbol_name() in scripts/kallsyms.c is also changed to have the same
> filtering pattern so both kernel and kallsyms tool have the same
> expectation on the order of symbols.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
>  [1] https://lore.kernel.org/live-patching/20230615170048.2382735-1-song@kernel.org/T/#u
> 
> Fixes: 6eb4bd92c1ce ("kallsyms: strip LTO suffixes from static functions")
> Reported-by: Song Liu <song@kernel.org>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/kallsyms.c  | 5 ++---
>  scripts/kallsyms.c | 6 +++---
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> Changelogs:
>   v1 -> v2:
>     . add 'Reported-by: Song Liu <song@kernel.org>'
>     . also fix in scripts/kallsyms.c.
> 
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 77747391f49b..4874508bb950 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -174,11 +174,10 @@ static bool cleanup_symbol_name(char *s)
>  	 * LLVM appends various suffixes for local functions and variables that
>  	 * must be promoted to global scope as part of LTO.  This can break
>  	 * hooking of static functions with kprobes. '.' is not a valid
> -	 * character in an identifier in C. Suffixes observed:
> +	 * character in an identifier in C. Suffixes only in LLVM LTO observed:
>  	 * - foo.llvm.[0-9a-f]+
> -	 * - foo.[0-9a-f]+
>  	 */
> -	res = strchr(s, '.');
> +	res = strstr(s, ".llvm.");
>  	if (res) {
>  		*res = '\0';
>  		return true;
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 0d2db41177b2..13af6d0ff845 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -346,10 +346,10 @@ static void cleanup_symbol_name(char *s)
>  	 * ASCII[_]   = 5f
>  	 * ASCII[a-z] = 61,7a
>  	 *
> -	 * As above, replacing '.' with '\0' does not affect the main sorting,
> -	 * but it helps us with subsorting.
> +	 * As above, replacing the first '.' in ".llvm." with '\0' does not
> +	 * affect the main sorting, but it helps us with subsorting.
>  	 */
> -	p = strchr(s, '.');
> +	p = strstr(s, ".llvm.");
>  	if (p)
>  		*p = '\0';
>  }
> 

-- 
Regards,
  Zhen Lei
