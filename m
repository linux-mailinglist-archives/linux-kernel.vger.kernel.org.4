Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709C36A1AA8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjBXKxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjBXKxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:53:43 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ED73A98;
        Fri, 24 Feb 2023 02:53:41 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id B642041A42;
        Fri, 24 Feb 2023 10:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677236018;
        bh=odM30e7WfL3ViJ4E9vhvIiTABVNJt0PmQ5FpXRDjdOc=;
        h=From:Subject:Date:To:Cc;
        b=n1c8/V2PdeG+C9jXJV9jb7KJ+xyYlUqjbt0Mld7UAGz0CkjOhT/GrQSyRSUGP60sG
         LAutDXuGsllVxUcvMbbylk/U+Zen+UE/wqHNMSwY713yk8EwESk97CSr+p263AjjHA
         g3J9umbv9pMa1EOaQoc8//Z3I6tPO7VeKhIzZGrBjzdBxPiBsqK1gXe/DZ2W9XvYAy
         8Tm/ZA6Za5OfjDunoU7iGMmOtvOt1DmYmCxmG/+aEvnn6JIRJbRhwXu6EvQMEi3i9C
         t8qNFUnOD50VCCl+zXPm4zWFb3Gbz93DeVuWvM0TznIg+no3wkXb222O3VQhtgRc+D
         zCreT7+jPdj6A==
From:   Asahi Lina <lina@asahilina.net>
Subject: [PATCH 0/5] rust: Add io_pgtable and RTKit abstractions
Date:   Fri, 24 Feb 2023 19:53:12 +0900
Message-Id: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABiX+GMC/x3N3QrCMAyG4VsZOTZYYyfirYgH/YkuCO1Iqghj9
 263w5ePh28BYxU2uA0LKH/FpJYep8MAaQrlxSi5N5CjsyPyqB9rKHVuqO0tDS/5GsfRZ3I+QVc
 xGGPUUNK0ueiPu2DVqts+Kz/ltz/eH+v6B231hz+BAAAA
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677236013; l=5246;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=odM30e7WfL3ViJ4E9vhvIiTABVNJt0PmQ5FpXRDjdOc=;
 b=77qpU72o1r3pU2uvyd6xqIOz3reuaOyNcrk9IYpYUNgdaZW2kfY9XHpZwQlXrZsLNFH97SOcn
 gJxZenolLObD4XkE3hMAbyN04MCpiHpXVuxBfVH0dBcgoEj8F/Tre/T
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

It builds on top of the error helper series [1] and adds the skeleton
of a Device abstraction and two proper subsystem abstractions that use
it: io_pgtable and RTKit.

Many kernel subsystems need to take `struct device` pointers. In the
downstream rust-for-linux/rust branch, this is abstracted as a RawDevice
trait that specific `struct device` subtypes (like `platform_device`)
can implement such that all device subclasses can interoperate with
device class-agnostic kernel APIs. Importing this trivial trait is all
that is needed to start building and upstreaming abstractions.

The first patch in this series just adds a private Sealed trait, which
is a common Rust pattern to allow crates to have traits that cannot be
implemented outside the trait. This is important where implementing such
traits incorrectly could lead to soundness issues, and where in general
there is no reason for anything outside the kernel crate to do so.

The next patch introduces the RawDevice trait, which just represents
anything that contains a `struct device`. This is enough for kernel
abstractions that need to pass down such pointers to the underlying C
code to compile.

The third patch adds the io_pgtable abstraction. The Apple GPU driver
uses this common code to manage the GPU page tables, which are mostly
standard ARMv8 page tables. The common code does need a new variant type
to handle the specific PTE permission scheme and a few other details,
which I already submitted [2]. This abstraction does not include that
new type. If the underlying C support goes in first, I can update this
series to add the missing wrapper in a later revision (it's just a few
extra lines). See the panfrost driver for another example of a GPU
driver reusing common io_pgtable code (with a specific format variant
too).

The fourth patch adds the Apple RTKit subsystem abstraction, which is
part of drivers/soc/apple. This builds on some support patches that
should already be in the SoC tree queued for 6.3. While this code only
makes sense on ARM64 (which does not yet have upstream Rust support),
it should compile on x86 too with CONFIG_COMPILE_TEST. If you want to
compile test this yourself at this point, you will need to merge in [3]
(this will no longer be required as soon as Linus pulls the SoC stuff
in this merge window).

Note: Although this patch adds a consumer for the Error stuff introduced
previously, it is conditionally compiled so we still need the dead_code
allow tags to avoid warnings when RTKit is not enabled. Also, since the
Rust build system does not yet have split crates with helpers/bindings
to allow for modular abstractions, this abstraction hard-depends on
CONFIG_APPLE_RTKIT=y. We expect to remove this restriction once the
build system is improved, but from talks with the DRM folks we're okay
with the driver introducing built-in dependencies on some kernel
subsystems (even though the driver itself is buildable as a module).

The fifth patch adds some more bits of the Device abstraction, to give
context on the direction that is headed in. It includes a basic `Device`
type that represents an owned reference to a generic `struct device`.
This doesn't have to go in right now, but I thought it would be useful
to provide some more context.

The branch at [4] contains the full series of patches rebased on
upstream leading to the complete driver, for reference on how these APIs
and abstractions are used.

Please let me know if you have any comments on how this is structured or
would like to see the abstractions upstreamed separate! It's very
difficult to upstream things only when they have a user, since the
dependency chain for that user (the GPU driver) is very long. I hope
that bundling these together helps give some context and get some
momentum going with the upstreaming process.

[1] https://lore.kernel.org/rust-for-linux/20230224-rust-error-v1-0-f8f9a9a87303@asahilina.net/T/#t
[2] https://lore.kernel.org/asahi/20230121084758.31875-1-lina@asahilina.net/
[3] https://github.com/AsahiLinux/linux.git asahi-soc-rtkit-pmgr-6.3
[4] https://github.com/AsahiLinux/linux/tree/gpu/rebase-20230224

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
Asahi Lina (3):
      rust: Add a Sealed trait
      rust: io_pgtable: Add io_pgtable abstraction
      rust: soc: apple: rtkit: Add Apple RTKit abstraction

Wedson Almeida Filho (2):
      rust: device: Add a minimal RawDevice trait
      rust: device: Add a stub abstraction for devices
 rust/bindings/bindings_helper.h |   3 +
 rust/helpers.c                  |  13 ++
 rust/kernel/device.rs           |  97 +++++++++++
 rust/kernel/io_pgtable.rs       | 351 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   9 ++
 rust/kernel/soc/apple/mod.rs    |   6 +
 rust/kernel/soc/apple/rtkit.rs  | 259 +++++++++++++++++++++++++++++
 rust/kernel/soc/mod.rs          |   5 +
 8 files changed, 743 insertions(+)
---
base-commit: 0ac13d87afc0086c0be43e7988173295a0864d5d
change-id: 20230224-rust-iopt-rtkit-6d8b554d204c

Thank you,
~~ Lina

