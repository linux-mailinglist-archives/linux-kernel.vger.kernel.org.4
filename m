Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE88747F97
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjGEI0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjGEI0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:26:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29ECD1709
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 01:26:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39C7B1682;
        Wed,  5 Jul 2023 01:26:52 -0700 (PDT)
Received: from [10.57.28.141] (unknown [10.57.28.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70D7D3F73F;
        Wed,  5 Jul 2023 01:26:08 -0700 (PDT)
Message-ID: <4c78c516-8cb6-d865-c64c-0b2443006690@arm.com>
Date:   Wed, 5 Jul 2023 09:26:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] iommu/mediatek: Remove a unnecessary checking for larbid
To:     =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Cc:     "will@kernel.org" <will@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20230704115634.7727-1-yong.wu@mediatek.com>
 <633be7a7-0bb8-1575-535e-2f96302198bd@collabora.com>
 <ca4a06b89442e56df652c4aeba3ad83473f4db58.camel@mediatek.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ca4a06b89442e56df652c4aeba3ad83473f4db58.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-05 07:49, Yong Wu (吴勇) wrote:
> On Tue, 2023-07-04 at 14:19 +0200, AngeloGioacchino Del Regno wrote:
>>   	
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>   Il 04/07/23 13:56, Yong Wu ha scritto:
>>> Fix a coverity issue:
>>>
>>>>> assignment: Assigning: larbid = (fwspec->ids[0] >> 5) & 0x1fU.
>>> larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
>>>>> between: At condition larbid >= 32U, the value of larbid must be
>> between
>>>>> 0 and 31.
>>>>> dead_error_condition: The condition larbid >= 32U cannot be true.
>>> if (larbid >= MTK_LARB_NR_MAX)
>>>>> CID 11306470 (#1 of 1): Logically dead code (DEADCODE)
>>>>> dead_error_line: Execution cannot reach this statement:
>>>>> return ERR_PTR(-22L);
>>>           return ERR_PTR(-EINVAL);
>>>
>>> The checking "if (larbid >= MTK_LARB_NR_MAX)" is unnecessary.
>>>
>>
>> I agree with the coverity tool in that after the transformation
>> (going through
>> the definition of MTK_M4U_TO_LARB) the check is pointless, but I
>> think that the
>> right fix here is to check for validity of fwspec->ids[0] instead of
>> simply
>> removing validation.
>>
>> Having no validation after mtk_iommu_probe_device() is fine, but
>> that's
>> because we assume that *this* function performs all validation steps.
> 
> There already is validation code at the point later in this function.
> 
> "if (!larbdev) return ERR_PTR(-EINVAL);" //if the larbid is invalid.
> 
> This patch just removes a deadcode.

Right, if the fwspec value was out of range then the truncated value 
might happen to map to a valid LARB, but then the fwspec could equally 
have an in-range value for a valid (but incorrect) LARB; in general a 
driver can't validate the overall correctness of data from the DT (and 
if it could, that data wouldn't need to be in the DT anyway).

 From the history, the intent of this check doesn't appear to have been 
anything other than protecting the dereference of the data->larb_imu 
array, and it's never had any functional effect, so we don't lose 
anything by removing it. FWIW,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Cheers,
Robin.

> 
>>
>> Regards,
>> Angelo
>>
>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>> ---
>>> Rebase on v6.4-rc1.
>>> ---
>>>    drivers/iommu/mtk_iommu.c | 3 ---
>>>    1 file changed, 3 deletions(-)
>>>
>>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>>> index aecc7d154f28..67caa90b481b 100644
>>> --- a/drivers/iommu/mtk_iommu.c
>>> +++ b/drivers/iommu/mtk_iommu.c
>>> @@ -838,9 +838,6 @@ static struct iommu_device
>> *mtk_iommu_probe_device(struct device *dev)
>>>     * All the ports in each a device should be in the same larbs.
>>>     */
>>>    larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
>>> -if (larbid >= MTK_LARB_NR_MAX)
>>> -return ERR_PTR(-EINVAL);
>>> -
>>>    for (i = 1; i < fwspec->num_ids; i++) {
>>>    larbidx = MTK_M4U_TO_LARB(fwspec->ids[i]);
>>>    if (larbid != larbidx) {
>>
>>
