Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ED0747D36
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjGEGlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjGEGlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:41:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7115B1700;
        Tue,  4 Jul 2023 23:41:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F08B36144E;
        Wed,  5 Jul 2023 06:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3662C433C8;
        Wed,  5 Jul 2023 06:41:00 +0000 (UTC)
Message-ID: <d0ae9e77-cd3a-6ed1-1f99-104d10de9fba@xs4all.nl>
Date:   Wed, 5 Jul 2023 08:40:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
Content-Language: en-US
To:     Daniel Almeida <daniel.almeida@collabora.com>, wedsonaf@gmail.com,
        ojeda@kernel.org, mchehab@kernel.org
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230406215615.122099-1-daniel.almeida@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 06/04/2023 23:56, Daniel Almeida wrote:
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
> 
> Lastly, the origins of this series trace back to a v4l2 virtIO driver I
> was writing in Rust. As the project was eventually shelved for other
> reasons, I picked both the virtIO and the v4l2 bindings into their own
> patches which I am now in the process of submitting. This is to say that
> I tested this code with said driver and CrosVM in the past, and it
> worked ok.
> 
> Please let me know your thoughts.

Based on our discussions during the Media Summit I am going to mark this
series as RFC in patchwork.

Once we have a new maintenance process up and running and things have
stabilized on that front, then this can be revisited, but by that time
it is better to post a v2, rebased and updated.

Regards,

	Hans

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

