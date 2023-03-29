Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AE66CED1C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjC2Pi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjC2Pi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:38:26 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4F7135;
        Wed, 29 Mar 2023 08:38:24 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32T9DfOv021397;
        Wed, 29 Mar 2023 10:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=gquVTUvHedpHcdq5AeqiVp3y34dsTEeVrnOo0Yqlu7c=;
 b=ptz/49+KmM8VdXSGhmnQfUcyrszhHBjZslOfE4fVZyaBu0oGQk7/e/WBjbNX9r/eo9UN
 swETDuMBeM+2a5yU0vA3NdkDLbYBXyp2M12HNs9w6ISua/AOUzX1MuVEpe3hsxfGgoFH
 3FwZekUJc9bVBbeVpZZlfw+6rsh28HJVW9iKvZ9rQAhpJmv/kEVYigcDEkd3mnx7S6eV
 2LAbX1Hdf6RC6PpQzeDb4vrdXuJE5uq/X0gRA6VQ0Vee/Q75qieWX2IiHQUJGqKGs/NS
 mAwNv30FX0TtjLw1X/kRM/UEaIuesEUgndwnuWonp3/fBo4kAcRv7XCF9pKX/MGvy7cD iA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pmjghgk5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 10:38:09 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Wed, 29 Mar
 2023 10:38:08 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 29 Mar 2023 10:38:08 -0500
Received: from [198.61.65.23] (EDIN4L06LR3.ad.cirrus.com [198.61.65.23])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 07FE5B38;
        Wed, 29 Mar 2023 15:38:06 +0000 (UTC)
Message-ID: <51cdc8df-9472-a604-3cca-ebaa7ae5d899@opensource.cirrus.com>
Date:   Wed, 29 Mar 2023 16:38:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] Asoc: wm_adsp: Add support for loading firmware with
 prefix name
Content-Language: en-US
To:     Jianhua Lu <lujianhua000@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>
References: <20230329130525.15830-1-lujianhua000@gmail.com>
 <20230329140524.GU68926@ediswmail.ad.cirrus.com> <ZCRNRhI3+6jUbqvy@Gentoo>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <ZCRNRhI3+6jUbqvy@Gentoo>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: oqzieBcBoMJu0JrbVmSUGjtJEtY2GhHN
X-Proofpoint-ORIG-GUID: oqzieBcBoMJu0JrbVmSUGjtJEtY2GhHN
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/3/23 15:37, Jianhua Lu wrote:
> On Wed, Mar 29, 2023 at 02:05:24PM +0000, Charles Keepax wrote:
>>
>> This direction seems slightly problematic, especially in the
>> context of amps (which I presume this relates to, please let know
>> if that is wrong). It would probably be better to be fixing
>> things up such that the amp in question sets system_name when
>> registered through DT. Generally speaking the idea is the amp
> I also consider setting system_name when registered by DT, but I don't
> known setting what name to it. Card name or something else?

It just has to be a unique string.
The normal process is that Cirrus would release the firmware with the
correct name for the platform, so the system-name matches the string in
those release firmware files.

Do you have an official firmware for your platform?

>> tuning is going to be specific to the enclosure/speaker involved,
>> so a generic tuning for say left amps doesn't really make a lot
>> of sense.
> I don't known about amp tuning much, my need just is loading firmware for
> more than 1 speaker amp at the platform using fdt.
> 
> One of the both way is good to me.
>>
>> Thanks,
>> Charles
