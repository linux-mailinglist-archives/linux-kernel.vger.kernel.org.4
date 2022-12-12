Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE2364A85E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbiLLUEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbiLLUEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:04:41 -0500
Received: from forward501p.mail.yandex.net (forward501p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F48F1789C;
        Mon, 12 Dec 2022 12:04:38 -0800 (PST)
Received: from iva2-656890eaceb5.qloud-c.yandex.net (iva2-656890eaceb5.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:6902:0:640:6568:90ea])
        by forward501p.mail.yandex.net (Yandex) with ESMTP id BA3756212297;
        Mon, 12 Dec 2022 23:04:36 +0300 (MSK)
Received: by iva2-656890eaceb5.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id X4kblwWYm0U1-7cv5hKKb;
        Mon, 12 Dec 2022 23:04:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1670875475;
        bh=6SX0EynK6RIvhWjb2zjmvtqkipLIeeuKvC/PeivrWbM=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=mfNLCXyt4oCqEnDyNiripWetTOfJ6jG4zd5B0QXGviMyfrUWLIpJxMH9i8gLoiAG2
         FA5BkgR2hkUl5Lj2CxiuuhUCVlMpyX3SQNnINVg60A88HFCxAJStop4CvdKTp9QfeD
         UNE1bhr+bO6ajec7MVNRJm1VKDkseVJdnTFj05s4=
Authentication-Results: iva2-656890eaceb5.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <011e1128-8b57-8edd-9854-7c4dd6a37291@yandex.ru>
Date:   Tue, 13 Dec 2022 01:04:32 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: strange behavior with sigreturn() to 32bit
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-x86_64@vger.kernel.org,
        luto@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@ZenIV.linux.org.uk>
References: <85ca9ae1-d319-ee77-4a71-bc9c7874f2cb@yandex.ru>
 <87iligo1n1.fsf@email.froward.int.ebiederm.org>
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <87iligo1n1.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

13.12.2022 00:36, Eric W. Biederman пишет:
> Stas,
>
> in your github report you mention that you believe this is a regression
> https://github.com/dosemu2/dosemu2/pull/1830.
>
> Can you tell us the last kernel this worked on?

The only thing I actually think is a
regression, is the return of 0 as an error
code for GPF. I am pretty sure it used
to work, because I was reporting the
zeroed-out err code to @amluto and
he fixed it. But that was something like
5 years ago. These days @amluto seems
to be inactive, does anyone know what
have happened? He was always providing
a very quick help in the past (and well,
he wrote all that 64-32 switching code
in sigreturn for us).
Other problems I've found, are likely not
a regressions. I.e. I never tried such
tests under gdb before and I never tried
to set high dword of RIP to non-zero.
In fact, reliable err code is what I care
most. If things can't be fixed under gdb
or if I should always clear high part of
RIP before switching to 32bit segment -
fine. But zero error code is bad.


>    Which kernel you tested
> that this fails on?

5.19.0-26-generic from ubuntu.


>    It would be awesome if you could bisect this to the
> commit that is broken but at least knowing kernel's you have tried that
> work and don't work would be very useful.

Perhaps I'll look into setting up the test
env under qemu if everything else fails.

> Dosemu is old enough that anything it has down historically that no
> longer works certainly counts as a regression and should be fixed.
dosemu2 nowadays is using Andy's sigreturn
new code, which is now about 10 years old.
Historic dosemu afaik is not using anything
like that, switching to 32bit by hands with iret.
