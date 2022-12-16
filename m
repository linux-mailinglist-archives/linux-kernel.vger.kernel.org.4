Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DAC64EAEF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiLPLxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiLPLxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:53:08 -0500
X-Greylist: delayed 519 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 16 Dec 2022 03:53:04 PST
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42DB28E39;
        Fri, 16 Dec 2022 03:53:04 -0800 (PST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4NYS1Z2q08z1sBpp;
        Fri, 16 Dec 2022 12:44:18 +0100 (CET)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.84])
        by mail.m-online.net (Postfix) with ESMTP id 4NYS1Y75Y5z1qqlR;
        Fri, 16 Dec 2022 12:44:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan3.mail.m-online.net [192.168.6.84]) (amavisd-new, port 10024)
        with ESMTP id 0b5ZjKHkwL_v; Fri, 16 Dec 2022 12:44:16 +0100 (CET)
X-Auth-Info: f4ezSsfKVzN9CazZHPLG18zOuZzzKP8PLF09Joa2rcSALQhcCh1YnQT2Bkw3vKhq
Received: from igel.home (aftr-62-216-205-197.dynamic.mnet-online.de [62.216.205.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 16 Dec 2022 12:44:16 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 1913F2C339A; Fri, 16 Dec 2022 12:44:16 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        David Laight <David.Laight@aculab.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH v9] kallsyms: Add self-test facility
References: <20221115083349.1662-1-thunder.leizhen@huawei.com>
        <CAMuHMdWM6+pC3yUqy+hHRrAf1BCz2sz1KQv2zxS+Wz-639X-aA@mail.gmail.com>
        <ad09966d-9357-1c32-e491-a402af8dac6e@huawei.com>
        <CAMuHMdW=KXfYc3Rqz6LizJcDxRX3BzUFTPpdTpDB68sw+QPJ=A@mail.gmail.com>
        <b00bcc04-0633-bac9-76ab-572f9470901c@huawei.com>
        <CAMuHMdWPSeieR-sGuozd3kWGjVw85EV40irqM9aErXufifzFNA@mail.gmail.com>
X-Yow:  What GOOD is a CARDBOARD suitcase ANYWAY?
Date:   Fri, 16 Dec 2022 12:44:16 +0100
In-Reply-To: <CAMuHMdWPSeieR-sGuozd3kWGjVw85EV40irqM9aErXufifzFNA@mail.gmail.com>
        (Geert Uytterhoeven's message of "Thu, 15 Dec 2022 14:24:51 +0100")
Message-ID: <87len7k1yn.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dez 15 2022, Geert Uytterhoeven wrote:

> Changing:
>
>     --- a/arch/m68k/include/asm/string.h
>     +++ b/arch/m68k/include/asm/string.h
>     @@ -42,7 +42,7 @@ static inline char *strncpy(char *dest, const
> char *src, size_t n)
>      #define __HAVE_ARCH_STRCMP
>      static inline int strcmp(const char *cs, const char *ct)
>      {
>     -       char res;
>     +       signed char res;
>
>             asm ("\n"
>                     "1:     move.b  (%0)+,%2\n"     /* get *cs */

Note that strcmp needs to compute the return value from the difference
of the _unsigned_ characters.  That does not explain the error, though,
since symbol names don't have characters with the high bit set.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
