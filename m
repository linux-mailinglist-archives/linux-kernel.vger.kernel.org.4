Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7316F5403
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjECJIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjECJHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:07:39 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF87649EC
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 02:07:28 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f1950f5628so47382935e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 02:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1683104847; x=1685696847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NatBW5eIyTK1anrfiMCu2himhC60W7yfvOzay2vGAv8=;
        b=p4BdIUQKmjerjPm5oD73Ay9h/299qjSSXcgv4Bb+Qmp2g4owzjxFGY/dLkga6OOGno
         Nr2jHy7hW1KNXt2jFPKbJW4XgnrPwqb0NM4WY1MM+UiU7g1J3uHlVIYp9v2p258ltsrF
         t7OVqRC2Ti6RK+iAoEbzM+tW8O5ETUmXvIXQ0Nxl6UW1vz8hYm/rqZHDMKt3tb7YvkKb
         iSqk4PNYf+RSBTYroInYiqq9Vr6T8hmJUsoBUh2dCy7hB3MQazTr8tkOvGxRyX7V7C39
         56UYzcYTSvClGccgLv6Ha/V3GAC/brvbNBumsb2Up+/YyAQ1fBFju2Cj4nuQOlnNUGET
         azOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683104847; x=1685696847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NatBW5eIyTK1anrfiMCu2himhC60W7yfvOzay2vGAv8=;
        b=C4UcpfjM5uxFCfZN3I632bYW8Gl07NlmDWC95eNCbQFYfnFEq4UL0ByrWDOutpaQBJ
         mNjIeJaHjewu7ZiG3tK/plz05e7r2CkONu0Y5PtXRVv4QGgiY2gzH4HK6/xxnsysFqai
         cZSFTIEjgm8z3edbrYKobZZzF2AY0VPJieIrGzO1tACM0qOpavaAVTPZBWDV3L/lJXQq
         BgafV208QLdpFARatAPhwmgCIJZjnCNz8j+SVPLEcIv1jyErUaKXQ9nGpS+2uo3aIYRc
         juMJyW148d7XYjOHRl6S7+9OKc3s8IBqu4zA5En+3xhquziG+eHedIoNzB4IaLyKVXSg
         Waaw==
X-Gm-Message-State: AC+VfDweEeE7XnGh1MwxSwwJMhWOTzHzQjIbrru00CmVsNjcMN+nr2Hl
        eiMd0qNGbMFGRE1E9VTpnS1Mow==
X-Google-Smtp-Source: ACHHUZ4V+4yXzD+7jMqjGJI2nu+9smDJfF7r7MsYfyR2VAHsFx3pXLD9Y8eoC2R23SPbbiOVCzgrKw==
X-Received: by 2002:a1c:4b0c:0:b0:3ee:b3bf:5f7c with SMTP id y12-20020a1c4b0c000000b003eeb3bf5f7cmr14680443wma.23.1683104846390;
        Wed, 03 May 2023 02:07:26 -0700 (PDT)
Received: from localhost ([147.161.155.99])
        by smtp.gmail.com with ESMTPSA id x2-20020a05600c21c200b003f182c11667sm1233908wmj.39.2023.05.03.02.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 02:07:26 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Andreas Hindborg <a.hindborg@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <nmi@metaspace.dk>,
        linux-kernel@vger.kernel.org (open list), gost.dev@samsung.com
Subject: [RFC PATCH 10/11] rust: add null block driver
Date:   Wed,  3 May 2023 11:07:07 +0200
Message-Id: <20230503090708.2524310-11-nmi@metaspace.dk>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503090708.2524310-1-nmi@metaspace.dk>
References: <20230503090708.2524310-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

The driver is implemented entirely using safe Rust. This initial version
supports direct completion, read and write requests, blk-mq and optional memory
backing.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 drivers/block/Kconfig         |   4 +
 drivers/block/Makefile        |   4 +
 drivers/block/rnull-helpers.c |  60 ++++++++++++
 drivers/block/rnull.rs        | 177 ++++++++++++++++++++++++++++++++++
 scripts/Makefile.build        |   2 +-
 5 files changed, 246 insertions(+), 1 deletion(-)
 create mode 100644 drivers/block/rnull-helpers.c
 create mode 100644 drivers/block/rnull.rs

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index f79f20430ef7..644ef1bc7574 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -354,6 +354,10 @@ config VIRTIO_BLK
 	  This is the virtual block driver for virtio.  It can be used with
           QEMU based VMMs (like KVM or Xen).  Say Y or M.
 
+config BLK_DEV_RS_NULL
+	tristate "Rust null block driver"
+	depends on RUST
+
 config BLK_DEV_RBD
 	tristate "Rados block device (RBD)"
 	depends on INET && BLOCK
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 101612cba303..cebbeece4bc2 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -9,6 +9,10 @@
 # needed for trace events
 ccflags-y				+= -I$(src)
 
+obj-$(CONFIG_BLK_DEV_RS_NULL) += rnull_mod.o
+rnull_mod-y := rnull-helpers.o rnull.o
+LLVM_LINK_FIX_drivers/block/rnull_mod.o := 1
+
 obj-$(CONFIG_MAC_FLOPPY)	+= swim3.o
 obj-$(CONFIG_BLK_DEV_SWIM)	+= swim_mod.o
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
diff --git a/drivers/block/rnull-helpers.c b/drivers/block/rnull-helpers.c
new file mode 100644
index 000000000000..826f2773ed93
--- /dev/null
+++ b/drivers/block/rnull-helpers.c
@@ -0,0 +1,60 @@
+
+#include <linux/bio.h>
+
+__attribute__((always_inline))
+void rust_helper_bio_advance_iter_single(const struct bio *bio,
+                                           struct bvec_iter *iter, unsigned int bytes)
+{
+	bio_advance_iter_single(bio, iter, bytes);
+}
+
+__attribute__((always_inline)) void *rust_helper_kmap(struct page *page)
+{
+	return kmap(page);
+}
+
+__attribute__((always_inline)) void rust_helper_kunmap(struct page *page)
+{
+	return kunmap(page);
+}
+
+__attribute__((always_inline)) void *rust_helper_kmap_atomic(struct page *page)
+{
+	return kmap_atomic(page);
+}
+
+__attribute__((always_inline)) void rust_helper_kunmap_atomic(void* address)
+{
+	kunmap_atomic(address);
+}
+
+__attribute__((always_inline)) struct page *
+rust_helper_alloc_pages(gfp_t gfp_mask, unsigned int order)
+{
+	return alloc_pages(gfp_mask, order);
+}
+
+__attribute__((always_inline)) void rust_helper_spin_lock_irq(spinlock_t *lock)
+{
+	spin_lock_irq(lock);
+}
+
+__attribute__((always_inline)) void
+rust_helper_spin_unlock_irq(spinlock_t *lock)
+{
+	spin_unlock_irq(lock);
+}
+__attribute__((always_inline)) unsigned long
+rust_helper_spin_lock_irqsave(spinlock_t *lock)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(lock, flags);
+
+	return flags;
+}
+__attribute__((always_inline)) void
+rust_helper_spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
+{
+	spin_unlock_irqrestore(lock, flags);
+}
diff --git a/drivers/block/rnull.rs b/drivers/block/rnull.rs
new file mode 100644
index 000000000000..d95025664a60
--- /dev/null
+++ b/drivers/block/rnull.rs
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! This is a null block driver. It currently supports optional memory backing,
+//! blk-mq interface and direct completion. The driver is configured at module
+//! load time by parameters `memory_backed` and `capacity_mib`.
+
+use kernel::{
+    bindings,
+    block::{
+        bio::Segment,
+        mq::{self, GenDisk, Operations, TagSet},
+    },
+    error::Result,
+    macros::vtable,
+    new_mutex, new_spinlock,
+    pages::Pages,
+    pr_info,
+    prelude::*,
+    radix_tree::RadixTree,
+    sync::{Arc, Mutex, SpinLock},
+    types::ForeignOwnable,
+};
+
+module! {
+    type: NullBlkModule,
+    name: "rs_null_blk",
+    author: "Andreas Hindborg",
+    license: "GPL v2",
+    params: {
+        memory_backed: bool {
+            default: true,
+            permissions: 0,
+            description: "Use memory backing",
+        },
+        capacity_mib: u64 {
+            default: 4096,
+            permissions: 0,
+            description: "Device capacity in MiB",
+        },
+    },
+}
+
+struct NullBlkModule {
+    _disk: Pin<Box<Mutex<GenDisk<NullBlkDevice>>>>,
+}
+
+fn add_disk(tagset: Arc<TagSet<NullBlkDevice>>) -> Result<GenDisk<NullBlkDevice>> {
+    let tree = RadixTree::new()?;
+    let queue_data = Box::pin_init(new_spinlock!(tree, "rnullb:mem"))?;
+
+    let disk = GenDisk::try_new(tagset, queue_data)?;
+    disk.set_name(format_args!("rnullb{}", 0))?;
+    disk.set_capacity(*capacity_mib.read() << 11);
+    disk.set_queue_logical_block_size(4096);
+    disk.set_queue_physical_block_size(4096);
+    disk.set_rotational(false);
+    Ok(disk)
+}
+
+impl kernel::Module for NullBlkModule {
+    fn init(_module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust null_blk loaded\n");
+        // Major device number?
+        let tagset = TagSet::try_new(1, (), 256, 1)?;
+        let disk = Box::pin_init(new_mutex!(add_disk(tagset)?, "nullb:disk"))?;
+
+        disk.lock().add()?;
+
+        Ok(Self { _disk: disk })
+    }
+}
+
+impl Drop for NullBlkModule {
+    fn drop(&mut self) {
+        pr_info!("Dropping rnullb\n");
+    }
+}
+
+struct NullBlkDevice;
+type Tree = kernel::radix_tree::RadixTree<Box<Pages<0>>>;
+type Data = Pin<Box<SpinLock<Tree>>>;
+
+impl NullBlkDevice {
+    #[inline(always)]
+    fn write(tree: &mut Tree, sector: usize, segment: &Segment<'_>) -> Result {
+        let idx = sector >> 3; // TODO: PAGE_SECTOR_SHIFT
+        let mut page = if let Some(page) = tree.get_mut(idx as u64) {
+            page
+        } else {
+            tree.try_insert(idx as u64, Box::try_new(Pages::new()?)?)?;
+            tree.get_mut(idx as u64).unwrap()
+        };
+
+        segment.copy_to_page_atomic(&mut page)?;
+
+        Ok(())
+    }
+
+    #[inline(always)]
+    fn read(tree: &mut Tree, sector: usize, segment: &mut Segment<'_>) -> Result {
+        let idx = sector >> 3; // TODO: PAGE_SECTOR_SHIFT
+        if let Some(page) = tree.get(idx as u64) {
+            segment.copy_from_page_atomic(page)?;
+        }
+
+        Ok(())
+    }
+
+    #[inline(never)]
+    fn transfer(
+        command: bindings::req_op,
+        tree: &mut Tree,
+        sector: usize,
+        segment: &mut Segment<'_>,
+    ) -> Result {
+        match command {
+            bindings::req_op_REQ_OP_WRITE => Self::write(tree, sector, segment)?,
+            bindings::req_op_REQ_OP_READ => Self::read(tree, sector, segment)?,
+            _ => (),
+        }
+        Ok(())
+    }
+}
+
+#[vtable]
+impl Operations for NullBlkDevice {
+    type RequestData = ();
+    type QueueData = Data;
+    type HwData = ();
+    type TagSetData = ();
+
+    fn new_request_data(
+        _tagset_data: <Self::TagSetData as ForeignOwnable>::Borrowed<'_>,
+    ) -> Result<Self::RequestData> {
+        Ok(())
+    }
+
+    #[inline(always)]
+    fn queue_rq(
+        _hw_data: <Self::HwData as ForeignOwnable>::Borrowed<'_>,
+        queue_data: <Self::QueueData as ForeignOwnable>::Borrowed<'_>,
+        rq: &mq::Request<Self>,
+        _is_last: bool,
+    ) -> Result {
+        rq.start();
+        if *memory_backed.read() {
+            let mut tree = queue_data.lock_irqsave();
+
+            let mut sector = rq.sector();
+            for bio in rq.bio_iter() {
+                for mut segment in bio.segment_iter() {
+                    let _ = Self::transfer(rq.command(), &mut tree, sector, &mut segment);
+                    sector += segment.len() >> 9; // TODO: SECTOR_SHIFT
+                }
+            }
+        }
+        rq.end_ok();
+        Ok(())
+    }
+
+    fn commit_rqs(
+        _hw_data: <Self::HwData as ForeignOwnable>::Borrowed<'_>,
+        _queue_data: <Self::QueueData as ForeignOwnable>::Borrowed<'_>,
+    ) {
+    }
+
+    fn complete(_rq: &mq::Request<Self>) {
+        //rq.end_ok();
+    }
+
+    fn init_hctx(
+        _tagset_data: <Self::TagSetData as ForeignOwnable>::Borrowed<'_>,
+        _hctx_idx: u32,
+    ) -> Result<Self::HwData> {
+        Ok(())
+    }
+}
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 9f94fc83f086..94127fc3cf77 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -277,7 +277,7 @@ $(obj)/%.lst: $(src)/%.c FORCE
 # Compile Rust sources (.rs)
 # ---------------------------------------------------------------------------
 
-rust_allowed_features := core_ffi_c,explicit_generic_args_with_impl_trait,new_uninit,pin_macro
+rust_allowed_features := core_ffi_c,explicit_generic_args_with_impl_trait,new_uninit,pin_macro,allocator_api
 
 rust_common_cmd = \
 	RUST_MODFILE=$(modfile) $(RUSTC_OR_CLIPPY) $(rust_flags) \
-- 
2.40.0

