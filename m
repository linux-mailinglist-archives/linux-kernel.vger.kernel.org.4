Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFCD719EED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjFAN5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbjFAN5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:57:49 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D66FC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 06:57:48 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-506b21104faso684004a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 06:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685627867; x=1688219867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Il50p8nZECxcQJDqUwkg/ZOtCLHgjGH7eHBvIr+OJqA=;
        b=woEEVeXRdIaNOBTuxaLQGdFXHzH0XEF+niu0dsO9UeJfo1436BCJtmE9PIaMuBm1Gw
         2TlWaCgo7du6wZP7cPNRfr2NARZW9QeUN+Kyf/Oo6lnJMqGqm6GXcV5SZ+/8/PFjwFym
         1TX75spnYLhrC7D6K6gHyZYI+3ApgUJsV3Gz/G1Oux0qwDrekdin+1Hf2uXbma6agOuy
         xQdsi5wTSib1B2vfRftoFo/X8JejRIQDj5V8tDbJ6tSX2QeWnIVyIZzqyr9/i/ur/5G1
         aC7RuAJ9WiyhVR+6T1jXJDvmY7YeW0blKboqYpu4UoLPr3c77ZS/i6p5z0Yei5sMJm8a
         WcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685627867; x=1688219867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Il50p8nZECxcQJDqUwkg/ZOtCLHgjGH7eHBvIr+OJqA=;
        b=fN0qtUcnsRGtDD0TCKCaSC2M5fK6yDKvsGpDr4WUZnIeUPj3iVfXjOohoxEuJVqxcd
         aRiGsqy8lu4DnPqeqOXs28Z0jmtSJkuIi7NRtODjyqf+R3P4B/e2P0RIfYSUjuEFxe8M
         gpYvK2fPL7g2c8Ymd11JlLu/YwplOr5gDckdz2Ty4B+vvtUptnYdc81zTDVsOoY1YFTu
         ZfmC0VCtEWgExtnXv4ipBDemIB9He6t/t5EsnLpSNnQMI+w6BiE9l1tERHaIjZX9l4Dr
         yMfxEX6qSOaj4znHmIoL6Y+hTuuK4gCQdCHTZfZNDBdipwPRg/1Nc+Y+PhoCCMTp7Bqh
         4juA==
X-Gm-Message-State: AC+VfDzfXQgTS34JsArPPOTA0rXDU/xa6p8zxXlqaa5IibMf2xF+oDhu
        1xYxocv+aOuDqDelaC8b7LcMf1R3Ax5Aduk=
X-Google-Smtp-Source: ACHHUZ7WvE4QJSoGfg6HWhpos46egMoDrUulcJUiBKGiTAvmV94C08JCqmzQITaMZhMI/RA5MuReTCwzHFong84=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a50:ab09:0:b0:50b:c88a:f7cd with SMTP id
 s9-20020a50ab09000000b0050bc88af7cdmr2009edc.4.1685627867420; Thu, 01 Jun
 2023 06:57:47 -0700 (PDT)
Date:   Thu,  1 Jun 2023 13:49:46 +0000
In-Reply-To: <20230601134946.3887870-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230601134946.3887870-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230601134946.3887870-9-aliceryhl@google.com>
Subject: [PATCH v2 8/8] rust: workqueue: add examples
From:   Alice Ryhl <aliceryhl@google.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds two examples of how to use the workqueue. The first example
shows how to use it when you only have one `work_struct` field, and the
second example shows how to use it when you have multiple `work_struct`
fields.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/workqueue.rs | 104 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index c302e8b8624b..cefcf43ff40e 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -26,6 +26,110 @@
 //!  * The `WorkItemPointer` trait is implemented for the pointer type that points at a something
 //!    that implements `WorkItem`.
 //!
+//! ## Example
+//!
+//! This example defines a struct that holds an integer and can be scheduled on the workqueue. When
+//! the struct is executed, it will print the integer. Since there is only one `work_struct` field,
+//! we do not need to specify ids for the fields.
+//!
+//! ```
+//! use kernel::prelude::*;
+//! use kernel::sync::Arc;
+//! use kernel::workqueue::{self, Work, WorkItem};
+//!
+//! #[pin_data]
+//! struct MyStruct {
+//!     value: i32,
+//!     #[pin]
+//!     work: Work<MyStruct>,
+//! }
+//!
+//! impl_has_work! {
+//!     impl HasWork<Self> for MyStruct { self.work }
+//! }
+//!
+//! impl MyStruct {
+//!     fn new(value: i32) -> Result<Arc<Self>> {
+//!         Arc::pin_init(pin_init!(MyStruct {
+//!             value,
+//!             work <- Work::new(),
+//!         }))
+//!     }
+//! }
+//!
+//! impl WorkItem for MyStruct {
+//!     type Pointer = Arc<MyStruct>;
+//!
+//!     fn run(this: Arc<MyStruct>) {
+//!         pr_info!("The value is: {}", this.value);
+//!     }
+//! }
+//!
+//! /// This method will enqueue the struct for execution on the system workqueue, where its value
+//! /// will be printed.
+//! fn print_later(val: Arc<MyStruct>) {
+//!     let _ = workqueue::system().enqueue(val);
+//! }
+//! ```
+//!
+//! The following example shows how multiple `work_struct` fields can be used:
+//!
+//! ```
+//! use kernel::prelude::*;
+//! use kernel::sync::Arc;
+//! use kernel::workqueue::{self, Work, WorkItem};
+//!
+//! #[pin_data]
+//! struct MyStruct {
+//!     value_1: i32,
+//!     value_2: i32,
+//!     #[pin]
+//!     work_1: Work<MyStruct, 1>,
+//!     #[pin]
+//!     work_2: Work<MyStruct, 2>,
+//! }
+//!
+//! impl_has_work! {
+//!     impl HasWork<Self, 1> for MyStruct { self.work_1 }
+//!     impl HasWork<Self, 2> for MyStruct { self.work_2 }
+//! }
+//!
+//! impl MyStruct {
+//!     fn new(value_1: i32, value_2: i32) -> Result<Arc<Self>> {
+//!         Arc::pin_init(pin_init!(MyStruct {
+//!             value_1,
+//!             value_2,
+//!             work_1 <- Work::new(),
+//!             work_2 <- Work::new(),
+//!         }))
+//!     }
+//! }
+//!
+//! impl WorkItem<1> for MyStruct {
+//!     type Pointer = Arc<MyStruct>;
+//!
+//!     fn run(this: Arc<MyStruct>) {
+//!         pr_info!("The value is: {}", this.value_1);
+//!     }
+//! }
+//!
+//! impl WorkItem<2> for MyStruct {
+//!     type Pointer = Arc<MyStruct>;
+//!
+//!     fn run(this: Arc<MyStruct>) {
+//!         pr_info!("The second value is: {}", this.value_2);
+//!     }
+//! }
+//!
+//! fn print_1_later(val: Arc<MyStruct>) {
+//!     let _ = workqueue::system().enqueue::<Arc<MyStruct>, 1>(val);
+//! }
+//!
+//! fn print_2_later(val: Arc<MyStruct>) {
+//!     let _ = workqueue::system().enqueue::<Arc<MyStruct>, 2>(val);
+//! }
+//! ```
+//!
 //! C header: [`include/linux/workqueue.h`](../../../../include/linux/workqueue.h)
 
 use crate::{bindings, prelude::*, sync::Arc, types::Opaque};
-- 
2.41.0.rc0.172.g3f132b7071-goog

