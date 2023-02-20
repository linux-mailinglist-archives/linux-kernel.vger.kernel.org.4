Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B510469CFA1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjBTOrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjBTOrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:47:46 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FD7DA5E4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:47:44 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 31KElWSB015937;
        Mon, 20 Feb 2023 15:47:32 +0100
Date:   Mon, 20 Feb 2023 15:47:32 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Vincent Dagonneau <v@vda.io>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/4] tools/nolibc: add integer types and integer
 limit macros
Message-ID: <20230220144732.GA15550@1wt.eu>
References: <20230219185133.14576-1-w@1wt.eu>
 <20230219185133.14576-3-w@1wt.eu>
 <4da90248dbe94c5db1036cd873dfd910@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4da90248dbe94c5db1036cd873dfd910@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Mon, Feb 20, 2023 at 09:14:04AM +0000, David Laight wrote:
> From: Willy Tarreau
> > Sent: 19 February 2023 18:52
> > 
> > This commit adds some of the missing integer types to stdint.h and adds
> > limit macros (e.g. INTN_{MIN,MAX}).
> > 
> ...
> > 
> > +typedef   int8_t       int_least8_t;
> > +typedef  uint8_t      uint_least8_t;
> > +typedef  int16_t      int_least16_t;
> > +typedef uint16_t     uint_least16_t;
> > +typedef  int32_t      int_least32_t;
> > +typedef uint32_t     uint_least32_t;
> > +typedef  int64_t      int_least64_t;
> > +typedef uint64_t     uint_least64_t;
> 
> The are also the 'fast' variants.
> Although I'd be tempted to either not define the 'least'
> or 'fast' types (or maybe define them all as 'long').
> The only code I've ever seen that used uint_fast32_t
> got 'confused' when it was 64 bits.

Honestly I've never seen either the "least" nor the "fast" variants
used and am not at all convinced we need them. But they're not causing
issues either and I'm fine with Vincent adding them.

> ...
> > +/* limits of integral types */
> > +
> > +#define        INT8_MIN  (-128)
> > +#define       INT16_MIN  (-32767-1)
> > +#define       INT32_MIN  (-2147483647-1)
> > +#define       INT64_MIN  (-9223372036854775807LL-1)
> 
> Those big decimal numbers are difficult to check!
> A typo would be unfortunate!

That's also the purpose of the test!

> Maybe (eg):
> #define	INT64_MIN	(-INT64_MAX - 1)

Some would argue that it's less easy to check when you're grepping for
a value. How often have you found yourself bouncing between glibc
include files looking for a definition for example ? I'm not sold on
either choice, it's indeed just a matter of taste in the end.

> > +#define        INT8_MAX  (127)
> > +#define       INT16_MAX  (32767)
> > +#define       INT32_MAX  (2147483647)
> > +#define       INT64_MAX  (9223372036854775807LL)
> > +
> > +#define       UINT8_MAX  (255)
> > +#define      UINT16_MAX  (65535)
> > +#define      UINT32_MAX  (4294967295U)
> > +#define      UINT64_MAX  (18446744073709551615ULL)
> 
> None of those need brackets.

Most likely it was done to be more uniform with the rest above.

> Defining in hex would be more readable.

Sure they would but it's not the same. Hex numbers are usually
considered as neither positive nor negative probably because they're
more commonly used to manipulate bits rather than quantities, and often
they will not trigger warnings on overflows. Look for example:

  $ cat yy.c 
  int a = 0x80000000;
  int b = -0x80000000;
  int c = 2147483648;
  int d = -2147483648;

  int e =  0x80000000 + 1;
  int f =  0x80000000 - 1;
  int g =  2147483648 + 1;
  int h = -2147483648 - 1;
  
  $ clang  -W -Wall -Wextra -c yy.c
  yy.c:3:9: warning: implicit conversion from 'long' to 'int' changes value from 2147483648 to -2147483648 [-Wconstant-conversion]
  int c = 2147483648;
      ~   ^~~~~~~~~~
  yy.c:8:21: warning: implicit conversion from 'long' to 'int' changes value from 2147483649 to -2147483647 [-Wconstant-conversion]
  int g =  2147483648 + 1;
      ~    ~~~~~~~~~~~^~~
  yy.c:9:21: warning: implicit conversion from 'long' to 'int' changes value from -2147483649 to 2147483647 [-Wconstant-conversion]
  int h = -2147483648 - 1;
      ~   ~~~~~~~~~~~~^~~

Notice how the hex ones didn't complain. Just for this I would
rather keep the decimal ones, even if less readable.

> Although all the 'f' get hard to count as well.
> Given that the types are defined in the same file, why
> not use ~0u and ~0ull for UINT32_MAX and UINT64_MAX.

That's what I usually do but here I think it's mostly to stay
consistent across the whole file.

> Should UINT8_MAX and UINT16_MAX be unsigned constants?
> (Or even be cast to the corresponding type?)

Same, better not if we want to keep the compiler's warnings in case
of wrong assignment. Just compare the outputs of:

   char c = UINT8_MAX;

when UINT8_MAX is defined as 255 and 255U. Only the former gives me:

  yy.c:11:11: warning: implicit conversion from 'int' to 'char' changes value from 255 to -1 [-Wconstant-conversion]
  char cc = 255;
       ~~   ^~~

Thus it gives one extra opportunity to spot a typo.

Thanks!
Willy
