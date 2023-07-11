Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3674D74E7C9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 09:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjGKHTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 03:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGKHTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 03:19:34 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D779BE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 00:19:33 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 793683F36E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689059970;
        bh=xRON641Prwmt7A4t6EJBbCJmTtEWBykCSOV9am7HjQc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=MshxMeGR8d1vq+idV04FZzLceYvL6aYkmdLurXVCOWVn/SdWoyGSw0dlPHpLTE+cd
         Zgxyki5HqhJzmf8SMOHqs1PlNts2WkzNdz80SCdHl5jmzkab+XLqcqKAHEuS3V5SmL
         TF+IF09moeev+/A60PgCidbrA+sawQRpn7CCZ4oxdKez7i1VLDwBdCjsPT4b7KD5/6
         FF6F6I6kc27Kceusw5QJRMlCb24HnerniIX9f236RuAZV+m2yuWamhpUHhAfTY0/yL
         UOoviJUmbuUXZ38eh3F3G1Pkf48LdLbDpbuXHXtRrcp4dU/8mOYllbzGdQoCDN4s0p
         0uQJZjpDrRE0w==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-98df34aa83aso750111666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 00:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689059967; x=1691651967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRON641Prwmt7A4t6EJBbCJmTtEWBykCSOV9am7HjQc=;
        b=iGPp0TFXFvYuk8p9qIakzXiRdK0jq+iPqVEBzEAE3mMBkXUlD2064ULSdCB3LaTq3W
         CkZRaEeiMxnu3WJlrSZA7fffO1BJ9pYkAPRb6+0aM4sdFaHhlSnwXl4aD3h5U7yY+UMF
         Zu0/qeLVVurEnhC1P7pl3TUrrZFNka6I6d2aDm9LjcZ2c5reyUVTn7GlEkMTW+nZNkTb
         DS5JBwfUCPIAs9x4XZyMtpB82alIvi/YRMpenACli1KMqRIP/JwdLA4DMifhmIPbH6Fj
         UXXUkoeZlXaowpfw+qjE3Kb4MrSLAh7FlAWyAOFj+qA6Hozrz7B3KHhkWFqkWCMSPd/P
         SWBQ==
X-Gm-Message-State: ABy/qLadpvClD4iWBySao8Czo5aDcup82QKzTKCdQQoPk7wa5ecczqaT
        g0gfcGLQZ0nVk4CWMcANF5wSzLW0A4hhmS/i3s+zhzZxQ2AHrn8hAqRxCQfqtfPjUHdGICe0s0q
        6KaFlcXYFrERJzCTUTu2heOJWP0xjC08DNitaNw1phQ==
X-Received: by 2002:a17:906:d9:b0:98e:2413:952f with SMTP id 25-20020a17090600d900b0098e2413952fmr19698187eji.18.1689059967618;
        Tue, 11 Jul 2023 00:19:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEli/fbeO4KxeIb+IfmtYxn8L0PBBNzCKXxRW4pUu5B2IKJhDL6R2vAN22+FLEOOlntd+n4IQ==
X-Received: by 2002:a17:906:d9:b0:98e:2413:952f with SMTP id 25-20020a17090600d900b0098e2413952fmr19698159eji.18.1689059967069;
        Tue, 11 Jul 2023 00:19:27 -0700 (PDT)
Received: from localhost.localdomain (host-95-234-206-203.retail.telecomitalia.it. [95.234.206.203])
        by smtp.gmail.com with ESMTPSA id a25-20020a1709062b1900b00992ae4cf3c1sm740573ejg.186.2023.07.11.00.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 00:19:26 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Kees Cook <keescook@chromium.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rust: fix bindgen build error with UBSAN_BOUNDS_STRICT
Date:   Tue, 11 Jul 2023 09:19:14 +0200
Message-Id: <20230711071914.133946-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 2d47c6956ab3 ("ubsan: Tighten UBSAN_BOUNDS on GCC") if
CONFIG_UBSAN is enabled and gcc supports -fsanitize=bounds-strict, we
can trigger the following build error due to bindgen lacking support for
this additional build option:

   BINDGEN rust/bindings/bindings_generated.rs
 error: unsupported argument 'bounds-strict' to option '-fsanitize='

Fix by adding -fsanitize=bounds-strict to the list of skipped gcc flags
for bindgen.

Fixes: 2d47c6956ab3 ("ubsan: Tighten UBSAN_BOUNDS on GCC")
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 rust/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/Makefile b/rust/Makefile
index 7c9d9f11aec5..4124bfa01798 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -257,7 +257,7 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
 	-fno-partial-inlining -fplugin-arg-arm_ssp_per_task_plugin-% \
 	-fno-reorder-blocks -fno-allow-store-data-races -fasan-shadow-offset=% \
 	-fzero-call-used-regs=% -fno-stack-clash-protection \
-	-fno-inline-functions-called-once \
+	-fno-inline-functions-called-once -fsanitize=bounds-strict \
 	--param=% --param asan-%
 
 # Derived from `scripts/Makefile.clang`.
-- 
2.40.1

