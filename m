Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F64168849C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjBBQit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjBBQip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:38:45 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED22B1B54E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:38:43 -0800 (PST)
Date:   Thu, 2 Feb 2023 16:38:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675355921;
        bh=dGaGY9SKHrhDUDwTzUjOHrj2FqFGK/c5FXI34ju9tkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VEsgtd0/dGGdxrIQTkzxqBhBlZZQLZtq/LUwHvdo0Esg0iQfezDu+I8se3ALMLb0N
         a1wZMSNvMcbh8Qbh9VNs0Z82XwdjxjWEDYCl0YLJl8ubtV03946LErnEwjKxA0z6Kv
         A2q8+X9vI1ElflXAl2O+RlavDsrKYnK0AsNKbc2I=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Vincent Dagonneau <v@vda.io>
Cc:     linux-kernel@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH] tools/nolibc: Add stdint.h
Message-ID: <20230202163836.livaqwrk4266uyzs@t-8ch.de>
References: <20230202160236.25342-1-v@vda.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202160236.25342-1-v@vda.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 11:02:37AM -0500, Vincent Dagonneau wrote:
> Hi,
> 
> I was testing out nolibc with some simple programs originally linked
> against glibc. I noticed a quick fix for some of them was to have an
> stdint.h with limits macros.
> 
> Here are the changes I made. I've got a couple more ideas for fleshing
> out nolibc, let me know if you are interested in contributions.
> 
> Add stdint.h and moved the relevant definitions from std.h. Also added
> macros for limits and *_least_* types.
> 
> ---
>  tools/include/nolibc/std.h    | 15 +------
>  tools/include/nolibc/stdint.h | 77 +++++++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+), 14 deletions(-)
>  create mode 100644 tools/include/nolibc/stdint.h
> 
> diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
> index 1747ae125392..c65ddf2e4db1 100644
> --- a/tools/include/nolibc/std.h
> +++ b/tools/include/nolibc/std.h
> @@ -18,20 +18,7 @@
>  #define NULL ((void *)0)
>  #endif
>  
> -/* stdint types */
> -typedef unsigned char       uint8_t;
> -typedef   signed char        int8_t;
> -typedef unsigned short     uint16_t;
> -typedef   signed short      int16_t;
> -typedef unsigned int       uint32_t;
> -typedef   signed int        int32_t;
> -typedef unsigned long long uint64_t;
> -typedef   signed long long  int64_t;
> -typedef unsigned long        size_t;
> -typedef   signed long       ssize_t;
> -typedef unsigned long     uintptr_t;
> -typedef   signed long      intptr_t;
> -typedef   signed long     ptrdiff_t;
> +#include <stdint.h>

Shouldn't this be

#include "stdint.h"?

>  /* those are commonly provided by sys/types.h */
>  typedef unsigned int          dev_t;
> diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
> new file mode 100644
> index 000000000000..1f11fffe2119
> --- /dev/null
> +++ b/tools/include/nolibc/stdint.h
> @@ -0,0 +1,77 @@
> +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> +/*
> + * Standard definitions and types for NOLIBC
> + * Copyright (C) 2023 Vincent Dagonneau <v@vda.io>
> + */
> +
> +#ifndef _NOLIBC_STDINT_H
> +#define _NOLIBC_STDINT_H
> +
> +typedef unsigned char       uint8_t;
> +typedef   signed char        int8_t;
> +typedef unsigned short     uint16_t;
> +typedef   signed short      int16_t;
> +typedef unsigned int       uint32_t;
> +typedef   signed int        int32_t;
> +typedef unsigned long long uint64_t;
> +typedef   signed long long  int64_t;
> +typedef unsigned long        size_t;
> +typedef   signed long       ssize_t;
> +typedef unsigned long     uintptr_t;
> +typedef   signed long      intptr_t;
> +typedef   signed long     ptrdiff_t;
> +
> +typedef   int8_t       int_least8_t;
> +typedef  uint8_t      uint_least8_t;
> +typedef  int16_t      int_least16_t;
> +typedef uint16_t     uint_least16_t;
> +typedef  int32_t      int_least32_t;
> +typedef uint32_t     uint_least32_t;
> +typedef  int64_t      int_least64_t;
> +typedef uint64_t     uint_least64_t;
> +
> +typedef  int64_t           intmax_t;
> +typedef uint64_t          uintmax_t;
> +
> +/* limits of integral types */
> +
> +#define        INT8_MIN  (-128)
> +#define       INT16_MIN  (-32767-1)
> +#define       INT32_MIN  (-2147483647-1)
> +#define       INT64_MIN  (-9223372036854775807-1)
> +
> +#define        INT8_MAX  (127)
> +#define       INT16_MAX  (32767)
> +#define       INT32_MAX  (2147483647)
> +#define       INT64_MAX  (9223372036854775807)
> +
> +#define       UINT8_MAX  (255)
> +#define      UINT16_MAX  (65535)
> +#define      UINT32_MAX  (4294967295U)
> +#define      UINT64_MAX  (18446744073709551615)
> +
> +#define  INT_LEAST8_MIN  (-128)
> +#define INT_LEAST16_MIN  (-32767-1)
> +#define INT_LEAST32_MIN  (-2147483647-1)
> +#define INT_LEAST64_MIN  (-9223372036854775807-1)

As int_least8_t is a typedef to int8_t, you could use

#define INT_LEAST8_MIN INT8_MIN

etc.

> +#define  INT_LEAST8_MAX  (127)
> +#define INT_LEAST16_MAX  (32767)
> +#define INT_LEAST32_MAX  (2147483647)
> +#define INT_LEAST64_MAX  (9223372036854775807)
> +
> +#define  UINT_LEAST8_MAX  (255)
> +#define UINT_LEAST16_MAX  (65535)
> +#define UINT_LEAST32_MAX  (4294967295U)
> +#define UINT_LEAST64_MAX  (18446744073709551615)
> +
> +#define         SIZE_MAX  (18446744073709551615UL)
> +
> +#define       INTPTR_MIN  (-9223372036854775807L-1)
> +#define       INTPTR_MAX  (9223372036854775807L)
> +#define      UINTPTR_MAX  (18446744073709551615UL)
> +
> +#define      PTRDIFF_MIN  (-9223372036854775807L-1)
> +#define      PTRDIFF_MAX  (9223372036854775807L)

The above break on 32 bit.

> +#endif /* _NOLIBC_STDINT_H */
> -- 
> 2.39.1
> 
