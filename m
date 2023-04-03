Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A9C6D4176
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjDCKCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjDCKBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:01:48 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24B049DA;
        Mon,  3 Apr 2023 03:01:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id DEC7242037;
        Mon,  3 Apr 2023 10:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1680516100;
        bh=5iG+gKdxqfqrOEbvILYGGdMiMNN4NG28/z/pH6bZA08=;
        h=From:Subject:Date:To:Cc;
        b=bfMEkvcp6B3G05vneL/GYZA6QOpF/jpx112ukqVEMsHbb8aOTEfzfgYpAeAsU3rMj
         3d7BMrBu+jZBw2zliSfttuKVx5ud8RIjx5rutmrxXgxySnSMNdusoKPjmIjq/MVu7V
         DtBgdekW8DdaP500+4c+dHEyo/ZhqqP8890xkAVM0bfRrjuo86gSYtzcNK21NaJYbi
         D3bcKuRiLaD4Vu4uRb6WU4ZTKybdCV0wYEDQy//8s3UUp7cySH72MHFPuHWS1CqCBu
         aAVUamVpSsymmpIlcZfTMkeb7exWHH2OzzAckNT3gNYsESyYdohJEUX9fte6kpTn3g
         Wz7TQbfH9CNBw==
From:   Asahi Lina <lina@asahilina.net>
Subject: [PATCH v2 0/2] rust: sync: Arc: Any downcasting and assume_init()
Date:   Mon, 03 Apr 2023 19:01:10 +0900
Message-Id: <20230224-rust-arc-v2-0-5c97a865b276@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOajKmQC/22NSw6CMBCGr2Jm7RDaYmNceQ/DYiijncQUM8VGQ
 7i7hbXL738ukFmFM1wOCygXyTKlCvZ4gBApPRhlrAy2ta61tkN95xlJAw7kgvU8duwJanygzDg
 opRC3QvGNQw1ms17Kd/nsL7e+cpQ8T/rdT4vZ1D/7xWCLJ39mJm8cdeZKmaI8JVGTeIZ+XdcfW
 a1geL8AAAA=
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     Andreas Hindborg <a.hindborg@samsung.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Benno Lossin <y86-dev@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680516096; l=1090;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=5iG+gKdxqfqrOEbvILYGGdMiMNN4NG28/z/pH6bZA08=;
 b=nkt1UWwOCWdkdM7BD3JwGd6hwT66+1JyRfcoXByFQvi0Zq6G+g3lbhQSXfIf+fefXIB1o4rvA
 pT1Sg/44QLUDO3xd9pAflcjuqRhchfbf4LzWoYrLFVdRM8DKbEAORvy
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

Hi everyone,

This short series is part of the set of dependencies for the drm/asahi
Apple M1/M2 GPU driver.

The two patches simply add two missing features to the kernel Arc
implementation which are present in the Rust std version: `Any`
downcasting and `assume_init()`.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
Changes in v2:
- #1: Moved the new function to a separate file, to keep the licensing
  clearer.
- #2: Replaced the safety comment with Benno's, from his pin-init series
  (we both wrote the same patch).
- Link to v1: https://lore.kernel.org/r/20230224-rust-arc-v1-0-568eea613a41@asahilina.net

---
Asahi Lina (2):
      rust: sync: arc: Implement Arc<dyn Any + Send + Sync>::downcast()
      rust: sync: arc: Add UniqueArc<MaybeUninit<T>::assume_init()
 rust/kernel/sync/arc.rs            | 13 +++++++++++++
 rust/kernel/sync/arc/std_vendor.rs | 28 ++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)
---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230224-rust-arc-ba3c26ed4e6a

Thank you,
~~ Lina

