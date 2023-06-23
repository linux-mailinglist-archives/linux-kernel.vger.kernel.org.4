Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F3C73BDE4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjFWRfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjFWRfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:35:21 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46162964;
        Fri, 23 Jun 2023 10:35:12 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9883123260fso96793566b.0;
        Fri, 23 Jun 2023 10:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687541711; x=1690133711;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l2mdnTcfARxptEAZsYOiOXtYWpRMgFe68mLKP2pFSjc=;
        b=mB3M5RPGWfTuJdIz06XHp7ifKX3tjs/cpyyPxmrxWst5xGq7jO6gWTLjkaU6M3Qr5c
         b5WrPx9V1t6S8loihdoY5drv+OYNCMexCwAxWENNi58SoEJcUOzPIegwoBF+FXRhZtj5
         MPxypkwy1OgTIa9wh1Lxt/xJg+Pwtugf1eiayh68iqZswSOwkJIb+vewB5zKQaFJ3Wjn
         bYteTZPBqh7CdHjsJH+9WNFeja6jWzosoEopJSuk/8Vmyyee+qL//TMeJd8moI5I6btF
         jEoaFIQKX81D0Mu3ZcaUIJdf2mqyjf2r3Fa4KaO7NLrXxK8QtzuKoXgBq4mm7WZlnd30
         HcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687541711; x=1690133711;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2mdnTcfARxptEAZsYOiOXtYWpRMgFe68mLKP2pFSjc=;
        b=IwM2Xq2qwslLdsF1OmHnoIxEsJWG/ZCXedbvDZD/YdKezww+MeFSHBSr8zFVT2m7cd
         +K0+tZj/g4F7RfVdPHGMzmyK9bTIE06s2hsGYlMB7OFgYF68JQSMRrSAgAcIeOg66pvQ
         XPQjKbF0X9H6Oz/qvvvlokyoW9YxB+mtRz/fl+ZMii7J4YVCCENk3Lxc6/4WkoblkhR9
         iFD8IrjjP4czRkWA28YGL1d35hveyuMSfLEQf2E2JLkj5kTTuM/Rz6gg6vdiYRYj/+QV
         z9jtHuzyytIFW2HtdqjEPG7K+CaEzt3AftA+794NLXgR8/QN1SKYcB59wr/o039fj18A
         P7YA==
X-Gm-Message-State: AC+VfDxHBuRipSNtSfbDACNve8PtFaCPKeAyh8SWSMuCOgodzhoQosKp
        I7Hs0Lr5ZQT8oyIp4py43nE=
X-Google-Smtp-Source: ACHHUZ4tpHOmjcnG78ldUVZZUaR0kFIiLvlHDIdbH8fFU6ZI3JEILmRXghFVQmevSDB3yxiR3tsOxQ==
X-Received: by 2002:a17:906:ef0b:b0:967:21:5887 with SMTP id f11-20020a170906ef0b00b0096700215887mr18000721ejs.40.1687541710659;
        Fri, 23 Jun 2023 10:35:10 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id f12-20020a17090624cc00b0098d2261d189sm2654529ejb.19.2023.06.23.10.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 10:35:10 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 50DD827C0054;
        Fri, 23 Jun 2023 13:35:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 23 Jun 2023 13:35:08 -0400
X-ME-Sender: <xms:y9eVZP-9HW4SlYeEnUMmZCtfC2uR3LdlS-YUX0JIpgW1vPFXmvn3fg>
    <xme:y9eVZLsbZyz0knGYLft7pap9fhtY-r1opcQrSVcQ65M0BlJtaQrN-sdyWUl0QEDW7
    jUOkt-zY5H3i33CLg>
X-ME-Received: <xmr:y9eVZNAolTyEBby62KJMbpMbEm8SPsYv70hOYRa7EmdMEaq_paX4knNC9FA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeggedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepueho
    qhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpeetueegiefhieeftdfhgeffteejvdejheefueegtdehheduledvueei
    veefveevtdenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhq
    uhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqud
    ejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgv
    rdhnrghmvg
X-ME-Proxy: <xmx:y9eVZLes0BJuV4Lyd8GrVbQ_awhoX0PD-HwVFmHebZ4m2hEpXtKzaQ>
    <xmx:y9eVZEO4_aTVY6uhb6IpWHTwUxYHUa3sXgpjBKyfvu9V3lccLTRKiA>
    <xmx:y9eVZNlCPqzo0X9T1HVnacfqdlGRVMQpemUp__05vKJCrc6mMr9dCw>
    <xmx:y9eVZLcKi7feDYjL4XPvjobB8eaRH7YNh72hVZUQT_AwuKEmFwFbXw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jun 2023 13:35:07 -0400 (EDT)
Date:   Fri, 23 Jun 2023 10:35:00 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     bjorn3_gh@protonmail.com
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: alloc: Add realloc and alloc_zeroed to the
 GlobalAlloc impl
Message-ID: <ZJXXxEfzVza5Jzxj@boqun-archlinux>
References: <20230622-global_alloc_methods-v1-1-3d3561593e23@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230622-global_alloc_methods-v1-1-3d3561593e23@protonmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 09:24:40PM +0200, Björn Roy Baron via B4 Relay wrote:
> From: Björn Roy Baron <bjorn3_gh@protonmail.com>
> 
> While there are default impls for these methods, using the respective C
> api's is faster. Currently neither the existing nor these new
> GlobalAlloc method implementations are actually called. Instead the
> __rust_* function defined below the GlobalAlloc impl are used. With
> rustc 1.71 these functions will be gone and all allocation calls will go
> through the GlobalAlloc implementation.
> 
> Link: https://github.com/Rust-for-Linux/linux/issues/68

Nice! Although I think we need to do the simialr size adjustment as:

	https://lore.kernel.org/rust-for-linux/20230613164258.3831917-1-boqun.feng@gmail.com/

so I applied your patch onto my patch and came up with the following:

--------------------------------->8
diff --git a/rust/kernel/allocator.rs b/rust/kernel/allocator.rs
index ce7a06bf7589..af723c2924dc 100644
--- a/rust/kernel/allocator.rs
+++ b/rust/kernel/allocator.rs
@@ -9,8 +9,17 @@
 
 struct KernelAllocator;
 
-unsafe impl GlobalAlloc for KernelAllocator {
-    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
+impl KernelAllocator {
+    /// # Safety
+    ///
+    /// * `ptr` can be either null or a pointer which has been allocated by this allocator.
+    /// * `layout` must have a non-zero size.
+    unsafe fn krealloc_with_flags(
+        &self,
+        ptr: *mut u8,
+        layout: Layout,
+        flags: bindings::gfp_t,
+    ) -> *mut u8 {
         // Customized layouts from `Layout::from_size_align()` can have size < align, so pads first.
         let layout = layout.pad_to_align();
 
@@ -26,9 +35,22 @@ unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
             size = size.next_power_of_two();
         }
 
-        // `krealloc()` is used instead of `kmalloc()` because the latter is
-        // an inline function and cannot be bound to as a result.
-        unsafe { bindings::krealloc(ptr::null(), size, bindings::GFP_KERNEL) as *mut u8 }
+        // SAFETY:
+        //
+        // * `ptr` is either null or a pointer returned from a previous k{re}alloc() by the function
+        //   safety requirement.
+        //
+        // * `size` is greater than 0 since it's either a `layout.size()` (which cannot be zero
+        //    according to the function safety requirement) or a result from `next_power_of_two()`.
+        unsafe { bindings::krealloc(ptr as *const core::ffi::c_void, size, flags) as *mut u8 }
+    }
+}
+
+unsafe impl GlobalAlloc for KernelAllocator {
+    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
+        // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
+        // requirement.
+        unsafe { self.krealloc_with_flags(ptr::null_mut(), layout, bindings::GFP_KERNEL) }
     }
 
     unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
@@ -37,23 +59,30 @@ unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
         }
     }
 
-    unsafe fn realloc(&self, ptr: *mut u8, _layout: Layout, new_size: usize) -> *mut u8 {
-        unsafe {
-            bindings::krealloc(
-                ptr as *const core::ffi::c_void,
-                new_size,
-                bindings::GFP_KERNEL,
-            ) as *mut u8
-        }
+    unsafe fn realloc(&self, ptr: *mut u8, layout: Layout, new_size: usize) -> *mut u8 {
+        // SAFETY:
+        // * `new_size` when rounded up to the nearest multiple of `layout.align()`, will not
+        //   overflow `isize` by the function safety requirement.
+        // * `layout.align()` is a proper alignment (i.e. not zero and must be a power of two).
+        let layout = unsafe { Layout::from_size_align_unchecked(new_size, layout.align()) };
+
+        // SAFETY:
+        // * `ptr` is either null or a pointer allocated by this allocator by function safety
+        //   requirement.
+        // * the size of `layout` is not zero because `new_size` is not zero by function safety
+        //   requirement.
+        unsafe { self.krealloc_with_flags(ptr, layout, bindings::GFP_KERNEL) }
     }
 
     unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
+        // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
+        // requirement.
         unsafe {
-            bindings::krealloc(
-                core::ptr::null(),
-                layout.size(),
+            self.krealloc_with_flags(
+                ptr::null_mut(),
+                layout,
                 bindings::GFP_KERNEL | bindings::__GFP_ZERO,
-            ) as *mut u8
+            )
         }
     }
 }


Regards,
Boqun

> Signed-off-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
> ---
>  rust/kernel/allocator.rs | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/rust/kernel/allocator.rs b/rust/kernel/allocator.rs
> index 397a3dd57a9b..e0a27b1326b5 100644
> --- a/rust/kernel/allocator.rs
> +++ b/rust/kernel/allocator.rs
> @@ -21,6 +21,26 @@ unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
>              bindings::kfree(ptr as *const core::ffi::c_void);
>          }
>      }
> +
> +    unsafe fn realloc(&self, ptr: *mut u8, _layout: Layout, new_size: usize) -> *mut u8 {
> +        unsafe {
> +            bindings::krealloc(
> +                ptr as *const core::ffi::c_void,
> +                new_size,
> +                bindings::GFP_KERNEL,
> +            ) as *mut u8
> +        }
> +    }
> +
> +    unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
> +        unsafe {
> +            bindings::krealloc(
> +                core::ptr::null(),
> +                layout.size(),
> +                bindings::GFP_KERNEL | bindings::__GFP_ZERO,
> +            ) as *mut u8
> +        }
> +    }
>  }
>  
>  #[global_allocator]
> 
> ---
> base-commit: d2e3115d717197cb2bc020dd1f06b06538474ac3
> change-id: 20230622-global_alloc_methods-abf5b5e38dba
> 
> Best regards,
> -- 
> Björn Roy Baron <bjorn3_gh@protonmail.com>
> 
