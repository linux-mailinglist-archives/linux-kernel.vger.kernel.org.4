Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC516AC181
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjCFNjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCFNjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:39:03 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472B01DB81;
        Mon,  6 Mar 2023 05:39:01 -0800 (PST)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PVfkb1QnxzKq07;
        Mon,  6 Mar 2023 21:36:55 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 21:38:58 +0800
Subject: Re: [PATCH 1/2] kallsyms: add kallsyms_seqs_of_names to list of
 special symbols
To:     Arnd Bergmann <arnd@kernel.org>, <linux-kbuild@vger.kernel.org>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
References: <20230306101451.375844-1-arnd@kernel.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <15ae14de-f73b-7dd0-b54d-b029e7fc7d16@huawei.com>
Date:   Mon, 6 Mar 2023 21:38:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230306101451.375844-1-arnd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/6 18:14, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> My randconfig build setup ran into another kallsyms warning:
> 
> Inconsistent kallsyms data
> Try make KALLSYMS_EXTRA_PASS=1 as a workaround
> 
> After adding some debugging code to kallsyms.c, I saw that the recently
> added kallsyms_seqs_of_names symbol can sometimes cause the second stage
> table to be slightly longer than the first stage, which makes the
> build inconsistent.
> 
> Add it to the exception table that contains all other kallsyms-generated
> symbols.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

Maybe we can do a sanity check in output_label(). Or dynamically add the new
symbol into ignored_symbols[], in this way, manual maintenance is not required.


> 
> Fixes: 60443c88f3a8 ("kallsyms: Improve the performance of kallsyms_lookup_name()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  scripts/kallsyms.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 8a68179a98a3..a239a87e7bec 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -119,6 +119,7 @@ static bool is_ignored_symbol(const char *name, char type)
>  		"kallsyms_markers",
>  		"kallsyms_token_table",
>  		"kallsyms_token_index",
> +		"kallsyms_seqs_of_names",
>  		/* Exclude linker generated symbols which vary between passes */
>  		"_SDA_BASE_",		/* ppc */
>  		"_SDA2_BASE_",		/* ppc */
> 

-- 
Regards,
  Zhen Lei
