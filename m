Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FA0663D11
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbjAJJix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238312AbjAJJip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:38:45 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8906496F3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:38:44 -0800 (PST)
Received: from [192.168.2.154] (unknown [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D10C96602D6F;
        Tue, 10 Jan 2023 09:38:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673343523;
        bh=y621n6SK+X9Nfr6zTaXGBH56ErBaS4V28NM92YYWqYY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BZgAAaz75Le5OkwMuhF1zfEasbE1EvqMpyM+kkIhWn0GEzctXKCICHmiL2Mav/6kO
         YogJJ5YSFCnrSiKiWmQP65FHgKacrPwUDyVyyu8AJtwN13TBzE34S8zmpClQSTL4L+
         ytl41dkfZKa9zOnp6c/L5+kJYogq7Cv3vZFVXwJF7t0gZbiq8Xf4lbvHPkYPJRd0oq
         1Dpe63Q7q8EeTURYHqV9Q6auxbxxWhooRpWPPldSriYoxgOe5azGmDpadfWJ88kvL1
         E5GIvgqzRlSh67dZboEF0119M19z/CawR3YYwewbAZbqyVw8kuSQlz/zCilIV1jdUp
         aTrrZanoexwVg==
Message-ID: <36bbc210-9f8c-ac18-9322-110949b746cb@collabora.com>
Date:   Tue, 10 Jan 2023 12:38:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] drm/virtio: Fix GEM handle creation UAF
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@redhat.com>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
References: <20221216233355.542197-1-robdclark@gmail.com>
 <20221216233355.542197-2-robdclark@gmail.com>
 <3ae74f28-580b-3b53-3d7b-e8bde97dabe3@collabora.com>
 <CAF6AEGvGb66L7cXod40PiKijJRTCOhWL+qCz4bgmi-69ZxJt8Q@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAF6AEGvGb66L7cXod40PiKijJRTCOhWL+qCz4bgmi-69ZxJt8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/23 04:47, Rob Clark wrote:
> On Mon, Jan 9, 2023 at 3:28 PM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>>
>> On 12/17/22 02:33, Rob Clark wrote:
>>> From: Rob Clark <robdclark@chromium.org>
>>>
>>> Userspace can guess the handle value and try to race GEM object creation
>>> with handle close, resulting in a use-after-free if we dereference the
>>> object after dropping the handle's reference.  For that reason, dropping
>>> the handle's reference must be done *after* we are done dereferencing
>>> the object.
>>>
>>> Signed-off-by: Rob Clark <robdclark@chromium.org>
>>> ---
>>>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 19 +++++++++++++++++--
>>>  1 file changed, 17 insertions(+), 2 deletions(-)
>>
>> Added fixes/stable tags and applied this virtio-gpu patch to misc-fixes.
>> The Panfrost patch is untouched.
> 
> Thanks.. the panfrost patch was not intended to be part of the same
> series (but apparently that is what happens when I send them at the
> same time), and was superceded by a patch from Steven Price (commit
> 4217c6ac8174 ("drm/panfrost: Fix GEM handle creation ref-counting")
> already applied to misc-fixes

Okay, I wanted to make clear what has been applied.

-- 
Best regards,
Dmitry

