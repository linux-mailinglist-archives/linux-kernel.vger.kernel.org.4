Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1C56A170E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 08:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBXH0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 02:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBXH0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 02:26:32 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722391EBDF;
        Thu, 23 Feb 2023 23:26:31 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C94FE4248B;
        Fri, 24 Feb 2023 07:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677223589;
        bh=nKGhps5DD27EJVZDy1ee9VeyZsp+Mb8LJV4KHerqhaA=;
        h=From:Subject:Date:To:Cc;
        b=zexXCZty7onfsKHpn30fdyS96xk4THjzQTKr2yMbkM3zdVyNT+OA+28iGZxOuXjTx
         nArZgrIBmwygvgzL28XQLDWkm2G5/QhIuU21ROMLCQOtzeUtRuiAiHTmdZ7lIFqYIw
         7VheS/1xAPZ4H8nFXDPS4FWlazjdlSNp53uF8s4JSns+c+7KVr5m5NhqxLyl8VWRNL
         rKcBCq2S+5PapCd8ktIXzn3vemb3Uih8oCBeI/ms00XL6SmFiry3i/WMtR6fsKTPdh
         fbtOs6YM8w3+sAfhUD6q3e8MoqPMEyAN9jel8CeCqmfBd/8Uehgh+2z3Ycql/tLPLt
         ztIQDkKrtAgig==
From:   Asahi Lina <lina@asahilina.net>
Subject: [PATCH 0/3] rust: Miscellaneous macro improvements
Date:   Fri, 24 Feb 2023 16:25:54 +0900
Message-Id: <20230224-rust-macros-v1-0-b39fae46e102@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIJm+GMC/x2NQQ6DMAwEv4J8rtWQoLbqV6oenGDAhwZkl6oS4
 u8kHGd3R7uBsQobPJsNlH9iMucC7aWBNFEeGaUvDN754LzvUFf74oeSzoa3EPo4PO6OuIViRDL
 GqJTTVJ1xWa/nvOa1X5QH+Z9vr/e+HwCnv259AAAA
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>,
        Finn Behrens <me@kloenk.dev>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677223586; l=1588;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=nKGhps5DD27EJVZDy1ee9VeyZsp+Mb8LJV4KHerqhaA=;
 b=VdMC491l3CXJjysB+gN/JRXZFdOkZ4zQ6Pu9earrHBjrMRmDFmisUcEWdeXDPkPlavbDFC/SK
 UfGto5/oEoUANXtk8nLj3pp1JouQCTSXJHJny8JsYj1HO85DU1d3E73
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

This short series is part of the set of dependencies for the drm/asahi
Apple M1/M2 GPU driver.

The first two patches make concat_idents!(bindings::foo, bar) work.
I use this later in the DRM abstractions to construct DRM IOCTL command
names [1], which avoids having to import all of bindings::*.

The third patch allows specifying multiple module aliases. Since modules
can have multiple aliases, the macro naturally needs to be able to take
an array instead of a single alias. I don't use this in the current
iteration of the driver, since I introduced proper support for automatic
modpost alias generation for Rust modules, but it can be useful both to
remove that support as a blocking factor (we can specify aliases manually
as a fallback), and for modules which need extra aliases not covered by
device ID tables.

[1] https://github.com/AsahiLinux/linux/blob/gpu/rebase-20230224/rust/kernel/drm/ioctl.rs#L101

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
Asahi Lina (3):
      rust: macros: Make expect_punct() return the Punct directly
      rust: macros: concat_idents: Allow :: paths in the first argument
      rust: macros: Allow specifying multiple module aliases
 rust/macros/concat_idents.rs | 24 +++++++++++++++++++++---
 rust/macros/helpers.rs       | 14 +++++++++++---
 rust/macros/module.rs        | 34 +++++++++++++++++++++++++++-------
 3 files changed, 59 insertions(+), 13 deletions(-)
---
base-commit: 83f978b63fa7ad474ca22d7e2772c5988101c9bd
change-id: 20230224-rust-macros-633dbf870ae1

Thank you,
~~ Lina

