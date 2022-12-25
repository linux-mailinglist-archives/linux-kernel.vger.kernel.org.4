Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04D0655E32
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 20:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiLYTkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 14:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYTkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 14:40:14 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E55427F
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 11:40:12 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so6594408wms.4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 11:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=81Qzt56uqUTTYiN7XGZEL0FZZ5igsYkPCbcExt0OB1M=;
        b=bFzu1W/Eo380jsp6DX9iPIaM6ZcNbLRdVuIe2xAJfxyuA2yKvLjdDHjq2j7ji5nP2G
         eOx3DDR2SHRAm8S41BtnwOrQmY1sxK0U25Ecd89HRMtvH9su6zGzDVTLFszle8xDdwJ2
         khmR3CRfBTUdMvm8jjVXZ8NAhxgZNEwRokoJZnotdfJgM3IUged1abMAWlWX2rynn8x4
         j5+SGaFRymoDVElgGhworGdvjru15iSomHL10vWCDKfhaOk38/SgSBEjrTtotCjn4VHH
         PBEOFcsFRC9s+WCUMC0bXZRs3KY9+pbgDKUKN21QgariCGVhWi9yCXzbqfMEjaENoo0x
         4T0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81Qzt56uqUTTYiN7XGZEL0FZZ5igsYkPCbcExt0OB1M=;
        b=RcetxIlqvZSlFzWS2vzorAWtPmel+SdUJ1U3uKCaMOMial5f8T+4Y7tsg7vijUE9EY
         uNud2F/ea3y2xQ993oJenrM+yfgQ9dE5pYZMV3T6QhTga/9JkQll55vs5OiYex1SGGtT
         x9gqBiwNbH2iYeTuoidA10iqzmV4IormGc48N5t6Ggo5hvDB7Q7QHfoFVS7UiFPRFwQ+
         ioJefwNTM2DO9Qz7TpiK9w6vRjmR1tQ+WUTJ0Ah5uolZ8hQFZWBn38LLlR2pl3hwCk2u
         OngeVD1rtVWrDXdXoFjgu7Iz61yNwaFjnCLUNBTEGKFRQKSJyrPKyJcQYIMuwwg7aulX
         +VfQ==
X-Gm-Message-State: AFqh2krRev2VCABd5d1PwIoIfEm0nR3uvAuMIMYRrb1ZkvpxudZizLvX
        Uquz/u3o84LHqezGH0c2cGux18Avg5bpl4lwr2s=
X-Google-Smtp-Source: AMrXdXtmvvKmNhGE7TQbRUiVmpwy7tyz+Ow0BlgMnKvBJZibTmnUQOgJsTiuIkMmaITnTNYhkGeM3HfQZlsMdOw5duM=
X-Received: by 2002:a05:600c:1c27:b0:3d1:eea7:e13d with SMTP id
 j39-20020a05600c1c2700b003d1eea7e13dmr985448wms.74.1671997210952; Sun, 25 Dec
 2022 11:40:10 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Sun, 25 Dec 2022 19:39:59 +0000
Message-ID: <CAEzXK1oghXAB_KpKpm=-CviDQbNaH0qfgYTSSjZgvvyj4U78AA@mail.gmail.com>
Subject: [PATCH] [RFC] drm/drm_buddy fails to initialize on 32-bit architectures
To:     akpm@linux-foundation.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-sending with the correct  linux-kernel mailing list email address.
Sorry for the inconvenience.

The proposed patch fixes the issue and allows amdgpu to work again on
armhf with a AMD RX 550 card, however it may not be the best solution
for the issue, as detailed below.

include/log2.h defined macros rounddown_pow_of_two(...) and
roundup_pow_of_two(...) do not handle 64-bit values on 32-bit
architectures (tested on armv9 armhf machine) causing
drm_buddy_init(...) to fail on BUG_ON with an underflow on the order
value, thus impeding amdgpu to load properly (no GUI).

One option is to modify rounddown_pow_of_two(...) to detect if the
variable takes 32 bits or less and call __rounddown_pow_of_two_u32(u32
n) or if the variable takes more space than 32 bits, then call
__rounddown_pow_of_two_u64(u64 n). This would imply renaming
__rounddown_pow_of_two(unsigne
d long n) to
__rounddown_pow_of_two_u32(u32 n) and add a new function
__rounddown_pow_of_two_u64(u64 n). This would be the most transparent
solution, however there a few complications, and they are:
- that the mm subsystem will fail to link on armhf with an undefined
reference on __aeabi_uldivmod
- there a few drivers that directly call __rounddown_pow_of_two(...)
- that other drivers and subsystems generate warnings

So this alternate solution was devised which avoids touching existing
code paths, and just updates drm_buddy which seems to be the only
driver that is failing, however I am not sure if this is the proper
way to go. So I would like to get a second opinion on this, by those
who know.

/include/linux/log2.h
/drivers/gpu/drm/drm_buddy.c

Signed-off-by: Lu=C3=ADs Mendes <luis.p.mendes@gmail.com>
>8------------------------------------------------------8<
diff -uprN linux-next/drivers/gpu/drm/drm_buddy.c
linux-nextLM/drivers/gpu/drm/drm_buddy.c
--- linux-next/drivers/gpu/drm/drm_buddy.c    2022-12-25
16:29:26.000000000 +0000
+++ linux-nextLM/drivers/gpu/drm/drm_buddy.c    2022-12-25
17:04:32.136007116 +0000
@@ -128,7 +128,7 @@ int drm_buddy_init(struct drm_buddy *mm,
         unsigned int order;
         u64 root_size;

-        root_size =3D rounddown_pow_of_two(size);
+        root_size =3D rounddown_pow_of_two_u64(size);
         order =3D ilog2(root_size) - ilog2(chunk_size);

         root =3D drm_block_alloc(mm, NULL, order, offset);
diff -uprN linux-next/include/linux/log2.h linux-nextLM/include/linux/log2.=
h
--- linux-next/include/linux/log2.h    2022-12-25 16:29:29.000000000 +0000
+++ linux-nextLM/include/linux/log2.h    2022-12-25 17:00:34.319901492 +000=
0
@@ -58,6 +58,18 @@ unsigned long __roundup_pow_of_two(unsig
 }

 /**
+ * __roundup_pow_of_two_u64() - round up to nearest power of two
+ * (unsgined 64-bits precision version)
+ * @n: value to round up
+ */
+static inline __attribute__((const))
+u64 __roundup_pow_of_two_u64(u64 n)
+{
+    return 1ULL << fls64(n - 1);
+}
+
+
+/**
  * __rounddown_pow_of_two() - round down to nearest power of two
  * @n: value to round down
  */
@@ -68,6 +80,17 @@ unsigned long __rounddown_pow_of_two(uns
 }

 /**
+ * __rounddown_pow_of_two_u64() - round down to nearest power of two
+ * (unsgined 64-bits precision version)
+ * @n: value to round down
+ */
+static inline __attribute__((const))
+u64 __rounddown_pow_of_two_u64(u64 n)
+{
+    return 1ULL << (fls64(n) - 1);
+}
+
+/**
  * const_ilog2 - log base 2 of 32-bit or a 64-bit constant unsigned value
  * @n: parameter
  *
@@ -163,6 +186,7 @@ unsigned long __rounddown_pow_of_two(uns
     __ilog2_u64(n)            \
  )

+
 /**
  * roundup_pow_of_two - round the given value up to nearest power of two
  * @n: parameter
@@ -181,6 +205,25 @@ unsigned long __rounddown_pow_of_two(uns
  )

 /**
+ * roundup_pow_of_two_u64 - round the given value up to nearest power of t=
wo
+ * (unsgined 64-bits precision version)
+ * @n: parameter
+ *
+ * round the given value up to the nearest power of two
+ * - the result is undefined when n =3D=3D 0
+ * - this can be used to initialise global variables from constant data
+ */
+#define roundup_pow_of_two_u64(n)            \
+(                        \
+    __builtin_constant_p(n) ? (        \
+        ((n) =3D=3D 1) ? 1 :        \
+        (1ULL << (ilog2((n) - 1) + 1))    \
+                   ) :        \
+    __roundup_pow_of_two_u64(n)            \
+ )
+
+
+/**
  * rounddown_pow_of_two - round the given value down to nearest power of t=
wo
  * @n: parameter
  *
@@ -195,6 +238,22 @@ unsigned long __rounddown_pow_of_two(uns
     __rounddown_pow_of_two(n)        \
  )

+/**
+ * rounddown_pow_of_two_u64 - round the given value down to nearest
power of two
+ * (unsgined 64-bits precision version)
+ * @n: parameter
+ *
+ * round the given value down to the nearest power of two
+ * - the result is undefined when n =3D=3D 0
+ * - this can be used to initialise global variables from constant data
+ */
+#define rounddown_pow_of_two_u64(n)            \
+(                        \
+    __builtin_constant_p(n) ? (        \
+        (1ULL << ilog2(n))) :        \
+    __rounddown_pow_of_two_u64(n)        \
+ )
+
 static inline __attribute_const__
 int __order_base_2(unsigned long n)
 {
