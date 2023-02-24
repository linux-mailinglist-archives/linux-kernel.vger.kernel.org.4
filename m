Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9E06A1841
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 09:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjBXIul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 03:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjBXIui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 03:50:38 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23F31206D;
        Fri, 24 Feb 2023 00:50:35 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 9110B3FA55;
        Fri, 24 Feb 2023 08:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677228633;
        bh=tQrGaAqMYCBhKSnr1KfIUiJLe3za3ls9Y5ZjKTRKLPw=;
        h=From:Subject:Date:To:Cc;
        b=UnzTzOwjsEg7GMA3hTnS3jxTaWR7RRJM2Qbhz5Yd/kbdKdH5tGs6auw27WcsUhWPm
         5SKVedClPkSnzYs0KifMo9+LeWoIpdOmNu4R5Q99BM2apeeXGSrYxshOh113WcTIbU
         FxtKfkIzfqZh4KGFcDsFIp1fDB8Ephy96kMmoo8W2wgEPnpkKsA2evNZX7ph2heHzJ
         AMuRvS5cBtlQlQ8953QPlBqwTFNvL7QgCo/cJwI9VKyxRlQAqRswO47ersffubGibt
         Zx/oQL7hKpmk1gVUpIcLPEIzyAA88JL/B2fWDuP38YIuE2d6qfPNLV+L2MN6wk9Sr+
         TOik9QnB5jmFw==
From:   Asahi Lina <lina@asahilina.net>
Subject: [PATCH 0/5] rust: error: Add missing wrappers to convert to/from
 kernel error codes
Date:   Fri, 24 Feb 2023 17:50:18 +0900
Message-Id: <20230224-rust-error-v1-0-f8f9a9a87303@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEp6+GMC/x2NSw6DMAxEr4K8rtXgVuJzlaqLJHXAm4BsqCoh7
 t6E5ZuZpznAWIUNxuYA5a+YLLlAe2sgzj5PjPIpDOTo4YieqLttyKqLYqK+a1OIg+sSFCF4Ywz
 qc5yrMq37/VrXvParcpLfdfZ6n+cf4Gama3wAAAA=
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Fox Chen <foxhlchen@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677228630; l=2180;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=tQrGaAqMYCBhKSnr1KfIUiJLe3za3ls9Y5ZjKTRKLPw=;
 b=3kkWlTBkfsbE+GogOzkuW4+mkz3cQDoMrBDE+y9cx7KXvHr4jG+I4+ATuSs+6374g3Ubh0SQ6
 l5k0Hli7jKsCeldS7hAxcjsI0BjX+MDCQunCDCnLwVq5bitF70CWnKd
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
Asahi Lina (1):
      rust: error: Add Error::to_ptr()

Miguel Ojeda (1):
      rust: error: Add Error::from_kernel_errno()

Sven Van Asbroeck (1):
      rust: error: Add a helper to convert a C ERR_PTR to a `Result`

Wedson Almeida Filho (2):
      rust: error: Add to_result() helper
      rust: error: Add from_kernel_result!() macro
 rust/helpers.c       |  19 +++++++
 rust/kernel/error.rs | 137 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 156 insertions(+)
---
base-commit: 83f978b63fa7ad474ca22d7e2772c5988101c9bd
change-id: 20230224-rust-error-f2871fbc907f

Thank you,
~~ Lina

