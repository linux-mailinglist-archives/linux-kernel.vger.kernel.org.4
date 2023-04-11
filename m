Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CA76DD49F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 09:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjDKHvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 03:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjDKHvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 03:51:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394D1B9;
        Tue, 11 Apr 2023 00:51:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C852B61BCD;
        Tue, 11 Apr 2023 07:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D739C433D2;
        Tue, 11 Apr 2023 07:51:08 +0000 (UTC)
Message-ID: <136035a4-26df-1c14-e51e-406b4ee5fe33@xs4all.nl>
Date:   Tue, 11 Apr 2023 09:51:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
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
X-Spam-Status: No, score=-5.3 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

I think this could be a good topic to discuss at the upcoming media summit:

https://lore.kernel.org/linux-media/893a7e34-1d98-23e2-4d27-d25cb3ee5bf0@xs4all.nl/

Please reply to that message with a topic description if you are interested.

One of my main concerns here is time: as subsystem maintainers we can barely
keep up with all the incoming patches. Introducing support for a new language
would add only more pressure. Even though these are mainly bindings (as I
understand it), this would still require that every change to a C kAPI is
duplicated in rust, requiring someone to do that work, and have maintainers
with enough rust knowledge to verify it.

And just reading about a new programming language is not enough to be able to
properly review code: that requires far more experience IMHO. The only way
to acquire that experience is by writing non-trivial drivers in rust.

And that in turn takes a lot of time. Which we do not have.

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

