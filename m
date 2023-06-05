Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29C0722AED
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjFEPYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjFEPYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:24:12 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C436CEE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:24:11 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3558e8qJ010267;
        Mon, 5 Jun 2023 10:23:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=uVmiTfqw7mNMn6Bzor8qN+zV9QQNIDAGFDMziJpJE20=;
 b=SuFG+NYOcggQgxA4azHkNp9/VLKBi9gRkHgOavnPxGKUnYrGhiUVWKgHTz4wkvEk2Ej6
 hLlSx/3WmWJmPLrYrDF2u4huit6QxPVg2Q+XlEIveAdRU1jjh+XTTw84kEQcBV+YIGlO
 uVkCti6JSnsckNk56mu8lCapFn7RGCrGdqC+5MpNnhEqA+yzQ9YjCvwtmBoPpXQz77sY
 6auErS2Zj0qjMdufWn+Qvtg5VInFjShRJzdrPFAv+C27ORQSKBYslO2OUibt96Q/Ea4B
 0bXZmPtYs+iDpidqCQQnHl+pZLbwSQSB+P2/4cx4YM5iMTrA1OVZEH2LU5C8yylFauqF Vg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3r01xna11f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 10:23:57 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Mon, 5 Jun
 2023 16:23:55 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 5 Jun 2023 16:23:55 +0100
Received: from [198.90.238.35] (LONN2DGDQ73.ad.cirrus.com [198.90.238.35])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7597D11AA;
        Mon,  5 Jun 2023 15:23:55 +0000 (UTC)
Message-ID: <21d2e747-f911-e9d4-2c55-e31c76c9d2bc@opensource.cirrus.com>
Date:   Mon, 5 Jun 2023 16:23:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RESEND v1 2/3] ALSA: hda: cs35l41: Fix endian conversions
To:     Takashi Iwai <tiwai@suse.de>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20230525135955.2108140-1-sbinding@opensource.cirrus.com>
 <20230525135955.2108140-3-sbinding@opensource.cirrus.com>
 <87zg5eidcb.wl-tiwai@suse.de>
 <ff8d0da4-10f7-31a7-5cf9-7a4c0e009192@opensource.cirrus.com>
 <878rcyhwvk.wl-tiwai@suse.de>
From:   Stefan Binding <sbinding@opensource.cirrus.com>
In-Reply-To: <878rcyhwvk.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Lkg6Khi7KamQ91EwYW0YOCtQrNfT2HqX
X-Proofpoint-GUID: Lkg6Khi7KamQ91EwYW0YOCtQrNfT2HqX
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

On 05/06/2023 14:17, Takashi Iwai wrote:
> On Mon, 05 Jun 2023 14:50:54 +0200,
> Stefan Binding wrote:
>> Hi Takashi,
>>
>> On 05/06/2023 08:21, Takashi Iwai wrote:
>>> On Thu, 25 May 2023 15:59:54 +0200,
>>> Stefan Binding wrote:
>>>> @@ -379,10 +379,10 @@ static int cs35l41_save_calibration(struct cs35l41_hda *cs35l41)
>>>>      				/* Calibration can only be applied
>>>> whilst the DSP is not running */
>>>>    				ret = cs35l41_apply_calibration(cs35l41,
>>>> -								cpu_to_be32(cl->calAmbient),
>>>> -								cpu_to_be32(cl->calR),
>>>> -								cpu_to_be32(cl->calStatus),
>>>> -								cpu_to_be32(cl->calR + 1));
>>>> +								(__be32)cpu_to_be32(cl->calAmbient),
>>>> +								(__be32)cpu_to_be32(cl->calR),
>>>> +								(__be32)cpu_to_be32(cl->calStatus),
>>>> +								(__be32)cpu_to_be32(cl->calR + 1));
>>> Do we really need those cast?  Even if yes, it must be with __force
>>> prefix for the endian cast in general.
>> These casts were added because we found some warnings when we ran the
>> static analyzer sparse locally.
>> I think these warnings are very minor, and we can drop this patch if
>> you prefer?
> The warnings must be bogus, or maybe pointing to other things?
> The cpu_to_be32() macro itself must return a __be32 value, hence it
> makes no sense to add an extra cast .
>
> If the static analysis still shows such a warning, it should be fixed
> differently -- either fix the analyzer or fix the cpu_to_be32() macro
> itself.
>
> The changes of the argument types to __be32 are fine.  I'm arguing
> only about those unnecessary cast.

You are correct, I double checked and the cast is not needed. I'll push 
up a v2.

Thanks,

Stefan

>
>
> thanks,
>
> Takashi
