Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA696B3687
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 07:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCJGVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 01:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjCJGVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 01:21:33 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126BCF28B1;
        Thu,  9 Mar 2023 22:21:30 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 9B5B74249A;
        Fri, 10 Mar 2023 06:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1678429288;
        bh=Su293xjC7HJqrmGn5asY9TEfKOlU5jJ/KKsqfzIhcss=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=R8QzFV6o2vdGKfZFYwqrGUzUpvt8V7mpifvkivq1CdeGZ81gA6szdX2TQLPZg1Vis
         ZUOnngxZUqRjp4CnEs/t36DNw2yaJ2YA34h0XwBMVKpx/9VfRrsFj3/zWM/9bnSZ4H
         XAMA8AE6bhaTutEre8t+wC8UJWNuMceDib/bF8LxFY4yjzQXZLl/3LgFi03CLOyyaJ
         4PyYU9fuNnkvWgswLo5icJqYJj/izs+JCuco33/A71lxWqAXX5z9VLtuFKa+ZcEZgH
         tNW+/koH3ycaNXbShllRhrmoNIQQGA33VS2nh34xCXGQBNMbzbd+m11IWKd6CL/kRl
         yQvngLiAhJMhA==
Message-ID: <b61d0b3e-fc10-be79-1b37-6c7aa278d75f@asahilina.net>
Date:   Fri, 10 Mar 2023 15:21:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RFC 01/18] rust: drm: ioctl: Add DRM ioctl abstraction
Content-Language: en-US
To:     Karol Herbst <kherbst@redhat.com>,
        Faith Ekstrand <faith.ekstrand@collabora.com>
Cc:     =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
        Ella Stanforth <ella@iglunix.org>, Mary <mary@mary.zone>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        rust-for-linux@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-sgx@vger.kernel.org,
        asahi@lists.linux.dev
References: <20230307-rust-drm-v1-0-917ff5bc80a8@asahilina.net>
 <20230307-rust-drm-v1-1-917ff5bc80a8@asahilina.net>
 <D9Cyx-9kbjaeb8QVBFqapDyctoDdVyu5uXEJDR41sdXUDXM1VgdRicV5huJDwfC3-T2J-R_DYHH8JZ1_aRdgbeYZFT78J9QveeeYbiTq4yU=@protonmail.com>
 <11ce9291-c17f-e73d-fb5d-13d5386fe6be@asahilina.net>
 <c9e0c6fdcd642192a59a2fea95941a773ea7b3e3.camel@collabora.com>
 <CACO55tukF-+HWUHve0YUPbq4jPFgU3szuedKLjAw55h_3uX5gg@mail.gmail.com>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <CACO55tukF-+HWUHve0YUPbq4jPFgU3szuedKLjAw55h_3uX5gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2023 05.39, Karol Herbst wrote:
> On Thu, Mar 9, 2023 at 9:24 PM Faith Ekstrand
> <faith.ekstrand@collabora.com> wrote:
>>
>> On Thu, 2023-03-09 at 15:04 +0900, Asahi Lina wrote:
>>> On 08/03/2023 02.34, Björn Roy Baron wrote:
>>>>> +                            // SAFETY: This is just the ioctl
>>>>> argument, which hopefully has the right type
>>>>> +                            // (we've done our best checking the
>>>>> size).
>>>>
>>>> In the rust tree there is the ReadableFromBytes [1] trait which
>>>> indicates that it is safe to read arbitrary bytes into the type.
>>>> Maybe you could add it as bound on the argument type when it lands
>>>> in rust-next? This way you can't end up with for example a struct
>>>> containing a bool with the byte value 2, which is UB.
>>>
>>> There's actually a much bigger story here, because that trait isn't
>>> really very useful without a way to auto-derive it. I need the same
>>> kind
>>> of guarantee for all the GPU firmware structs...
>>>
>>> There's one using only declarative macros [1] and one using proc
>>> macros
>>> [2]. And then, since ioctl arguments are declared in C UAPI header
>>> files, we need a way to be able to derive those traits for them...
>>> which
>>> I guess means bindgen changes?
>>
>> It'd be cool to be able to auto-verify that uAPI structs are all
>> tightly packed and use the right subset of types.  Maybe not possible
>> this iteration but it'd be cool to see in future.  I'd like to see it
>> for C as well, ideally.
>>
>> ~Faith
>>
> 
> I'm sure that with a macro you could verify that a struct definition
> doesn't contain any gaps, just not sure on how one would enforce that.
> Could add a trait which can only be implemented through a proc_macro?
> Maybe we can have a proc_macro ensuring no gaps? Would be cool tech to
> have indeed.

You just make the trait unsafe, as usual, then implement it via that
macro. It's how the things I linked work ^^

The tricky thing with C UAPI definitions is just that we need to get
bindgen to emit those macro instantiations around struct definitions
somehow. Or maybe it could be done with a brute force text-based
postprocessing pass? If we put all UAPI defs into their own crate, you
could probably just do it with sed or a python script or something on
the bindgen output to add it for all struct types...

@Rust folks: Should I try creating a uapi crate for this? I think we can
just mirror the bindings crate logic, and we don't need helpers or
anything like that here, so it shouldn't be very difficult. Then I could
(eventually) eliminate all usage of the full bindings crate in the
driver, and also try experimenting with stuff like this to validate all
UAPI types and implement special traits for them...

~~ Lina
