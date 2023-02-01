Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2454C686E44
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjBASkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjBASkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:40:17 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47ED037F1D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 10:39:59 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id ay1so13148290pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 10:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1bheOv+RMKsLccw364mds17HOO0bJItYyH4Drs1sYdU=;
        b=jMwdNnyeAncNolb8weAVUSEgRK9/0nmbRFJNgQmN9mMPSeUebPlB9TqqZpZHT9wWxe
         Vl7R/xpSk9DBsVswONwOZLpCl/uJ/X/6e3UcOEAJg6ah25SHNlEB88qrzHXFk4QRKQ7C
         7aKvLRrpp8VShSED5q8sQYBsyKoLWXYf9vFpm4wAxmgm81LkQJLIXBxLvwvLx80PppKb
         bkEwsK5gr/aiz/7OW/YEDesYKQ4CSSKj/9yVGKZtoIE0wjRaiobXcnRLwNTjA1aDilPs
         kB8klU3HaJcTd9i+HXdoUjVRASTWuE1whgoyEhW6bU5BQ3JoWjed2fr8Puzj/iz9ef58
         uBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bheOv+RMKsLccw364mds17HOO0bJItYyH4Drs1sYdU=;
        b=ukr7tQtQTEIXkFTSx+/9CL7fcAuzFzv6nDmatopI7kDrRdu/06rDymPNVMcgEZb3J7
         X5//JifqNdb+ogSGMsuZspSylsKhuhOvsC0QF6AaEdN5OljGMz6N7uophB7jx+b8VUXi
         +2TLlRH83Gbt7hRELQ22MUHJ6+3e1oXnAb/8bYODBia9sPV+rxnU72winZWm+6MsVeFQ
         ocfg88MlN1lqKdz3KjozfKoyGz6ZtTqU0pntw7h9xtPcXUmXp6h2mD7jnDlzrP3EfeDW
         1ePICsAwaFkaglCsrLhylTBXb8CsD/g7sPoEEJQmFaM5SxzL5WebxsRPEew+Ma9iSOJO
         tkCA==
X-Gm-Message-State: AO0yUKUNFYjCL5yLqAKPaDRLZtpm9o1/MhyTmjRu+UKQI1kS7ItEFRZU
        ike6BWgv+J6CtpIAo78p0HHNPA==
X-Google-Smtp-Source: AK7set+QBqSRHAUKmIFDrFVmv4riYVpG6AHQn0FUNOQJ/lawfEfaqiRxrWELEe0uPX4Ux8PpgKmxfg==
X-Received: by 2002:aa7:9af1:0:b0:57a:7140:84ae with SMTP id y17-20020aa79af1000000b0057a714084aemr3328095pfp.9.1675276791927;
        Wed, 01 Feb 2023 10:39:51 -0800 (PST)
Received: from smtpclient.apple ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id y84-20020a626457000000b00582579cb0e0sm11741320pfb.129.2023.02.01.10.39.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Feb 2023 10:39:51 -0800 (PST)
From:   Matt Evans <mev@rivosinc.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: [PATCH] locking/atomic: cmpxchg: Make __generic_cmpxchg_local compare
 against zero-extended 'old' value
Message-Id: <8B94CEAB-63AD-400F-A5CD-31AC4490EF4C@rivosinc.com>
Date:   Wed, 1 Feb 2023 18:39:48 +0000
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__generic_cmpxchg_local takes unsigned long old/new arguments which
might end up being up-cast from smaller signed types (which will
sign-extend).  The loaded compare value must be compared against a
truncated smaller type, so down-cast appropriately for each size.

The issue is apparent on 64-bit machines with code, such as
atomic_dec_unless_positive(), that sign-extends from int.

64-bit machines generally don't use the generic cmpxchg but
development/early ports might make use of it, so make it correct.

Signed-off-by: Matt Evans <mev@rivosinc.com>
---
 include/asm-generic/cmpxchg-local.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/cmpxchg-local.h =
b/include/asm-generic/cmpxchg-local.h
index 380cdc824e4b..c3e7315b7c1d 100644
--- a/include/asm-generic/cmpxchg-local.h
+++ b/include/asm-generic/cmpxchg-local.h
@@ -26,15 +26,15 @@ static inline unsigned long =
__generic_cmpxchg_local(volatile void *ptr,
 	raw_local_irq_save(flags);
 	switch (size) {
 	case 1: prev =3D *(u8 *)ptr;
-		if (prev =3D=3D old)
+		if (prev =3D=3D (u8)old)
 			*(u8 *)ptr =3D (u8)new;
 		break;
 	case 2: prev =3D *(u16 *)ptr;
-		if (prev =3D=3D old)
+		if (prev =3D=3D (u16)old)
 			*(u16 *)ptr =3D (u16)new;
 		break;
 	case 4: prev =3D *(u32 *)ptr;
-		if (prev =3D=3D old)
+		if (prev =3D=3D (u32)old)
 			*(u32 *)ptr =3D (u32)new;
 		break;
 	case 8: prev =3D *(u64 *)ptr;
--=20
2.30.2


