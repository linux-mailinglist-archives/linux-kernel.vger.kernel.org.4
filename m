Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62986B8DE7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjCNIz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjCNIzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:55:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBC252905;
        Tue, 14 Mar 2023 01:55:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A061B818A1;
        Tue, 14 Mar 2023 08:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D1BC433D2;
        Tue, 14 Mar 2023 08:55:11 +0000 (UTC)
Message-ID: <e704b505-86d8-c6f2-8546-adccdab72622@xs4all.nl>
Date:   Tue, 14 Mar 2023 09:55:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC 2/4] media: videobuf2: Replace bufs array by a list
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Laurent Pinchart' <laurent.pinchart@ideasonboard.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     "tfiga@chromium.org" <tfiga@chromium.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "ming.qian@nxp.com" <ming.qian@nxp.com>,
        "shijie.qin@nxp.com" <shijie.qin@nxp.com>,
        "eagle.zhou@nxp.com" <eagle.zhou@nxp.com>,
        "bin.liu@mediatek.com" <bin.liu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "tiffany.lin@mediatek.com" <tiffany.lin@mediatek.com>,
        "andrew-ct.chen@mediatek.com" <andrew-ct.chen@mediatek.com>,
        "yunfei.dong@mediatek.com" <yunfei.dong@mediatek.com>,
        "stanimir.k.varbanov@gmail.com" <stanimir.k.varbanov@gmail.com>,
        "quic_vgarodia@quicinc.com" <quic_vgarodia@quicinc.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "ezequiel@vanguardiasur.com.ar" <ezequiel@vanguardiasur.com.ar>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "daniel.almeida@collabora.com" <daniel.almeida@collabora.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "kernel@collabora.com" <kernel@collabora.com>
References: <20230313135916.862852-1-benjamin.gaignard@collabora.com>
 <20230313135916.862852-3-benjamin.gaignard@collabora.com>
 <20230313181155.GC22646@pendragon.ideasonboard.com>
 <86df05244d974416903e919d387a0a0b@AcuMS.aculab.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <86df05244d974416903e919d387a0a0b@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 00:16, David Laight wrote:
> From: Laurent Pinchart
>> Sent: 13 March 2023 18:12
>>
>> Hi Benjamin,
>>
>> Thank you for the patch.
>>
>> On Mon, Mar 13, 2023 at 02:59:14PM +0100, Benjamin Gaignard wrote:
>>> Replacing bufs array by a list allows to remove the 32 buffers
>>> limit per queue.
> 
> Is the limit actually a problem?
> Arrays of pointers have locking and caching advantages over
> linked lists.

I'm not so keen on using a list either. Adding or deleting buffers will
be an infrequency operation, so using an array of pointers and reallocing
it if needed would be perfectly fine. Buffer lookup based on the index
should be really fast, though.

Why not start with a dynamically allocated array of 32 vb2_buffer pointers?
And keep doubling the size (reallocing) whenever more buffers are needed,
up to some maximum (1024 would be a good initial value for that, I think).
This max could be even a module option.

A simple spinlock is sufficient, I think, to regulate access to the
struct vb2_buffer **bufs pointer in vb2_queue. From what I can see it is
not needed in interrupt context (i.e. vb2_buffer_done).

Regards,

	Hans

> 
> ...
>>> @@ -1239,8 +1242,12 @@ static inline void vb2_clear_last_buffer_dequeued(struct vb2_queue *q)
>>>  static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
>>>  						unsigned int index)
>>>  {
>>> -	if (index < q->num_buffers)
>>> -		return q->bufs[index];
>>> +	struct vb2_buffer *vb;
>>> +
>>> +	list_for_each_entry(vb, &q->allocated_bufs, allocated_entry)
>>> +		if (vb->index == index)
>>> +			return vb;
>>> +
>>>  	return NULL;
> 
> You really don't want to be doing that....
> 
> There are schemes for unbounded arrays.
> Scanning a linked list isn't a very good one.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

