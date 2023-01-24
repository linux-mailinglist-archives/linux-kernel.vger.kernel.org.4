Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3592467A561
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbjAXWFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjAXWFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:05:47 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E7C521E4;
        Tue, 24 Jan 2023 14:05:26 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1pKRPa-0001Lu-Er; Tue, 24 Jan 2023 23:05:02 +0100
Received: from [185.238.219.21] (helo=[192.168.46.66])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <kernel@mkarcher.dialup.fu-berlin.de>)
          id 1pKRPZ-0047e5-R3; Tue, 24 Jan 2023 23:05:02 +0100
Message-ID: <0dcf23d3-09d5-802f-d9cc-2900d2cdaa53@mkarcher.dialup.fu-berlin.de>
Date:   Tue, 24 Jan 2023 23:05:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 1/1] arch/sh: avoid spurious sizeof-pointer-div warning
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <b41ea008-d9c4-fd76-a5ce-00fe435deed5@mkarcher.dialup.fu-berlin.de>
 <f540c26e-baa8-5c18-9502-622a4091b675@infradead.org>
 <CAMuHMdUUq0FLmsRPw122My7tOUyRLJxsEKOSFgtfG3ec5OiyKQ@mail.gmail.com>
From:   Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
In-Reply-To: <CAMuHMdUUq0FLmsRPw122My7tOUyRLJxsEKOSFgtfG3ec5OiyKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Original-Sender: kernel@mkarcher.dialup.fu-berlin.de
X-Originating-IP: 185.238.219.21
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.01.2023 um 14:07 schrieb Geert Uytterhoeven:

> On Mon, Jan 23, 2023 at 8:40 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>> I'm curious how you generated this patch.

I'm currently using Thunderbird in a GUI environment as my only mail client,
and I pasted just the +/- lines of the patch into the pre-composed mail. The
copious amounts of bad mails I generated this way are a good point to set up
git-send-email in my linux environment to avoid bad patches / badly formatted
mails

> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks!

> Note that I didn't receive v5 (neither did lore), only Adrian's reply.

And that is another issue of my mail setup. Thunderbird is set to
automatically decide on HTML or plaintext only, and as soon as I switch to
"preformatted text", Thunderbird concludes that the mail contains
significant formatting, and defaults to multipart/alternative with HTML and
plain text. Mails of this type obviously get dropped by vger.kernel.org.

On the other hand, if I *don't* select "preformatted text", but use the
default settings "paragraph" or "normal text", there will be no HTML part
(which is good), but spaces will be transformed to non-breaking spaces.

I verified that the version of the v5 mail I just sent to all recipients
I already had on the v1 mail (so that doesn't include Geert, but both lkml
and linux-sh) now fulfills all requirements. I verified that it appeared
at lore on linux-sh.

>>> -#define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
>>> +#define _INTC_SIZEOF_OR_ZERO(a) (_Generic(a,                 \
>>> +                                 typeof(NULL):  0,           \
>>> +                                 default:       sizeof(a)))
> _INTC_SIZEOF_OR_ZERO() might be useful in general.

Indeed. Feel free to move it (using a name that doesn't start with _INTC) to
a more general linux header file.

On the other hand, having a sizeof-like macro that fails to work on void*
(what NULL is), but works on all other types might be confusing and
error-prone. You likely want to further type constrain it, and you need to
parenthesize the argument "a" if you generalize this macro.

The version suggested by Jakub Jelinek in the gcc bugtracker has the advantage
of verifying that the void* parameter is indeed the compiletime constant NULL,
but it has the disadvantage that the expression used to verify that NULL was
passed is involving pointers (it needs to, as NULL is a pointer), and an
expression involving pointers is not an integral constant expression according
to C90 rules, so the compile-time assert using a possibly negatively sized
array is rejected by -Wvla, which is enabled in the kernel source code by
default.

Kind regards,
   Michael Karcher

