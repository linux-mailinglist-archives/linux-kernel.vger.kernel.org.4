Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1A96A1888
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjBXJMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBXJME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:12:04 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDA85E860;
        Fri, 24 Feb 2023 01:12:01 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A76F73FA55;
        Fri, 24 Feb 2023 09:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677229920;
        bh=Kexcv5VSFsdhbWGeV5GdVt3exuFu1QaguzBZjGsJVc4=;
        h=From:Subject:Date:To:Cc;
        b=F4oms03Jp7CTRzOF3yqto6QFaEcvhk45z7gjOPE+9ydMdJzwydWFHiqqR8WVUSTbm
         hAlJCWyuf99nsMUTEpSR5N25p20FBWG+NmqtHegZBJtBoIbQTBB36eOl/MCLm+p40Y
         Zs2J6c79xrLyNBfntke48kRpTDRnEOidF+hcvU9CzxVdHCB+34iZcVHkzWoV2QTFTR
         vP21OnLMQmmyFyzvb/YlROKY6NC7srAiS/ax2DVwaF1x0iHMbAHZvTwnpGcPzgGxjN
         vb/dEkdzvvHjm8A5mni54oOXt1DalLrhPdm2d3hQRjCC31Zol8oru8Rkk2agPBPAJM
         Wz6QLemKJqbkw==
From:   Asahi Lina <lina@asahilina.net>
Subject: [PATCH 0/4] rust: alloc: vec: Add some missing fallible try_*
 methods
Date:   Fri, 24 Feb 2023 18:11:46 +0900
Message-Id: <20230224-rust-vec-v1-0-733b5b5a57c5@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFJ/+GMC/x2NQQ6DMAwEv4J8rtXURS3iK6iHJDjgS4psQJUQf
 2/CcXZntQcYq7BB3xygvIvJNxd43BqIs88To4yFgRw9HVGLutmKO0cc05uSb0PnXhGKHrwxBvU
 5znUwLdv9cmte+0U5ye+6Gj7n+QchxcjpegAAAA==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677229917; l=1547;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=Kexcv5VSFsdhbWGeV5GdVt3exuFu1QaguzBZjGsJVc4=;
 b=YQ2gdXmj9OUyOCsZnIMJb7O8keRcS8R6qfWgeG/YVrCqdM+f9OlY2HjMakkrhbPo6Mnu+F9AT
 9id+5rR0/TSCVZS6Y1Y1ZOuXVItaX+8VyaGTT7Dm5P+PqIhhTL3HdB5
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=Qn8jZuOtR1m5GaiDfTrAoQ4NE1XoYVZ/wmt5YtXWFC4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone!

This short series is part of the set of dependencies for the drm/asahi
Apple M1/M2 GPU driver.

This series imports part of a commit from Miguel in
rust-for-linux/linux, which adds missing fallible
mutation/allocation methods to `Vec`. These are generally useful to make
standard features available to the kernel environment, which does not
have infallible allocation.

The additions in turn depend on importing two submodules from the Rust
stdlib, which I have attributed using the same commit message template
used for the original import of this part of the codebase. These
versions come from Rust 1.66, but also build on Rust 1.62 (the current
version upstream). I added the SPDX identifiers in a separate commit to
clearly separate the original code from subsequent changes.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
Asahi Lina (3):
      rust: Import upstream `alloc::vec::set_len_on_drop` module
      rust: Import upstream `alloc::vec::spec_extend` module
      rust: Add SPDX headers to alloc::vec::{spec_extend, set_len_on_drop}

Miguel Ojeda (1):
      rust: alloc: vec: Add some try_* methods we need
 rust/alloc/vec/mod.rs             | 137 +++++++++++++++++++++++++++++-
 rust/alloc/vec/set_len_on_drop.rs |  30 +++++++
 rust/alloc/vec/spec_extend.rs     | 172 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 336 insertions(+), 3 deletions(-)
---
base-commit: 83f978b63fa7ad474ca22d7e2772c5988101c9bd
change-id: 20230224-rust-vec-df72fa4b806c

Thank you,
~~ Lina

