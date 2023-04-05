Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F506D8800
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbjDEUOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbjDEUOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:14:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F801BCB;
        Wed,  5 Apr 2023 13:14:28 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2804:14d:72b4:8284:32a8:8167:f815:2895])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dwlsalmeida)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 63E7866030CD;
        Wed,  5 Apr 2023 21:14:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680725667;
        bh=v2OezC2eOoKmX+pqSD+mVfxyCEzS9XKNpWmxKSDdPnk=;
        h=From:To:Cc:Subject:Date:From;
        b=UxbfPa4nKsc8IT7K38/+QZoKPGeSO33cym7VJPvwXMLJQboCJdKGYeCZzoLvFwAB/
         Ki6KVuioJ81Dx4HoZP3E3r58c0104VG2zms2QHsqQ+6ppYY7goIkEPYBm7imu83IAH
         XZ/NL5wgA4dYxI/ejlOHCYPVLfNTI3YrsGJ75P4+XWheHkXj0RlU/35JzebHLwt8W1
         MTfh/hjZtqF/0309g6IxmMCFa4nvfJQMUajl6hgqvZTfPblL6SHGlu+pQhoqWCkyxM
         PF5yTCJH6up83YRVaBapmI2eZC3OLe15ZvxsPJXWJ3EW3Mjs6JZfPCwQvBTtDMdeuF
         iqI37j9a5CUOA==
From:   Daniel Almeida <daniel.almeida@collabora.com>
To:     wedsonaf@gmail.com, ojeda@kernel.org
Cc:     Daniel Almeida <daniel.almeida@collabora.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 0/2] rust: virtio: add virtio support
Date:   Wed,  5 Apr 2023 17:14:14 -0300
Message-Id: <20230405201416.395840-1-daniel.almeida@collabora.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This used to be a single patch, but I split it into two with the
addition of struct Scatterlist.

Again a bit new with Rust submissions. I was told by Gary Guo to
rebase on top of rust-next, but it seems *very* behind?

The first patch does not build on its own due to a dead_code warning.
It is hard to not have dead code when one is adding infrastructure to be
used by others at a later opportunity. Let me know if you would like to
see the patches squashed into one to fix this.

As suggested by Bjorn, I added a small virtio-entropy based sample.
It is a very bare-bones clone of virtio-rng.c that only sends a
single request.

Changes from v1:

- Addressed review comments by Miguel and Bjorn.
- Added a scatterlist abstraction
- Added a virtio-rng based sample

Daniel Almeida (2):
  rust: add scatterlist support
  rust: virtio: add virtio support

 rust/bindings/bindings_helper.h |   3 +
 rust/helpers.c                  |  25 +++
 rust/kernel/lib.rs              |   3 +
 rust/kernel/scatterlist.rs      |  40 +++++
 rust/kernel/virtio.rs           | 261 ++++++++++++++++++++++++++++++++
 rust/kernel/virtio/virtqueue.rs | 126 +++++++++++++++
 samples/rust/Kconfig            |  10 ++
 samples/rust/Makefile           |   1 +
 samples/rust/rust_virtio.rs     | 195 ++++++++++++++++++++++++
 9 files changed, 664 insertions(+)
 create mode 100644 rust/kernel/scatterlist.rs
 create mode 100644 rust/kernel/virtio.rs
 create mode 100644 rust/kernel/virtio/virtqueue.rs
 create mode 100644 samples/rust/rust_virtio.rs

-- 
2.40.0

