Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AC16A1D0F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjBXNh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBXNh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:37:27 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB424BE90;
        Fri, 24 Feb 2023 05:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677245843; x=1708781843;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aZzsSFvg1UfLqYXxjgJ2eB+4H3YgR+M3br8uQwZVD1w=;
  b=QwWy4LSgPP8apy192AgnI4HWGoPp6kkVi/dJTy8dr7aBvBS27oIOccVP
   H6WVpaitfUP5w2+W9ec5HB/CE1U3jVi4SmWdZaPmXFQTboHPJz9ODceio
   y9Yb93YsiQ1sAJ615EoKA5+u3Dj6Ntd6oyuVVfFEzXpcEgMeM6nu4n2Jj
   EkoYId4kEmr3upVO7zF8uYcSEa2xM7ZCBBnqB+rSi5/ffRinzcPdnAHlY
   slkqlz9FKn1Auk7agsCW97kpOnQqG2aF3rTvhO3WxO87EAbxu5nrDrrK5
   1Y6IZwIsrhBvV1wZou6g7iAMde8rPZAYTYXiNE8rTcgHN2q5QJdRdZE5z
   w==;
X-IronPort-AV: E=Sophos;i="5.97,324,1669100400"; 
   d="scan'208";a="138922155"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2023 06:37:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 24 Feb 2023 06:37:20 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.16 via Frontend
 Transport; Fri, 24 Feb 2023 06:37:17 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <linux-riscv@lists.infradead.org>
CC:     Conor Dooley <conor.dooley@microchip.com>, <conor@kernel.org>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
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
Subject: [RFC 0/2] RISC-V: enable rust
Date:   Fri, 24 Feb 2023 13:36:08 +0000
Message-ID: <20230224133609.2877396-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1475; i=conor.dooley@microchip.com; h=from:subject; bh=aZzsSFvg1UfLqYXxjgJ2eB+4H3YgR+M3br8uQwZVD1w=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDMk/9rocvX3IpcHZwESXJXif4QPzG+uS7Z+U/3R8YDjTJC6T zbipo5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABOxMWRk2LhgbcZ94f3W9/ddLXNZq7 b64bvUiUmuPRJzVryeG7I6K4aRYUr5E82VBzfNVau2eiiQ6377v52T4gt7P5kbB5xL+Wr42QA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a somewhat blind (and maybe foolish) attempt at enabling Rust
for RISC-V. I've tested this on Icicle, and the modules seem to work.
I'd like to play around with Rust on RISC-V, but I'm not interested in
using downstream kernels, so figured I should try and see what's
missing...
I've tagged this as RFC in case I've missed some "WAaaaa you can't do
this" somewhere :)

Thanks,
Conor.

CC: Miguel Ojeda <ojeda@kernel.org>
CC: Alex Gaynor <alex.gaynor@gmail.com>
CC: Wedson Almeida Filho <wedsonaf@gmail.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Gary Guo <gary@garyguo.net>
CC: Björn Roy Baron <bjorn3_gh@protonmail.com>
CC: Jonathan Corbet <corbet@lwn.net>
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Nathan Chancellor <nathan@kernel.org>
CC: Nick Desaulniers <ndesaulniers@google.com>
CC: Tom Rix <trix@redhat.com>
CC: rust-for-linux@vger.kernel.org
CC: linux-doc@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-riscv@lists.infradead.org
CC: llvm@lists.linux.dev

Miguel Ojeda (2):
  scripts: generate_rust_target: enable building on RISC-V
  RISC-V: enable building the 64-bit kernels with rust support

 Documentation/rust/arch-support.rst |  2 ++
 arch/riscv/Kconfig                  |  1 +
 arch/riscv/Makefile                 |  3 ++-
 scripts/generate_rust_target.rs     | 19 +++++++++++++++++++
 4 files changed, 24 insertions(+), 1 deletion(-)

-- 
2.39.2

