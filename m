Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F374069C21C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 20:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjBSTXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 14:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjBSTXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 14:23:48 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6395D505
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 11:23:46 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 31JJNgp4007280;
        Sun, 19 Feb 2023 20:23:42 +0100
Date:   Sun, 19 Feb 2023 20:23:42 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Vincent Dagonneau <v@vda.io>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] tools/nolibc: add integer types and integer
 limit macros
Message-ID: <Y/J3PjGoehYQTK3Y@1wt.eu>
References: <20230219185133.14576-1-w@1wt.eu>
 <20230219185133.14576-3-w@1wt.eu>
 <dab2632a-262d-402c-8d86-5e8965b124f6@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dab2632a-262d-402c-8d86-5e8965b124f6@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2023 at 07:16:57PM +0000, Thomas Weißschuh wrote:
> On Sun, Feb 19, 2023 at 07:51:31PM +0100, Willy Tarreau wrote:
> > From: Vincent Dagonneau <v@vda.io>
> > 
> > This commit adds some of the missing integer types to stdint.h and adds
> > limit macros (e.g. INTN_{MIN,MAX}).
> > 
> > The reference used for adding these types is
> > https://pubs.opengroup.org/onlinepubs/009695399/basedefs/stdint.h.html.
> > 
> > Note that the maximum size of size_t is implementation-defined (>65535),
> > in this case I chose to stick with what the kernel uses in
> > linux/include/uapi/asm-generic/posix_types.h: unsigned int on 32bits and
> > unsigned long on 64bits.
> > 
> > Signed-off-by: Vincent Dagonneau <v@vda.io>
> > [wt: size_t is always ulong since it matches the word size on all archs
> >  we care for; calculate the SIZE_MAX, INTPTR_MIN and INTPTR_MAX based on
> >  the compiler-provided __LONG_MAX__]
> > Signed-off-by: Willy Tarreau <w@1wt.eu>
> > ---
> >  tools/include/nolibc/stdint.h | 51 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> > 
> > diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
> > index 4ba264031df9..5f1adf9316ca 100644
> > --- a/tools/include/nolibc/stdint.h
> > +++ b/tools/include/nolibc/stdint.h
> > @@ -21,4 +21,55 @@ typedef unsigned long     uintptr_t;
> >  typedef   signed long      intptr_t;
> >  typedef   signed long     ptrdiff_t;
> >  
> > +typedef   int8_t       int_least8_t;
> > +typedef  uint8_t      uint_least8_t;
> > +typedef  int16_t      int_least16_t;
> > +typedef uint16_t     uint_least16_t;
> > +typedef  int32_t      int_least32_t;
> > +typedef uint32_t     uint_least32_t;
> > +typedef  int64_t      int_least64_t;
> > +typedef uint64_t     uint_least64_t;
> > +
> > +typedef  int64_t           intmax_t;
> > +typedef uint64_t          uintmax_t;
> > +
> > +/* limits of integral types */
> > +
> > +#define        INT8_MIN  (-128)
> > +#define       INT16_MIN  (-32767-1)
> > +#define       INT32_MIN  (-2147483647-1)
> > +#define       INT64_MIN  (-9223372036854775807LL-1)
> > +
> > +#define        INT8_MAX  (127)
> > +#define       INT16_MAX  (32767)
> > +#define       INT32_MAX  (2147483647)
> > +#define       INT64_MAX  (9223372036854775807LL)
> > +
> > +#define       UINT8_MAX  (255)
> > +#define      UINT16_MAX  (65535)
> > +#define      UINT32_MAX  (4294967295U)
> > +#define      UINT64_MAX  (18446744073709551615ULL)
> > +
> > +#define  INT_LEAST8_MIN  INT8_MIN
> > +#define INT_LEAST16_MIN  INT16_MIN
> > +#define INT_LEAST32_MIN  INT32_MIN
> > +#define INT_LEAST64_MIN  INT64_MIN
> > +
> > +#define  INT_LEAST8_MAX  INT8_MAX
> > +#define INT_LEAST16_MAX  INT16_MAX
> > +#define INT_LEAST32_MAX  INT32_MAX
> > +#define INT_LEAST64_MAX  INT64_MAX
> > +
> > +#define  UINT_LEAST8_MAX UINT8_MAX
> > +#define UINT_LEAST16_MAX UINT16_MAX
> > +#define UINT_LEAST32_MAX UINT32_MAX
> > +#define UINT_LEAST64_MAX UINT64_MAX
> > +
> > +#define SIZE_MAX         ((__SIZE_TYPE__)(__LONG_MAX__) * 2 + 1)
> 
> Nit: size_t would look nicer than __SIZE_TYPE__.

Thanks, I hesitated.

> Also SSIZE_MAX could be added.

Ah I hadn't noticed that ssize_t was defined in the file, in this case
I agree it would be better to have it as well.

> > +#define INTPTR_MIN       (-__LONG_MAX__ - 1)
> > +#define INTPTR_MAX       __LONG_MAX__
> > +#define UINTPTR_MAX      (SIZE_MAX)
> 
> Braces seem unnecessary.

Indeed.

Thanks!
Willy
