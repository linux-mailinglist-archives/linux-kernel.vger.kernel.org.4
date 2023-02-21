Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B8F69E621
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbjBURkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbjBURkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:40:09 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B415B2A6F4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:40:07 -0800 (PST)
Date:   Tue, 21 Feb 2023 17:40:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1677001205; bh=ij4GSueVQMFyDGUOlZ/XLmtQ92yrwr9I25ysgY1p4fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Snt4sQO04bKvR5QLTXebiSr81wNxgBNlo79RZsVRwgZiAJgXhBNW9SNuiIBv4+T7f
         I5Yzf5OXJLUuCVGOH27/FjxiMpWcENkgGXsztnuUvZD2riyorPUThagvXUmxJ39c9e
         ARqLvYVdrVBSNoHYJxFRrXBQY30g5tfN3IlpB7b0=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Vincent Dagonneau <v@vda.io>
Cc:     linux-kernel@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH v5 2/4] tools/nolibc: add integer types and integer limit
 macros
Message-ID: <78f08587-7719-40fa-a676-2ba6c4b39b42@t-8ch.de>
References: <20230220202010.37475-1-v@vda.io>
 <20230220202010.37475-3-v@vda.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220202010.37475-3-v@vda.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 03:20:08PM -0500, Vincent Dagonneau wrote:
> This commit adds some of the missing integer types to stdint.h and adds
> limit macros (e.g. INTN_{MIN,MAX}).
> 
> The reference used for adding these types is
> https://pubs.opengroup.org/onlinepubs/009695399/basedefs/stdint.h.html.
> 
> We rely on the compiler-defined __LONG_MAX__ to get the right limits for
> ssize_t, size_t, intptr_t, uintptr_t and ptrdiff_t. This compiler
> constant seem to have been defined at least since GCC 4.1.2 and clang
> 3.0.0 on x86_64. It is also defined on ARM (32&64), mips and RISC-V.
> 
> Note that the maximum size of size_t is implementation-defined (>65535),
> in this case I chose to go with unsigned long on all platforms since
> unsigned long == unsigned int on all the platforms we care about. Note
> that the kernel uses either unsigned int or unsigned long in
> linux/include/uapi/asm-generic/posix_types.h. These should be equivalent
> for the plaforms we are targeting.
> 
> Also note that the 'fast*' flavor of the types have been chosen to be
> always 1 byte for '*fast8*' and always long (a.k.a. size_t/ssize_t) for
> the other variants. I have never seen the 'fast*' types in use in the wild
> but that seems to be what glibc does.
> 
> Signed-off-by: Vincent Dagonneau <v@vda.io>
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> ---
>  tools/include/nolibc/stdint.h | 77 +++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
> index 4ba264031df9..f7179a583f61 100644
> --- a/tools/include/nolibc/stdint.h
> +++ b/tools/include/nolibc/stdint.h
> @@ -21,4 +21,81 @@ typedef unsigned long     uintptr_t;
>  typedef   signed long      intptr_t;
>  typedef   signed long     ptrdiff_t;
>  
> +typedef   int8_t       int_least8_t;
> +typedef  uint8_t      uint_least8_t;
> +typedef  int16_t      int_least16_t;
> +typedef uint16_t     uint_least16_t;
> +typedef  int32_t      int_least32_t;
> +typedef uint32_t     uint_least32_t;
> +typedef  int64_t      int_least64_t;
> +typedef uint64_t     uint_least64_t;
> +
> +typedef   int8_t        int_fast8_t;
> +typedef  uint8_t       uint_fast8_t;
> +typedef  ssize_t       int_fast16_t;
> +typedef   size_t      uint_fast16_t;
> +typedef  ssize_t       int_fast32_t;
> +typedef   size_t      uint_fast32_t;
> +typedef  ssize_t       int_fast64_t;
> +typedef   size_t      uint_fast64_t;
> +
> +typedef  int64_t           intmax_t;
> +typedef uint64_t          uintmax_t;
> +
> +/* limits of integral types */
> +
> +#define        INT8_MIN  (-128)
> +#define       INT16_MIN  (-32767-1)
> +#define       INT32_MIN  (-2147483647-1)
> +#define       INT64_MIN  (-9223372036854775807LL-1)
> +
> +#define        INT8_MAX  (127)
> +#define       INT16_MAX  (32767)
> +#define       INT32_MAX  (2147483647)
> +#define       INT64_MAX  (9223372036854775807LL)
> +
> +#define       UINT8_MAX  (255)
> +#define      UINT16_MAX  (65535)
> +#define      UINT32_MAX  (4294967295U)
> +#define      UINT64_MAX  (18446744073709551615ULL)
> +
> +#define  INT_LEAST8_MIN  INT8_MIN
> +#define INT_LEAST16_MIN  INT16_MIN
> +#define INT_LEAST32_MIN  INT32_MIN
> +#define INT_LEAST64_MIN  INT64_MIN
> +
> +#define  INT_LEAST8_MAX  INT8_MAX
> +#define INT_LEAST16_MAX  INT16_MAX
> +#define INT_LEAST32_MAX  INT32_MAX
> +#define INT_LEAST64_MAX  INT64_MAX
> +
> +#define  UINT_LEAST8_MAX UINT8_MAX
> +#define UINT_LEAST16_MAX UINT16_MAX
> +#define UINT_LEAST32_MAX UINT32_MAX
> +#define UINT_LEAST64_MAX UINT64_MAX
> +
> +#define SIZE_MAX         ((size_t)(__LONG_MAX__) * 2 + 1)
> +#define SSIZE_MIN        (-__LONG_MAX__ - 1)

SSIZE_MIN is not defined by a standard.
It also doesn't really make sense to have, as ssize_t is only supposed
to store [-1,SSIZE_MAX].

> +#define SSIZE_MAX        __LONG_MAX__

Apparently SSIZE_MAX can also defined via the compilers <limits.h> as
used by nolibc-test.c leading to a warning.
Maybe wrap it in #ifndef SSIZE_MAX.

    In file included from sysroot/x86/include/std.h:21,
		     from sysroot/x86/include/stdio.h:12,
		     from nolibc-test.c:15:
    sysroot/x86/include/stdint.h:79: warning: "SSIZE_MAX" redefined
       79 | #define SSIZE_MAX        __LONG_MAX__
	  | 
    In file included from /usr/include/limits.h:195,
		     from /usr/lib/gcc/x86_64-pc-linux-gnu/12.2.1/include-fixed/limits.h:203,
		     from /usr/lib/gcc/x86_64-pc-linux-gnu/12.2.1/include-fixed/syslimits.h:7,
		     from /usr/lib/gcc/x86_64-pc-linux-gnu/12.2.1/include-fixed/limits.h:34,
		     from nolibc-test.c:6:
    /usr/include/bits/posix1_lim.h:169: note: this is the location of the previous definition
      169 | #  define SSIZE_MAX     LONG_MAX
	  | 

> +#define INTPTR_MIN       SSIZE_MIN
> +#define INTPTR_MAX       SSIZE_MAX
> +#define PTRDIFF_MIN      SSIZE_MIN
> +#define PTRDIFF_MAX      SSIZE_MAX
> +#define UINTPTR_MAX       SIZE_MAX
> +
> +#define  INT_FAST8_MIN  INT8_MIN
> +#define INT_FAST16_MIN  SSIZE_MIN
> +#define INT_FAST32_MIN  SSIZE_MIN
> +#define INT_FAST64_MIN  SSIZE_MIN
> +
> +#define  INT_FAST8_MAX  INT8_MAX
> +#define INT_FAST16_MAX  SSIZE_MAX
> +#define INT_FAST32_MAX  SSIZE_MAX
> +#define INT_FAST64_MAX  SSIZE_MAX
> +
> +#define  UINT_FAST8_MAX UINT8_MAX
> +#define UINT_FAST16_MAX SIZE_MAX
> +#define UINT_FAST32_MAX SIZE_MAX
> +#define UINT_FAST64_MAX SIZE_MAX

Alignment of values within lines is inconsistent.

> +
>  #endif /* _NOLIBC_STDINT_H */
> -- 
> 2.39.2
> 
