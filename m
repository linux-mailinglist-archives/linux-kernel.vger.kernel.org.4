Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3066DCDA9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 00:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjDJWq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 18:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDJWq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 18:46:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B021BDB;
        Mon, 10 Apr 2023 15:46:26 -0700 (PDT)
Received: from localhost (unknown [IPv6:2001:569:beb1:1500:c96f:992f:7c34:9ff])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dbrouwer)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2D46F6603085;
        Mon, 10 Apr 2023 23:46:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681166783;
        bh=9c4iluAe1XdyJtOZMymDhLS/AIaO/Q70FhnFi5leiec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LbH8Nb8XBTgz2eveAwcbCXjuqnrQFv4M/8nsYMmyus/G0NRk+AhZZNgaKU8cmXQjf
         gjmDdxX0yT3mRuLsJjJmInQJ9D8aniu0vwxiI4wakMCp1VOvH9kYKCdFnWp1gMDjiy
         Is/zCj8eOreZabG0ospwUdYCUEQQXLeYQVYSA453f9AHYWmYcMxOrDWF70yKp9t6gK
         +ZLu8JbtgUktuUxjHl8bWWnmfrRjxvwlLWSbmu6JdVG1lF7RSbKeTl/L26Tih5CmbZ
         C+KfysLHNx6GNxK0h4DJd7KydBbHmHdkNKtI0dzSa/RUczyzc7ON01Q5G4BgxMI5ex
         k8Zv19l+uHaZQ==
Date:   Mon, 10 Apr 2023 15:46:03 -0700
From:   Deborah Brouwer <deborah.brouwer@collabora.com>
To:     Daniel Almeida <daniel.almeida@collabora.com>
Cc:     wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        hverkuil@xs4all.nl, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
Message-ID: <ZDSRSWhWsN34MghQ@xps>
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406215615.122099-1-daniel.almeida@collabora.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 06:56:09PM -0300, Daniel Almeida wrote:
> Hi all, this is my first attempt at adding Rust support to the
> media subsystem.
> 
> It adds just enough support to write a clone of the virtio-camera
> prototype written by my colleague, Dmitry Osipenko, available at [0].
> 
> Basically, there's support for video_device_register,
> v4l2_device_register and for some ioctls in v4l2_ioctl_ops. There is
> also some initial vb2 support, alongside some wrappers for some types
> found in videodev2.h.
> 
> I wrote a sample Rust driver just to prove that this probes, and
> that you get a message on dmesg whenever an ioctl is called.
> 
> As there is no actual implementation for any of the ioctls, this module
> can misbehave with some programs. I can work around this in a future
> submission.
> 
> Note that this is based on the rust branch, as opposed to rust-next. The
> reasoning is simple: I expect this series to just kickstart some
> discussion around the subject. Actual upstreaming can come up much
> later, at which point I can rebase on the rust branch.

Hi Daniel - I don't know if the 'rust branch' is common knowledge but
it helped me to know it was this:
https://github.com/Rust-for-Linux/linux

For what it's worth, I was able to get the V4L2 Rust sample probed
pretty easily following the quick start instructions
https://docs.kernel.org/rust/quick-start.html

Cool to see this working!
Deb

> 
> Lastly, the origins of this series trace back to a v4l2 virtIO driver I
> was writing in Rust. As the project was eventually shelved for other
> reasons, I picked both the virtIO and the v4l2 bindings into their own
> patches which I am now in the process of submitting. This is to say that
> I tested this code with said driver and CrosVM in the past, and it
> worked ok.
> 
> Please let me know your thoughts.
> 
> [0]: https://gitlab.collabora.com/dmitry.osipenko/linux-kernel-rd/-/commit/055a2c322e931a8b388f864f1db81bbdfd525602
> 
> Daniel Almeida (6):
>   rust: media: add the media module
>   rust: media: add initial videodev2.h abstractions
>   rust: sync: introduce FfiMutex
>   rust: media: videobuf2: add a videobuf2 abstraction
>   rust: media: add {video|v4l2}_device_register support
>   rust: media: add v4l2 rust sample
> 
>  rust/bindings/bindings_helper.h        |   8 +
>  rust/kernel/lib.rs                     |   2 +
>  rust/kernel/media/mod.rs               |   6 +
>  rust/kernel/media/v4l2/capabilities.rs |  80 ++++
>  rust/kernel/media/v4l2/dev.rs          | 369 +++++++++++++++
>  rust/kernel/media/v4l2/device.rs       | 115 +++++
>  rust/kernel/media/v4l2/enums.rs        | 135 ++++++
>  rust/kernel/media/v4l2/format.rs       | 178 ++++++++
>  rust/kernel/media/v4l2/framesize.rs    | 176 +++++++
>  rust/kernel/media/v4l2/inputs.rs       | 104 +++++
>  rust/kernel/media/v4l2/ioctls.rs       | 608 +++++++++++++++++++++++++
>  rust/kernel/media/v4l2/mmap.rs         |  81 ++++
>  rust/kernel/media/v4l2/mod.rs          |  13 +
>  rust/kernel/media/videobuf2/core.rs    | 552 ++++++++++++++++++++++
>  rust/kernel/media/videobuf2/mod.rs     |   5 +
>  rust/kernel/sync.rs                    |   1 +
>  rust/kernel/sync/ffi_mutex.rs          |  70 +++
>  samples/rust/Kconfig                   |  11 +
>  samples/rust/Makefile                  |   1 +
>  samples/rust/rust_v4l2.rs              | 403 ++++++++++++++++
>  20 files changed, 2918 insertions(+)
>  create mode 100644 rust/kernel/media/mod.rs
>  create mode 100644 rust/kernel/media/v4l2/capabilities.rs
>  create mode 100644 rust/kernel/media/v4l2/dev.rs
>  create mode 100644 rust/kernel/media/v4l2/device.rs
>  create mode 100644 rust/kernel/media/v4l2/enums.rs
>  create mode 100644 rust/kernel/media/v4l2/format.rs
>  create mode 100644 rust/kernel/media/v4l2/framesize.rs
>  create mode 100644 rust/kernel/media/v4l2/inputs.rs
>  create mode 100644 rust/kernel/media/v4l2/ioctls.rs
>  create mode 100644 rust/kernel/media/v4l2/mmap.rs
>  create mode 100644 rust/kernel/media/v4l2/mod.rs
>  create mode 100644 rust/kernel/media/videobuf2/core.rs
>  create mode 100644 rust/kernel/media/videobuf2/mod.rs
>  create mode 100644 rust/kernel/sync/ffi_mutex.rs
>  create mode 100644 samples/rust/rust_v4l2.rs
> 
> -- 
> 2.40.0
> 
