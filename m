Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8FD6DA50E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjDFV5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239550AbjDFV5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:57:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C975BDD5;
        Thu,  6 Apr 2023 14:56:28 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2804:14d:72b4:8284:32a8:8167:f815:2895])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dwlsalmeida)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 68D0466031CD;
        Thu,  6 Apr 2023 22:56:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680818186;
        bh=+RgTu+XfjA67kcgtbr4jnvnSVYYMZKKcrwsr5PcOo+k=;
        h=From:To:Cc:Subject:Date:From;
        b=DTHL20v/Q8Ki3aG9tnnoZYgKIGKiE5EBuqVh+LWBf1aDRi1NFcwl6nzRahU1gchvk
         +x+W/ElzVuklOi/tQasYuLzTGAQQJigW/L8GhPv3eG3/xnSxfgmm5JJ7m9SehQ5lsM
         H530ekYEuBAQMQ6CY7PxbltBn2Umo9d4ojJrSKeqN45Zt3mu4Qo5ldMFIS9q0Nndto
         X5PzFfEOuGGzpyApL5+7O2DOA/WSpLnF4Vtf+cRdJGYd3W96LJ3kSTLJmWux0cphi6
         C7c8yhzBwAi7sX8Mxy3OYSPyW2S5yMUM72mPUGU6an1dm00s3uZ1cbWt7vxp+WdY0f
         FiexTUhRRMZWw==
From:   Daniel Almeida <daniel.almeida@collabora.com>
To:     wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        hverkuil@xs4all.nl
Cc:     Daniel Almeida <daniel.almeida@collabora.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
Subject: [PATCH 0/6] Initial Rust V4L2 support
Date:   Thu,  6 Apr 2023 18:56:09 -0300
Message-Id: <20230406215615.122099-1-daniel.almeida@collabora.com>
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

Hi all, this is my first attempt at adding Rust support to the
media subsystem.

It adds just enough support to write a clone of the virtio-camera
prototype written by my colleague, Dmitry Osipenko, available at [0].

Basically, there's support for video_device_register,
v4l2_device_register and for some ioctls in v4l2_ioctl_ops. There is
also some initial vb2 support, alongside some wrappers for some types
found in videodev2.h.

I wrote a sample Rust driver just to prove that this probes, and
that you get a message on dmesg whenever an ioctl is called.

As there is no actual implementation for any of the ioctls, this module
can misbehave with some programs. I can work around this in a future
submission.

Note that this is based on the rust branch, as opposed to rust-next. The
reasoning is simple: I expect this series to just kickstart some
discussion around the subject. Actual upstreaming can come up much
later, at which point I can rebase on the rust branch.

Lastly, the origins of this series trace back to a v4l2 virtIO driver I
was writing in Rust. As the project was eventually shelved for other
reasons, I picked both the virtIO and the v4l2 bindings into their own
patches which I am now in the process of submitting. This is to say that
I tested this code with said driver and CrosVM in the past, and it
worked ok.

Please let me know your thoughts.

[0]: https://gitlab.collabora.com/dmitry.osipenko/linux-kernel-rd/-/commit/055a2c322e931a8b388f864f1db81bbdfd525602

Daniel Almeida (6):
  rust: media: add the media module
  rust: media: add initial videodev2.h abstractions
  rust: sync: introduce FfiMutex
  rust: media: videobuf2: add a videobuf2 abstraction
  rust: media: add {video|v4l2}_device_register support
  rust: media: add v4l2 rust sample

 rust/bindings/bindings_helper.h        |   8 +
 rust/kernel/lib.rs                     |   2 +
 rust/kernel/media/mod.rs               |   6 +
 rust/kernel/media/v4l2/capabilities.rs |  80 ++++
 rust/kernel/media/v4l2/dev.rs          | 369 +++++++++++++++
 rust/kernel/media/v4l2/device.rs       | 115 +++++
 rust/kernel/media/v4l2/enums.rs        | 135 ++++++
 rust/kernel/media/v4l2/format.rs       | 178 ++++++++
 rust/kernel/media/v4l2/framesize.rs    | 176 +++++++
 rust/kernel/media/v4l2/inputs.rs       | 104 +++++
 rust/kernel/media/v4l2/ioctls.rs       | 608 +++++++++++++++++++++++++
 rust/kernel/media/v4l2/mmap.rs         |  81 ++++
 rust/kernel/media/v4l2/mod.rs          |  13 +
 rust/kernel/media/videobuf2/core.rs    | 552 ++++++++++++++++++++++
 rust/kernel/media/videobuf2/mod.rs     |   5 +
 rust/kernel/sync.rs                    |   1 +
 rust/kernel/sync/ffi_mutex.rs          |  70 +++
 samples/rust/Kconfig                   |  11 +
 samples/rust/Makefile                  |   1 +
 samples/rust/rust_v4l2.rs              | 403 ++++++++++++++++
 20 files changed, 2918 insertions(+)
 create mode 100644 rust/kernel/media/mod.rs
 create mode 100644 rust/kernel/media/v4l2/capabilities.rs
 create mode 100644 rust/kernel/media/v4l2/dev.rs
 create mode 100644 rust/kernel/media/v4l2/device.rs
 create mode 100644 rust/kernel/media/v4l2/enums.rs
 create mode 100644 rust/kernel/media/v4l2/format.rs
 create mode 100644 rust/kernel/media/v4l2/framesize.rs
 create mode 100644 rust/kernel/media/v4l2/inputs.rs
 create mode 100644 rust/kernel/media/v4l2/ioctls.rs
 create mode 100644 rust/kernel/media/v4l2/mmap.rs
 create mode 100644 rust/kernel/media/v4l2/mod.rs
 create mode 100644 rust/kernel/media/videobuf2/core.rs
 create mode 100644 rust/kernel/media/videobuf2/mod.rs
 create mode 100644 rust/kernel/sync/ffi_mutex.rs
 create mode 100644 samples/rust/rust_v4l2.rs

-- 
2.40.0

