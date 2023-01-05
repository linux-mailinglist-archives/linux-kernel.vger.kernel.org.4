Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC3465F650
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 22:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbjAEV6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 16:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbjAEV6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:58:12 -0500
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B42D67BEF;
        Thu,  5 Jan 2023 13:58:10 -0800 (PST)
Received: from [IPV6:2a01:e35:39f2:1220:c70:c024:95ee:ebbb] (unknown [IPv6:2a01:e35:39f2:1220:c70:c024:95ee:ebbb])
        by smtp3-g21.free.fr (Postfix) with ESMTPS id C4DD413F846;
        Thu,  5 Jan 2023 22:57:48 +0100 (CET)
Message-ID: <10302240-51ec-0854-2c86-16752d67a9be@opteya.com>
Date:   Thu, 5 Jan 2023 22:57:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
Content-Language: fr-FR
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org
References: <20230101162910.710293-1-Jason@zx2c4.com>
 <20230101162910.710293-3-Jason@zx2c4.com> <Y7QIg/hAIk7eZE42@gmail.com>
 <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
 <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com>
 <Y7SDgtXayQCy6xT6@zx2c4.com>
 <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com>
 <Y7SJ+/axonTK0Fir@zx2c4.com>
 <CAHk-=wi4gshfKjbhEO_xZdVb9ztXf0iuv5kKhxtvAHf2HzTmng@mail.gmail.com>
 <Y7STv9+p248zr+0a@zx2c4.com>
From:   Yann Droneaud <ydroneaud@opteya.com>
Organization: OPTEYA
In-Reply-To: <Y7STv9+p248zr+0a@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 03/01/2023 à 21:44, Jason A. Donenfeld a écrit :
> On Tue, Jan 03, 2023 at 12:15:57PM -0800, Linus Torvalds wrote:
>> On Tue, Jan 3, 2023 at 12:03 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>>> That buffering cannot be done safely currently
>> .. again, this is "your semantics" (the (b) in my humbug list), not
>> necessarily reality for anybody else.
> Yea that's fair. Except, of course, I maintain that my semantics are
> important ones. :)


I concur.

To hold secret material, we need MADV_WIPEONFORK | MADV_DONTDUMP and the side effect of mlock() (pages' content never written to swap), inherited across fork().
And I want mlock() without paying the price.

Jason's proposed semantics, which I call MADV_WIPEONSWAP, provide a mean to hold /unlimited/ amount secrets in userspace memory (not limited by RLIMIT_MEMLOCK).
The only constraint for userspace is to handle the case pages are wiped, which is already the case of userspace arc4random()'s implementation.

Regards.

-- 
Yann Droneaud
OPTEYA

