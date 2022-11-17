Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16DC62E31E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbiKQRdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiKQRdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:33:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0DF7991B;
        Thu, 17 Nov 2022 09:33:02 -0800 (PST)
Received: from [192.168.2.32] (109-252-117-140.nat.spd-mgts.ru [109.252.117.140])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B443166015AC;
        Thu, 17 Nov 2022 17:33:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668706381;
        bh=cedBJtYyiA9dCMinWRYLl88BHzqlXi2cVMCMxrRsTgo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R86+NjxG77C4ypDUckAAkObDhwFfW8LsXLyziX+YDeVo9NJcK+pvp2Ku7DowgFCbn
         NSSG+Z6FPLAkr7zIPD9w0ejv0e3TIonPbWMRULexD+DWsCafXY1vF/aHtkfHIZoMcK
         PvP1EbICeFzCEoevJDaBIhHXXRcq4FCtcWT4A+RJ4y+ljL/zZo/44q/RpG9EHJZsjV
         2CtyicOGXpvG5b2cuWTc6be328u6R51RN7gBhayk+aF7AmkuXdoKqQGIdAIBXf6haL
         uDTWUdi/5Q7pXQf2qYzqS3GbfFeQCjLbvy+gp3ZVsNRAE/bnyasV7R3xk0LdnVGWk/
         +sE4rG2SpbxZg==
Message-ID: <cd382f43-1995-12a6-840b-32450e62f9f4@collabora.com>
Date:   Thu, 17 Nov 2022 20:32:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4] udmabuf: add vmap and vunmap methods to udmabuf_ops
Content-Language: en-US
To:     Lukasz Wiecaszek <lukasz.wiecaszek@googlemail.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20221117045842.27161-1-lukasz.wiecaszek@gmail.com>
 <970e798d-ea26-5e1e-ace8-7915a866f7c7@collabora.com>
 <20221117170838.GA74987@thinkpad-p72>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20221117170838.GA74987@thinkpad-p72>
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

On 11/17/22 20:08, Lukasz Wiecaszek wrote:
> On Thu, Nov 17, 2022 at 12:04:35PM +0300, Dmitry Osipenko wrote:
>> Hi,
>>
>> On 11/17/22 07:58, Lukasz Wiecaszek wrote:
>>> The reason behind that patch is associated with videobuf2 subsystem
>>> (or more genrally with v4l2 framework) and user created
>>> dma buffers (udmabuf). In some circumstances
>>> when dealing with V4L2_MEMORY_DMABUF buffers videobuf2 subsystem
>>> wants to use dma_buf_vmap() method on the attached dma buffer.
>>> As udmabuf does not have .vmap operation implemented,
>>> such dma_buf_vmap() natually fails.
>>>
>>> videobuf2_common: __vb2_queue_alloc: allocated 3 buffers, 1 plane(s) each
>>> videobuf2_common: __prepare_dmabuf: buffer for plane 0 changed
>>> videobuf2_common: __prepare_dmabuf: failed to map dmabuf for plane 0
>>> videobuf2_common: __buf_prepare: buffer preparation failed: -14
>>>
>>> The patch itself seems to be strighforward.
>>> It adds implementation of .vmap and .vunmap methods
>>> to 'struct dma_buf_ops udmabuf_ops'.
>>> .vmap method itself uses vm_map_ram() to map pages linearly
>>> into the kernel virtual address space.
>>> .vunmap removes mapping created earlier by .vmap.
>>> All locking and 'vmapping counting' is done in dma_buf.c
>>> so it seems to be redundant/unnecessary in .vmap/.vunmap.
>>>
>>> Signed-off-by: Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>
>>
>> If new patch version doesn't contain significant changes and you got
>> acks/reviews for the previous version, then you should add the given
>> acked-by and reviewed-by tags to the commit message by yourself.
>>
>> -- 
>> Best regards,
>> Dmitry
>>
> 
> I would like to thank you all for your patience and on the same time say
> sorry that I still cannot follow the process (although I have read
> 'submitting patches' chapter).

If you'll continue to contribute actively, you'll find things that
aren't documented at all. Don't worry about it, usually somebody will
tell you about what's missing. Just apply the new knowledge next time ;)

-- 
Best regards,
Dmitry

