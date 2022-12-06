Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A439643EC0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbiLFIfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbiLFIf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:35:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3773A1DA5F;
        Tue,  6 Dec 2022 00:35:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A744B615BE;
        Tue,  6 Dec 2022 08:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60204C433C1;
        Tue,  6 Dec 2022 08:35:01 +0000 (UTC)
Message-ID: <5d79ed06-15c0-3564-97b6-5fd4433acabf@xs4all.nl>
Date:   Tue, 6 Dec 2022 09:34:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] media: cedrus: Convert to MPLANE uAPI
Content-Language: en-US
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     linux-media@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
References: <20221129074530.640251-1-wenst@chromium.org>
 <45143854.fMDQidcC6G@kista>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <45143854.fMDQidcC6G@kista>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2022 22:01, Jernej Škrabec wrote:
> Hi Chen-Yu!
> 
> Dne torek, 29. november 2022 ob 08:45:30 CET je Chen-Yu Tsai napisal(a):
>> The majority of the V4L2 stateless video decoder drivers use the MPLANE
>> interface.
>>
>> On the userspace side, Gstreamer supports non-MPLANE and MPLANE
>> interfaces. Chromium only supports the MPLANE interface, and is not yet
>> usable with standard desktop Linux. FFmpeg support for either has not
>> landed.
> 
> I don't like fixing userspace issues in kernel, if kernel side works fine. 
> Implementing missing non-MPLANE support in Chromium will also allow it to work 
> with older kernels.
> 
> Hans, what's linux-media politics about such changes?

Not keen on this. Does the cedrus HW even have support for multiple planes?
I suspect not, in which case the driver shouldn't suggest that it can do that.

Now, if the hardware *can* support this, then there is an argument to be made
for the cedrus driver to move to the multiplanar API before moving it out
of staging to allow such future enhancements.

Note that you have to choose whether to support single or multiplanar, you
can't support both at the same time.

So the decision to move to multiplanar should be led by the HW capabilities.

And Chromium really needs to support non-multiplanar formats as well. I'm
really surprised to hear that it doesn't, to be honest.

Regards,

	Hans

> 
> Best regards,
> Jernej
> 
>>
>> A fallback route using libv4l is also available. The library translates
>> MPLANE interface ioctl calls to non-MPLANE ones, provided that the pixel
>> format used is single plane.
>>
>> Convert the Cedrus driver to the MPLANE interface, while keeping the
>> supported formats single plane. Besides backward compatibility through
>> the plugin, the hardware requires that different planes not be located
>> too far apart in memory. Keeping the single plane pixel format makes
>> this easy to enforce.
>>
>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>> ---
>>
>> This has been tested with Fluster. The score remained the same with or
>> without the patch. This also helps with getting VP8 decoding working
>> with Chromium's in-tree test program "video_decode_accelerator_tests",
>> though Chromium requires other changes regarding buffer allocation and
>> management.
> 
> 

