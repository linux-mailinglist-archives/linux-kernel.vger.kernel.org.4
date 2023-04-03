Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15786D4126
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjDCJtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjDCJsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:48:53 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407CAEB4A;
        Mon,  3 Apr 2023 02:48:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 4463F41E64;
        Mon,  3 Apr 2023 09:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1680515299;
        bh=03IUxiM2NYytsEqkQE0lVeut6Us6UiwebZUlwtHiGAw=;
        h=From:Subject:Date:To:Cc;
        b=aoUxhbKxLFpvEJeDumfIatd9IjwP2zReeLidrQ1Ep5+PVvi6js4j9xBpeVqGfzXmy
         o438S0uS1YXY0hhlkh+L34mCmGIrxUlPu5+urHmz8HBvbbTmVNVheRpUZJJ+SlAHwW
         UPdHHqEVBrS9yB0oWXZZMKbxpdSzDPS//LUSa1chCqk+CUMxJw84mkte31t7YiaWZ+
         3uj5w57+t+JEMxiVdlLdtWMhQ5t04c/dE6i1nQSihEviQTcvD5jKGUcz2UoDExmQg4
         cGN4+lQx8tI8zI6cvsF4JKaX5uIXhzIIP787AVgj6OZsl/xCnqElBpziEsPFkrcgrn
         RGDLOmmyvy0IQ==
From:   Asahi Lina <lina@asahilina.net>
Subject: [PATCH v3 0/6] rust: error: Add missing wrappers to convert
 to/from kernel error codes
Date:   Mon, 03 Apr 2023 18:48:09 +0900
Message-Id: <20230224-rust-error-v3-0-03779bddc02b@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANmgKmQC/3WNzQ7CIBAGX8Vwdht+jAVPvofxsKUgJIaapRJN0
 3cXejR6nN3MNwvLjqLL7LRbGLkSc5xSBbXfMRsw3RzEsTKTXCou5QHomWdwRBOBl7oXfrCG955
 VYcDsYCBMNjSlHDsFZEV7Pcj5+No6l2vlEPM80XvLFtGuPwtFAAevvUGDuldcnTFjiPeYsEtuZ
 m2qyP+6rLoynCthtJAjfuvrun4A9VVoMgIBAAA=
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Fox Chen <foxhlchen@gmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680515295; l=2833;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=03IUxiM2NYytsEqkQE0lVeut6Us6UiwebZUlwtHiGAw=;
 b=AEvTg7zbHfH1jU1Nbh1O5xfdN5frIkRqX2gs26fdTWv1Oydau6SiA0q51h0OP0PTgMgdeJvdu
 wlnzkf+pIgxBOIKxCX14E7suJNdfxb//pkXsNoq83FYVeWPulNAZWWv
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

Hi everyone!

This series is part of the set of dependencies for the drm/asahi
Apple M1/M2 GPU driver.

It adds a bunch of missing wrappers in kernel::error, which are useful
to convert to/from kernel error codes. Since these will be used by many
abstractions coming up soon, I think it makes sense to merge them as
soon as possible instead of bundling them with the first user. Hence,
they have allow() tags to silence dead code warnings. These can be
removed as soon as the first user is in the kernel crate.

Getting this in first allows the subsequent abstractions to be merged in
any order, so we don't have to worry about piecewise rebasing and fixing
conflicts in the Error wrappers. See [1] for a complete tree with the DRM
abstractions and all other miscellaneous work-in-progress prerequisites
rebased on top of mainline.

Most of these have been extracted from the rust-for-linux/rust branch,
with author attribution to the first/primary author and Co-developed-by:
for everyone else who touched the code.

Attribution changes:
- One of the patches had Miguel's old email in the tags, updated that per
  his request.
- Wedson's email changed from @google.com to @gmail.com (I understand
  this is the current one).

Sven: There is one patch from you in this series, do you want to send it
yourself directly? I understand Wedson and Miguel are okay with me
sending stuff on their behalf.

[1] https://github.com/Rust-for-Linux/linux/pull/969/commits

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
Changes in v3:
- Re-introduced from_errno_unchecked() (but private to this module since
  it has no outside users) and used it in from_err_ptr().
- Updated safety comment in to_ptr().
- Link to v2: https://lore.kernel.org/r/20230224-rust-error-v2-0-3900319812da@asahilina.net

Changes in v2:
- Removed the redundant _kernel from various function names.
- Replaced the from_result!{} macro with a from_result() function taking a closure.
- Link to v1: https://lore.kernel.org/r/20230224-rust-error-v1-0-f8f9a9a87303@asahilina.net

---
Asahi Lina (2):
      rust: error: Rename to_kernel_errno() -> to_errno()
      rust: error: Add Error::to_ptr()

Miguel Ojeda (1):
      rust: error: Add Error::from_errno{_unchecked}()

Sven Van Asbroeck (1):
      rust: error: Add a helper to convert a C ERR_PTR to a `Result`

Wedson Almeida Filho (2):
      rust: error: Add to_result() helper
      rust: error: Add from_result() helper
 rust/helpers.c        |  19 +++++++
 rust/kernel/error.rs  | 137 +++++++++++++++++++++++++++++++++++++++++++++++++-
 rust/macros/module.rs |   2 +-
 3 files changed, 156 insertions(+), 2 deletions(-)
---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230224-rust-error-f2871fbc907f

Thank you,
~~ Lina

