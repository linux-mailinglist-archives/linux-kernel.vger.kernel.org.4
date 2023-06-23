Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9FC73B219
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjFWHvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjFWHve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:51:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F3B10D;
        Fri, 23 Jun 2023 00:51:33 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:4849:8b52:4bff:674] (unknown [IPv6:2a01:e0a:120:3210:4849:8b52:4bff:674])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EB293660712B;
        Fri, 23 Jun 2023 08:51:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687506692;
        bh=IXSG7zZWbP+AwYQOLnWcF9xBZeJYynGpMRfo2WLgtCg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=opJS58tLdQU7YgNFJUmqNjtvNi91rAm2bjUy5XSJTziw0Kzbhy0CJ0UUak/xI7jgL
         vx4+DOqhd4m2VeH5sfQokwGGD0g6ZmWRimqlB7E+W+uPcKyTPWaekM7ENeW/FT6PV4
         VFIQejfKUdiTG98Hi5h+j1pc3nPu1gW7ynHnEQ8bXu5/MAP6RkFjaoRDX08emZ3sEw
         Vu8z8i1m5gQ9bpjSIh6QvkNJS6E8nWRkeGXOe1Dxegk+Xq+fkyHdtozWTz7CfS+HPL
         QCftKOh1hkTTKqzuc+w9+1m53HCjE+sXCTihxVYdk9QnB35uWZW57tDSvK3DFJOb6F
         BVFs/E+zgUpGQ==
Message-ID: <fee4a434-a4b6-9ecc-1188-4638a3cd6af8@collabora.com>
Date:   Fri, 23 Jun 2023 09:51:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 03/11] media: videobuf2: Remove VB2_MAX_FRAME limit on
 buffer storage
Content-Language: en-US
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        nicolas.dufresne@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20230622131349.144160-1-benjamin.gaignard@collabora.com>
 <20230622131349.144160-4-benjamin.gaignard@collabora.com>
 <bddd6cb7-cd72-4fb5-8d4a-d02cb9c46dce@kadam.mountain>
 <39aff680-316a-7382-c93b-d9ca61c389e9@collabora.com>
 <f21d6fce-155c-28f0-fdea-e9264ba1f7ba@xs4all.nl>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <f21d6fce-155c-28f0-fdea-e9264ba1f7ba@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 23/06/2023 à 09:02, Hans Verkuil a écrit :
> On 22/06/2023 16:13, Benjamin Gaignard wrote:
>> Le 22/06/2023 à 16:11, Dan Carpenter a écrit :
>>> On Thu, Jun 22, 2023 at 03:13:41PM +0200, Benjamin Gaignard wrote:
>>>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
>>>> index f1ff7af34a9f..86e1e926fa45 100644
>>>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>>>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>>>> @@ -455,9 +455,9 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>>>>        struct vb2_buffer *vb;
>>>>        int ret;
>>>>    -    /* Ensure that q->num_buffers+num_buffers is below VB2_MAX_FRAME */
>>>> +    /* Ensure that q->num_buffers + num_buffers is UINT_MAX */
>>>>        num_buffers = min_t(unsigned int, num_buffers,
>>>> -                VB2_MAX_FRAME - q->num_buffers);
>>>> +                UINT_MAX - q->num_buffers);
>>>>          for (buffer = 0; buffer < num_buffers; ++buffer) {
>>>>            /* Allocate vb2 buffer structures */
>>> Ah...  Here's one of the integer overflow bugs I was talking about.  The
>>> __vb2_queue_alloc() function returns an int so if num_buffers goes over
>>> INT_MAX we are hosed.
>> I will limit it to:
>> #define VB2_QUEUE_MAX_BUFFERS  (INT_MAX & PAGE_MASK)  /* The mask prevents 85% of integer overflows */
>> as you have suggest it.
> IMHO INT_MAX is way overkill. How about (1U << 20)? I would like some sort of
> sanity check here. 1048576 buffers of 640x480 and 4 bytes per pixel is 1.2 TB.

I will go for (1U << 20) in next version.

Regards,
Benjamin

>
> Since a TB of memory is doable these days, I think this is a reasonable
> value for MAX_BUFFERS without allowing just anything.
>
> An alternative is to make this a kernel config.
>
> Regards,
>
> 	Hans
>
>> That will be in version 4.
>>
>> Thanks,
>> Benjamin
>>
>>> regards,
>>> dan carpenter
>>>
