Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C936ADBCB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjCGKZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjCGKZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:25:27 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAB95073C;
        Tue,  7 Mar 2023 02:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678184720; x=1709720720;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OInxuMJtdIyDPn0imEFBCcfPVJWWAD2dQ/VhXFHBFuY=;
  b=Gwp215xaiOgI+uTvcjyvH1nPDsHOfrIjUIwFUhV8yeAujtjxiRJ1rNNx
   vwlJDCs86lytaHGkRF6y6UYj0tVXhftNddrWhkN/B6jeA/iypDOYRyXXG
   QPYm2Tie/YoSmyE/6UEK7NZ/xN2z7ZK2r+Rp0tl/n/P0AjEWEB2Ic4vK/
   Pd9f1GW3Ze2H7QGwBdHxl/Drj52Yh9xdmoBumWouQwE4IImcMG9B8URJB
   qTHvcZnfjJCWoteQwlCQFWW2vmscntcXHsHnyWRsKrKf/mcYplBHERdY3
   WOSTn91EM+95OhKnZIlMqSTrPZQ2Pz2LO4wnmk9Sgda3ZFMqed37p/FXL
   g==;
X-IronPort-AV: E=Sophos;i="5.98,240,1673938800"; 
   d="scan'208";a="140694248"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2023 03:25:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Mar 2023 03:25:15 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.16 via Frontend
 Transport; Tue, 7 Mar 2023 03:25:12 -0700
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
Subject: [PATCH v1 0/2] RISC-V: enable rust
Date:   Tue, 7 Mar 2023 10:24:39 +0000
Message-ID: <20230307102441.94417-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2088; i=conor.dooley@microchip.com; h=from:subject; bh=OInxuMJtdIyDPn0imEFBCcfPVJWWAD2dQ/VhXFHBFuY=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCnsAs8kPwY+WPDTW83kbZ7n9rULE84/3btU3L1pj9Su+gea apKSHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZhIhAPDP9vQmtgpq6++Ptj9MuPKLd 5J942cmbL2szoy/Ciezv3hViXD//KFmxlmvp0gz2ITs0bPJ+dy7MGQD2/k7rwL1QlWf+3wgRcA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the authorship debacle on the RFC, I've tried to be even more
careful this time around. Gary opted for a Co-developed-by in the replies
of the RFC stuff, so I have given them one.
I have added SoB's too, but if that is not okay Gary, then please scream
loudly.

As this is lifted from the state of the Rust-for-Linux tree, the commit
messages from there cannot be preserved, so these patches have commit
messages that I wrote.

I've tested this on Icicle, and the modules seem to work as expected.
Unfortunately there appear to be implicit 32-bit divisions (or similar)
in core Rust code, so, as in the downstream Rust-for-Linux tree, Rust is
only enabled for 64-bit.

Thanks,
Conor.

Changes in v1:
- rebase on v6.3-rc1
- resort the `um` entry in the arch-support table while adding RISC-V
  to it
- drop 32-bit bits
- have another crack at assigning authorship

Changes in RFC-RESEND:
- fix the asymmetrical additions in the Makefile bits
- add cc-cover to my git send-email command...

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
  RISC-V: enable building 64-bit kernels with rust support

 Documentation/rust/arch-support.rst |  3 ++-
 arch/riscv/Kconfig                  |  1 +
 arch/riscv/Makefile                 |  2 ++
 scripts/generate_rust_target.rs     | 16 ++++++++++++++++
 4 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.39.2

