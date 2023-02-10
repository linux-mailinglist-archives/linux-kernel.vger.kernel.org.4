Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67108692459
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 18:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjBJRWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 12:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjBJRWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:22:09 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37BC36696
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 09:22:08 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7F1F43F0C3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 17:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676049725;
        bh=S/oztqFWeJmzmDr/U8nZfNkMKK2hxPAiujJO+Umo16I=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=qvyPWeT34QkKF1H90NqcC7RCf83vXhwFnQhk/wrRuX5Aj1g5g7vpqiTmwCiveUY+5
         GJpnPDgXs3N+jMEd3F+8OvKLzE16LZkNR8LxRqT1+iKbJ4eNs6r00t6J28sCzTuszk
         T2S/vCt+ckG6nnjKo8ilJBFkxAVGuPYaX4HV/hBE3L3oDJMcIPQafV+ozpsZxsNCLh
         e2O3zHef9VITfFTI6UOD1EChWAuvwOGzsfV7rlPfEe1yQ4YGCGPc29KGC4FDVbU53g
         MGLt9aZILvjU5kphfwZPeneeZAhVB4T1TG7V5W7SUaAFUcJkGZxjaMvag+X//qgoIX
         UhXTyXfVeJtXQ==
Received: by mail-ej1-f70.google.com with SMTP id qa17-20020a170907869100b0088ea39742c8so3974986ejc.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 09:22:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/oztqFWeJmzmDr/U8nZfNkMKK2hxPAiujJO+Umo16I=;
        b=hXZYHoM7gs+vhX2u/zQK5Ds6gB+gLKs+zpsg8lsqe+JHrASw08tPv1BbKfUJ85voxs
         vQyQzxgDoM9ix10JIHivKGPklo41SJ0gh2jIv7/blDpPlJRlPATEHBh4F0qh6f/T8+2W
         9EBF0vrPMRyC+x+NQ3Uhs0rM0SA5iuh+n8/hKG4ATQ4iEH6Z6L/FI/3qq+D14ONMvVTZ
         f8b+pncFbExoFWo9Fg5PgPfQHRZALODmVEbiSTrxGBFozSqnek3YBQiY3rNaJPzJf6Ur
         0HE5prvVzUFI5MzJC3SSU8T6TKGro1NE6ahlxGNEt1rvKRV+kSAhU4hujdZVjCkl6d0b
         EOcw==
X-Gm-Message-State: AO0yUKVJCa7l4I8BeU0YBoPBinjdP3BI5xPmEu6m2Zb3OWKiWw6akUVE
        6SGOumDkrg3OaVLwxvO6r65w6Ml8ajQUD1yp/hXJEa2Bv8K0NgMw+cdQSaPcICFuKWSoGJy1qrl
        4x452yEmKNh+s5Kuay9rwbntqSrEH3iatZjpYrSVbrA==
X-Received: by 2002:a17:906:1614:b0:87b:dba1:1bf3 with SMTP id m20-20020a170906161400b0087bdba11bf3mr16347227ejd.30.1676049725208;
        Fri, 10 Feb 2023 09:22:05 -0800 (PST)
X-Google-Smtp-Source: AK7set/YIySZYVz31YG5CrgtiBo3ntekvjcI08pZJN9QSahhumZtZTxLAgUnewRtPJBbaHEL0+GH+g==
X-Received: by 2002:a17:906:1614:b0:87b:dba1:1bf3 with SMTP id m20-20020a170906161400b0087bdba11bf3mr16347206ejd.30.1676049725036;
        Fri, 10 Feb 2023 09:22:05 -0800 (PST)
Received: from righiandr-XPS-13-7390.homenet.telecomitalia.it (host-87-7-128-191.retail.telecomitalia.it. [87.7.128.191])
        by smtp.gmail.com with ESMTPSA id i12-20020a170906250c00b008adc971f5acsm2655543ejb.178.2023.02.10.09.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 09:22:04 -0800 (PST)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        bjorn3_gh@protonmail.com, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, rust-for-linux@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] rust: allow to use INIT_STACK_ALL_ZERO
Date:   Fri, 10 Feb 2023 18:22:03 +0100
Message-Id: <20230210172203.101331-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_INIT_STACK_ALL_ZERO enabled, bindgen is passing
-ftrivial-auto-var-init=zero to clang, that triggers the following:

  error: '-ftrivial-auto-var-init=zero' hasn't been enabled; enable it at your own peril for benchmarking purpose only with '-enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang'

This flag should be dropped in clang-17, but at the moment it seems more
reasonable to add it to the bindgen CFLAGS to prevent the error above.

In this way we can enable CONFIG_INIT_STACK_ALL_ZERO with CONFIG_RUST
without triggering any build error.

Link: https://reviews.llvm.org/D125142
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 rust/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/Makefile b/rust/Makefile
index ff70c4c916f8..5e26db07a1dc 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -267,7 +267,8 @@ BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
 # All warnings are inhibited since GCC builds are very experimental,
 # many GCC warnings are not supported by Clang, they may only appear in
 # some configurations, with new GCC versions, etc.
-bindgen_extra_c_flags = -w --target=$(BINDGEN_TARGET)
+bindgen_extra_c_flags = -w --target=$(BINDGEN_TARGET) \
+			-enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
 
 bindgen_c_flags = $(filter-out $(bindgen_skip_c_flags), $(c_flags)) \
 	$(bindgen_extra_c_flags)
-- 
2.37.2

