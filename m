Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7797C64F795
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 05:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiLQEpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 23:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiLQEpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 23:45:21 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9F03EAE0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 20:44:58 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id k18-20020a170902c41200b001896d523dc8so2992360plk.19
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 20:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YND6/2+MHvKx/dzQIvDqR3IvAStElNFUwtkZlZ3WKgQ=;
        b=QMd8J7EJRoRyHw9X4KgOQl8PvNtaLwUhiAS3fSGBCOFhPoHi9xnvzQDYxVD7j5amTH
         Q4GsEYMqTBsn7iQ3GKJlOQR7EYCNqdaNx2qM4/U0btqkZqTcRMc1G1ID4ksjk8w1ygdM
         DAJeLauQhKJzcld5IN4m9ojYJJXJWXH/+Ncc0RYib27ehXOQzrkybiAFl8r2x8Ptjl/S
         +YkSCxfYkmE6lb0ISCS9tQc9f+6I+0E0L/Tx5CAD18WVWeqB1ST40GnnDKUI3RFsEfBa
         yGtQZgSh/2My4u1fuJc0S39x7Y8SoUOc2boVv2C5FpiuBzR3ANMP90xclhrEoiRdL/87
         jXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YND6/2+MHvKx/dzQIvDqR3IvAStElNFUwtkZlZ3WKgQ=;
        b=UFEw17Ihmmo4cvVVCcP6HZA1puGKrT7fgj8HMW7mejWnGo2JxpIEXW3RAcFJFVL7zu
         CX4X58fnkEtjXqByDJZzfPwKVShsK8cJ/0ZeAGDb8vgUecIjUbQFQ+c2gY2PIJs8czxs
         GQcLxxisvO2vAjWS9eQb8MgKRT0R7d05xUB1otTEh208SPbpCWDxH53ZCe+rmCRgS4Un
         sKd+SlRAbz8LFP0h9WrFRu7jcMdOvIijaHVoU+K7q13fTgRlRgY0wyyWmPUH7ibyOEJx
         hL5bM2Ii86eRLNbF5j2Pruu5VDDf2yVh+p3sp38rTLlrtfWT0bj4JN3dFkLsaSJu68DE
         A0/g==
X-Gm-Message-State: ANoB5pmeu5+2sMDOBb8UzGFm+JCvD2wCew1G6gea+JSayUp0qi5k6EaO
        1JwhxEC5JUK86VuWVZ0uS7Ccyz30coRoIA==
X-Google-Smtp-Source: AA0mqf6DRN18kEtRr6vU/bQebITkL+OzR7rXnAWVsO4WmsI6YKnoCOGcBUx49MMTn8GtKKmZYYEz8T0hXzfXAA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:902:8698:b0:188:e255:39af with SMTP
 id g24-20020a170902869800b00188e25539afmr80407695plo.86.1671252297906; Fri,
 16 Dec 2022 20:44:57 -0800 (PST)
Date:   Sat, 17 Dec 2022 12:44:36 +0800
In-Reply-To: <20221217044436.4138642-1-davidgow@google.com>
Mime-Version: 1.0
References: <20221217044436.4138642-1-davidgow@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221217044436.4138642-4-davidgow@google.com>
Subject: [PATCH 3/3] rust: arch/um: Add support for CONFIG_RUST under x86_64 UML
From:   David Gow <davidgow@google.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     David Gow <davidgow@google.com>, rust-for-linux@vger.kernel.org,
        linux-um@lists.infradead.org, llvm@lists.linux.dev,
        linux-doc@vger.kernel.org, kunit-dev@googlegroups.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_RUST currently supports x86_64, but does not support it under
UML. With the previous patches applied, adding support is trivial:
add CONFIG_HAVE_RUST to UML if X86_64 is set.

The scripts/generate_rust_target.rs file already checks for
CONFIG_X86_64, not CONFIG_X86, so is prepared for UML support.

The Rust support does not currently support X86_32.

Also, update the Rust architecture support documentation to not that
this is being maintained: I intend to look after this as best I can.

Signed-off-by: David Gow <davidgow@google.com>
---
 Documentation/rust/arch-support.rst | 2 ++
 arch/um/Kconfig                     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
index 6982b63775da..a526ca1c688b 100644
--- a/Documentation/rust/arch-support.rst
+++ b/Documentation/rust/arch-support.rst
@@ -17,3 +17,5 @@ Architecture  Level of support  Constraints
 ============  ================  ==============================================
 ``x86``       Maintained        ``x86_64`` only.
 ============  ================  ==============================================
+``um``        Maintained        ``x86_64`` only.
+============  ================  ==============================================
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index ad4ff3b0e91e..4db186f019ae 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -28,6 +28,7 @@ config UML
 	select TRACE_IRQFLAGS_SUPPORT
 	select TTY # Needed for line.c
 	select HAVE_ARCH_VMAP_STACK
+	select HAVE_RUST			if X86_64
 
 config MMU
 	bool
-- 
2.39.0.314.g84b9a713c41-goog

