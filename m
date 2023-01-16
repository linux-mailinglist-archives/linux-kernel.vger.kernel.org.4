Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBBC66BB12
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjAPKAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjAPKAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:00:18 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C546A5D4;
        Mon, 16 Jan 2023 02:00:17 -0800 (PST)
Received: from [192.168.0.192] (unknown [194.146.248.75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 06DC36602AA1;
        Mon, 16 Jan 2023 10:00:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673863205;
        bh=bteXBz8BLiztEyL7HtssVPl+baNjigI3gWj/ST9tDa0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aJYKfJiPhFWcCppJFPrl60DfbWgsRc7GY6t2GzHT4tus3wVdBiou5+4Gfjcuh2923
         EHmu3YIfHo+vaBf2UgnGJU/y3DEV9nNY7dqJJ8vvIqRO5GcSjTVeSNwAQbJ6NarlEQ
         qV2UvlqPbYYT+ExP8u0WX78BEpcMbcCdNAN4PMok/VvFvPwfhH7YhvLR2l0VU3eGgm
         eDDROmNA0L1IDkiJwg3VN2+QiVzODbQSDSJzWI12aIP1lOyK8cJ2hV6rydebPKDBNY
         ZHnvqyKtNUwjUXfyjVQtiIczAgQzJc67pcyb/I9+wGCu8Zb/VTMOGwsI/OhnbyMoXf
         zHRMLpDD3qLoA==
Message-ID: <075169b4-3c6a-2379-0dc9-34b89fb83ef1@collabora.com>
Date:   Mon, 16 Jan 2023 11:00:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 05/12] staging: media: rkvdec: Add SPS structure to
 internal context
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        Jonas Karlman <jonas@kwiboo.se>,
        Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Collabora Kernel-domain <kernel@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
References: <20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com>
 <20230101-patch-series-v2-6-2-rc1-v2-5-fa1897efac14@collabora.com>
 <CAAEAJfDqXJf-UovhGnmN7FDY-skSu-x5Rgz+K2WVQP+PKUVbsQ@mail.gmail.com>
Content-Language: en-US
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <CAAEAJfDqXJf-UovhGnmN7FDY-skSu-x5Rgz+K2WVQP+PKUVbsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

W dniu 12.01.2023 o 16:02, Ezequiel Garcia pisze:
> Hi Sebastian,
> 
> On Thu, Jan 12, 2023 at 9:56 AM Sebastian Fricke
> <sebastian.fricke@collabora.com> wrote:
>>
>> Prepare storing the SPS structure for HEVC & H264 in the internal
>> context of the rkvdec instance. This structure is used to figure out
>> which capture queue format is appropriate for decoding.
>>
>> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
>> ---
>>   drivers/staging/media/rkvdec/rkvdec.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/staging/media/rkvdec/rkvdec.h b/drivers/staging/media/rkvdec/rkvdec.h
>> index 633335ebb9c4..332126e7b812 100644
>> --- a/drivers/staging/media/rkvdec/rkvdec.h
>> +++ b/drivers/staging/media/rkvdec/rkvdec.h
>> @@ -105,6 +105,7 @@ struct rkvdec_ctx {
>>          struct v4l2_ctrl_handler ctrl_hdl;
>>          struct rkvdec_dev *dev;
>>          void *priv;
>> +       void *sps;
> 
> I don't really like re-caching the SPS in the context,
> since all the controls are already stored in the context,
> via the ctrl_handler.
> 
> See hantro_get_ctrl().
> 
> Duplicating state can lead to problems and even if we get it
> right this time, will be hard to maintain.
> 

Also, just looking at this patch is seems a bit too fine-grained
a change to add a member to a driver-internal struct and have no
users at the same time. OTOH Ezequiel has easily spotted it :D

Andrzej

> Thanks,
> Ezequiel
> 
>>   };
>>
>>   static inline struct rkvdec_ctx *fh_to_rkvdec_ctx(struct v4l2_fh *fh)
>>
>> --
>> 2.25.1

