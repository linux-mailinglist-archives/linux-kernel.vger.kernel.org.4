Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF0573D0D6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjFYMS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjFYMSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:18:05 -0400
Received: from out0-220.mail.aliyun.com (out0-220.mail.aliyun.com [140.205.0.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83493E47;
        Sun, 25 Jun 2023 05:17:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047190;MF=changxian.cqs@antgroup.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---.TdIoyYs_1687695461;
Received: from localhost(mailfrom:changxian.cqs@antgroup.com fp:SMTPD_---.TdIoyYs_1687695461)
          by smtp.aliyun-inc.com;
          Sun, 25 Jun 2023 20:17:42 +0800
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
Subject: [RFC PATCH 8/8] samples: rust: add a device mapper linear target
Date:   Sun, 25 Jun 2023 20:16:57 +0800
Message-Id: <20230625121657.3631109-9-changxian.cqs@antgroup.com>
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

Add a device mapper linear target sample, based on the
rust device_mapper abstractions.

Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
---
 samples/rust/Kconfig           |  10 ++
 samples/rust/Makefile          |   1 +
 samples/rust/rust_dm_linear.rs | 257 +++++++++++++++++++++++++++++++++
 3 files changed, 268 insertions(+)
 create mode 100644 samples/rust/rust_dm_linear.rs

diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index b0f74a81c8f9..0d532c995f9a 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -30,6 +30,16 @@ config SAMPLE_RUST_PRINT
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_DM_LINEAR
+	tristate "Device mapper linear target"
+	help
+	  This option builds the Rust device mapper linear sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_dm_linear.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_HOSTPROGS
 	bool "Host programs"
 	help
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index 03086dabbea4..cf4bf82312d8 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -2,5 +2,6 @@
 
 obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
 obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
+obj-$(CONFIG_SAMPLE_RUST_DM_LINEAR)		+= rust_dm_linear.o
 
 subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
diff --git a/samples/rust/rust_dm_linear.rs b/samples/rust/rust_dm_linear.rs
new file mode 100644
index 000000000000..1f338e6b227f
--- /dev/null
+++ b/samples/rust/rust_dm_linear.rs
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust device mapper linear target sample.
+//!
+//! C version: drivers/md/dm-linear.c
+
+use core::ops::Range;
+use core::ptr::NonNull;
+use kernel::bindings::PAGE_SECTORS_SHIFT;
+use kernel::device_mapper::*;
+use kernel::prelude::*;
+use kernel::{c_str, fmt, str::CString};
+
+module! {
+    type: RustDmLinear,
+    name: "rust_dm_linear",
+    author: "Rust for Linux Contributors",
+    description: "Rust device mapper linear target sample",
+    license: "GPL",
+}
+
+struct Linear {
+    dev: TargetDevice<Self>,
+    start: usize,
+}
+
+impl Linear {
+    fn new(dev: TargetDevice<Self>, start: usize) -> impl Init<Self> {
+        init!(Self { dev, start })
+    }
+
+    fn map_sector(&self, sector: usize, base: usize) -> usize {
+        sector - base + self.start
+    }
+}
+
+// SAFETY: `Linear` could be used from all threads.
+unsafe impl Sync for Linear {}
+
+#[vtable]
+impl TargetOperations for Linear {
+    type Private = Linear;
+
+    fn ctr(t: &mut Target<Self>, args: Args) -> Result<Box<Linear>> {
+        if args.len() != 2 {
+            t.set_error(c_str!("Invalid argument count"));
+            return Err(EINVAL);
+        }
+
+        let dev = match t.get_device(&args[0]) {
+            Ok(dev) => dev,
+            Err(e) => {
+                t.set_error(c_str!("Device lookup failed"));
+                return Err(e);
+            }
+        };
+
+        let start = &args[1].to_str().map_err(|_| EINVAL)?;
+        let start = usize::from_str_radix(start, 10).map_err(|_| {
+            t.set_error(c_str!("Invalid device sector"));
+            EINVAL
+        })?;
+
+        t.set_num_flush_bios(1);
+        t.set_num_discard_bios(1);
+        t.set_num_secure_erase_bios(1);
+        t.set_num_write_zeroes_bios(1);
+
+        Box::init(Linear::new(dev, start))
+    }
+
+    fn dtr(_: &mut Target<Self>) {}
+
+    fn map(t: &mut Target<Self>, mut bio: Pin<&mut Bio>) -> MapState {
+        let Some(linear) = t.private() else {
+            pr_warn!("Error, found no rust_linear\n");
+            return MapState::Kill;
+        };
+
+        let offset = bio.sector() - linear.dev.target().begin_sector();
+        bio.set_dev(&linear.dev);
+        bio.set_sector(linear.start + offset);
+        MapState::Remapped
+    }
+
+    fn status(t: &mut Target<Self>, type_: StatusType, _: StatusFlags) -> Option<CString> {
+        let Some(linear) = t.private() else {
+            pr_warn!("Error, found no rust_linear\n");
+            return None;
+        };
+
+        match type_ {
+            StatusType::Info => None,
+            StatusType::Table => {
+                CString::try_from_fmt(fmt!("{} {}", linear.dev.device_name(), linear.start)).ok()
+            }
+            StatusType::Ima => {
+                let version = linear.dev.target().version();
+                CString::try_from_fmt(fmt!(
+                    "target_name={},target_version={}.{}.{},device_name={},start={};",
+                    linear.dev.target().name(),
+                    version[0],
+                    version[1],
+                    version[2],
+                    linear.dev.device_name(),
+                    linear.start
+                ))
+                .ok()
+            }
+            _ => {
+                pr_warn!("Unsupported dm_status_type\n");
+                None
+            }
+        }
+    }
+
+    fn prepare_ioctl(t: &mut Target<Self>) -> (i32, Option<NonNull<TargetDevice<Self>>>) {
+        let Some(mut linear) = t.private() else {
+                pr_warn!("Error, found no rust_linear\n");
+                return (EINVAL.to_errno(), None);
+            };
+
+        let mut ret = 0;
+        if linear.start > 0 || linear.dev.target().total_sectors() != linear.dev.device_sectors() {
+            ret = 1;
+        }
+        (ret, Some(linear.dev.as_ptr()))
+    }
+
+    fn iterate_devices(t: &mut Target<Self>) -> Result<Box<dyn Iterator<Item = IterDevice<Self>>>> {
+        let Some(mut linear) = t.private() else {
+            pr_warn!("Error, found no rust_linear\n");
+            return Err(EINVAL);
+        };
+
+        Ok(Box::init(IterLinear::new(
+            linear.dev.as_ptr(),
+            linear.start,
+            t.total_sectors(),
+        ))?)
+    }
+
+    #[cfg(CONFIG_BLK_DEV_ZONED)]
+    fn report_zones(t: &mut Target<Self>, args: &mut [ReportZonesArgs]) -> Result {
+        if args.len() == 0 {
+            pr_warn!("Invalid report_zones_args\n");
+            return Err(EINVAL);
+        }
+
+        let Some(linear) = t.private() else {
+            pr_warn!("Error, found no rust_linear\n");
+            return Err(EINVAL);
+        };
+
+        let sector = linear.map_sector(args[0].next_sector(), linear.dev.target().begin_sector());
+        linear.dev.report_zones(linear.start, sector, args)
+    }
+
+    #[cfg(CONFIG_FS_DAX)]
+    fn direct_access(
+        t: &mut Target<Self>,
+        pgoff: usize,
+        nr_pages: usize,
+        mode: DaxMode,
+    ) -> Result<(usize, Range<usize>)> {
+        let base = t.begin_sector();
+        let Some(mut linear) = t.private() else {
+            pr_warn!("Error, found no rust_linear\n");
+            return Err(EINVAL);
+        };
+
+        let sector = linear.map_sector(pgoff << PAGE_SECTORS_SHIFT, base);
+        let offset = (linear.dev.device_sectors() + sector) >> PAGE_SECTORS_SHIFT;
+        linear.dev.dax_direct_access(offset, nr_pages, mode)
+    }
+
+    #[cfg(CONFIF_FS_DAX)]
+    fn dax_zero_page_range(t: &mut Target<Self>, pgoff: usize, nr_pages: usize) -> Result {
+        let base = t.begin_sector();
+        let Some(mut linear) = t.private() else {
+            pr_warn!("Error, found no rust_linear\n");
+            return Err(EINVAL);
+        };
+
+        let sector = linear.map_sector(pgoff << PAGE_SECTORS_SHIFT, base);
+        let offset = (linear.dev.device_sectors() + sector) >> PAGE_SECTORS_SHIFT;
+        linear.dev.dax_zero_page_range(offset, nr_pages)
+    }
+
+    #[cfg(CONFIF_FS_DAX)]
+    fn dax_recovery_write(
+        t: &mut Target<Self>,
+        iov_iter: Pin<&mut IovIter>,
+        pgoff: usize,
+        region: Range<usize>,
+    ) -> usize {
+        let base = t.begin_sector();
+        let Some(mut linear) = t.private() else {
+            pr_warn!("Error, found no rust_linear\n");
+            return 0;
+        };
+
+        let sector = linear.map_sector(pgoff << PAGE_SECTORS_SHIFT, base);
+        let offset = (linear.dev.device_sectors() + sector) >> PAGE_SECTORS_SHIFT;
+        linear.dev.dax_recovery_write(iov_iter, offset, region)
+    }
+}
+
+struct IterLinear {
+    item: Option<IterDevice<Linear>>,
+}
+
+impl IterLinear {
+    fn new(dev: NonNull<TargetDevice<Linear>>, start: usize, len: usize) -> impl Init<Self> {
+        init!(Self {
+            item: Some((dev, start, len))
+        })
+    }
+}
+
+impl Iterator for IterLinear {
+    type Item = IterDevice<Linear>;
+
+    fn next(&mut self) -> Option<Self::Item> {
+        self.item.take()
+    }
+}
+
+struct RustDmLinear(Pin<Box<TargetType>>);
+
+impl kernel::Module for RustDmLinear {
+    fn init(_module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust device mapper linear target sample (init)\n");
+
+        let target = Box::pin_init(TargetType::register::<Linear>(
+            _module,
+            c_str!("rust_linear"),
+            [0, 0, 1],
+            0,
+        ));
+
+        let target = match target {
+            Ok(target) => target,
+            Err(e) => {
+                pr_warn!("Target register failed, errno: {}\n", e.to_errno());
+                return Err(e);
+            }
+        };
+        Ok(RustDmLinear(target))
+    }
+}
+
+impl Drop for RustDmLinear {
+    fn drop(&mut self) {
+        pr_info!("Rust device mapper linear target sample (exit)\n");
+    }
+}
-- 
2.40.1

