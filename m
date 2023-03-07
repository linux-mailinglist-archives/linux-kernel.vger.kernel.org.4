Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EB26ADBCC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjCGKZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCGKZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:25:27 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA6C5290F;
        Tue,  7 Mar 2023 02:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678184721; x=1709720721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XVOGB1MKbCD9q0kwWf3Y939WJhlxGIP60HVW5R87Egg=;
  b=sVib/3ghsWOA/pyidmygcrT9U9ZQY7TuBI6NgDpH1qjN88FVgGR3Ewlm
   lqoyyWcUdhorxRNKupldnC6Ut2MDuYEgYWqy3Seb+AkzOnl/XG3rgJyF6
   3+MqCn7RYB3BNhq4hs60oqI5/U66SSea57VqAFeHfxonWvIsOO3KH0LMI
   G4GtKROBOIBl/aee7tvvY8eMZNmqPVL7UFmP6WcPX0v2F+1wycrj94CMa
   WqHfSJVyvSYTpCkjyQgh0AP9f/y9OTICZuP7l/xbVbbTkFxwh0lz3Sw8x
   hPJdt8Hz4JEYP5xxJEwkPPn1e6dy6M90Q+oDHmVhvofT9xjgT/VVO5AkX
   g==;
X-IronPort-AV: E=Sophos;i="5.98,240,1673938800"; 
   d="scan'208";a="140694259"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2023 03:25:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Mar 2023 03:25:19 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.16 via Frontend
 Transport; Tue, 7 Mar 2023 03:25:16 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <linux-riscv@lists.infradead.org>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, <rust-for-linux@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>
Subject: [PATCH v1 1/2] scripts: generate_rust_target: enable building on RISC-V
Date:   Tue, 7 Mar 2023 10:24:40 +0000
Message-ID: <20230307102441.94417-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307102441.94417-1-conor.dooley@microchip.com>
References: <20230307102441.94417-1-conor.dooley@microchip.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1821; i=conor.dooley@microchip.com; h=from:subject; bh=pr00Ws4xP6t9YpK/ZLk9y5gdrCaL6G8nYnSeAmZhBfg=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCnsAs9qpdez1rj9zF+iHerL/93bMvKB8jeJviVJhybu/Gd6 68z8jlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEzEZyUjw2KV9qAllV8z2ve1q2iqfm rlu9qzNcK9bYd+ztKJZU6ZjQz/ayUOsLFt2TB1drtIkkjf9F3xt/UNFiqeuT6LKXBXxOtGTgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miguel Ojeda <ojeda@kernel.org>

Add the required bits from rust-for-linux to enable generating a RISC-V
target for rust. The script, written by Miguel, was originally a
config file contributed by Gary.

Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Despite removing 32-bit support, I kept the structure of the if
statement, despite early return being stylistically preferred, for
alignment with the Rust-for-Linux tree. I'm happy to respin to sort that
out of desired.
---
 scripts/generate_rust_target.rs | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_target.rs
index 3c6cbe2b278d3..85d690f764389 100644
--- a/scripts/generate_rust_target.rs
+++ b/scripts/generate_rust_target.rs
@@ -161,6 +161,22 @@ fn main() {
         ts.push("features", features);
         ts.push("llvm-target", "x86_64-linux-gnu");
         ts.push("target-pointer-width", "64");
+    } else if cfg.has("RISCV") {
+        if cfg.has("64BIT") {
+            ts.push("arch", "riscv64");
+            ts.push("data-layout", "e-m:e-p:64:64-i64:64-i128:128-n64-S128");
+            ts.push("llvm-target", "riscv64-linux-gnu");
+            ts.push("target-pointer-width", "64");
+        } else {
+            panic!("32-bit RISC-V is an unsupported architecture")
+        }
+        ts.push("code-model", "medium");
+        ts.push("disable-redzone", true);
+        let mut features = "+m,+a".to_string();
+        if cfg.has("RISCV_ISA_C") {
+            features += ",+c";
+        }
+        ts.push("features", features);
     } else {
         panic!("Unsupported architecture");
     }
-- 
2.39.2

