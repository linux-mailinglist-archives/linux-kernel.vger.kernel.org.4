Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8B46C8104
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjCXPSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjCXPSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:18:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0199CA0B;
        Fri, 24 Mar 2023 08:18:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75B9C62B74;
        Fri, 24 Mar 2023 15:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6113C433D2;
        Fri, 24 Mar 2023 15:18:10 +0000 (UTC)
Message-ID: <68ba7b3f-57f5-3969-5036-2c8d08273548@xs4all.nl>
Date:   Fri, 24 Mar 2023 16:18:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC 2/4] media: videobuf2: Replace bufs array by a list
Content-Language: en-US
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        "tfiga@chromium.org" <tfiga@chromium.org>,
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
 <e704b505-86d8-c6f2-8546-adccdab72622@xs4all.nl>
 <dc04d48e34ed40e58f43badd001a81d0@AcuMS.aculab.com>
 <cbf34cf1-e065-8136-8344-89ca1864f637@xs4all.nl>
 <20230319233358.GD20234@pendragon.ideasonboard.com>
 <f085aa9225c573df906bdc7ff032a8fd591b18b3.camel@ndufresne.ca>
 <20230322150153.GO20234@pendragon.ideasonboard.com>
 <2d6480e36ce061a63440d1e11d52b02e57ba746d.camel@ndufresne.ca>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <2d6480e36ce061a63440d1e11d52b02e57ba746d.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2023 16:14, Nicolas Dufresne wrote:
> Le mercredi 22 mars 2023 à 17:01 +0200, Laurent Pinchart a écrit :
>> On Wed, Mar 22, 2023 at 10:50:52AM -0400, Nicolas Dufresne wrote:
>>> Hi Laurent,
>>>
>>> Le lundi 20 mars 2023 à 01:33 +0200, Laurent Pinchart a écrit :
>>>>> The typical usage is that applications allocate N buffers with the
>>>>> VIDIOC_REQBUFS ioctl, and in most cases that's all they use.
>>>>
>>>> Note that once we get DELETE_BUF (or DELETE_BUFS) support I'd like to
>>>> encourage applications to use the new API, and deprecate REQBUFS
>>>> (dropping it isn't on my radar, as it would take forever before no
>>>> userspace uses it anymore).
>>>
>>> I was wondering if you can extend on this. I'm worried the count semantic might
>>> prevent emulating it over create_bufs() ops, but if that works, did you meant to
>>> emulate it so driver no longer have to implement reqbufs() if they have
>>> create_bufs() ?
>>
>> For drivers it should be fairly simply, as the reqbufs and create_bufs
>> ioctl handlers should just point to the corresponding videobuf2 helpers.
>>
>> What I meant is that I'd like to encourage userspace to use the
>> VIDIOC_CREATE_BUFS ioctl instead of VIDIOC_REQBUFS.
>>
> 
> I'm not sure what rationale I can give implementer to "encourage" them to use a
> more complex API that needs to copy over the FMT (which has just been set),
> specially in the initial pre-allocation case. For most, CREATE_BUFS after SMT
> will look like a very redundant and counter intuitive thing. Maybe you have a
> more optimistic view on the matter ? Or you have a better idea how we could give
> a meaning to having a fmt there on the initial case where the allocation matches
> the queue FMT ?

I wouldn't mind if we can make a much nicer CREATE_BUFS variant with just the
size instead of a format. That was in hindsight a really bad idea, terrible
over-engineering.

Regards,

	Hans
