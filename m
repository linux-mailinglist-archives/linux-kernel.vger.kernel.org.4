Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613676DA510
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238173AbjDFV5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjDFV5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:57:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8679EC166;
        Thu,  6 Apr 2023 14:56:31 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2804:14d:72b4:8284:32a8:8167:f815:2895])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dwlsalmeida)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 72D8666031D8;
        Thu,  6 Apr 2023 22:56:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680818190;
        bh=TtJ2WnTRRkClhj1i41IWbhWF3uLZCg3n4yAehksz+EQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ik0lOVuKltSX4y1PfBu6VtFlVFA0pILRH2V1/WCWU/rLrhfJeQ6sta6PLgKugNPvX
         g5U1EB29IDbYe1DNPCZekG5g8PqFaBPEW0tx5sA94q8zjXezQ1Be1Z22mclr51iY81
         rQFPOyedj55Iy4NibjdvwpMAdqn6sC5llmmMLgLU91J5scKfrXCsJ1c9ck34F3zD+A
         jAW2TmtQ3Qlt030U9zLFQSyNyRwnAqBmDcPijl9aoNeRhb7ozXc1fKti9K/GCiJKuc
         UNYfIRGGTIeaJaO0K2YRPRUU12D8NItP2cWXVWpuSNwMU1SrBUW08e+B8lkpOAQ4kZ
         3nC5PgPdkRbmg==
From:   Daniel Almeida <daniel.almeida@collabora.com>
To:     wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        hverkuil@xs4all.nl
Cc:     Daniel Almeida <daniel.almeida@collabora.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
Subject: [PATCH 1/6] rust: media: add the media module
Date:   Thu,  6 Apr 2023 18:56:10 -0300
Message-Id: <20230406215615.122099-2-daniel.almeida@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230406215615.122099-1-daniel.almeida@collabora.com>
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the initial rust v4l2 support, add the media module
to the kernel crate.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/lib.rs            | 2 ++
 rust/kernel/media/mod.rs      | 5 +++++
 rust/kernel/media/v4l2/mod.rs | 3 +++
 3 files changed, 10 insertions(+)
 create mode 100644 rust/kernel/media/mod.rs
 create mode 100644 rust/kernel/media/v4l2/mod.rs

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index c20b37e88ab2..d7e8f3297405 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -48,6 +48,8 @@ pub mod types;
 #[doc(hidden)]
 pub use bindings;
 pub use macros;
+#[cfg(CONFIG_MEDIA_SUPPORT)]
+pub mod media;
 
 #[cfg(CONFIG_ARM_AMBA)]
 pub mod amba;
diff --git a/rust/kernel/media/mod.rs b/rust/kernel/media/mod.rs
new file mode 100644
index 000000000000..342e66382719
--- /dev/null
+++ b/rust/kernel/media/mod.rs
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Media subsystem
+
+pub mod v4l2;
diff --git a/rust/kernel/media/v4l2/mod.rs b/rust/kernel/media/v4l2/mod.rs
new file mode 100644
index 000000000000..068dd9b4863d
--- /dev/null
+++ b/rust/kernel/media/v4l2/mod.rs
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+
+//! Abstractions for include/media/v4l2-*.h
-- 
2.40.0

