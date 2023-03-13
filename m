Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FE66B7B94
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjCMPKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjCMPJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:09:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5C66C8BD;
        Mon, 13 Mar 2023 08:09:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D98AAB81184;
        Mon, 13 Mar 2023 15:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D55C433D2;
        Mon, 13 Mar 2023 15:09:41 +0000 (UTC)
Message-ID: <f0db2bb7-01b0-c146-6643-5509e8fa4b11@xs4all.nl>
Date:   Mon, 13 Mar 2023 16:09:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] media: hantro: fix use after free bug in hantro_remove
 due to race condition
Content-Language: en-US
From:   Hans Verkuil <hverkuil@xs4all.nl>
To:     Zheng Wang <zyytlz.wz@163.com>, ezequiel@vanguardiasur.com.ar
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com
References: <20230307154157.1184826-1-zyytlz.wz@163.com>
 <43b48f87-2343-5855-e6c2-8f30319687c5@xs4all.nl>
In-Reply-To: <43b48f87-2343-5855-e6c2-8f30319687c5@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2023 16:08, Hans Verkuil wrote:
> On 07/03/2023 16:41, Zheng Wang wrote:
>> In hantro_probe, vpu->watchdog_work is bound with
>> hantro_watchdog. Then hantro_end_prepare_run may
>> be called to start the work.
>>
>> If we close the file or remove the module which will
>> call hantro_release and hantro_remove to make cleanup,
>> there may be a unfinished work. The possible sequence
>> is as follows, which will cause a typical UAF bug.
>>
>> The same thing will happen in hantro_release, and use
>> ctx after freeing it.
>>
>> Fix it by canceling the work before cleanup in hantro_release.
>>
>> CPU0                  CPU1
>>
>>                     |hantro_watchdog
>> hantro_remove     |
>>   v4l2_m2m_release  |
>>     kfree(m2m_dev); |
>>                     |
>>                     | v4l2_m2m_get_curr_priv
>>                     |   m2m_dev->curr_ctx //use
>>
>> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
>> ---
>>  drivers/media/platform/verisilicon/hantro_drv.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
>> index b0aeedae7b65..80bd856a4da9 100644
>> --- a/drivers/media/platform/verisilicon/hantro_drv.c
>> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
>> @@ -1099,6 +1099,7 @@ static int hantro_remove(struct platform_device *pdev)
>>  
>>  	v4l2_info(&vpu->v4l2_dev, "Removing %s\n", pdev->name);
>>  
>> +	cancel_delayed_work(&vpu->watchdog_work);
> 
> Use cancel_delayed_work_sync(): that ensures the code waits for a running
> watchdog function to finish.
> 
> Ditto for the other patch.

And also the cedrus and rkvdec patches.

Regards,

	Hans

> 
> Regards,
> 
> 	Hans
> 
>>  	media_device_unregister(&vpu->mdev);
>>  	hantro_remove_dec_func(vpu);
>>  	hantro_remove_enc_func(vpu);
> 

