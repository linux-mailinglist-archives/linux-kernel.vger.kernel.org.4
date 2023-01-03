Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BDE65C41F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbjACQkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238136AbjACQkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:40:11 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26DFADFF5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:40:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 819861516;
        Tue,  3 Jan 2023 08:40:51 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 804AE3F71A;
        Tue,  3 Jan 2023 08:40:07 -0800 (PST)
Message-ID: <832f3200-77ac-1ee0-e1b5-5f56353cba36@arm.com>
Date:   Tue, 3 Jan 2023 16:39:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/3] iommu/sound: Use component_match_add_of helper
Content-Language: en-GB
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Sean Anderson <sean.anderson@seco.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Joerg Roedel <joro@8bytes.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Will Deacon <will@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>, alsa-devel@alsa-project.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20221222233759.1934852-1-sean.anderson@seco.com>
 <20221222233759.1934852-3-sean.anderson@seco.com>
 <7897d4a6-bf43-becd-3437-7a254f38f6be@arm.com>
 <20230103161550.4tui3ihl65olvkd7@houat>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230103161550.4tui3ihl65olvkd7@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 4:15 pm, Maxime Ripard wrote:
> Hi Robin,
> 
> On Tue, Jan 03, 2023 at 01:01:07PM +0000, Robin Murphy wrote:
>> Hi Sean,
>>
>> On 22/12/2022 11:37 pm, Sean Anderson wrote:
>>> Convert users of component_match_add_release with component_release_of
>>> and component_compare_of to component_match_add_of.
>>>
>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>> Acked-by: Mark Brown <broonie@kernel.org>
>>> ---
>>>
>>> Changes in v2:
>>> - Split off from helper addition
>>>
>>>    drivers/iommu/mtk_iommu.c    | 3 +--
>>>    drivers/iommu/mtk_iommu_v1.c | 3 +--
>>>    sound/soc/codecs/wcd938x.c   | 6 ++----
>>>    3 files changed, 4 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>>> index 2ab2ecfe01f8..483b7a9e4410 100644
>>> --- a/drivers/iommu/mtk_iommu.c
>>> +++ b/drivers/iommu/mtk_iommu.c
>>> @@ -1079,8 +1079,7 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
>>>    		}
>>>    		data->larb_imu[id].dev = &plarbdev->dev;
>>> -		component_match_add_release(dev, match, component_release_of,
>>> -					    component_compare_of, larbnode);
>>> +		component_match_add_of(dev, match, larbnode);
>>
>> I've long since given up trying to make sense of how the DRM tree works, but
>> the conflicting change is definitely already in mainline:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=b5765a1b44bea9dfcae69c53ffeb4c689d0922a7
> 
> As far as I can see, that patch doesn't affect DRM at all, and the
> commit you pointed to doesn't either, nor has it been merged through the
> DRM tree.

Right it doesn't affect DRM, and was merged via the IOMMU tree, but it 
does affect *this* patch, which Sean has based on a drm-next branch that 
seemingly still wasn't up to date with 6.2-rc1 at the time.

Since v2 had already been posted, it seemed like a bright idea to 
comment here to clarify that it was still relevant, rather than bumping 
the old thread to reply directly. Apologies for any confusion.

In practical terms I think it's merely a case of dropping this hunk; the 
other one in mtk_iommu_v1.c looks fine to me.

Cheers,
Robin.

> Can you expand a bit on how we're involved in this, what we should
> clarify or help with?
> 
> Maxime
