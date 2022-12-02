Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314AD640A67
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbiLBQQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbiLBQQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:16:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C83DFB59;
        Fri,  2 Dec 2022 08:15:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7085262333;
        Fri,  2 Dec 2022 16:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F36C43146;
        Fri,  2 Dec 2022 16:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669997754;
        bh=8fgcMdAohdJYjCkWzYvRkRAqAWDQxKAVkDLoxRdowB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YYwF93ZCf7UzzXELsUSmRSnkfBJntXg8aLS8HuPV3a2J+ECFCY4+zLfWSyTjUBbV9
         mZu5WpsHUtugXp36Jntkp3lfpE9LfC2GoSA9wID41WKDBmeNor1D8dm5lDkqEOjn71
         x7fESbWVL3HkGd/xljpCodYSqtujtN16IbAID2aPCoPT2/PuMEqtF/Yj4DJcKCUZZL
         Qk7cXQf7FiwsrgXAaWpWyOPvTJx2COYvaGQXhyHiwnGsAP+HQyAUZ9JSDBpN8lQb+8
         IZJ4pBSL2MDljf1Pvo0z4TfbWyBDCzvtNexWqV8QHlrbFEn4wyLl+MNx9eOCCBOLZW
         rSvYxHlQuZ8yA==
From:   ojeda@kernel.org
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Viktor Garske <viktor@v-gar.de>
Subject: [PATCH v2 09/28] rust: error: add codes from `errno-base.h`
Date:   Fri,  2 Dec 2022 17:14:40 +0100
Message-Id: <20221202161502.385525-10-ojeda@kernel.org>
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

From: Viktor Garske <viktor@v-gar.de>

Only a few codes were added so far. With the `declare_err!`
macro in place, add the remaining ones (which is most of them)
from `include/uapi/asm-generic/errno-base.h`.

Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Viktor Garske <viktor@v-gar.de>
Reviewed-by: Gary Guo <gary@garyguo.net>
[Reworded, adapted for upstream and applied latest changes]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/error.rs | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index b843f3445483..861746f2422d 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -17,7 +17,40 @@ pub mod code {
         };
     }
 
+    declare_err!(EPERM, "Operation not permitted.");
+    declare_err!(ENOENT, "No such file or directory.");
+    declare_err!(ESRCH, "No such process.");
+    declare_err!(EINTR, "Interrupted system call.");
+    declare_err!(EIO, "I/O error.");
+    declare_err!(ENXIO, "No such device or address.");
+    declare_err!(E2BIG, "Argument list too long.");
+    declare_err!(ENOEXEC, "Exec format error.");
+    declare_err!(EBADF, "Bad file number.");
+    declare_err!(ECHILD, "Exec format error.");
+    declare_err!(EAGAIN, "Try again.");
     declare_err!(ENOMEM, "Out of memory.");
+    declare_err!(EACCES, "Permission denied.");
+    declare_err!(EFAULT, "Bad address.");
+    declare_err!(ENOTBLK, "Block device required.");
+    declare_err!(EBUSY, "Device or resource busy.");
+    declare_err!(EEXIST, "File exists.");
+    declare_err!(EXDEV, "Cross-device link.");
+    declare_err!(ENODEV, "No such device.");
+    declare_err!(ENOTDIR, "Not a directory.");
+    declare_err!(EISDIR, "Is a directory.");
+    declare_err!(EINVAL, "Invalid argument.");
+    declare_err!(ENFILE, "File table overflow.");
+    declare_err!(EMFILE, "Too many open files.");
+    declare_err!(ENOTTY, "Not a typewriter.");
+    declare_err!(ETXTBSY, "Text file busy.");
+    declare_err!(EFBIG, "File too large.");
+    declare_err!(ENOSPC, "No space left on device.");
+    declare_err!(ESPIPE, "Illegal seek.");
+    declare_err!(EROFS, "Read-only file system.");
+    declare_err!(EMLINK, "Too many links.");
+    declare_err!(EPIPE, "Broken pipe.");
+    declare_err!(EDOM, "Math argument out of domain of func.");
+    declare_err!(ERANGE, "Math result not representable.");
 }
 
 /// Generic integer kernel error.
-- 
2.38.1

