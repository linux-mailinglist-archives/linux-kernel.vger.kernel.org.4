Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFF4707314
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjEQUcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 16:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjEQUbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:31:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFA29ED1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:31:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba2526a8918so2080886276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684355498; x=1686947498;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jLXiUUyXZrTzMck4adUmLD4E9Fc4RhEDENIXEJkaNoM=;
        b=znudaE6IMsPT1uZOZAWZvlBQ4z18gWvrpr8fQ4zqjHZn7//aWo6ZQ16KmYAioUALok
         80CFBTCmDmR4fNUzZUBj27X6ZgckRry3Fu5AZp45GYmXV2veHpWjjyrtCSQoQqXfFt1B
         4Ij33s7K67FQEiNQAKgTwoZzNOk6K5OasuA+WzfFmKEab16aipOvC9AC4a0oMtyQ6k7d
         0k7oZtWs6TculeG1g/RbFchNLUWoLMWBAR5qgp3kvjsBryBPOkhTeRwWPYYZyfgxVK1t
         k9AxgpmoHL+5TCJq+1CuAf/e7QXSrYKn7oaL9C7P43K27eB9YFHabF88nKM/ykhEAczq
         6k0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684355498; x=1686947498;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLXiUUyXZrTzMck4adUmLD4E9Fc4RhEDENIXEJkaNoM=;
        b=K8hHTwfyWIxauhLpxaamRzqk9tm0ixKHSXhkSziifubEmuJD3fZc2jJKuQ0RpztBGG
         Va400BwcA4IoKi2epqhY8b4c9JypzXApiF9krYS0HADNxTCTR6TLo0FYAwr2+WJ656wm
         BNTOc827PFx/diNw9euZx6i+QePXx6Y+VXtVWElgvBfYLKWi3vliVXmhKm2iz0wGVg4U
         eVjTM9xEhq48W4vPCbWfc3WfGJSaftLP6/FbhBC/3OKAaWYxJFe2W8krii0JgYrDvZzI
         gEbH1QRNlmFEaTNMLiXfASPDobz8BI++/ljNd7TfX6dox6E7zNDiYIy9LWieVvInSSFO
         JB9g==
X-Gm-Message-State: AC+VfDzaxri4ag2XgD74N0YVMeSbN6+Q1WCTqEEQxieRzQGs55Kw+ap1
        joYWqlztKibRQDXRo5sxBl9LqtB6OVcukl4=
X-Google-Smtp-Source: ACHHUZ5tmViXv0Bqs6ow3OaP3sc8at0uvRWvWrrBDcPlcxzghI4kY4ZB84bf1guzl4ZHc3sj/NZqh2+ej0dk5OY=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a25:9309:0:b0:ba8:2e79:c193 with SMTP id
 f9-20020a259309000000b00ba82e79c193mr2630490ybo.12.1684355498779; Wed, 17 May
 2023 13:31:38 -0700 (PDT)
Date:   Wed, 17 May 2023 20:31:19 +0000
In-Reply-To: <20230517203119.3160435-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230517203119.3160435-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230517203119.3160435-8-aliceryhl@google.com>
Subject: [PATCH v1 7/7] rust: workqueue: add `try_spawn` helper method
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a convenience method that lets you spawn a closure for
execution on a workqueue. This will be the most convenient way to use
workqueues, but it is fallible because it needs to allocate memory.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/workqueue.rs | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 007005ddcaf0..303b72efd95f 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -57,6 +57,42 @@ impl Queue {
             })
         }
     }
+
+    /// Tries to spawn the given function or closure as a work item.
+    ///
+    /// This method can fail because it allocates memory to store the work item.
+    pub fn try_spawn<T: 'static + Send + Fn()>(&self, func: T) -> Result {
+        let init = pin_init!(ClosureWork {
+            work <- Work::new(),
+            func: Some(func),
+        });
+
+        self.enqueue(Box::pin_init(init)?);
+        Ok(())
+    }
+}
+
+/// A helper type used in `try_spawn`.
+#[pin_data]
+struct ClosureWork<T> {
+    #[pin]
+    work: Work<Pin<Box<ClosureWork<T>>>>,
+    func: Option<T>,
+}
+
+impl<T> ClosureWork<T> {
+    fn project(self: Pin<&mut Self>) -> &mut Option<T> {
+        // SAFETY: The `func` field is not structurally pinned.
+        unsafe { &mut self.get_unchecked_mut().func }
+    }
+}
+
+impl<T: FnOnce()> BoxWorkItem for ClosureWork<T> {
+    fn run(mut self: Pin<Box<Self>>) {
+        if let Some(func) = self.as_mut().project().take() {
+            (func)()
+        }
+    }
 }
 
 /// A work item.
@@ -280,6 +316,10 @@ macro_rules! impl_has_work {
     )*};
 }
 
+impl_has_work! {
+    impl<T> HasWork<Pin<Box<Self>>> for ClosureWork<T> { self.work }
+}
+
 /// Declares that [`Arc<Self>`] should implement [`WorkItem`].
 ///
 /// # Examples
-- 
2.40.1.606.ga4b1b128d6-goog

