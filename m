Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482C05EBD87
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiI0IhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiI0IgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:36:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB31C101E0;
        Tue, 27 Sep 2022 01:36:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DCCAB80DA6;
        Tue, 27 Sep 2022 08:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2372AC433D6;
        Tue, 27 Sep 2022 08:36:05 +0000 (UTC)
Message-ID: <4566e72a-a2a0-fd1a-89a5-66e0331ab672@xs4all.nl>
Date:   Tue, 27 Sep 2022 10:36:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] media: dvb_vb2: fix possible out of bound access
Content-Language: en-US
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     Hangyu Hua <hbh25y@gmail.com>, mchehab@kernel.org,
        senozhatsky@chromium.org, cai.huoqing@linux.dev,
        sw0312.kim@samsung.com, satendra.t@samsung.com,
        jh1009.sung@samsung.com, nenggun.kim@samsung.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220519021743.8295-1-hbh25y@gmail.com>
 <b4b52911-e135-38b6-ab2e-4580e1ac0302@gmail.com>
 <5dd713e1-0ad2-f9b3-6dd3-2ee87b329db8@xs4all.nl>
In-Reply-To: <5dd713e1-0ad2-f9b3-6dd3-2ee87b329db8@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hangyu,

On 27/09/2022 10:10, Hans Verkuil wrote:
> On 27/09/2022 04:01, Hangyu Hua wrote:
>> On 19/5/2022 10:17, Hangyu Hua wrote:
>>> vb2_core_qbuf and vb2_core_querybuf don't check the range of b->index
>>> controlled by the user.
>>>
>>> Fix this by adding range checking code before using them.
>>>
>>> Fixes: 57868acc369a ("media: videobuf2: Add new uAPI for DVB streaming I/O")
>>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>>> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
>>> ---
>>>
>>> v2:
>>> 1. fix inappropriate use of dprintk.
>>> 2. add "fixes" tag
>>>
>>>   drivers/media/dvb-core/dvb_vb2.c | 11 +++++++++++
>>>   1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/media/dvb-core/dvb_vb2.c b/drivers/media/dvb-core/dvb_vb2.c
>>> index a1bd6d9c9223..909df82fed33 100644
>>> --- a/drivers/media/dvb-core/dvb_vb2.c
>>> +++ b/drivers/media/dvb-core/dvb_vb2.c
>>> @@ -354,6 +354,12 @@ int dvb_vb2_reqbufs(struct dvb_vb2_ctx *ctx, struct dmx_requestbuffers *req)
>>>     int dvb_vb2_querybuf(struct dvb_vb2_ctx *ctx, struct dmx_buffer *b)
>>>   {
>>> +    struct vb2_queue *q = &ctx->vb_q;
>>> +
>>> +    if (b->index >= q->num_buffers) {
>>> +        dprintk(1, "[%s] buffer index out of range\n", ctx->name);
>>> +        return -EINVAL;
>>> +    }
>>>       vb2_core_querybuf(&ctx->vb_q, b->index, b);
>>>       dprintk(3, "[%s] index=%d\n", ctx->name, b->index);
>>>       return 0;
>>> @@ -378,8 +384,13 @@ int dvb_vb2_expbuf(struct dvb_vb2_ctx *ctx, struct dmx_exportbuffer *exp)
>>>     int dvb_vb2_qbuf(struct dvb_vb2_ctx *ctx, struct dmx_buffer *b)
>>>   {
>>> +    struct vb2_queue *q = &ctx->vb_q;
>>>       int ret;
>>>   +    if (b->index >= q->num_buffers) {
>>> +        dprintk(1, "[%s] buffer index out of range\n", ctx->name);
>>> +        return -EINVAL;
>>> +    }
>>>       ret = vb2_core_qbuf(&ctx->vb_q, b->index, b, NULL);
>>>       if (ret) {
>>>           dprintk(1, "[%s] index=%d errno=%d\n", ctx->name,
>>
>> Hi guys,
>>
>> Looks like this patch was forgotten to to merge into master branch. This bug still in:
>> https://git.linuxtv.org/media_tree.git/tree/drivers/media/dvb-core/dvb_vb2.c#n355
>> and
>> https://git.linuxtv.org/media_tree.git/tree/drivers/media/dvb-core/dvb_vb2.c#n379
>>
>> Thanks,
>> Hangyu
> 
> That's weird, it was part of this pull request:
> 
> https://patchwork.linuxtv.org/project/linux-media/patch/2eeaad13-091d-6547-cdeb-0a7a15dc5c3f@xs4all.nl/
> 
> But none of the patches in that PR ever made it to upstream. Something went very wrong
> with that PR.
> 
> I'm preparing a new pull request.
> 
> Thank you very much for notifying me!

Mauro discovered that a small number of patches were never pushed to our git trees,
and so indeed got lost. They have now been merged. This patch has been really unlucky:
it took a long time for the original patch to be reviewed, and then the PR itself
fell through the cracks :-(

Again, thank you very much for double checking this!

Regards,

	Hans
