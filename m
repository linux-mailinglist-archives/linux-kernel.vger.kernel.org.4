Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE759721B6B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 03:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbjFEBWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 21:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjFEBWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 21:22:09 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69624BC;
        Sun,  4 Jun 2023 18:22:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 896FF42450;
        Mon,  5 Jun 2023 01:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1685928122; bh=6z/0S9faUaZ6zgRpxpD/gzAmGLCL2N5TsJeJv9RS2l8=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To;
        b=KFq/P4B5tUrlQxvEizSZXMBcTuLu+y5/lBnfDQZT1XLK6pMGS5bo5YMZqmfBN9MfM
         QvCbMMGUGFhdg0hnhDHEILYO7LoJDLP1Qkqqa2xA1Ht88GLv0mKHw8EpwbolIxeEAC
         jtNzblqxtAS8yoBbO4iBRzvr1Blq9DZ3l/urdnonQ7qd0lWjMgOXi7MiXqsAfjQk+R
         qRCzOfdd6R6lm2yRiTmlRRvibPUnrzptgYwI5XIquYVGu5lAUwNqMa7ILtkfsQhuCh
         LhSAoNH2QMpRtzeFMaiw+d6wIiuL4jZUv3OEDOD2PeHFqm7jZZz7hEWKrlloc/QZvD
         qzblQAwFzhjDw==
Message-ID: <69ea054d-9e3a-6a84-a38b-796f6f152961@marcan.st>
Date:   Mon, 5 Jun 2023 10:21:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: linux-next: build failure after merge of the asahi-soc tree
Content-Language: en-US
From:   Hector Martin <marcan@marcan.st>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Asahi Linux <asahi@lists.linux.dev>
References: <20230605085816.4f54bb43@canb.auug.org.au>
 <E17AC653-8534-4189-ACDF-F6CCD1C1D9F0@marcan.st>
In-Reply-To: <E17AC653-8534-4189-ACDF-F6CCD1C1D9F0@marcan.st>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2023 08.11, Hector Martin "marcan" wrote:
> Hi!
> 
> Thanks, looks like a missing include. I'll fix it up when I get home in a bit. Sorry for the noise!
> 
> (And apologies for top-posting, I'm on mobile right now)
> 

Should be fixed now, thanks again!

TIL that allmodconfig includes COMPILE_TEST. Makes sense though. I don't
build test for x86 often, and I think on arm64 we get bitfield.h pulled
in via common headers, so this isn't the first time I've missed this one...

> On June 5, 2023 7:58:16 AM GMT+09:00, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> Hi all,
>>
>> After merging the asahi-soc tree, today's linux-next build (x86_64
>> allmodconfig) failed like this:
>>
>> In file included from include/linux/io.h:13,
>>                 from drivers/soc/apple/mailbox.c:22:
>> drivers/soc/apple/mailbox.c: In function 'apple_mbox_send':
>> drivers/soc/apple/mailbox.c:151:24: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
>>  151 |         writeq_relaxed(FIELD_PREP(APPLE_MBOX_MSG1_MSG, msg.msg1),
>>      |                        ^~~~~~~~~~
>> arch/x86/include/asm/io.h:103:42: note: in definition of macro 'writeq_relaxed'
>>  103 | #define writeq_relaxed(v, a)    __writeq(v, a)
>>      |                                          ^
>> drivers/soc/apple/mailbox.c: In function 'apple_mbox_poll_locked':
>> drivers/soc/apple/mailbox.c:188:28: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
>>  188 |                 msg.msg1 = FIELD_GET(
>>      |                            ^~~~~~~~~
>>
>> Caused by commit
>>
>>  0d1f3f7f8486 ("soc: apple: mailbox: Add ASC/M3 mailbox driver")
>>
>> I have used the asshi-soc tree from next-20230602 for today.
>>
> 
> - Hector

- Hector

