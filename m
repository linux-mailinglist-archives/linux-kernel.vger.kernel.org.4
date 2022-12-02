Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E4B640A65
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbiLBQQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiLBQQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:16:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680E0CC65A;
        Fri,  2 Dec 2022 08:16:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E516B821F0;
        Fri,  2 Dec 2022 16:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C939EC43152;
        Fri,  2 Dec 2022 16:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669997760;
        bh=Fu0cQySj6UrPLD5hDPAQuIBqC91+Uyo9Z9HV2mYAaok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RV0FORfM/sgu1IT0HI/gc8w6bR0fwFSxo5jG4QS2W+B3fltkS0gl5tZUSXr4MmGGE
         IDOVl0VTFvK3xbvQuIuhsBU7sWjwn5PW4QKicCEwbD5w9hHZu0p0tqbvlIHhCQulpr
         ynzBlpngUBX0n6FP2A7TNmAOLKiPRtDTYOhmTtsOoKQJkvOd+VzMhFYKSp8y3YQwwB
         1fGmbGvvU0q0vWAmTK4EphZ9H+pKZuqBP+GJPAR6K8JU8ANdyzYHNXidCgJmg1fWwz
         pTzX65kWdJFhveTMW2GZk6zZobgt2z8MblGS2EmWx4eBVbDXKYa0/hjv93ZXxryUZw
         WXVDAmk7+p4WQ==
From:   ojeda@kernel.org
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v2 11/28] rust: prelude: add `error::code::*` constant items
Date:   Fri,  2 Dec 2022 17:14:42 +0100
Message-Id: <20221202161502.385525-12-ojeda@kernel.org>
In-Reply-To: <20221202161502.385525-1-ojeda@kernel.org>
References: <20221202161502.385525-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wedson Almeida Filho <wedsonaf@gmail.com>

It is convenient to have all the `Error` constant items (such as
`EINVAL`) available as-is everywhere (i.e. for code using the kernel
prelude such as kernel modules).

Therefore, add all of them to the prelude.

For instance, this allows to write `Err(EINVAL)` to create
a kernel `Result`:

    fn f() -> Result<...> {
        ...
        Err(EINVAL)
    }

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
[Reworded, adapted for upstream and applied latest changes]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/prelude.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 7c4c35bf3c66..1e08b08e9420 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -19,6 +19,6 @@ pub use macros::{module, vtable};
 
 pub use super::{pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info, pr_notice, pr_warn};
 
-pub use super::error::{Error, Result};
+pub use super::error::{code::*, Error, Result};
 
 pub use super::ThisModule;
-- 
2.38.1

