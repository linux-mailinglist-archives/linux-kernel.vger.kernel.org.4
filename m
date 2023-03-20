Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854436C237D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCTVUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjCTVU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:20:28 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22FF27D61;
        Mon, 20 Mar 2023 14:20:26 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eh3so52177380edb.11;
        Mon, 20 Mar 2023 14:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679347225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wnqyD8RmQzvkYX7wOFvo1E4JUh7LYwrEe0pQvUYqgq8=;
        b=OMb/UAsVxy8Rg203eWnmzDoBUU19ufkggfUFz4Fxls5xlKcieP5DAe5fzdyJwZUe+S
         kgPWUSNXhvNG0aLaGBVZVzBgb31YXb+NfdPbVKxc/iwVlU0lScSCBKrPr9ipZe+gcdjs
         2xiXaUIRJauRplbDIPjdtumdMLjgmi5Ta/+5z3wNjG8+0ilUEza8FD6tYvItbI/tTWtX
         FNdj0LggZDFosWVHqRn3wdMJ0H6+lo6hzVR7irbeCwaXGFGZhN40QdmCOzqPqGqXgk5u
         DBkhuPYAKGDF8yvqcnMKSwJLf81UrOWoBwCogOjhV+qrzEtaffl/svxhJF31xtk4FabA
         l3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679347225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wnqyD8RmQzvkYX7wOFvo1E4JUh7LYwrEe0pQvUYqgq8=;
        b=M3cq3TvQpPOYxrd5USXCRRQ/CwNQvTanV4UACZxAZGz93WNdYrHxY081bCiDnvmzXv
         g9s5XAwfI6DxtDLMXkJxpMlLFMeIB91MNWKthpH+EdsFdL+A5HttXbXt4IgfPEfi7P3V
         0Et7Ou0g5v9TMqYBpjcSxWNcOqqmHsL14cHxxKE5XVbUlma6FJM+idNWaoHMQENDNKI+
         0WhXmNFZEJ222YSk8yMzQMnFX3BgC9hF3o7MSDZk3Ea235ALTK9ZRWZeseX2xzqNGxGM
         /M4JMzMR/Dcd9jGz8kqaHRJ0A/V8edKtE+98F/8IbwpCqL/klQ5P92OwiFTmKyWKyyxc
         2yIQ==
X-Gm-Message-State: AO0yUKW/d8aFFJg6EabAcw+XBI6E2d/mv5Dp+09vhtrVsasXMBBAGqdP
        J1xgJ6EctzIoGu8/cHzysl44c5b03ibKnA==
X-Google-Smtp-Source: AK7set9sUKcWrD+oHlhGhdrIF7i2vzCBsNuf2Y+0YQe1oM1ZNnY1Gxgbzfga6fx4hKrTWshl6nF4jw==
X-Received: by 2002:a17:906:5fd4:b0:931:51c0:7300 with SMTP id k20-20020a1709065fd400b0093151c07300mr468394ejv.77.1679347224778;
        Mon, 20 Mar 2023 14:20:24 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id z26-20020a17090674da00b009310d4dece9sm4875965ejl.62.2023.03.20.14.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 14:20:24 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2] x86/ACPI/boot: Improve __acpi_acquire_global_lock
Date:   Mon, 20 Mar 2023 22:20:12 +0100
Message-Id: <20230320212012.12704-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve __acpi_acquire_global_lock by using a temporary variable.
This enables compiler to perform if-conversion and improves generated
code from:

 ...
 72a:	d1 ea                	shr    %edx
 72c:	83 e1 fc             	and    $0xfffffffc,%ecx
 72f:	83 e2 01             	and    $0x1,%edx
 732:	09 ca                	or     %ecx,%edx
 734:	83 c2 02             	add    $0x2,%edx
 737:	f0 0f b1 17          	lock cmpxchg %edx,(%rdi)
 73b:	75 e9                	jne    726 <__acpi_acquire_global_lock+0x6>
 73d:	83 e2 03             	and    $0x3,%edx
 740:	31 c0                	xor    %eax,%eax
 742:	83 fa 03             	cmp    $0x3,%edx
 745:	0f 95 c0             	setne  %al
 748:	f7 d8                	neg    %eax

to:

 ...
 72a:	d1 e9                	shr    %ecx
 72c:	83 e2 fc             	and    $0xfffffffc,%edx
 72f:	83 e1 01             	and    $0x1,%ecx
 732:	09 ca                	or     %ecx,%edx
 734:	83 c2 02             	add    $0x2,%edx
 737:	f0 0f b1 17          	lock cmpxchg %edx,(%rdi)
 73b:	75 e9                	jne    726 <__acpi_acquire_global_lock+0x6>
 73d:	8d 41 ff             	lea    -0x1(%rcx),%eax

BTW: the compiler could generate:

	lea 0x2(%rcx,%rdx,1),%edx

instead of:

	or     %ecx,%edx
	add    $0x2,%edx

but unwated conversion from add to or when bits are known to be zero
prevents this improvement. This is GCC PR108477.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
v2: Expand return statement.
---
 arch/x86/kernel/acpi/boot.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 1c38174b5f01..a08a4a7a03f8 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1853,13 +1853,18 @@ early_param("acpi_sci", setup_acpi_sci);
 
 int __acpi_acquire_global_lock(unsigned int *lock)
 {
-	unsigned int old, new;
+	unsigned int old, new, val;
 
 	old = READ_ONCE(*lock);
 	do {
-		new = (((old & ~0x3) + 2) + ((old >> 1) & 0x1));
+		val = (old >> 1) & 0x1;
+		new = (old & ~0x3) + 2 + val;
 	} while (!try_cmpxchg(lock, &old, new));
-	return ((new & 0x3) < 3) ? -1 : 0;
+
+	if (val)
+		return 0;
+
+	return -1;
 }
 
 int __acpi_release_global_lock(unsigned int *lock)
-- 
2.39.2

