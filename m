Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CB8717913
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbjEaHx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbjEaHxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:53:30 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131E0E53;
        Wed, 31 May 2023 00:52:06 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q4Gca-0004IM-2M; Wed, 31 May 2023 09:51:52 +0200
Message-ID: <f713cf25-1a53-f691-ad54-6141f2d4bccb@leemhuis.info>
Date:   Wed, 31 May 2023 09:51:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, de-DE
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     =?UTF-8?Q?Joan_Bruguera_Mic=c3=b3?= <joanbrugueram@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alyssa Ross <hi@alyssa.is>,
        Sami Tolvanen <samitolvanen@google.com>,
        Alexander Potapenko <glider@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230531003345.never.325-kees@kernel.org>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH] x86/purgatory: Do not use fortified string functions
In-Reply-To: <20230531003345.never.325-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1685519527;264f77ae;
X-HE-SMSGID: 1q4Gca-0004IM-2M
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees, thx for looking into this.

Joan, thx for bisecting. I should have done this earlier myself...

On 31.05.23 02:33, Kees Cook wrote:
> With the addition of -fstrict-flex-arrays=3, struct sha256_state's
> trailing array is no longer ignored by CONFIG_FORTIFY_SOURCE:
> 
> struct sha256_state {
>         u32 state[SHA256_DIGEST_SIZE / 4];
>         u64 count;
>         u8 buf[SHA256_BLOCK_SIZE];
> };
> 
> This means that the memcpy() calls with "buf" as a destination in
> sha256.c's code will attempt to perform run-time bounds checking, which
> could lead to calling missing functions, specifically a potential
> WARN_ONCE, which isn't callable from purgatory.
> 
> Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> Closes: https://lore.kernel.org/lkml/175578ec-9dec-7a9c-8d3a-43f24ff86b92@leemhuis.info/

Did a test build and booted it in a Vm, everything seems fine. So thx
again and feel free to add:

Tested-by: Thorsten Leemhuis <linux@leemhuis.info>

Ciao, Thorsten
