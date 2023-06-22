Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B512B73A2BA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjFVONY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjFVONV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:13:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1B919A6;
        Thu, 22 Jun 2023 07:13:19 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:7d72:676c:e745:a6ef] (unknown [IPv6:2a01:e0a:120:3210:7d72:676c:e745:a6ef])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 967E866070DD;
        Thu, 22 Jun 2023 15:13:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687443198;
        bh=d0+lITGrVZq3i8JXW6FpYpEa1ZDzGHWdfubAbMUC1X8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=noqEqmkRmxOoXU6FxKMZXfXVgKNpqEz7La+dfkLvLpo51iTqrXgVpYYmA9lHaIk8Z
         a9ovq548hSIXu9e8qKs1bROyPWpBZwaBa5LqlGujvfHK2DkXlCAhq9OL25Au0QPjYe
         ca/gkQ8ZeY8t/k+bCfnpWmR08WFtB8OibJRFpxK1fjvvx1F9G2lhSOtyCeGVvvFNrf
         k9OuRBLOk0arhpHcIWGqHkqkgH88lhJU3k2giewHcySacS/Hv1m0NslVJ8vw7nRa5e
         wbJMX6ZJleoGuStEi7wf/q8k8VbqAWDODZP6/POXkgFhE9VZO+SJULFs9sB447XAua
         RQXxI0W5WRDmw==
Message-ID: <39aff680-316a-7382-c93b-d9ca61c389e9@collabora.com>
Date:   Thu, 22 Jun 2023 16:13:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 03/11] media: videobuf2: Remove VB2_MAX_FRAME limit on
 buffer storage
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20230622131349.144160-1-benjamin.gaignard@collabora.com>
 <20230622131349.144160-4-benjamin.gaignard@collabora.com>
 <bddd6cb7-cd72-4fb5-8d4a-d02cb9c46dce@kadam.mountain>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <bddd6cb7-cd72-4fb5-8d4a-d02cb9c46dce@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 22/06/2023 à 16:11, Dan Carpenter a écrit :
> On Thu, Jun 22, 2023 at 03:13:41PM +0200, Benjamin Gaignard wrote:
>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
>> index f1ff7af34a9f..86e1e926fa45 100644
>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>> @@ -455,9 +455,9 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>>   	struct vb2_buffer *vb;
>>   	int ret;
>>   
>> -	/* Ensure that q->num_buffers+num_buffers is below VB2_MAX_FRAME */
>> +	/* Ensure that q->num_buffers + num_buffers is UINT_MAX */
>>   	num_buffers = min_t(unsigned int, num_buffers,
>> -			    VB2_MAX_FRAME - q->num_buffers);
>> +			    UINT_MAX - q->num_buffers);
>>   
>>   	for (buffer = 0; buffer < num_buffers; ++buffer) {
>>   		/* Allocate vb2 buffer structures */
> Ah...  Here's one of the integer overflow bugs I was talking about.  The
> __vb2_queue_alloc() function returns an int so if num_buffers goes over
> INT_MAX we are hosed.

I will limit it to:
#define VB2_QUEUE_MAX_BUFFERS  (INT_MAX & PAGE_MASK)  /* The mask prevents 85% of integer overflows */
as you have suggest it.

That will be in version 4.

Thanks,
Benjamin

>
> regards,
> dan carpenter
>
