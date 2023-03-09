Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622366B1B15
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjCIGE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCIGE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:04:26 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B9987D8B;
        Wed,  8 Mar 2023 22:04:24 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id E42A342037;
        Thu,  9 Mar 2023 06:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1678341862;
        bh=yXH1tZdsDmO++xIlBpu0JLuAAbte1OW7AlybHK5hIBg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=L26euRJ0eRSChLfBBV+IWoJpXejfXnHpxYL7EKKxQNfNY3MHWKaHrZ0sXQwYPrYjl
         j0hAICH5fd0yIi9MUnBCGQJ2J/6Qbc2vaFXhPzja0rtJkPaOT0D6BVUaDh2KleQjJb
         V9Q8BguecZBBMPvATXnO5AmpObEALYXxJDP4XlSvevTfXkmhlRxHWnw8QuunLcXUOm
         YrZoEGe/la+xsrlvECQsvt7d+kil4hHLFigx8YmCEzkKb1Y6ouadywOXrPImwCCfU5
         EkNVKQwuFJFHWt9UWr30hoU/WCszEJG2VRApZSuCsQz88fGHJUdoD9Yew/iCxUuDC7
         BTptPp5MzKzeg==
Message-ID: <11ce9291-c17f-e73d-fb5d-13d5386fe6be@asahilina.net>
Date:   Thu, 9 Mar 2023 15:04:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RFC 01/18] rust: drm: ioctl: Add DRM ioctl abstraction
Content-Language: en-US
To:     =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Karol Herbst <kherbst@redhat.com>,
        Ella Stanforth <ella@iglunix.org>,
        Faith Ekstrand <faith.ekstrand@collabora.com>,
        Mary <mary@mary.zone>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-sgx@vger.kernel.org, asahi@lists.linux.dev
References: <20230307-rust-drm-v1-0-917ff5bc80a8@asahilina.net>
 <20230307-rust-drm-v1-1-917ff5bc80a8@asahilina.net>
 <D9Cyx-9kbjaeb8QVBFqapDyctoDdVyu5uXEJDR41sdXUDXM1VgdRicV5huJDwfC3-T2J-R_DYHH8JZ1_aRdgbeYZFT78J9QveeeYbiTq4yU=@protonmail.com>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <D9Cyx-9kbjaeb8QVBFqapDyctoDdVyu5uXEJDR41sdXUDXM1VgdRicV5huJDwfC3-T2J-R_DYHH8JZ1_aRdgbeYZFT78J9QveeeYbiTq4yU=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 02.34, Björn Roy Baron wrote:
>> +                            // SAFETY: This is just the ioctl argument, which hopefully has the right type
>> +                            // (we've done our best checking the size).
> 
> In the rust tree there is the ReadableFromBytes [1] trait which indicates that it is safe to read arbitrary bytes into the type. Maybe you could add it as bound on the argument type when it lands in rust-next? This way you can't end up with for example a struct containing a bool with the byte value 2, which is UB.

There's actually a much bigger story here, because that trait isn't
really very useful without a way to auto-derive it. I need the same kind
of guarantee for all the GPU firmware structs...

There's one using only declarative macros [1] and one using proc macros
[2]. And then, since ioctl arguments are declared in C UAPI header
files, we need a way to be able to derive those traits for them... which
I guess means bindgen changes?

For now though, I don't think this is something we need to worry about
too much for this particular use case because the macro forces all
struct types to be part of `bindings`, and any driver UAPI should
already follow these constraints if it is well-formed (and UAPIs are
going to already attract a lot of scrutiny anyway). Technically you
could try taking a random kernel struct containing a `bool` in an ioctl
list, but that would stand out as nonsense just as much as trying to
unsafe impl ReadableFromBytes for it so... it's kind of an academic
problem ^^

Actually, I think we talked of moving UAPI types to a separate crate (so
drivers can get access to those types and only those types, not the main
bindings crate). Then maybe we could just say that if the macro forces
the type to be from that crate, it's inherently safe since all UAPIs
should already be castable to/from bytes if properly designed.

Aside: I'm not sure the ReadableFromBytes/WritableToBytes distinction is
very useful. I know it exists (padding bytes, uninit fields, and
technically bool should be WritableToBytes but not ReadableFromBytes),
but I can't think of a good use case for it... I think I'd rather start
with a single trait and just always enforce the union of the rules,
because pretty much any time you're casting to/from bytes you want
well-defined "bag of bytes" struct layouts anyway. ioctls can be R/W/RW
so having separate traits depending on ioctl type complicates the code...

[1]
https://github.com/QubesOS/qubes-gui-rust/blob/940754bfefb7325548eece658c307a0c41c9bc7c/qubes-castable/src/lib.rs
[2] https://docs.rs/pkbuffer/latest/pkbuffer/derive.Castable.html

> 
> https://rust-for-linux.github.io/docs/kernel/io_buffer/trait.ReadableFromBytes.html [1]
> 

~~ Lina
