Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5FD6DA512
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbjDFV5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238829AbjDFV5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:57:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F9FC645;
        Thu,  6 Apr 2023 14:56:34 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2804:14d:72b4:8284:32a8:8167:f815:2895])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dwlsalmeida)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7E52566031E4;
        Thu,  6 Apr 2023 22:56:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680818193;
        bh=hvI9cEvN/Bd2EG3hOaKkNG3kaCy57jal3AVi4mFUeNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RZPw+LBV1EEE8dB1adiU9CT/tWC+3BjjHmueBehDpzQRbv7hsli4pf+dQEFQCermb
         nKXO/i9xky2ccoxsRKtKtXCqWN/nUYKvi4qU1/CpUvHqZcgrX6OlRswI9h1v0JcLvu
         nRKL6rKEg+6SnbDDPzH/T/0h1GFO+LRXHvXXLGE8rlgGBT30Yfusq07k03PptN38rO
         1D36cLL2g4ntrPz58LsCSpUDIrw/R7aUlINCHwq1vijgYbribSwRFvz1WFISE9sZSc
         JVGsuojSbZge2GizIeNIyQQ+lkiY62BNMS/mCz9OAS3nI3qEUgNvtY1LfTq+spNNhE
         U/FLYUh5QKY2g==
From:   Daniel Almeida <daniel.almeida@collabora.com>
To:     wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        hverkuil@xs4all.nl
Cc:     Daniel Almeida <daniel.almeida@collabora.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
Subject: [PATCH 2/6] rust: media: add initial videodev2.h abstractions
Date:   Thu,  6 Apr 2023 18:56:11 -0300
Message-Id: <20230406215615.122099-3-daniel.almeida@collabora.com>
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

Add initial videodev2.h abstractions.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/bindings/bindings_helper.h        |   1 +
 rust/kernel/media/v4l2/capabilities.rs |  80 +++++++++++
 rust/kernel/media/v4l2/enums.rs        | 135 +++++++++++++++++++
 rust/kernel/media/v4l2/format.rs       | 178 +++++++++++++++++++++++++
 rust/kernel/media/v4l2/framesize.rs    | 176 ++++++++++++++++++++++++
 rust/kernel/media/v4l2/inputs.rs       | 104 +++++++++++++++
 rust/kernel/media/v4l2/mmap.rs         |  81 +++++++++++
 rust/kernel/media/v4l2/mod.rs          |   7 +
 8 files changed, 762 insertions(+)
 create mode 100644 rust/kernel/media/v4l2/capabilities.rs
 create mode 100644 rust/kernel/media/v4l2/enums.rs
 create mode 100644 rust/kernel/media/v4l2/format.rs
 create mode 100644 rust/kernel/media/v4l2/framesize.rs
 create mode 100644 rust/kernel/media/v4l2/inputs.rs
 create mode 100644 rust/kernel/media/v4l2/mmap.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 048bae2197ac..3b3d6fcf110f 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -35,6 +35,7 @@
 #include <linux/sysctl.h>
 #include <linux/uaccess.h>
 #include <linux/uio.h>
+#include <linux/videodev2.h>
 
 /* `bindgen` gets confused at certain things. */
 const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
diff --git a/rust/kernel/media/v4l2/capabilities.rs b/rust/kernel/media/v4l2/capabilities.rs
new file mode 100644
index 000000000000..4abc5728f12d
--- /dev/null
+++ b/rust/kernel/media/v4l2/capabilities.rs
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! V4L2 Capabilities
+//!
+//! Part of the following C header: [`include/linux/videodev2.h`](../../../../include/linux/videodev2.h)
+
+/// Capabilities as defined by `V4L2_CAP_*`.
+#[allow(missing_docs)]
+#[derive(Copy, Clone, Debug, PartialEq, PartialOrd)]
+pub enum Capabilities {
+    VideoCapture = bindings::V4L2_CAP_VIDEO_CAPTURE as isize,
+    VideoOutput = bindings::V4L2_CAP_VIDEO_OUTPUT as isize,
+    VideoOverlay = bindings::V4L2_CAP_VIDEO_OVERLAY as isize,
+    VbiCapture = bindings::V4L2_CAP_VBI_CAPTURE as isize,
+    VbiOutput = bindings::V4L2_CAP_VBI_OUTPUT as isize,
+    SlicedVbiCapture = bindings::V4L2_CAP_SLICED_VBI_CAPTURE as isize,
+    SlicedVbiOutput = bindings::V4L2_CAP_SLICED_VBI_OUTPUT as isize,
+    RdsCapture = bindings::V4L2_CAP_RDS_CAPTURE as isize,
+    VideoOutputOverlay = bindings::V4L2_CAP_VIDEO_OUTPUT_OVERLAY as isize,
+    HwFrequencySeek = bindings::V4L2_CAP_HW_FREQ_SEEK as isize,
+    RdsOutput = bindings::V4L2_CAP_RDS_OUTPUT as isize,
+    VideoCaptureMplane = bindings::V4L2_CAP_VIDEO_CAPTURE_MPLANE as isize,
+    VideoOutputMplane = bindings::V4L2_CAP_VIDEO_OUTPUT_MPLANE as isize,
+    M2mMplane = bindings::V4L2_CAP_VIDEO_M2M_MPLANE as isize,
+    M2m = bindings::V4L2_CAP_VIDEO_M2M as isize,
+    Tuner = bindings::V4L2_CAP_TUNER as isize,
+    Audio = bindings::V4L2_CAP_AUDIO as isize,
+    Radio = bindings::V4L2_CAP_RADIO as isize,
+    Modulator = bindings::V4L2_CAP_MODULATOR as isize,
+    SdrCapture = bindings::V4L2_CAP_SDR_CAPTURE as isize,
+    ExtPixFormat = bindings::V4L2_CAP_EXT_PIX_FORMAT as isize,
+    SdrOutput = bindings::V4L2_CAP_SDR_OUTPUT as isize,
+    MetaCapture = bindings::V4L2_CAP_META_CAPTURE as isize,
+    ReadWrite = bindings::V4L2_CAP_READWRITE as isize,
+    Streaming = bindings::V4L2_CAP_STREAMING as isize,
+    MetaOutput = bindings::V4L2_CAP_META_OUTPUT as isize,
+    Touch = bindings::V4L2_CAP_TOUCH as isize,
+    IoMc = bindings::V4L2_CAP_IO_MC as isize,
+}
+
+/// A wrapper over a pointer to `struct v4l2_capability`.
+#[derive(Copy, Clone, Debug, PartialEq, PartialOrd)]
+pub struct CapabilitiesRef(*mut bindings::v4l2_capability);
+
+impl CapabilitiesRef {
+    /// # Safety
+    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
+    /// returned [`CapabilitiesRef`] instance.
+    pub unsafe fn from_ptr(ptr: *mut bindings::v4l2_capability) -> Self {
+        Self(ptr)
+    }
+
+    // For internal convenience only.
+    fn as_mut(&mut self) -> &mut bindings::v4l2_capability {
+        // SAFETY: ptr is safe during the lifetime of [`CapabilitiesRef`] as per
+        // the safety requirement in `from_ptr()`
+        unsafe { self.0.as_mut().unwrap() }
+    }
+
+    /// Sets the `driver` field.
+    pub fn set_driver(&mut self, driver: &[u8]) {
+        let this = self.as_mut();
+        let len = core::cmp::min(driver.len(), this.driver.len());
+        this.driver[0..len].copy_from_slice(&driver[0..len]);
+    }
+
+    /// Sets the `card` field.
+    pub fn set_card(&mut self, card: &[u8]) {
+        let this = self.as_mut();
+        let len = core::cmp::min(card.len(), this.card.len());
+        this.card[0..len].copy_from_slice(&card[0..len]);
+    }
+
+    /// Sets the `bus_info` field.
+    pub fn set_bus_info(&mut self, bus_info: &[u8]) {
+        let this = self.as_mut();
+        let len = core::cmp::min(bus_info.len(), this.bus_info.len());
+        this.bus_info[0..len].copy_from_slice(&bus_info[0..len]);
+    }
+}
diff --git a/rust/kernel/media/v4l2/enums.rs b/rust/kernel/media/v4l2/enums.rs
new file mode 100644
index 000000000000..41397693c208
--- /dev/null
+++ b/rust/kernel/media/v4l2/enums.rs
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! V4L2 Enums
+//!
+//! Part of the following C header: [`include/linux/videodev2.h`](../../../../include/linux/videodev2.h)
+
+use crate::prelude::EINVAL;
+
+/// Buffer types as defined by `V4L2_BUF_TYPE_*`
+#[allow(missing_docs)]
+#[derive(Copy, Clone, Debug, PartialEq, PartialOrd)]
+pub enum BufType {
+    VideoCapture = bindings::v4l2_buf_type_V4L2_BUF_TYPE_VIDEO_CAPTURE as isize,
+    VideoOutput = bindings::v4l2_buf_type_V4L2_BUF_TYPE_VIDEO_OUTPUT as isize,
+    VideoOverlay = bindings::v4l2_buf_type_V4L2_BUF_TYPE_VIDEO_OVERLAY as isize,
+    VbiCapture = bindings::v4l2_buf_type_V4L2_BUF_TYPE_VBI_CAPTURE as isize,
+    VbiOutput = bindings::v4l2_buf_type_V4L2_BUF_TYPE_VBI_OUTPUT as isize,
+    SlicedVbiCapture = bindings::v4l2_buf_type_V4L2_BUF_TYPE_SLICED_VBI_CAPTURE as isize,
+    SlicedVbiOutput = bindings::v4l2_buf_type_V4L2_BUF_TYPE_SLICED_VBI_OUTPUT as isize,
+    VideoOutputOverlay = bindings::v4l2_buf_type_V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY as isize,
+    VideoCaptureMplane = bindings::v4l2_buf_type_V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE as isize,
+    VideoOutputMplane = bindings::v4l2_buf_type_V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE as isize,
+    SdrCapture = bindings::v4l2_buf_type_V4L2_BUF_TYPE_SDR_CAPTURE as isize,
+    SdrOutput = bindings::v4l2_buf_type_V4L2_BUF_TYPE_SDR_OUTPUT as isize,
+    MetaCapture = bindings::v4l2_buf_type_V4L2_BUF_TYPE_META_CAPTURE as isize,
+    MetaOutput = bindings::v4l2_buf_type_V4L2_BUF_TYPE_META_OUTPUT as isize,
+}
+
+impl TryFrom<u32> for BufType {
+    type Error = crate::error::Error;
+
+    fn try_from(value: u32) -> Result<Self, Self::Error> {
+        match value {
+            bindings::v4l2_buf_type_V4L2_BUF_TYPE_VIDEO_CAPTURE => Ok(Self::VideoCapture),
+            bindings::v4l2_buf_type_V4L2_BUF_TYPE_VIDEO_OUTPUT => Ok(Self::VideoOutput),
+            bindings::v4l2_buf_type_V4L2_BUF_TYPE_VIDEO_OVERLAY => Ok(Self::VideoOverlay),
+            bindings::v4l2_buf_type_V4L2_BUF_TYPE_VBI_CAPTURE => Ok(Self::VbiCapture),
+            bindings::v4l2_buf_type_V4L2_BUF_TYPE_VBI_OUTPUT => Ok(Self::VbiOutput),
+            bindings::v4l2_buf_type_V4L2_BUF_TYPE_SLICED_VBI_CAPTURE => Ok(Self::SlicedVbiCapture),
+            bindings::v4l2_buf_type_V4L2_BUF_TYPE_SLICED_VBI_OUTPUT => Ok(Self::SlicedVbiOutput),
+            bindings::v4l2_buf_type_V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY => {
+                Ok(Self::VideoOutputOverlay)
+            }
+            bindings::v4l2_buf_type_V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE => {
+                Ok(Self::VideoCaptureMplane)
+            }
+            bindings::v4l2_buf_type_V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE => {
+                Ok(Self::VideoOutputMplane)
+            }
+            bindings::v4l2_buf_type_V4L2_BUF_TYPE_SDR_CAPTURE => Ok(Self::SdrCapture),
+            bindings::v4l2_buf_type_V4L2_BUF_TYPE_SDR_OUTPUT => Ok(Self::SdrOutput),
+            bindings::v4l2_buf_type_V4L2_BUF_TYPE_META_CAPTURE => Ok(Self::MetaCapture),
+            bindings::v4l2_buf_type_V4L2_BUF_TYPE_META_OUTPUT => Ok(Self::MetaOutput),
+            _ => Err(EINVAL),
+        }
+    }
+}
+
+/// Fields as defined by `V4L2_FIELD_*`
+#[allow(missing_docs)]
+#[derive(Copy, Clone, Debug, PartialEq, PartialOrd)]
+pub enum Field {
+    Any = bindings::v4l2_field_V4L2_FIELD_ANY as isize,
+    None = bindings::v4l2_field_V4L2_FIELD_NONE as isize,
+    Top = bindings::v4l2_field_V4L2_FIELD_TOP as isize,
+    Bottom = bindings::v4l2_field_V4L2_FIELD_BOTTOM as isize,
+    Interlaced = bindings::v4l2_field_V4L2_FIELD_INTERLACED as isize,
+    SeqTb = bindings::v4l2_field_V4L2_FIELD_SEQ_TB as isize,
+    SeqBt = bindings::v4l2_field_V4L2_FIELD_SEQ_BT as isize,
+    Alternate = bindings::v4l2_field_V4L2_FIELD_ALTERNATE as isize,
+    InterlacedTb = bindings::v4l2_field_V4L2_FIELD_INTERLACED_TB as isize,
+    InterlacedBt = bindings::v4l2_field_V4L2_FIELD_INTERLACED_BT as isize,
+}
+
+impl TryFrom<u32> for Field {
+    type Error = crate::error::Error;
+
+    fn try_from(value: u32) -> Result<Self, Self::Error> {
+        match value {
+            bindings::v4l2_field_V4L2_FIELD_ANY => Ok(Self::Any),
+            bindings::v4l2_field_V4L2_FIELD_NONE => Ok(Self::None),
+            bindings::v4l2_field_V4L2_FIELD_TOP => Ok(Self::Top),
+            bindings::v4l2_field_V4L2_FIELD_BOTTOM => Ok(Self::Bottom),
+            bindings::v4l2_field_V4L2_FIELD_INTERLACED => Ok(Self::Interlaced),
+            bindings::v4l2_field_V4L2_FIELD_SEQ_TB => Ok(Self::SeqTb),
+            bindings::v4l2_field_V4L2_FIELD_SEQ_BT => Ok(Self::SeqBt),
+            bindings::v4l2_field_V4L2_FIELD_ALTERNATE => Ok(Self::Alternate),
+            bindings::v4l2_field_V4L2_FIELD_INTERLACED_TB => Ok(Self::InterlacedTb),
+            bindings::v4l2_field_V4L2_FIELD_INTERLACED_BT => Ok(Self::InterlacedBt),
+            _ => Err(EINVAL),
+        }
+    }
+}
+
+/// Colorspaces as defined by `V4L2_COLORSPACE_*`
+#[allow(missing_docs)]
+#[derive(Copy, Clone, Debug, PartialEq, PartialOrd)]
+pub enum Colorspace {
+    Default = bindings::v4l2_colorspace_V4L2_COLORSPACE_DEFAULT as isize,
+    Smpte170m = bindings::v4l2_colorspace_V4L2_COLORSPACE_SMPTE170M as isize,
+    Smpte240m = bindings::v4l2_colorspace_V4L2_COLORSPACE_SMPTE240M as isize,
+    Rec709 = bindings::v4l2_colorspace_V4L2_COLORSPACE_REC709 as isize,
+    Bt878 = bindings::v4l2_colorspace_V4L2_COLORSPACE_BT878 as isize,
+    SystemM470 = bindings::v4l2_colorspace_V4L2_COLORSPACE_470_SYSTEM_M as isize,
+    SystemBg470 = bindings::v4l2_colorspace_V4L2_COLORSPACE_470_SYSTEM_BG as isize,
+    Jpeg = bindings::v4l2_colorspace_V4L2_COLORSPACE_JPEG as isize,
+    Srgb = bindings::v4l2_colorspace_V4L2_COLORSPACE_SRGB as isize,
+    Oprgb = bindings::v4l2_colorspace_V4L2_COLORSPACE_OPRGB as isize,
+    Bt2020 = bindings::v4l2_colorspace_V4L2_COLORSPACE_BT2020 as isize,
+    Raw = bindings::v4l2_colorspace_V4L2_COLORSPACE_RAW as isize,
+    DciP3 = bindings::v4l2_colorspace_V4L2_COLORSPACE_DCI_P3 as isize,
+}
+
+impl TryFrom<u32> for Colorspace {
+    type Error = crate::error::Error;
+
+    fn try_from(value: u32) -> Result<Self, Self::Error> {
+        match value {
+            bindings::v4l2_colorspace_V4L2_COLORSPACE_DEFAULT => Ok(Self::Default),
+            bindings::v4l2_colorspace_V4L2_COLORSPACE_SMPTE170M => Ok(Self::Smpte170m),
+            bindings::v4l2_colorspace_V4L2_COLORSPACE_SMPTE240M => Ok(Self::Smpte240m),
+            bindings::v4l2_colorspace_V4L2_COLORSPACE_REC709 => Ok(Self::Rec709),
+            bindings::v4l2_colorspace_V4L2_COLORSPACE_BT878 => Ok(Self::Bt878),
+            bindings::v4l2_colorspace_V4L2_COLORSPACE_470_SYSTEM_M => Ok(Self::SystemM470),
+            bindings::v4l2_colorspace_V4L2_COLORSPACE_470_SYSTEM_BG => Ok(Self::SystemBg470),
+            bindings::v4l2_colorspace_V4L2_COLORSPACE_JPEG => Ok(Self::Jpeg),
+            bindings::v4l2_colorspace_V4L2_COLORSPACE_SRGB => Ok(Self::Srgb),
+            bindings::v4l2_colorspace_V4L2_COLORSPACE_OPRGB => Ok(Self::Oprgb),
+            bindings::v4l2_colorspace_V4L2_COLORSPACE_BT2020 => Ok(Self::Bt2020),
+            bindings::v4l2_colorspace_V4L2_COLORSPACE_RAW => Ok(Self::Raw),
+            bindings::v4l2_colorspace_V4L2_COLORSPACE_DCI_P3 => Ok(Self::DciP3),
+            _ => Err(EINVAL),
+        }
+    }
+}
diff --git a/rust/kernel/media/v4l2/format.rs b/rust/kernel/media/v4l2/format.rs
new file mode 100644
index 000000000000..83bdd61b5c09
--- /dev/null
+++ b/rust/kernel/media/v4l2/format.rs
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! V4L2 Format Enumerations
+//!
+//! Part of the following C header: [`include/linux/videodev2.h`](../../../../include/linux/videodev2.h)
+
+use crate::media::v4l2::enums;
+use crate::prelude::*;
+
+/// A wrapper over a pointer to `struct v4l2_fmtdesc`.
+#[derive(Copy, Clone, Debug, PartialEq, PartialOrd)]
+pub struct FormatDescRef(*mut bindings::v4l2_fmtdesc);
+
+impl FormatDescRef {
+    /// # Safety
+    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
+    /// returned [`FormatDescRef`] instance.
+    pub unsafe fn from_ptr(ptr: *mut bindings::v4l2_fmtdesc) -> Self {
+        Self(ptr)
+    }
+
+    fn as_mut(&mut self) -> &mut bindings::v4l2_fmtdesc {
+        // SAFETY: ptr is safe during the lifetime of [`FormatDescRef`] as per
+        // the safety requirement in `from_ptr()`
+        unsafe { self.0.as_mut().unwrap() }
+    }
+
+    fn as_ref(&self) -> &bindings::v4l2_fmtdesc {
+        // SAFETY: ptr is safe during the lifetime of [`FormatDescRef`] as per
+        // the safety requirement in `from_ptr()`
+        unsafe { self.0.as_mut().unwrap() }
+    }
+
+    /// Sets the `pixelformat` field.
+    pub fn set_pixel_format(&mut self, pixel_format: u32) {
+        let fmt = self.as_mut();
+        fmt.pixelformat = pixel_format;
+    }
+
+    /// Returns the `index` field.
+    pub fn index(&self) -> u32 {
+        self.as_ref().index
+    }
+
+    /// Returns the `type_` field.
+    pub fn type_(&self) -> u32 {
+        self.as_ref().type_
+    }
+}
+
+/// A wrapper over a pointer to `struct v4l2_format`.
+#[derive(Copy, Clone, Debug, PartialEq, PartialOrd)]
+pub struct FormatRef(*mut bindings::v4l2_format);
+
+impl FormatRef {
+    /// # Safety
+    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
+    /// returned [`FormatRef`] instance.
+    pub unsafe fn from_ptr(ptr: *mut bindings::v4l2_format) -> Self {
+        Self(ptr)
+    }
+
+    // For internal convenience only.
+    fn as_mut(&mut self) -> &mut bindings::v4l2_format {
+        // SAFETY: ptr is safe during the lifetime of [`FormatDescRef`] as per
+        // the safety requirement in `from_ptr()`
+        unsafe { self.0.as_mut().unwrap() }
+    }
+
+    fn as_ref(&self) -> &bindings::v4l2_format {
+        // SAFETY: ptr is safe during the lifetime of [`FormatDescRef`] as per
+        // the safety requirement in `from_ptr()`
+        unsafe { self.0.as_mut().unwrap() }
+    }
+
+    /// Returns the `type_` field.
+    pub fn type_(&self) -> u32 {
+        self.as_ref().type_
+    }
+
+    /// Get the field `field` for the `pix` union member.
+    pub fn pix_field(&self) -> Result<enums::Field> {
+        let fmt = self.as_ref();
+        let pix = &unsafe { fmt.fmt.pix };
+        enums::Field::try_from(pix.field)
+    }
+
+    /// Get the field `width` for the `pix` union member.
+    pub fn pix_width(&self) -> u32 {
+        let fmt = self.as_ref();
+        let pix = &unsafe { fmt.fmt.pix };
+        pix.width
+    }
+
+    /// Get the field `height` for the `pix` union member.
+    pub fn pix_height(&self) -> u32 {
+        let fmt = self.as_ref();
+        let pix = &unsafe { fmt.fmt.pix };
+        pix.height
+    }
+
+    /// Get the field `pixelformat` for the `pix` union member.
+    pub fn pix_pixelformat(&self) -> u32 {
+        let fmt = self.as_ref();
+        let pix = &unsafe { fmt.fmt.pix };
+        pix.pixelformat
+    }
+
+    /// Get the field `bytesperline` for the `pix` union member.
+    pub fn pix_bytesperline(&self) -> u32 {
+        let fmt = self.as_ref();
+        let pix = &unsafe { fmt.fmt.pix };
+        pix.bytesperline
+    }
+
+    /// Get the field `sizeimage` for the `pix` union member.
+    pub fn pix_sizeimage(&self) -> u32 {
+        let fmt = self.as_ref();
+        let pix = &unsafe { fmt.fmt.pix };
+        pix.sizeimage
+    }
+
+    /// Get the field `colorspace` for the `pix` union member.
+    pub fn pix_colorspace(&self) -> Result<enums::Colorspace> {
+        let fmt = self.as_ref();
+        let pix = &unsafe { fmt.fmt.pix };
+        enums::Colorspace::try_from(pix.colorspace)
+    }
+
+    /// Set the field `field` for the `pix` union member.
+    pub fn set_pix_field(&mut self, field: enums::Field) {
+        let fmt = self.as_mut();
+        let pix = &mut unsafe { fmt.fmt.pix };
+        pix.field = field as u32;
+    }
+
+    /// Set the field `width` for the `pix` union member.
+    pub fn set_pix_width(&mut self, width: u32) {
+        let fmt = self.as_mut();
+        let pix = &mut unsafe { fmt.fmt.pix };
+        pix.width = width;
+    }
+
+    /// Set the field `height` for the `pix` union member.
+    pub fn set_pix_height(&mut self, height: u32) {
+        let fmt = self.as_mut();
+        let pix = &mut unsafe { fmt.fmt.pix };
+        pix.height = height;
+    }
+
+    /// Set the field `pixelformat` for the `pix` union member.
+    pub fn set_pix_pixel_format(&mut self, pixel_format: u32) {
+        let fmt = self.as_mut();
+        let pix = &mut unsafe { fmt.fmt.pix };
+        pix.pixelformat = pixel_format;
+    }
+
+    /// Set the field `bytesperline` for the `pix` union member.
+    pub fn set_pix_bytesperline(&mut self, bytesperline: u32) {
+        let fmt = self.as_mut();
+        let pix = &mut unsafe { fmt.fmt.pix };
+        pix.bytesperline = bytesperline;
+    }
+
+    /// Set the field `sizeimage` for the `pix` union member.
+    pub fn set_pix_sizeimage(&mut self, sizeimage: u32) {
+        let fmt = self.as_mut();
+        let pix = &mut unsafe { fmt.fmt.pix };
+        pix.sizeimage = sizeimage;
+    }
+
+    /// Set the field `sizeimage` for the `pix` union member.
+    pub fn set_pix_colorspace(&mut self, colorspace: enums::Colorspace) {
+        let fmt = self.as_mut();
+        let pix = &mut unsafe { fmt.fmt.pix };
+        pix.colorspace = colorspace as u32;
+    }
+}
diff --git a/rust/kernel/media/v4l2/framesize.rs b/rust/kernel/media/v4l2/framesize.rs
new file mode 100644
index 000000000000..2d015a7444be
--- /dev/null
+++ b/rust/kernel/media/v4l2/framesize.rs
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! V4L2 Frame size enumerations
+//!
+//! Part of the following C header: [`include/linux/videodev2.h`](../../../../include/linux/videodev2.h)
+
+/// Frame size types as defined in `V4L2_FRMSIZE_TYPE`
+#[derive(Copy, Clone, Debug, PartialEq, PartialOrd)]
+#[allow(missing_docs)]
+pub enum FrameSizeType {
+    Discrete = bindings::v4l2_frmsizetypes_V4L2_FRMSIZE_TYPE_DISCRETE as isize,
+    Continuous = bindings::v4l2_frmsizetypes_V4L2_FRMSIZE_TYPE_CONTINUOUS as isize,
+    Stepwise = bindings::v4l2_frmsizetypes_V4L2_FRMSIZE_TYPE_STEPWISE as isize,
+}
+
+impl TryFrom<u32> for FrameSizeType {
+    type Error = crate::error::Error;
+
+    fn try_from(value: u32) -> Result<Self, Self::Error> {
+        match value {
+            bindings::v4l2_frmsizetypes_V4L2_FRMSIZE_TYPE_DISCRETE => Ok(Self::Discrete),
+            bindings::v4l2_frmsizetypes_V4L2_FRMSIZE_TYPE_CONTINUOUS => Ok(Self::Continuous),
+            bindings::v4l2_frmsizetypes_V4L2_FRMSIZE_TYPE_STEPWISE => Ok(Self::Stepwise),
+            _ => Err(crate::prelude::EINVAL),
+        }
+    }
+}
+
+/// A wrapper over a pointer to `struct v4l2_frmsizeenum`.
+#[derive(Copy, Clone, Debug, PartialEq, PartialOrd)]
+pub struct FrameSizeRef(*mut bindings::v4l2_frmsizeenum);
+
+impl FrameSizeRef {
+    /// # Safety
+    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
+    /// returned [`FrameSizeRef`] instance.
+    pub unsafe fn from_ptr(ptr: *mut bindings::v4l2_frmsizeenum) -> Self {
+        Self(ptr)
+    }
+
+    fn as_ref(&self) -> &bindings::v4l2_frmsizeenum {
+        // SAFETY: ptr is safe during the lifetime of [`FrameSizeRef`] as per
+        // the safety requirement in `from_ptr()`
+        unsafe { self.0.as_ref().unwrap() }
+    }
+
+    fn as_mut(&mut self) -> &mut bindings::v4l2_frmsizeenum {
+        // SAFETY: ptr is safe during the lifetime of [`FrameSizeRef`] as per
+        // the safety requirement in `from_ptr()`
+        unsafe { self.0.as_mut().unwrap() }
+    }
+
+    /// Sets the `index` member.
+    pub fn set_index(&mut self, index: u32) {
+        let this = self.as_mut();
+        this.index = index;
+    }
+
+    /// Sets the `pixel_format` member.
+    pub fn set_pixel_format(&mut self, pixel_format: u32) {
+        let this = self.as_mut();
+        this.pixel_format = pixel_format;
+    }
+
+    /// Sets the `type_` member.
+    pub fn set_type(&mut self, type_: FrameSizeType) {
+        let this = self.as_mut();
+        this.type_ = type_ as _;
+    }
+
+    /// Sets the `width` member from the `discrete` union member.
+    pub fn set_discrete_width(&mut self, width: u32) {
+        let this = self.as_mut();
+        this.__bindgen_anon_1.discrete.width = width;
+    }
+
+    /// Sets the `height` member from the `discrete` union member.
+    pub fn set_discrete_height(&mut self, height: u32) {
+        let this = self.as_mut();
+        this.__bindgen_anon_1.discrete.height = height;
+    }
+
+    /// Sets the `min_width` member from the `step_wise` union member.
+    pub fn set_stepwise_min_width(&mut self, min_width: u32) {
+        let this = self.as_mut();
+        this.__bindgen_anon_1.stepwise.min_width = min_width;
+    }
+
+    /// Sets the `max_width` member from the `step_wise` union member.
+    pub fn set_stepwise_max_width(&mut self, max_width: u32) {
+        let this = self.as_mut();
+        this.__bindgen_anon_1.stepwise.max_width = max_width;
+    }
+
+    /// Sets the `step_width` member from the `step_wise` union member.
+    pub fn set_stepwise_step_width(&mut self, step_width: u32) {
+        let this = self.as_mut();
+        this.__bindgen_anon_1.stepwise.step_width = step_width;
+    }
+
+    /// Sets the `min_height` member from the `step_wise` union member.
+    pub fn set_stepwise_min_height(&mut self, min_height: u32) {
+        let this = self.as_mut();
+        this.__bindgen_anon_1.stepwise.min_height = min_height;
+    }
+
+    /// Sets the `max_height` member from the `step_wise` union member.
+    pub fn set_stepwise_max_height(&mut self, max_height: u32) {
+        let this = self.as_mut();
+        this.__bindgen_anon_1.stepwise.max_height = max_height;
+    }
+
+    /// Sets the `step_height` member from the `step_wise` union member.
+    pub fn set_stepwise_step_height(&mut self, step_height: u32) {
+        let this = self.as_mut();
+        this.__bindgen_anon_1.stepwise.step_height = step_height;
+    }
+
+    /// Returns the `index` member.
+    pub fn index(&self) -> u32 {
+        self.as_ref().index
+    }
+
+    /// Returns the `pixel_format` member.
+    pub fn pixel_format(&self) -> u32 {
+        self.as_ref().pixel_format
+    }
+
+    /// Returns the `width` member from the `discrete` union member.
+    pub fn discrete_width(&self) -> u32 {
+        let this = self.as_ref();
+        unsafe { this.__bindgen_anon_1.discrete.width }
+    }
+
+    /// Returns the `height` member from the `discrete` union member.
+    pub fn discrete_height(&self) -> u32 {
+        let this = self.as_ref();
+        unsafe { this.__bindgen_anon_1.discrete.height }
+    }
+
+    /// Returns the `min_width` member from the `step_wise` union member.
+    pub fn stepwise_min_width(&self) -> u32 {
+        let this = self.as_ref();
+        unsafe { this.__bindgen_anon_1.stepwise.min_width }
+    }
+
+    /// Returns the `max_width` member from the `step_wise` union member.
+    pub fn stepwise_max_width(&self) -> u32 {
+        let this = self.as_ref();
+        unsafe { this.__bindgen_anon_1.stepwise.max_width }
+    }
+
+    /// Returns the `step_width` member from the `step_wise` union member.
+    pub fn stepwise_step_width(&self) -> u32 {
+        let this = self.as_ref();
+        unsafe { this.__bindgen_anon_1.stepwise.step_width }
+    }
+
+    /// Returns the `min_height` member from the `step_wise` union member.
+    pub fn stepwise_min_height(&self) -> u32 {
+        let this = self.as_ref();
+        unsafe { this.__bindgen_anon_1.stepwise.min_height }
+    }
+
+    /// Returns the `max_height` member from the `step_wise` union member.
+    pub fn stepwise_max_height(&self) -> u32 {
+        let this = self.as_ref();
+        unsafe { this.__bindgen_anon_1.stepwise.max_height }
+    }
+
+    /// Returns the `step_height` member from the `step_wise` union member.
+    pub fn stepwise_step_height(&self) -> u32 {
+        let this = self.as_ref();
+        unsafe { this.__bindgen_anon_1.stepwise.step_height }
+    }
+}
diff --git a/rust/kernel/media/v4l2/inputs.rs b/rust/kernel/media/v4l2/inputs.rs
new file mode 100644
index 000000000000..8361971e2983
--- /dev/null
+++ b/rust/kernel/media/v4l2/inputs.rs
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! V4L2 Video Inputs
+//!
+//! Part of the following C header: [`include/linux/videodev2.h`](../../../../include/linux/videodev2.h)
+
+use crate::prelude::*;
+use crate::str::CStr;
+
+/// A wrapper over a pointer to `struct v4l2_input`.
+#[derive(Copy, Clone, Debug, PartialEq, PartialOrd)]
+pub struct InputRef(*mut bindings::v4l2_input);
+
+impl InputRef {
+    /// # Safety
+    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
+    /// returned [`InputRef`] instance.
+    pub unsafe fn from_ptr(ptr: *mut bindings::v4l2_input) -> Self {
+        Self(ptr)
+    }
+
+    fn as_mut(&mut self) -> &mut bindings::v4l2_input {
+        // SAFETY: ptr is safe during the lifetime of [`InputRef`] as per
+        // the safety requirement in `from_ptr()`
+        unsafe { self.0.as_mut().unwrap() }
+    }
+
+    fn as_ref(&self) -> &bindings::v4l2_input {
+        // SAFETY: ptr is safe during the lifetime of [`InputRef`] as per
+        // the safety requirement in `from_ptr()`
+        unsafe { self.0.as_ref().unwrap() }
+    }
+
+    /// Returns the `index` member.
+    pub fn index(&self) -> u32 {
+        let this = self.as_ref();
+        this.index
+    }
+
+    /// Returns the `name` member.
+    pub fn name(&self) -> core::result::Result<&CStr, crate::str::CStrConvertError> {
+        let this = self.as_ref();
+        CStr::from_bytes_with_nul(&this.name)
+    }
+
+    /// Returns the `type_` member.
+    pub fn type_(&self) -> Result<Type> {
+        let this = self.as_ref();
+        Type::try_from(this.type_)
+    }
+
+    /// Returns the `status` member.
+    pub fn status(&self) -> u32 {
+        let this = self.as_ref();
+        this.status
+    }
+
+    /// Sets the `name` member.
+    pub fn set_name(&mut self, name: &CStr) {
+        let this = self.as_mut();
+        let len = core::cmp::min(name.len(), this.name.len());
+        this.name[0..len].copy_from_slice(&name[0..len]);
+    }
+
+    /// Sets the `type_` member.
+    pub fn set_type(&mut self, type_: Type) {
+        let this = self.as_mut();
+        this.type_ = type_ as u32;
+    }
+
+    /// Sets the `std` member.
+    pub fn set_std(&mut self, std: u64) {
+        let this = self.as_mut();
+        this.std = std;
+    }
+
+    /// Sets the `status` member.
+    pub fn set_status(&mut self, status: u32) {
+        let this = self.as_mut();
+        this.status = status;
+    }
+}
+
+/// Input types as defined by `V4L2_INPUT_TYPE_*`
+#[allow(missing_docs)]
+#[derive(Copy, Clone, Debug, PartialEq, PartialOrd)]
+pub enum Type {
+    Tuner = bindings::V4L2_INPUT_TYPE_TUNER as isize,
+    Camera = bindings::V4L2_INPUT_TYPE_CAMERA as isize,
+    Touch = bindings::V4L2_INPUT_TYPE_TOUCH as isize,
+}
+
+impl TryFrom<u32> for Type {
+    type Error = crate::error::Error;
+
+    fn try_from(value: u32) -> Result<Self> {
+        match value {
+            bindings::V4L2_INPUT_TYPE_TUNER => Ok(Self::Tuner),
+            bindings::V4L2_INPUT_TYPE_CAMERA => Ok(Self::Camera),
+            bindings::V4L2_INPUT_TYPE_TOUCH => Ok(Self::Touch),
+            _ => Err(EINVAL),
+        }
+    }
+}
diff --git a/rust/kernel/media/v4l2/mmap.rs b/rust/kernel/media/v4l2/mmap.rs
new file mode 100644
index 000000000000..2d9ce2ceb148
--- /dev/null
+++ b/rust/kernel/media/v4l2/mmap.rs
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! V4L2 Memory-mapping buffers
+//!
+//! Part of the following C header: [`include/linux/videodev2.h`](../../../../include/linux/videodev2.h)
+
+/// Buffer flags as defined by `V4L2_BUF_FLAG_*`.
+#[allow(missing_docs)]
+#[derive(Copy, Clone, Debug, PartialEq, PartialOrd)]
+pub enum BufferFlag {
+    Mapped = bindings::V4L2_BUF_FLAG_MAPPED as isize,
+    Queued = bindings::V4L2_BUF_FLAG_QUEUED as isize,
+    Done = bindings::V4L2_BUF_FLAG_DONE as isize,
+    Keyframe = bindings::V4L2_BUF_FLAG_KEYFRAME as isize,
+    Pframe = bindings::V4L2_BUF_FLAG_PFRAME as isize,
+    Bframe = bindings::V4L2_BUF_FLAG_BFRAME as isize,
+    Error = bindings::V4L2_BUF_FLAG_ERROR as isize,
+    InRequest = bindings::V4L2_BUF_FLAG_IN_REQUEST as isize,
+    Timecode = bindings::V4L2_BUF_FLAG_TIMECODE as isize,
+    HoldCaptureBuf = bindings::V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF as isize,
+    Prepared = bindings::V4L2_BUF_FLAG_PREPARED as isize,
+    NoCacheInvalidate = bindings::V4L2_BUF_FLAG_NO_CACHE_INVALIDATE as isize,
+    NoCacheClean = bindings::V4L2_BUF_FLAG_NO_CACHE_CLEAN as isize,
+    TimestampMonotonic = bindings::V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC as isize,
+    TimestampCopy = bindings::V4L2_BUF_FLAG_TIMESTAMP_COPY as isize,
+    TstampSrcSoe = bindings::V4L2_BUF_FLAG_TSTAMP_SRC_SOE as isize,
+    Last = bindings::V4L2_BUF_FLAG_LAST as isize,
+    RequestFd = bindings::V4L2_BUF_FLAG_REQUEST_FD as isize,
+}
+
+/// A wrapper over a pointer to `struct v4l2_exportbuffer`.
+#[derive(Copy, Clone, Debug, PartialEq, PartialOrd)]
+pub struct ExportBufferRef(*mut bindings::v4l2_exportbuffer);
+
+impl ExportBufferRef {
+    /// # Safety
+    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
+    /// returned [`ExportBufferRef`] instance.
+    pub unsafe fn from_ptr(ptr: *mut bindings::v4l2_exportbuffer) -> Self {
+        Self(ptr)
+    }
+}
+
+/// A wrapper over a pointer to `struct v4l2_requestbuffers`.
+#[derive(Copy, Clone, Debug, PartialEq, PartialOrd)]
+pub struct RequestBuffersRef(*mut bindings::v4l2_requestbuffers);
+
+impl RequestBuffersRef {
+    /// # Safety
+    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
+    /// returned [`RequestBuffersRef`] instance.
+    pub unsafe fn from_ptr(ptr: *mut bindings::v4l2_requestbuffers) -> Self {
+        Self(ptr)
+    }
+}
+
+/// A wrapper over a pointer to `struct v4l2_create_buffers`.
+#[derive(Copy, Clone, Debug, PartialEq, PartialOrd)]
+pub struct CreateBuffersRef(*mut bindings::v4l2_create_buffers);
+
+impl CreateBuffersRef {
+    /// # Safety
+    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
+    /// returned [`CreateBuffersRef`] instance.
+    pub unsafe fn from_ptr(ptr: *mut bindings::v4l2_create_buffers) -> Self {
+        Self(ptr)
+    }
+}
+
+/// A wrapper over a pointer to `struct v4l2_buffer`.
+#[derive(Copy, Clone, Debug, PartialEq, PartialOrd)]
+pub struct BufferRef(*mut bindings::v4l2_buffer);
+
+impl BufferRef {
+    /// # Safety
+    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
+    /// returned [`BufferRef`] instance.
+    pub unsafe fn from_ptr(ptr: *mut bindings::v4l2_buffer) -> Self {
+        Self(ptr)
+    }
+}
diff --git a/rust/kernel/media/v4l2/mod.rs b/rust/kernel/media/v4l2/mod.rs
index 068dd9b4863d..77864640f19e 100644
--- a/rust/kernel/media/v4l2/mod.rs
+++ b/rust/kernel/media/v4l2/mod.rs
@@ -1,3 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0 OR MIT
 
 //! Abstractions for include/media/v4l2-*.h
+
+pub mod capabilities;
+pub mod enums;
+pub mod format;
+pub mod framesize;
+pub mod inputs;
+pub mod mmap;
-- 
2.40.0

