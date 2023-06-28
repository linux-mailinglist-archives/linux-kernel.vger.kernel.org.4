Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA5574101E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjF1LeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:34:25 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:44129 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjF1LeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:34:22 -0400
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QrfXq74zVzMpcn;
        Wed, 28 Jun 2023 19:31:07 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 19:34:18 +0800
Subject: Re: [PATCH] kallsyms: strip LTO-only suffixes from promoted global
 functions
To:     Yonghong Song <yhs@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Petr Mladek <pmladek@suse.com>, Song Liu <song@kernel.org>
CC:     Fangrui Song <maskray@google.com>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
References: <20230628064433.2859335-1-yhs@fb.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <42da73d9-063b-24c9-6a7e-734403827dcb@huawei.com>
Date:   Wed, 28 Jun 2023 19:34:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230628064433.2859335-1-yhs@fb.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/28 14:44, Yonghong Song wrote:
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
> 
>  [1] https://lore.kernel.org/live-patching/20230615170048.2382735-1-song@kernel.org/T/#u

Missed the addition of:
Reported-by: Song Liu <song@kernel.org>

> 
> Fixes: 6eb4bd92c1ce ("kallsyms: strip LTO suffixes from static functions")
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/kallsyms.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
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

We'd better modify function cleanup_symbol_name() in scripts/kallsyms.c accordingly.


>  	if (res) {
>  		*res = '\0';
>  		return true;
> 

-- 
Regards,
  Zhen Lei
