Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061B56B7966
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjCMNrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjCMNrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:47:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDC66F495;
        Mon, 13 Mar 2023 06:47:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E826DB810E8;
        Mon, 13 Mar 2023 13:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE390C433D2;
        Mon, 13 Mar 2023 13:47:02 +0000 (UTC)
Message-ID: <1c1e4e60-3b90-f268-8012-3193e1de4769@xs4all.nl>
Date:   Mon, 13 Mar 2023 14:47:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] media: hantro: fix use after free bug in hantro_release
 due to race condition
Content-Language: en-US
To:     Zheng Hacker <hackerzheng666@gmail.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com
References: <20230307153542.1178065-1-zyytlz.wz@163.com>
 <7f9796d2-1885-a6f2-b9e3-d6ea58524033@xs4all.nl>
 <CAJedcCwnvNK8Gbcxz2V5+ebRJFrEYjpoJsKTKZ7DOSETr_7LEQ@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <CAJedcCwnvNK8Gbcxz2V5+ebRJFrEYjpoJsKTKZ7DOSETr_7LEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2023 14:45, Zheng Hacker wrote:
> Hans Verkuil <hverkuil@xs4all.nl> 于2023年3月13日周一 21:17写道：
>>
>> On 07/03/2023 16:35, Zheng Wang wrote:
>>> In hantro_probe, vpu->watchdog_work is bound with
>>> hantro_watchdog. Then hantro_end_prepare_run may
>>> be called to start the work.
>>>
>>> If we close the file or remove the module which will
>>> call hantro_release and hantro_remove to make cleanup,
>>> there may be a unfinished work. The possible sequence
>>> is as follows, which will cause a typical UAF bug.
>>>
>>> The same thing will happen in hantro_release, and use
>>> ctx after freeing it.
>>>
>>> Fix it by canceling the work before cleanup in hantro_release.
>>>
>>> CPU0                  CPU1
>>>
>>>                     |hantro_watchdog
>>> hantro_remove     |
>>>   v4l2_m2m_release  |
>>>     kfree(m2m_dev); |
>>>                     |
>>>                     | v4l2_m2m_get_curr_priv
>>>                     |   m2m_dev->curr_ctx //use
>>>
>>> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
>>> ---
>>>  drivers/media/platform/verisilicon/hantro_drv.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
>>> index b0aeedae7b65..cf00ccaa7829 100644
>>> --- a/drivers/media/platform/verisilicon/hantro_drv.c
>>> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
>>> @@ -601,6 +601,7 @@ static int hantro_release(struct file *filp)
>>>        * No need for extra locking because this was the last reference
>>>        * to this file.
>>>        */
>>> +     cancel_delayed_work(&vpu->watchdog_work);
>>>       v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
>>>       v4l2_fh_del(&ctx->fh);
>>>       v4l2_fh_exit(&ctx->fh);
>>
>> drivers/media/platform/verisilicon/hantro_drv.c: In function ‘hantro_release’:
>> drivers/media/platform/verisilicon/hantro_drv.c:604:30: error: ‘vpu’ undeclared (first use in this function); did you mean ‘fpu’?
>>   604 |         cancel_delayed_work(&vpu->watchdog_work);
>>       |                              ^~~
>>       |                              fpu
>> drivers/media/platform/verisilicon/hantro_drv.c:604:30: note: each undeclared identifier is reported only once for each function it appears in
>>
>> You clearly didn't compile this patch!
>>
> Sorry for my mistake. I was hurried to report the issue and discuss
> with developer to confirm it . I'll complete it and test it locally.

Was this UAF actually observed, or is it theoretical?

Regards,

	Hans

> 
> Best regards,
> Zheng

