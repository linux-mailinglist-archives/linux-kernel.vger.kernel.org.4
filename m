Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7948C6B105F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCHRo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCHRox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:44:53 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701C7498BC;
        Wed,  8 Mar 2023 09:44:52 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id DAE6041DF4;
        Wed,  8 Mar 2023 17:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1678297490;
        bh=fhXB/EYYX9j8qxFHx1ZRx8caCPXojBAtmHMmCPfk7/c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=D8uQBUHl406auUb4dgJPw/yDLp3vQCmgE9+0F5HY1bdli22kwGEGbT4SkxZaMNooS
         ZpLzFCm5pCeALq5rxsxhI4v/XdIR1ZIGHaoDM2on86t0B9wBOopKdlyvAKXzprhS1Q
         HodEPkB7neoFcykRt8Qd+kTERz10lzWtJSVHUoZlnUMVdhM2VjGNIUyhjs+QJEeUlD
         82GrtZJ1mTeafPZkk97TBy0XztQZgjtu7wJdGgymG56KQpHZaU3s8kttKkfv2r/3tu
         fklvJcKvD3EPQlvr9EIXkAT2GCYbGzlBHVw+mNPPPjTXLJMtoNWs2qVp2wEluvsT+a
         5dBzDRJfxskDQ==
Message-ID: <c82660f4-e2d0-35ca-304a-57d1abcf814d@asahilina.net>
Date:   Thu, 9 Mar 2023 02:44:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RFC 11/18] drm/scheduler: Clean up jobs when the scheduler
 is torn down
Content-Language: en-US
To:     alyssa@rosenzweig.io,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Karol Herbst <kherbst@redhat.com>,
        Ella Stanforth <ella@iglunix.org>,
        Faith Ekstrand <faith.ekstrand@collabora.com>,
        Mary <mary@mary.zone>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-sgx@vger.kernel.org, asahi@lists.linux.dev
References: <0f14c1ae-0c39-106c-9563-7c1c672154c0@asahilina.net>
 <20230307-rust-drm-v1-0-917ff5bc80a8@asahilina.net>
 <20230307-rust-drm-v1-11-917ff5bc80a8@asahilina.net>
 <bbd7c5ee-c2f0-3e19-757d-a9aff1a26d3d@linux.intel.com>
 <585fa052-4eff-940e-b307-2415c315686a@amd.com>
 <3320e497-09c0-6eb6-84c5-bab2e63f28ec@asahilina.net>
 <7b39ef96-3ec5-c492-6e1b-bf065b7c90a2@amd.com>
 <8e93126cfaf47ebad0dc70e038ccc92f@rosenzweig.io>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <8e93126cfaf47ebad0dc70e038ccc92f@rosenzweig.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 02.39, alyssa@rosenzweig.io wrote:
>> You can't ask me for a list
>> of pending jobs (the scheduler knows this, it doesn't make any sense to
>> duplicate that outside)
> 
> Silly question: could you add a new exported function to drm_sched to get the list of pending jobs, to be used by the Rust abstraction internally? IDK if that makes any sense.

The drm_sched struct is public, we could just go in there and do it
anyway... but then I need to figure out how to do
`list_for_each_entry_safe` in Rust and this all makes very little sense
when it's clearly the scheduler's job to provide some form of cleanup
function users can use to do it...

I mean, I guess I can do that if Christian is adamantly against
providing a safe C API, but it's clearly not the right solution and I
hope this is not the approach maintainers take with Rust abstractions,
because that's going to make our lives a lot harder for no good reason,
and it also means C users don't get any of the benefits of Rust
abstraction work if the APIs can't be improved at all along with it.

~~ Lina
