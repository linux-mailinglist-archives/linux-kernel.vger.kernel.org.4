Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04FD728E0A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 04:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbjFICcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 22:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjFICcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 22:32:08 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB141993
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 19:32:07 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64d57cd373fso930403b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 19:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686277927; x=1688869927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OnkNTQ7vQ/65tI6egNmBI+KQzCz/La0xHvOB9G5PUAU=;
        b=KaYDTzWL/CVTKWhB4aYRc8okkpBqZxKD8FOCsDrm1SrY+UB+BSZL63gPGIrlFIWNWm
         CU2bocDEjoQpHZ0HHkyx8alDOL/QpJAQZe3694UQLx+I32CjmLwNB5i6X83jA0TTWUc8
         l1yfiZitbxc1BYUl+YbgzNiGzGR5/DJGnAtSUfcEpW1Y4x6toq6o20t5J5r5lqYTpRn/
         Kspk/labEu0oZu7X2SpS4I3r/z8qVr0eXZFKF+ITU00wuhTE5PrEC4OQsKLaPwtxmTDX
         xzMXGDgH5yE0mMZU0TK3HT3hStWYyHIl44Qwl+Jq3iJo00dMhoSa/hDliHIHscdZnrAy
         V+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686277927; x=1688869927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OnkNTQ7vQ/65tI6egNmBI+KQzCz/La0xHvOB9G5PUAU=;
        b=gL9TBCX6AzzL/3STCapnBPLbYPRhdgZJ/GC4ATxin1IIWRfNu4w8CUi3Xq4dxZcp4P
         /QwgJ0Q6GyElvd8JHJMc6q0He6+fuu/oIPH4voX0ZjfEmYThJj9TvOR8w/bUMP9+GdYJ
         ztgMiz8nNcFsK/ubsv25oHVN2dqTVkL3IyIsehWBa0k3ei5B7ddsaxZlmOYjeLSenpWG
         XhLAYRmYzK7NKyVwzGxwy7wyUYoIWbQ4l/EujrW2VYyKumwXvQ7wOw71Z5wa3nHHRylR
         mcgC5YZA+OZFoiaKL2jXDFoSIWzyqCm9o9Y9F61ap+hcQk+SH6yWqYZIxqvi97lSsmle
         AXGQ==
X-Gm-Message-State: AC+VfDywg3uu1QM/SiEFHVNn3Q+JcPppcTMF6Nvb/uoee9uvakY3f52a
        ytRrdcFNUsY4bEm+kyN4XyCyYivkfmE=
X-Google-Smtp-Source: ACHHUZ7wrRlxkBa45Avxv9D+Fi40M8IRXaHj4rKIRLKHYxv9i0U++2dcSh8NmJt9Ugl24gYeN2Z9jw==
X-Received: by 2002:a05:6a20:160d:b0:10b:d70d:f971 with SMTP id l13-20020a056a20160d00b0010bd70df971mr741977pzj.3.1686277926936;
        Thu, 08 Jun 2023 19:32:06 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:3aa3:2af1:e3f1:5039])
        by smtp.gmail.com with ESMTPSA id c26-20020a62e81a000000b0064d413ca7desm1708900pfi.171.2023.06.08.19.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 19:32:05 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: boot-redboot: clean up Makefile
Date:   Thu,  8 Jun 2023 19:32:00 -0700
Message-Id: <20230609023200.1694846-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop references to external library search directory and compiler libgcc
from the link command. Use KBUILD_LDFLAGS in the link command.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/boot/boot-redboot/Makefile | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/xtensa/boot/boot-redboot/Makefile b/arch/xtensa/boot/boot-redboot/Makefile
index 1d1d46215b1c..c0eef3f6f32d 100644
--- a/arch/xtensa/boot/boot-redboot/Makefile
+++ b/arch/xtensa/boot/boot-redboot/Makefile
@@ -6,16 +6,12 @@
 
 OBJCOPY_ARGS := -O $(if $(CONFIG_CPU_BIG_ENDIAN),elf32-xtensa-be,elf32-xtensa-le)
 
-LD_ARGS	= -T $(srctree)/$(obj)/boot.ld
-
 boot-y	:= bootstrap.o
 targets	+= $(boot-y)
 
 OBJS	:= $(addprefix $(obj)/,$(boot-y))
 LIBS	:= arch/xtensa/boot/lib/lib.a arch/xtensa/lib/lib.a
 
-LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
-
 $(obj)/zImage.o: $(obj)/../vmlinux.bin.gz $(OBJS)
 	$(Q)$(OBJCOPY) $(OBJCOPY_ARGS) -R .comment \
 		--add-section image=$< \
@@ -23,7 +19,10 @@ $(obj)/zImage.o: $(obj)/../vmlinux.bin.gz $(OBJS)
 		$(OBJS) $@
 
 $(obj)/zImage.elf: $(obj)/zImage.o $(LIBS)
-	$(Q)$(LD) $(LD_ARGS) -o $@ $^ -L/xtensa-elf/lib $(LIBGCC)
+	$(Q)$(LD) $(KBUILD_LDFLAGS) \
+		-T $(srctree)/$(obj)/boot.ld \
+		--build-id=none \
+		-o $@ $^
 
 $(obj)/../zImage.redboot: $(obj)/zImage.elf
 	$(Q)$(OBJCOPY) -S -O binary $< $@
-- 
2.30.2

