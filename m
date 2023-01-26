Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7B467CC68
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbjAZNka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237109AbjAZNk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:40:28 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832356B990
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:40:23 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso5273145pjg.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MLcHj69Cx994vdvNyYZka26Sq1fMSdZUGe0hWxQ2OlA=;
        b=VdtGasRwZUbjqugPAxobzNYIEPcTqnN9DBGa2eCqiauMce2k6LPUG59MZbx0iTCfXE
         37aB87oDUBC3tcOMjNBLdsM4sPxp8jSuqVRQSmwlUfH/7EKi408vryuA/SvkcSFWv1hV
         AoLOttxvSIEaVvbk4c+i+l4ECvvp9P5HWp2w9gImMD9xzj7Ss8lx7QfcVVzbCutFYpgK
         djrzqymWLNkgiYMbI60IyMo33HhyRGykuwjodhyuQUftmGHfHunW145ZL1wGXb5rq5sY
         CXRb0GYD+QIRrfo1Ip5njJbEDRDdE3HueQsxlpaRPt67dowD03spJ/tJwXyxMY+8f4SZ
         0kcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MLcHj69Cx994vdvNyYZka26Sq1fMSdZUGe0hWxQ2OlA=;
        b=gWkYhxCK5IjxCvifDIWeeAjLBN3of1MBEJ2qOYRP3IeXsUz7+xyuqpSc7N3H9c8+vg
         4NfxJxhTA5Ju+JyyZRZjXzxOv97W9PxJaVaMrE6aTSjmzNenJ9tCAgLFNzShwbflYwwP
         r5l+mJJEJBAIOmgbcRjhm7ycjHJY+YbDGY/u7xthWmS/cfiVr/TvqhrutVeIZP5qk9hc
         fSSZ7ZGlxaxikSXrZ0gJXQsBmSbqnk/b/WelEItEFumEtFqTKCOh1D5vTkVPQDEipVPc
         TuAhme4+RelL/W7aLgunQSwRZOIwWAJUw/oNenR/ETL/VHUfHyvP5r95H+ra/AL+0Ng5
         bXuw==
X-Gm-Message-State: AO0yUKWa0/dWSvkGilOo/Xq7HJtnlZ3+4UQAKCAucTkC01+J5YKLvTjJ
        oCz7BkUjgMBvG9l52MJr7vCqylRSkeP4lP4ztGQ7e18=
X-Google-Smtp-Source: AK7set+HMXfE9UkUX2/5adWrCEW2/yvGJJOOgxtZWk2zFqGBkzv3+UyShx+ibu2PPGNya/vElRGUxSJvsq9Ljb+v2aY=
X-Received: by 2002:a17:90a:9a93:b0:22c:1bd6:77d5 with SMTP id
 e19-20020a17090a9a9300b0022c1bd677d5mr545749pjp.18.1674740422832; Thu, 26 Jan
 2023 05:40:22 -0800 (PST)
MIME-Version: 1.0
From:   Jason Quinn <jason.lee.quinn@gmail.com>
Date:   Thu, 26 Jan 2023 21:39:46 +0800
Message-ID: <CALCW2DWLraWsEfhsHH+fz3WnRyQK=upRTeb4iDZcgV+MS9LGdg@mail.gmail.com>
Subject: improved num_digits() function for x86/lib/misc.c
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Jason Quinn <jason.lee.quinn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear X86 Architecture (32-bit and 64-bit) Maintainers,

While diving into smpboot.c source to investigate what I believe to be a bug
that causes listings of CPU numbers to show up as kernel warnings during boot,
I also checked out the source for lib/misc.c that houses the
"int num_digits(int val)" function. It seems kernel/smpboot.c is the only file
in the linux kernel that directly uses this function. The implementation used
for num_digits() has multiple issues. First there are some bugs:

BUG A: For large inputs, the function returns incorrect results, if it returns
at all. For example, on my amd64 machine, num_digits(1500000000) incorrectly
returns 16 instead of 10 and the function may simply get stuck in an infinite
loop as it does with num_digits(2000000000). Both inputs are valid 4-byte
integers so this should not occur. This problem is triggered whenever the input
argument has the maximum number of digits of an int variable ( abs(val) >= 1e9
for 4-byte ints). The faulty behavior occurs because the local variable "m"
overflows in the while loop for these large (but valid) inputs.

It seems this function is only used to printk() some core and cpu numbers.
Admittedly, a billion is still far less than the number of core in the largest
supercomputer today (The Andromeda's 15.5 million) but this function should
be functionally correct for any input for its domain, especially since
somebody someday might trustingly use it for other purposes than info messages.
In other words, this is a bug that should be fixed despite it not currently
causing a practical problem in the SMP code. The good news is that the function
itself can be made faster while also extending correctness.

BUG B: For the specific case of num_digits(INT_MIN), the function may enter an
infinite loop. This occurs because an -INT_MIN calculation, which the
implementation performs, may be undefined behavior depending on architecture.
In particular, -INT_MIN is undefined for two's complement signed integers,
which includes almost all computers nowadays. [NOTE: the upcoming C2x standard
will REQUIRE the two's complement representation of signed ints.] Compilers
will often treat -INT_MIN as equal to INT_MIN (see gcc's -ftrapv and -fwrapv
options) in which case the line "val=-val" doesn't actually change the sign and
subsequently the function gets trapped in a loop. We must, therefore, handle
an input of INT_MIN as a special case.

IMPROVEMENT: The current implementation of num_digits() (reproduced now):

int num_digits(int val)
{
    int m = 10;
    int d = 1;

    if (val < 0) {
        d++;
        val = -val;
    }

    while (val >= m) {
        m *= 10;
        d++;
    }

    return d;
}

is not only buggy but slow, relying on multiplication operations. It is possible
to have code of no less clarity (I say even clearer) and without the
multiplication. Here's my sketch of an improved version that assumes
(INT_MIN=2147483648 or INT_MIN=-2147483647) and INT_MAX=2147483648:

int num_digits(int val)
{
    int d=0;

    if ( val == INT_MIN ) return 11; /* 10 + extra for minus sign */

    if ( val < 0 ) {
        val=-val;
        d++;
    }

    if ( val < 1e1 ) return d+1;
    if ( val < 1e2 ) return d+2;
    if ( val < 1e3 ) return d+3;
    if ( val < 1e4 ) return d+4;
    if ( val < 1e5 ) return d+5;
    if ( val < 1e6 ) return d+6;
    if ( val < 1e7 ) return d+7;
    if ( val < 1e8 ) return d+8;
    if ( val < 1e9 ) return d+9;

    return d+10;
}

This code is basically just a loop unroll and the INT_MIN special case
that gets discovered during routine testing. My quick tests suggests it has
about a 2x speed-up. The binary size will be about 10% bigger but that's
offset by it not suffering from the two bugs. The only question
remaining is if to handle INT_MIN and INT_MAX more generally and if so by
how much. I have yet to come up with a clever version that generalizes without
starting to make the code ugly but it's probably possible. What set of values
must we want to handle for INT_MIN and what set of values must we handle for
INT_MAX? Are just INT_MIN = -2147483648 and INT_MAX = 2147483647 sufficient?

There's a patch attached below. Please test and modify as you like if
you wish to merge.

Cheers,
Jason


--- misc.c    2023-01-26 21:00:02.115701806 +0800
+++ misc_new.c    2023-01-26 21:04:33.059488195 +0800
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <limits.h>
 #include <asm/misc.h>

 /*
@@ -8,17 +9,31 @@
  */
 int num_digits(int val)
 {
-    int m = 10;
-    int d = 1;
+    int d=0; /* initialize minus sign flag */

-    if (val < 0) {
-        d++;
-        val = -val;
-    }
+    /* Special case: -INT_MIN may be undefined behavior on some
+       architectures like those that use two's complement. Compilers often
+       implement -INT_MIN such that it equals INT_MIN which mean the
+       val=-val statement below would not actually reverse the sign. */
+    if ( val == INT_MIN ) return 11; /* Assuming INT_MIN=-2147483648
(10 digits plus 1 for the minus sign) */

-    while (val >= m) {
-        m *= 10;
-        d++;
+    if ( val < 0 ) {
+        val=-val;
+        d++; // turn on minus sign flag
     }
-    return d;
+
+    if ( val < 1e1 ) return d+1;
+    if ( val < 1e2 ) return d+2;
+    if ( val < 1e3 ) return d+3;
+    if ( val < 1e4 ) return d+4;
+    if ( val < 1e5 ) return d+5;
+    if ( val < 1e6 ) return d+6;
+    if ( val < 1e7 ) return d+7;
+    if ( val < 1e8 ) return d+8;
+    if ( val < 1e9 ) return d+9;
+
+    /* Assuming INT_MAX=2147483647, at this point 1e9 <= val <= INT_MAX
+       so all possible values contain ten digits. We can return without
+       another if-statement because val <= INT_MAX is always true. */
+    return d+10;
 }
