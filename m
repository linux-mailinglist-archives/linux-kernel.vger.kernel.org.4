Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DA76ADAE9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjCGJul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjCGJud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:50:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CE456173;
        Tue,  7 Mar 2023 01:50:08 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 834976602FE5;
        Tue,  7 Mar 2023 09:49:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678182572;
        bh=bFdUBSoZid4noEejpjbjSQLY78Rr8UCoRauX0ECcyZA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kcggbC72pydIcHkWby/ACFWWdCiqdOuN0UM0dY+WlDJcji32m0LSpuaHeJQzMfqID
         SNZU4O4gOX9VBuV1AY0lgnanwvNp0V+VctHE+4BMgDQb2WBzH0YfV5IcomBGeTSLI7
         qGZvfX5i/1+Jta4RCeH+0eUmB2T+03z01JP0TZgV6MRUCnBLjaOVX6X+mKQNsa6YgF
         KatpFW1/mYXcuW3vv7gk4fyuFQCm7y4LLzeu5P8bwYRGZMzQpJ5NNtdVhL3sotm3aG
         9gVq7W2vOtuNlI21Sw9WYPaLBbdmsRJP3cBrHmal8Ymjbuhg4GiALNL/TsSeV/3rIB
         zhrED7sSSTScg==
Message-ID: <57c17bfd-83f3-fcce-0eab-e28469fb0ced@collabora.com>
Date:   Tue, 7 Mar 2023 10:49:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RESEND PATCH] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
Content-Language: en-US
To:     Zheng Hacker <hackerzheng666@gmail.com>,
        Zheng Wang <zyytlz.wz@163.com>,
        Irui Wang <irui.wang@mediatek.com>
Cc:     mchehab@kernel.org, bin.liu@mediatek.com, matthias.bgg@gmail.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com
References: <20230306062633.200427-1-zyytlz.wz@163.com>
 <CAJedcCzeVwwi9SkkwouFXUAVhF-tKF4dkqsFqVQwszSwY1SJ0A@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAJedcCzeVwwi9SkkwouFXUAVhF-tKF4dkqsFqVQwszSwY1SJ0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/03/23 10:27, Zheng Hacker ha scritto:
> Hi,
> 
> Is there anyone who can help with this? I can provide more details
> like invoking chain if needed.
> 

Providing more details is always good. Please do.

Meanwhile, adding Irui Wang to the loop: he's doing mtk-jpeg.

Regards,
Angelo

> Thanks,
> Zheng
> 
> Zheng Wang <zyytlz.wz@163.com> 于2023年3月6日周一 14:28写道：
>>
>> In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
>> mtk_jpeg_job_timeout_work. Then mtk_jpeg_dec_device_run
>> and mtk_jpeg_enc_device_run may be called to start the
>> work.
>> If we remove the module which will call mtk_jpeg_remove
>> to make cleanup, there may be a unfinished work. The
>> possible sequence is as follows, which will cause a
>> typical UAF bug.
>>
>> Fix it by canceling the work before cleanup in the mtk_jpeg_remove
>>
>> CPU0                  CPU1
>>
>>                      |mtk_jpeg_job_timeout_work
>> mtk_jpeg_remove     |
>>    v4l2_m2m_release  |
>>      kfree(m2m_dev); |
>>                      |
>>                      | v4l2_m2m_get_curr_priv
>>                      |   m2m_dev->curr_ctx //use
>>
>> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
>> ---
>>   drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
>> index 969516a940ba..364513e7897e 100644
>> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
>> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
>> @@ -1793,7 +1793,7 @@ static int mtk_jpeg_probe(struct platform_device *pdev)
>>   static int mtk_jpeg_remove(struct platform_device *pdev)
>>   {
>>          struct mtk_jpeg_dev *jpeg = platform_get_drvdata(pdev);
>> -
>> +       cancel_delayed_work(&jpeg->job_timeout_work);
>>          pm_runtime_disable(&pdev->dev);
>>          video_unregister_device(jpeg->vdev);
>>          v4l2_m2m_release(jpeg->m2m_dev);
>> --
>> 2.25.1
>>



