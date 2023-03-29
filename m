Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADE36CD89E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjC2Lkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjC2Lko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:40:44 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419239E;
        Wed, 29 Mar 2023 04:40:42 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 31D284247C;
        Wed, 29 Mar 2023 11:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1680090039;
        bh=sgkJirkqva0+PxNuqlvJAdh/8AuGnLCXCYPdCELUlwo=;
        h=From:Subject:Date:To:Cc;
        b=uifV4TGE4jPUce3MH0xUpkihM9a6blY7pA0w4nuRwCaPdTtmzVfuyZzz+XAy4sgf7
         3SP9PWvGMVJx9mXxuN9qJucuYn0hyvJj4Z4RiaFVuzsPV6SCIt396KgRS33KW5TMgk
         AmP08hvqlKjBdTEpHWPYDcJKLjyc4Jwbzu4kb9Q0E919BeW3bh825uXmVrKprPO0Ge
         T78jgzSxe3ycFXi2l1xmMBNahsA/CHH5UCWkc3DboTGhET0xxXdZjXMVzqSsIz5rIo
         PtPUhD3RmuKo5vdQKhE13TP93OFLTCDDDbrfNS7FKIwGbDDObX6JO29d5Ef6SrT/O7
         kIXJ3myU9t5AQ==
From:   Asahi Lina <lina@asahilina.net>
Subject: [PATCH 0/2] rust: Add uapi crate
Date:   Wed, 29 Mar 2023 20:40:17 +0900
Message-Id: <20230329-rust-uapi-v1-0-ee78f2933726@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKIjJGQC/x2N0QqDMAxFf0XyvDKNFdb9yvAhrZkGRpVEx0D89
 1UfD/cc7g7GKmzwrHZQ/orJnAs0twrSRHlkJ0NhwBrbusXgdLPVbbSIewTvseFA3YBQ/EjGLir
 lNJ1F9PfLlTmtn3NflN/yu75e/XH8AZU0bYh7AAAA
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680090036; l=1778;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=sgkJirkqva0+PxNuqlvJAdh/8AuGnLCXCYPdCELUlwo=;
 b=JAcBC6InJetx1oLYXbylVQ6zXKv9RfrKEn2QqgZdQHk+Hl+tXDUGrONRmBYZgzAXNfUiEqbyH
 3SRCJz6L1WMDOz0AlTX8hP5En++UM7F5E5e6xAYz7VWKLK1EndDLDX2
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
while the second patch modifies the ioctl crate (which I sent as a
separate series) to use the new crate. Miguel: if/once everything looks
good, feel free to merge just patch #1 and I can squash #2 into the ioctl
crate, or you can squash it yourself, or just merge both series in
sequence, whatever works ^^

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
Asahi Lina (2):
      rust: uapi: Add UAPI crate
      rust: ioctl: Move to the uapi crate
 rust/.gitignore         |  1 +
 rust/Makefile           | 18 ++++++++++++++++--
 rust/kernel/ioctl.rs    | 32 ++++++++++++++++----------------
 rust/kernel/lib.rs      |  1 +
 rust/uapi/lib.rs        | 27 +++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h |  9 +++++++++
 6 files changed, 70 insertions(+), 18 deletions(-)
---
base-commit: 5aa20836252a607ce5d3fa96f9807b56e9f6b1ca
change-id: 20230329-rust-uapi-894421e9a5d2

Thank you,
~~ Lina

