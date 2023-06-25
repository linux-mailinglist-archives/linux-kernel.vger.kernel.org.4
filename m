Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0F473D0D5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjFYMSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjFYMSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:18:04 -0400
Received: from out0-211.mail.aliyun.com (out0-211.mail.aliyun.com [140.205.0.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D294FE4C;
        Sun, 25 Jun 2023 05:17:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047187;MF=changxian.cqs@antgroup.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---.TdJWI.A_1687695459;
Received: from localhost(mailfrom:changxian.cqs@antgroup.com fp:SMTPD_---.TdJWI.A_1687695459)
          by smtp.aliyun-inc.com;
          Sun, 25 Jun 2023 20:17:40 +0800
From:   "Qingsong Chen" <changxian.cqs@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "=?UTF-8?B?55Sw5rSq5Lqu?=" <tate.thl@antgroup.com>,
        "Qingsong Chen" <changxian.cqs@antgroup.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        "Benno Lossin" <benno.lossin@proton.me>,
        <rust-for-linux@vger.kernel.org>
Subject: [RFC PATCH 7/8] rust: kernel: prepare to implement dm target in Rust
Date:   Sun, 25 Jun 2023 20:16:56 +0800
Message-Id: <20230625121657.3631109-8-changxian.cqs@antgroup.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230625121657.3631109-1-changxian.cqs@antgroup.com>
References: <20230625121657.3631109-1-changxian.cqs@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add some methods to set fields in `dm_target`.
- Add some methods to `TargetDevice` to operate on
  the underlying devices.
- Add some methods to dummy `bio`, for remapping.

Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
---
 rust/helpers.c               |   7 ++
 rust/kernel/device_mapper.rs | 237 +++++++++++++++++++++++++++++++++++
 2 files changed, 244 insertions(+)

diff --git a/rust/helpers.c b/rust/helpers.c
index bb594da56137..706541b58432 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -27,6 +27,7 @@
 #include <linux/spinlock.h>
 #include <linux/sched/signal.h>
 #include <linux/wait.h>
+#include <linux/bio.h>
 
 __noreturn void rust_helper_BUG(void)
 {
@@ -135,6 +136,12 @@ void rust_helper_put_task_struct(struct task_struct *t)
 }
 EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
 
+void rust_helper_bio_set_dev(struct bio *bio, struct block_device *bdev)
+{
+	bio_set_dev(bio, bdev);
+}
+EXPORT_SYMBOL_GPL(rust_helper_bio_set_dev);
+
 /*
  * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
  * as the Rust `usize` type, so we can use it in contexts where Rust
diff --git a/rust/kernel/device_mapper.rs b/rust/kernel/device_mapper.rs
index d2c9d0a5bcd5..fa9b33d529b7 100644
--- a/rust/kernel/device_mapper.rs
+++ b/rust/kernel/device_mapper.rs
@@ -671,6 +671,124 @@ pub fn get_device(&mut self, path: &CStr) -> Result<TargetDevice<T>> {
             }
         }
     }
+
+    /// Return maximum size (in sectors) of I/O submitted to the target.
+    pub fn max_io_len(&self) -> usize {
+        // SAFETY: `self.opaque` is borrowed from foreign pointer, should be valid.
+        unsafe { (*self.opaque.get()).max_io_len as _ }
+    }
+
+    /// Set maximum size (in sectors) of I/O submitted to the target.
+    pub fn set_max_io_len(&mut self, len: usize) -> Result {
+        // SAFETY: `self.opaque` is borrowed from foreign pointer, should be valid.
+        unsafe {
+            to_result(bindings::dm_set_target_max_io_len(
+                self.opaque.get(),
+                len as _,
+            ))
+        }
+    }
+
+    /// Return the number of zero-length barrier bios that will be submitted
+    /// to the target for the purpose of flushing cache.
+    pub fn num_flush_bios(&self) -> usize {
+        // SAFETY: `self.opaque` is borrowed from foreign pointer, should be valid.
+        unsafe { (*self.opaque.get()).num_flush_bios as _ }
+    }
+
+    /// Set the number of zero-length barrier bios that will be submitted
+    /// to the target for the purpose of flushing cache.
+    pub fn set_num_flush_bios(&mut self, num: usize) {
+        // SAFETY: `self.opaque` is borrowed from foreign pointer, should be valid.
+        unsafe {
+            (*self.opaque.get()).num_flush_bios = num as _;
+        }
+    }
+
+    /// Return the number of discard bios.
+    pub fn num_discard_bios(&self) -> usize {
+        // SAFETY: `self.opaque` is borrowed from foreign pointer, should be valid.
+        unsafe { (*self.opaque.get()).num_discard_bios as _ }
+    }
+
+    /// Set the number of discard bios.
+    pub fn set_num_discard_bios(&mut self, num: usize) {
+        // SAFETY: `self.opaque` is borrowed from foreign pointer, should be valid.
+        unsafe {
+            (*self.opaque.get()).num_discard_bios = num as _;
+        }
+    }
+
+    /// Return the number of secure erase bios.
+    pub fn num_secure_erase_bios(&self) -> usize {
+        // SAFETY: `self.opaque` is borrowed from foreign pointer, should be valid.
+        unsafe { (*self.opaque.get()).num_secure_erase_bios as _ }
+    }
+
+    /// Set the number of secure erase bios.
+    pub fn set_num_secure_erase_bios(&mut self, num: usize) {
+        // SAFETY: `self.opaque` is borrowed from foreign pointer, should be valid.
+        unsafe {
+            (*self.opaque.get()).num_secure_erase_bios = num as _;
+        }
+    }
+
+    /// Return the number of WRITE ZEROES bios.
+    pub fn num_write_zeroes_bios(&self) -> usize {
+        // SAFETY: `self.opaque` is borrowed from foreign pointer, should be valid.
+        unsafe { (*self.opaque.get()).num_write_zeroes_bios as _ }
+    }
+
+    /// Set the number of WRITE ZEROES bios.
+    pub fn set_num_write_zeroes_bios(&mut self, num: usize) {
+        // SAFETY: `self.opaque` is borrowed from foreign pointer, should be valid.
+        unsafe {
+            (*self.opaque.get()).num_write_zeroes_bios = num as _;
+        }
+    }
+
+    /// Return the minimum number of extra bytes allocated in each io
+    /// for the target to use.
+    pub fn per_io_data_size(&self) -> usize {
+        // SAFETY: `self.opaque` is borrowed from foreign pointer, should be valid.
+        unsafe { (*self.opaque.get()).per_io_data_size as _ }
+    }
+
+    /// Set the minimum number of extra bytes allocated in each io
+    /// for the target to use.
+    pub fn set_per_io_data_size(&mut self, size: usize) {
+        // SAFETY: `self.opaque` is borrowed from foreign pointer, should be valid.
+        unsafe {
+            (*self.opaque.get()).per_io_data_size = size as _;
+        }
+    }
+
+    /// Set an error string for the target, could be used
+    /// by [`TargetOperations::ctr`].
+    pub fn set_error(&mut self, err: &CStr) {
+        // SAFETY: `self.opaque` is borrowed from foreign pointer, should be valid.
+        unsafe {
+            (*self.opaque.get()).error = err.as_char_ptr() as _;
+        }
+    }
+
+    /// Check if the target is suspended.
+    pub fn suspended(&self) -> bool {
+        // SAFETY: `self.opaque` is borrowed from foreign pointer, should be valid.
+        unsafe { bindings::dm_suspended(self.opaque.get()) != 0 }
+    }
+
+    /// Check if the target is post_suspending.
+    pub fn post_suspending(&self) -> bool {
+        // SAFETY: `self.opaque` is borrowed from foreign pointer, should be valid.
+        unsafe { bindings::dm_post_suspending(self.opaque.get()) != 0 }
+    }
+
+    /// Check if the target is noflush_suspending.
+    pub fn noflush_suspending(&self) -> bool {
+        // SAFETY: `self.opaque` is borrowed from foreign pointer, should be valid.
+        unsafe { bindings::dm_noflush_suspending(self.opaque.get()) != 0 }
+    }
 }
 
 /// Represent an underlying device of a device mapper target.
@@ -721,6 +839,100 @@ pub fn device_sectors(&self) -> usize {
         // SAFETY: the `from_raw` caller should pass valid `dev` pointer.
         unsafe { (*(*self.dev.as_ptr()).bdev).bd_nr_sectors as _ }
     }
+
+    /// Return [NonNull<TargetDevice>].
+    pub fn as_ptr(&mut self) -> NonNull<Self> {
+        // SAFETY: `self` is non-null and valid.
+        unsafe { NonNull::new_unchecked(self as *mut Self) }
+    }
+
+    /// Propagate report zones command to underlying devices.
+    #[cfg(CONFIG_BLK_DEV_ZONED)]
+    pub fn report_zones(
+        &self,
+        start: usize,
+        sector: usize,
+        args: &mut [ReportZonesArgs],
+    ) -> Result {
+        // SAFETY: the `from_raw` caller should pass valid `dev` pointer.
+        unsafe {
+            let bdev = (*self.dev.as_ptr()).bdev;
+            let ptr = args.as_mut_ptr() as *mut bindings::dm_report_zones_args;
+            to_result(bindings::dm_report_zones(
+                bdev,
+                start as _,
+                sector as _,
+                ptr,
+                args.len() as _,
+            ))
+        }
+    }
+
+    /// Translate a device-relative logical-page-offset into an
+    /// absolute physical pfn.
+    ///
+    /// Return the `addr` and the `pages` available for `DAX` at
+    /// that pfn, if success.
+    #[cfg(CONFIG_FS_DAX)]
+    pub fn dax_direct_access(
+        &mut self,
+        pgoff: usize,
+        nr_pages: usize,
+        mode: DaxMode,
+    ) -> Result<(usize, Range<usize>)> {
+        let mut kaddr = core::ptr::null_mut();
+        let mut pfn = bindings::pfn_t::default();
+
+        // SAFETY: the `from_raw` caller should pass valid `dev` pointer.
+        let count = unsafe {
+            let dax_dev = (*self.dev.as_ptr()).dax_dev;
+            bindings::dax_direct_access(
+                dax_dev,
+                pgoff as _,
+                nr_pages as _,
+                mode as _,
+                &mut kaddr,
+                &mut pfn,
+            )
+        };
+
+        if count < 0 {
+            Err(Error::from_errno(count as _))
+        } else {
+            let pages = Range {
+                start: pfn.val as usize,
+                end: (pfn.val as usize) + (count as usize),
+            };
+            Ok((kaddr as _, pages))
+        }
+    }
+
+    /// Zero page range.
+    #[cfg(CONFIG_FS_DAX)]
+    pub fn dax_zero_page_range(&mut self, pgoff: usize, nr_pages: usize) -> Result {
+        // SAFETY: the `from_raw` caller should pass valid `dev` pointer.
+        unsafe {
+            let dax_dev = (*self.dev.as_ptr()).dax_dev;
+            to_result(bindings::dax_zero_page_range(dax_dev, pgoff as _, nr_pages))
+        }
+    }
+
+    /// Recover a poisoned range by DAX device driver capable of
+    /// clearing poison.
+    #[cfg(CONFIG_FS_DAX)]
+    pub fn dax_recovery_write(
+        &mut self,
+        iov_iter: Pin<&mut IovIter>,
+        pgoff: usize,
+        region: Range<usize>,
+    ) -> usize {
+        // SAFETY: the `from_raw` caller should pass `dev` pointer.
+        unsafe {
+            let dax_dev = (*self.dev.as_ptr()).dax_dev;
+            let i = iov_iter.opaque.get();
+            bindings::dax_recovery_write(dax_dev, pgoff as _, region.start as _, region.len(), i)
+        }
+    }
 }
 
 impl<T: TargetOperations> Drop for TargetDevice<T> {
@@ -919,6 +1131,31 @@ fn op_and_flags(&self) -> u32 {
     pub fn is_write(&self) -> bool {
         self.op_and_flags() & bindings::req_op_REQ_OP_WRITE != 0
     }
+
+    /// Return the start sector of bio.
+    pub fn sector(&self) -> usize {
+        // SAFETY: the `from_raw` caller should pass valid `bio`, so
+        // `self.opaque` is valid too.
+        unsafe { (*self.opaque.get()).bi_iter.bi_sector as _ }
+    }
+
+    /// Set the start sector of bio.
+    pub fn set_sector(&mut self, sector: usize) {
+        // SAFETY: the `from_raw` caller should pass valid `bio`, so
+        // `self.opaque` is valid too.
+        unsafe {
+            (*self.opaque.get()).bi_iter.bi_sector = sector as _;
+        }
+    }
+
+    /// Set the block device of bio.
+    pub fn set_dev<T: TargetOperations>(&mut self, td: &TargetDevice<T>) {
+        // SAFETY: the `from_raw` caller should pass valid `bio`, so
+        // `self.opaque` is valid too.
+        unsafe {
+            bindings::bio_set_dev(self.opaque.get(), (*td.dev.as_ptr()).bdev);
+        }
+    }
 }
 
 /// Wrap the kernel struct `request`.
-- 
2.40.1

