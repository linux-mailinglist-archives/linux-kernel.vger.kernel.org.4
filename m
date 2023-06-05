Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1411F72265B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 14:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjFEMvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 08:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjFEMvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:51:19 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EA0E6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 05:51:15 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3558e8hD010267;
        Mon, 5 Jun 2023 07:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=yU9eshyqKAIkJa4SLDx3YPJnfeTYlRKTxJ/oaNHkkXI=;
 b=lWb5nHMtT0fcm7O84i2QCHRlsOoeVdXBTFYaVhaUi1Q124K4ALl7g4sLTKDPgx+168f7
 YyPVMtgLDq9Ymu6603cjx4K+BkKOTrfRhNQoCFzIThC7hSf+WRwDlK00nxSxlsQkw1yb
 yFT/A/O21qCdwDHj705mFlrSO6vCcGNZ0FGvLWG+vGJ59GFUENS2s8/ls9BQ2WSxWFX6
 ir7KRFegR1zoXVFJ3zLlYplW9FSgWFaN599bDz4zKMbOU7A4EPwNUONKe/d2jThRxApK
 UpFstf9dabk5WWwAlI629BI5L9s376nZAkly90g+F6AxW05kJfPbSTztnlV92Ff4Ulwo kQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3r01xn9tw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 07:50:56 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Mon, 5 Jun
 2023 13:50:54 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 5 Jun 2023 13:50:54 +0100
Received: from [198.90.238.35] (LONN2DGDQ73.ad.cirrus.com [198.90.238.35])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5AC9C458;
        Mon,  5 Jun 2023 12:50:54 +0000 (UTC)
Message-ID: <ff8d0da4-10f7-31a7-5cf9-7a4c0e009192@opensource.cirrus.com>
Date:   Mon, 5 Jun 2023 13:50:54 +0100
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
From:   Stefan Binding <sbinding@opensource.cirrus.com>
In-Reply-To: <87zg5eidcb.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: -7NHbr8YGozgAH0ikn2DmeYWPwtQUtCc
X-Proofpoint-GUID: -7NHbr8YGozgAH0ikn2DmeYWPwtQUtCc
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

On 05/06/2023 08:21, Takashi Iwai wrote:
> On Thu, 25 May 2023 15:59:54 +0200,
> Stefan Binding wrote:
>> @@ -379,10 +379,10 @@ static int cs35l41_save_calibration(struct cs35l41_hda *cs35l41)
>>   
>>   				/* Calibration can only be applied whilst the DSP is not running */
>>   				ret = cs35l41_apply_calibration(cs35l41,
>> -								cpu_to_be32(cl->calAmbient),
>> -								cpu_to_be32(cl->calR),
>> -								cpu_to_be32(cl->calStatus),
>> -								cpu_to_be32(cl->calR + 1));
>> +								(__be32)cpu_to_be32(cl->calAmbient),
>> +								(__be32)cpu_to_be32(cl->calR),
>> +								(__be32)cpu_to_be32(cl->calStatus),
>> +								(__be32)cpu_to_be32(cl->calR + 1));
> Do we really need those cast?  Even if yes, it must be with __force
> prefix for the endian cast in general.

These casts were added because we found some warnings when we ran the 
static analyzer sparse locally.
I think these warnings are very minor, and we can drop this patch if you 
prefer?

Thanks,

Stefan

>
> thanks,
>
> Takashi
