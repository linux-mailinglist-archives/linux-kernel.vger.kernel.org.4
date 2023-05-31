Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095F2717A15
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbjEaIaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbjEaIan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:30:43 -0400
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF889BE
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:30:41 -0700 (PDT)
X-KPN-MessageId: 6b6a2c64-ff8d-11ed-b139-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 6b6a2c64-ff8d-11ed-b139-005056ab378f;
        Wed, 31 May 2023 10:30:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=bi/zwW1dF0baBHFGLa1Ol2YY+ghL4hKqNhiswnod4IY=;
        b=Cbx2lnBI939OqQlwn2LgA2WtjioUKZjZDqNO54cgoWQaDD9mMT75o3zz4hySA8tRKu/u6KChttcwC
         XziBcYpFDtwzd+rVXRRr9KDDX4K2+VtaE7//Mog3QLgp8PG8TW3urucSmi+PQ1+govLxt64R3SYwDb
         RTpfsmVGvxNahUXSAhKnnX+5sPH+O/W/1vtVq8y+n+vBPYHV6ekR60QRAFge2gzNNJmajAcBuza0BP
         bwcW1ukpQPaOs0Mu1NNJe3rQ5tVnbj+AesMLe8j38mo4oFHHZZ2QOoHx4HYUx3rLAfAQyn3ukFaoV5
         oMer0XYvZHUuPxpRQppi/EzjwaEBUkg==
X-KPN-MID: 33|Fcd5oOhZ044j3uOQbeA2h3AjFJJJbejqxfpkqOfmqYParZA1prin+rv5J38icqA
 3vHUOx6g9HA1xlyqcjCnfdbicA2a9kyRyk3ej0hpbsbk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|3YKdBL7gafLa96P8ALjF+44XrQH3OeXh6KixQi1/qKwG3bLPylcZA9xSJT+Plbx
 sCBzYiEGKS2jF5n8a2fWIBQ==
X-Originating-IP: 173.38.220.44
Received: from [10.47.77.214] (unknown [173.38.220.44])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 6b437bb6-ff8d-11ed-a898-005056abf0db;
        Wed, 31 May 2023 10:30:38 +0200 (CEST)
Message-ID: <608ae7d6-3f3b-137d-08d2-d41a240be2c4@xs4all.nl>
Date:   Wed, 31 May 2023 10:30:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/8] media: videobuf2: Add a module param to limit vb2
 queue buffer storage
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        ming.qian@nxp.com, shijie.qin@nxp.com, eagle.zhou@nxp.com,
        bin.liu@mediatek.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, tiffany.lin@mediatek.com,
        andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        daniel.almeida@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
References: <20230321102855.346732-1-benjamin.gaignard@collabora.com>
 <20230321102855.346732-4-benjamin.gaignard@collabora.com>
 <6c4658fd-3a64-b3f8-67cd-17ed2d7d3567@xs4all.nl>
 <20230531080331.GB6496@pendragon.ideasonboard.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230531080331.GB6496@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/23 10:03, Laurent Pinchart wrote:
> On Wed, May 31, 2023 at 08:36:59AM +0200, Hans Verkuil wrote:
>> On 21/03/2023 11:28, Benjamin Gaignard wrote:
>>> Add module parameter "max_vb_buffer_per_queue" to be able to limit
>>> the number of vb2 buffers store in queue.
>>>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>> ---
>>>  drivers/media/common/videobuf2/videobuf2-core.c | 15 +++------------
>>>  include/media/videobuf2-core.h                  | 11 +++++++++--
>>>  2 files changed, 12 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
>>> index ae9d72f4d181..f4da917ccf3f 100644
>>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>>> @@ -34,6 +34,8 @@
>>>  static int debug;
>>>  module_param(debug, int, 0644);
>>>  
>>> +module_param(max_vb_buffer_per_queue, ulong, 0644);
>>
>> There is no MODULE_PARM_DESC here? Please add. I see it is not there for
>> the debug param either, it should be added for that as well.
> 
> Would this be the right time to consider resource accounting in V4L2 for
> buffers ? Having a module parameter doesn't sound very useful, an
> application could easily allocate more buffers by using buffer orphaning
> (allocating buffers, exporting them as dmabuf objects, and freeing them,
> which leaves the memory allocated). Repeating allocation cycles up to
> max_vb_buffer_per_queue will allow allocating an unbounded number of
> buffers, using all the available system memory. I'd rather not add a
> module argument that only gives the impression of some kind of safety
> without actually providing any value.

Does dmabuf itself provide some accounting mechanism? Just wondering.

More specific to V4L2: I'm not so sure about this module parameter either.
It makes sense to have a check somewhere against ridiculous values (i.e.
allocating MAXINT buffers), but that can be a define as well. But otherwise
I am fine with allowing applications to allocate buffers until the memory
is full.

The question is really: what is this parameter supposed to do? The only
thing it does is to sanitize unlikely inputs (e.g. allocating MAXINT buffers).

I prefer that as a define, to be honest.

I think it is perfectly fine for users to try to request more buffers than
memory allows. It will just fail in that case, not a problem.

And if an application is doing silly things like buffer orphaning, then so
what? Is that any different than allocating memory and not freeing it?
Eventually it will run out of memory and crash, which is normal.

Regards,

	Hans
