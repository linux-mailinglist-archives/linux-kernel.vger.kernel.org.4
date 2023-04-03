Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DD06D40B9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjDCJe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjDCJe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:34:27 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BE01117E;
        Mon,  3 Apr 2023 02:34:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 49C1642037;
        Mon,  3 Apr 2023 09:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1680514438;
        bh=QF2xjWnU+Upz2uOIFUZSXuBfb3X3n6mqz6fHktFg6Y0=;
        h=From:Subject:Date:To:Cc;
        b=o5jY98udMPDyja3v8O2S6/AWf2UgvbLViBr5/ajaIdUj9nULu5Km1ruc+rG+tJrqN
         j9+V05imSeFYFO2aPw5atEqYJdsZbcttgr6LV9jxh1uxF6mg75tjZzn/6GOPy37GI9
         MaXZ3mVyskBwzdWamR4I1j8mZxVHZbqKqh0xNa+aOjjxY1CQYcE4IzgnD/Zp6Vz9kf
         uiGllrswYtk3m3DMCom7+lnI01D89/Di1LYetwhkp77vTdXLSx8Q2LaQrpe10wDVcy
         IcSzsJ4L7HjlP5dv++rwhBiFacrD0SRTVDfsJ+Dt9eCSH+35Zf/QpeV2trdFgGfj97
         Gczju5SOnvxLg==
From:   Asahi Lina <lina@asahilina.net>
Subject: [PATCH v2 0/2] rust: Add uapi crate
Date:   Mon, 03 Apr 2023 18:33:51 +0900
Message-Id: <20230329-rust-uapi-v2-0-bca5fb4d4a12@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH+dKmQC/22Nyw6CMBBFf8V07RA6RR6u/A/DYoDBTmIKaaHRE
 P7dwtrluY+cTQX2wkHdL5vyHCXI5BLg9aJ6S+7FIENihTma3GADfg0LrDQL1E1RoOaGbgOqtO8
 oMHSeXG+PRywzA77XRzV7HuVzap5tYithmfz3tEZ9pP8EUUMOzFU9YmNMheWDAll5i6PM8aLaf
 d9/WFad5sEAAAA=
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680514434; l=2079;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=QF2xjWnU+Upz2uOIFUZSXuBfb3X3n6mqz6fHktFg6Y0=;
 b=cexXIb2Ua4kAUE1Fqp7maY6ZSva2VPVE2kt7u1P+uTfDgFL4Y3TdGVrlRHs/vcMi2nrhkSnet
 WwkIHk2S416CzTv/1vmbbVeTVq8UpJBhkZhx7nek15DU3izf+PONyw8
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=Qn8jZuOtR1m5GaiDfTrAoQ4NE1XoYVZ/wmt5YtXWFC4=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In general, direct bindgen bindings for C kernel APIs are not intended
to be used by drivers outside of the `kernel` crate. However, some
drivers do need to interact directly with UAPI definitions to implement
userspace APIs.

Instead of making this an exception to the use of the `bindings` crate,
introduce a new `uapi` crate that will contain only these publicly
usable definitions. The build logic mirrors the `bindings` crate, but
there is no helper support since UAPIs are only intended to contain
constant and type definitions, not function prototypes.

In the future, we would like to extend this to also auto-derive and
validate certain safety properties for UAPI structure definitions, such
as that they are safely castable to/from "bag of bits" buffers.

The first patch introduces the `uapi` crate proper and stands on its own,
while the second patch introduces the `ioctl` module in the kernel crate
that uses it.

(Miguel: this series should apply stand-alone now)

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
Changes in v2:
- Fixed the trailing '\' warning (mirroring the fix from Vicenzo
  Palazzo)
- Pulled in the ioctl module patch into this series. Per the discussion
  in the meeting, this could be moved into the uapi crate in principle,
  but we can decide to do that later since the whole buildsystem is
  likely to undergo major changes anyway.
- Link to v1: https://lore.kernel.org/r/20230329-rust-uapi-v1-0-ee78f2933726@asahilina.net

---
Asahi Lina (2):
      rust: uapi: Add UAPI crate
      rust: ioctl: Add ioctl number manipulation functions
 rust/.gitignore         |  1 +
 rust/Makefile           | 18 +++++++++++--
 rust/kernel/ioctl.rs    | 71 +++++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs      |  2 ++
 rust/uapi/lib.rs        | 27 +++++++++++++++++++
 rust/uapi/uapi_helper.h |  9 +++++++
 6 files changed, 126 insertions(+), 2 deletions(-)
---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230329-rust-uapi-894421e9a5d2

Thank you,
~~ Lina

