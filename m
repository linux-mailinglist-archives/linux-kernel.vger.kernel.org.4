Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10230725AB9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238374AbjFGJi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbjFGJiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:38:22 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51511E43
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 02:38:21 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 25D1B2B6;
        Wed,  7 Jun 2023 11:37:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1686130672;
        bh=Tb+ysY4linkYaB45XMud7iGM44eizwZQ/ClNN38SdNQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AxARCMkCrorxgL1QOSjqBlpeMh0qnkevxUSwoTHNpas7vYFt1xd1eySO/fHrf8Pfn
         ZTvQENB7mUn6f6eErfsKxP1aaxysNw4dSSzsESYioCF1ybAw8mhTuGysvZkbJVmNUl
         TJdHc+7gcnXhziZQ0GeQ34IOaXEJGw1Ga60kJRNQ=
Message-ID: <70a188a2-7d56-9798-ecc9-700c9e8fd57f@ideasonboard.com>
Date:   Wed, 7 Jun 2023 12:38:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm: xlnx: zynqmp_dpsub: Add missing check for
 dma_set_mask
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     hyun.kwon@xilinx.com, airlied@gmail.com, daniel@ffwll.ch,
        michal.simek@amd.com, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230607020529.22934-1-jiasheng@iscas.ac.cn>
 <20230607050705.GF14101@pendragon.ideasonboard.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230607050705.GF14101@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 08:07, Laurent Pinchart wrote:
> Hello Jiasheng,
> 
> Thank you for the patch.
> 
> On Wed, Jun 07, 2023 at 10:05:29AM +0800, Jiasheng Jiang wrote:
>> Add check for dma_set_mask() and return the error if it fails.
>>
>> Fixes: d76271d22694 ("drm: xlnx: DRM/KMS driver for Xilinx ZynqMP DisplayPort Subsystem")
>> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
>> ---
>>   drivers/gpu/drm/xlnx/zynqmp_dpsub.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
>> index bab862484d42..068413be6527 100644
>> --- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
>> +++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
>> @@ -227,7 +227,9 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
>>   	dpsub->dev = &pdev->dev;
>>   	platform_set_drvdata(pdev, dpsub);
>>   
>> -	dma_set_mask(dpsub->dev, DMA_BIT_MASK(ZYNQMP_DISP_MAX_DMA_BIT));
>> +	ret = dma_set_mask(dpsub->dev, DMA_BIT_MASK(ZYNQMP_DISP_MAX_DMA_BIT));
>> +	if (ret)
>> +		return ret;
> 
> This seems reasonable.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Tomi, would you be able to quickly test this ?

Works for me.

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

