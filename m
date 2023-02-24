Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948376A188C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjBXJM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjBXJMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:12:17 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A210965CFD;
        Fri, 24 Feb 2023 01:12:14 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 2D2ED3FA55;
        Fri, 24 Feb 2023 09:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677229933;
        bh=rySOe8C+EOHBcINSIJX8QO1nEpuKvnx7nO+s+ewSOfE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=UQisdBOXr/aBVNREW1ajga0fx1kylmLydkZ1A6SEte7+DuX+CrAhj86MBg8ziguPN
         tlSD413VcSsYZSOzp8cuguz+Q7VF3FJ8Aizf6x+KaegXXEe6CX2M7mZGbBMJPnAZv2
         M1FuONlXRamn5MOLK5/GKKnUUAI7KrYamU1I9knhfTdMjr6HpgvpRvBbcmq1QJ5Qmw
         uscO69ncOFWcw3aBaQa7uc8ma1Kta1viLwIjr7uWrzAT7Tpy38OqM1WXxDVupQctH3
         kG3zAef3n5Lpym14EiG6jhPh2ZlhVPd4+D6Kf5yBEUZYHi6v5o+Xe9GHtwcglvRd7i
         QXioyjHFpZP3g==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 24 Feb 2023 18:11:50 +0900
Subject: [PATCH 4/4] rust: alloc: vec: Add some try_* methods we need
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-vec-v1-4-733b5b5a57c5@asahilina.net>
References: <20230224-rust-vec-v1-0-733b5b5a57c5@asahilina.net>
In-Reply-To: <20230224-rust-vec-v1-0-733b5b5a57c5@asahilina.net>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677229917; l=12257;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=D79jXdo5FTKXLLha+LXra032tDEtF09O0Gra2CyUwtA=;
 b=ESmxTKHa/YudfQcXi8DOpmJs4uMj/rvNEuScGm/xTEWyhQ0wLGK2y+uj+btCcNtUVBCPaSh1Y
 u/gx1Ds7UTZBnoVDTkvg1G0w/0yaf5as1qym/tCZHf4GL56awYC/Z4Z
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

From: Miguel Ojeda <ojeda@kernel.org>

Add some missing fallible methods that we need.

They are all marked as:

    #[stable(feature = "kernel", since = "1.0.0")]

for easy identification.

Lina: Extracted from commit 487d7578bd03 ("rust: alloc: add some `try_*`
methods we need") in rust-for-linux/rust.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/alloc/vec/mod.rs         | 137 +++++++++++++++++++++++++++++++++++++++++-
 rust/alloc/vec/spec_extend.rs |  83 +++++++++++++++++++++++++
 2 files changed, 217 insertions(+), 3 deletions(-)

diff --git a/rust/alloc/vec/mod.rs b/rust/alloc/vec/mod.rs
index f77c7368d534..feb9262b5029 100644
--- a/rust/alloc/vec/mod.rs
+++ b/rust/alloc/vec/mod.rs
@@ -122,10 +122,8 @@ use self::spec_from_elem::SpecFromElem;
 #[cfg(not(no_global_oom_handling))]
 mod spec_from_elem;
 
-#[cfg(not(no_global_oom_handling))]
 use self::set_len_on_drop::SetLenOnDrop;
 
-#[cfg(not(no_global_oom_handling))]
 mod set_len_on_drop;
 
 #[cfg(not(no_global_oom_handling))]
@@ -149,7 +147,8 @@ mod spec_from_iter;
 #[cfg(not(no_global_oom_handling))]
 use self::spec_extend::SpecExtend;
 
-#[cfg(not(no_global_oom_handling))]
+use self::spec_extend::TrySpecExtend;
+
 mod spec_extend;
 
 /// A contiguous growable array type, written as `Vec<T>`, short for 'vector'.
@@ -1919,6 +1918,17 @@ impl<T, A: Allocator> Vec<T, A> {
         self.len += count;
     }
 
+    /// Tries to append elements to `self` from other buffer.
+    #[inline]
+    unsafe fn try_append_elements(&mut self, other: *const [T]) -> Result<(), TryReserveError> {
+        let count = unsafe { (*other).len() };
+        self.try_reserve(count)?;
+        let len = self.len();
+        unsafe { ptr::copy_nonoverlapping(other as *const T, self.as_mut_ptr().add(len), count) };
+        self.len += count;
+        Ok(())
+    }
+
     /// Removes the specified range from the vector in bulk, returning all
     /// removed elements as an iterator. If the iterator is dropped before
     /// being fully consumed, it drops the remaining removed elements.
@@ -2340,6 +2350,45 @@ impl<T: Clone, A: Allocator> Vec<T, A> {
         }
     }
 
+    /// Tries to resize the `Vec` in-place so that `len` is equal to `new_len`.
+    ///
+    /// If `new_len` is greater than `len`, the `Vec` is extended by the
+    /// difference, with each additional slot filled with `value`.
+    /// If `new_len` is less than `len`, the `Vec` is simply truncated.
+    ///
+    /// This method requires `T` to implement [`Clone`],
+    /// in order to be able to clone the passed value.
+    /// If you need more flexibility (or want to rely on [`Default`] instead of
+    /// [`Clone`]), use [`Vec::resize_with`].
+    /// If you only need to resize to a smaller size, use [`Vec::truncate`].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec!["hello"];
+    /// vec.try_resize(3, "world").unwrap();
+    /// assert_eq!(vec, ["hello", "world", "world"]);
+    ///
+    /// let mut vec = vec![1, 2, 3, 4];
+    /// vec.try_resize(2, 0).unwrap();
+    /// assert_eq!(vec, [1, 2]);
+    ///
+    /// let mut vec = vec![42];
+    /// let result = vec.try_resize(usize::MAX, 0);
+    /// assert!(result.is_err());
+    /// ```
+    #[stable(feature = "kernel", since = "1.0.0")]
+    pub fn try_resize(&mut self, new_len: usize, value: T) -> Result<(), TryReserveError> {
+        let len = self.len();
+
+        if new_len > len {
+            self.try_extend_with(new_len - len, ExtendElement(value))
+        } else {
+            self.truncate(new_len);
+            Ok(())
+        }
+    }
+
     /// Clones and appends all elements in a slice to the `Vec`.
     ///
     /// Iterates over the slice `other`, clones each element, and then appends
@@ -2365,6 +2414,30 @@ impl<T: Clone, A: Allocator> Vec<T, A> {
         self.spec_extend(other.iter())
     }
 
+    /// Tries to clone and append all elements in a slice to the `Vec`.
+    ///
+    /// Iterates over the slice `other`, clones each element, and then appends
+    /// it to this `Vec`. The `other` slice is traversed in-order.
+    ///
+    /// Note that this function is same as [`extend`] except that it is
+    /// specialized to work with slices instead. If and when Rust gets
+    /// specialization this function will likely be deprecated (but still
+    /// available).
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![1];
+    /// vec.try_extend_from_slice(&[2, 3, 4]).unwrap();
+    /// assert_eq!(vec, [1, 2, 3, 4]);
+    /// ```
+    ///
+    /// [`extend`]: Vec::extend
+    #[stable(feature = "kernel", since = "1.0.0")]
+    pub fn try_extend_from_slice(&mut self, other: &[T]) -> Result<(), TryReserveError> {
+        self.try_spec_extend(other.iter())
+    }
+
     /// Copies elements from `src` range to the end of the vector.
     ///
     /// # Panics
@@ -2504,6 +2577,36 @@ impl<T, A: Allocator> Vec<T, A> {
             // len set by scope guard
         }
     }
+
+    /// Try to extend the vector by `n` values, using the given generator.
+    fn try_extend_with<E: ExtendWith<T>>(&mut self, n: usize, mut value: E) -> Result<(), TryReserveError> {
+        self.try_reserve(n)?;
+
+        unsafe {
+            let mut ptr = self.as_mut_ptr().add(self.len());
+            // Use SetLenOnDrop to work around bug where compiler
+            // might not realize the store through `ptr` through self.set_len()
+            // don't alias.
+            let mut local_len = SetLenOnDrop::new(&mut self.len);
+
+            // Write all elements except the last one
+            for _ in 1..n {
+                ptr::write(ptr, value.next());
+                ptr = ptr.add(1);
+                // Increment the length in every step in case next() panics
+                local_len.increment_len(1);
+            }
+
+            if n > 0 {
+                // We can write the last element directly without cloning needlessly
+                ptr::write(ptr, value.last());
+                local_len.increment_len(1);
+            }
+
+            // len set by scope guard
+            Ok(())
+        }
+    }
 }
 
 impl<T: PartialEq, A: Allocator> Vec<T, A> {
@@ -2838,6 +2941,34 @@ impl<T, A: Allocator> Vec<T, A> {
         }
     }
 
+    // leaf method to which various SpecFrom/SpecExtend implementations delegate when
+    // they have no further optimizations to apply
+    fn try_extend_desugared<I: Iterator<Item = T>>(&mut self, mut iterator: I) -> Result<(), TryReserveError> {
+        // This is the case for a general iterator.
+        //
+        // This function should be the moral equivalent of:
+        //
+        //      for item in iterator {
+        //          self.push(item);
+        //      }
+        while let Some(element) = iterator.next() {
+            let len = self.len();
+            if len == self.capacity() {
+                let (lower, _) = iterator.size_hint();
+                self.try_reserve(lower.saturating_add(1))?;
+            }
+            unsafe {
+                ptr::write(self.as_mut_ptr().add(len), element);
+                // Since next() executes user code which can panic we have to bump the length
+                // after each step.
+                // NB can't overflow since we would have had to alloc the address space
+                self.set_len(len + 1);
+            }
+        }
+
+        Ok(())
+    }
+
     /// Creates a splicing iterator that replaces the specified range in the vector
     /// with the given `replace_with` iterator and yields the removed items.
     /// `replace_with` does not need to be the same length as `range`.
diff --git a/rust/alloc/vec/spec_extend.rs b/rust/alloc/vec/spec_extend.rs
index ade317ab96b2..94d3722b01a1 100644
--- a/rust/alloc/vec/spec_extend.rs
+++ b/rust/alloc/vec/spec_extend.rs
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: Apache-2.0 OR MIT
 
 use crate::alloc::Allocator;
+use crate::collections::{TryReserveError, TryReserveErrorKind};
 use core::iter::TrustedLen;
 use core::ptr::{self};
 use core::slice::{self};
@@ -8,10 +9,17 @@ use core::slice::{self};
 use super::{IntoIter, SetLenOnDrop, Vec};
 
 // Specialization trait used for Vec::extend
+#[cfg(not(no_global_oom_handling))]
 pub(super) trait SpecExtend<T, I> {
     fn spec_extend(&mut self, iter: I);
 }
 
+// Specialization trait used for Vec::try_extend
+pub(super) trait TrySpecExtend<T, I> {
+    fn try_spec_extend(&mut self, iter: I) -> Result<(), TryReserveError>;
+}
+
+#[cfg(not(no_global_oom_handling))]
 impl<T, I, A: Allocator> SpecExtend<T, I> for Vec<T, A>
 where
     I: Iterator<Item = T>,
@@ -21,6 +29,16 @@ where
     }
 }
 
+impl<T, I, A: Allocator> TrySpecExtend<T, I> for Vec<T, A>
+where
+    I: Iterator<Item = T>,
+{
+    default fn try_spec_extend(&mut self, iter: I) -> Result<(), TryReserveError> {
+        self.try_extend_desugared(iter)
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
 impl<T, I, A: Allocator> SpecExtend<T, I> for Vec<T, A>
 where
     I: TrustedLen<Item = T>,
@@ -59,6 +77,39 @@ where
     }
 }
 
+impl<T, I, A: Allocator> TrySpecExtend<T, I> for Vec<T, A>
+where
+    I: TrustedLen<Item = T>,
+{
+    default fn try_spec_extend(&mut self, iterator: I) -> Result<(), TryReserveError> {
+        // This is the case for a TrustedLen iterator.
+        let (low, high) = iterator.size_hint();
+        if let Some(additional) = high {
+            debug_assert_eq!(
+                low,
+                additional,
+                "TrustedLen iterator's size hint is not exact: {:?}",
+                (low, high)
+            );
+            self.try_reserve(additional)?;
+            unsafe {
+                let mut ptr = self.as_mut_ptr().add(self.len());
+                let mut local_len = SetLenOnDrop::new(&mut self.len);
+                iterator.for_each(move |element| {
+                    ptr::write(ptr, element);
+                    ptr = ptr.offset(1);
+                    // NB can't overflow since we would have had to alloc the address space
+                    local_len.increment_len(1);
+                });
+            }
+            Ok(())
+        } else {
+            Err(TryReserveErrorKind::CapacityOverflow.into())
+        }
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
 impl<T, A: Allocator> SpecExtend<T, IntoIter<T>> for Vec<T, A> {
     fn spec_extend(&mut self, mut iterator: IntoIter<T>) {
         unsafe {
@@ -68,6 +119,17 @@ impl<T, A: Allocator> SpecExtend<T, IntoIter<T>> for Vec<T, A> {
     }
 }
 
+impl<T, A: Allocator> TrySpecExtend<T, IntoIter<T>> for Vec<T, A> {
+    fn try_spec_extend(&mut self, mut iterator: IntoIter<T>) -> Result<(), TryReserveError> {
+        unsafe {
+            self.try_append_elements(iterator.as_slice() as _)?;
+        }
+        iterator.ptr = iterator.end;
+        Ok(())
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
 impl<'a, T: 'a, I, A: Allocator + 'a> SpecExtend<&'a T, I> for Vec<T, A>
 where
     I: Iterator<Item = &'a T>,
@@ -78,6 +140,17 @@ where
     }
 }
 
+impl<'a, T: 'a, I, A: Allocator + 'a> TrySpecExtend<&'a T, I> for Vec<T, A>
+where
+    I: Iterator<Item = &'a T>,
+    T: Clone,
+{
+    default fn try_spec_extend(&mut self, iterator: I) -> Result<(), TryReserveError> {
+        self.try_spec_extend(iterator.cloned())
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
 impl<'a, T: 'a, A: Allocator + 'a> SpecExtend<&'a T, slice::Iter<'a, T>> for Vec<T, A>
 where
     T: Copy,
@@ -87,3 +160,13 @@ where
         unsafe { self.append_elements(slice) };
     }
 }
+
+impl<'a, T: 'a, A: Allocator + 'a> TrySpecExtend<&'a T, slice::Iter<'a, T>> for Vec<T, A>
+where
+    T: Copy,
+{
+    fn try_spec_extend(&mut self, iterator: slice::Iter<'a, T>) -> Result<(), TryReserveError> {
+        let slice = iterator.as_slice();
+        unsafe { self.try_append_elements(slice) }
+    }
+}

-- 
2.35.1

