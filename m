Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE646A9DC3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjCCRdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 12:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjCCRdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:33:44 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301EC4207
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 09:33:43 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32385Nnc010547;
        Fri, 3 Mar 2023 17:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rT9oXyMOiJsVqlFyPDuL53W0Fy6C8viYI4Cr8IbjbC0=;
 b=oB/nk/P6rqPZ1p3q7nG5//wY4rA5HAnldkmEzFcDnaN5b/6gF0Ns3oKHhl1aaKPtR/Po
 Ir2pwm/apJM0F1cts1ujpoWCVJk6XqyGebYfb0TSpZ/ELrkEAsAnP5lJREDAAuF6p0XD
 gFiGynL71R7/AGRxR36E7TEjmWEIJoih94zkbiLfV/ZyjjrDER+jvVrcjtyk/940OavN
 KlPDcVA+edfR41a98tQVvJycPYksm0U/Q14BCshXGfqXhk6NF0BDjiyYJcQ2pd4yQwWw
 bjO2FCKzk8QMalr+NurMhpFgR93OX4SzOli05iE7w+c3yZBAe/3W2+eTnkVKuQfeMO94 Mg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p3c8hsu98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 17:32:54 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 323HWrlf016803
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Mar 2023 17:32:53 GMT
Received: from [10.216.31.251] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 3 Mar 2023
 09:32:50 -0800
Message-ID: <79d4f0ad-c014-6b9f-4c0e-c71163457b30@quicinc.com>
Date:   Fri, 3 Mar 2023 23:02:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] ASoC: codecs: tx-macro: Fix for KASAN: slab-out-of-bounds
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC:     Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:QCOM AUDIO (ASoC) DRIVERS" 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230303125717.29196-1-quic_visr@quicinc.com>
 <73ea5ba2-18c8-abd8-3896-eb9656201f53@linaro.org>
From:   VISHNUVARDHAN RAO RAVULAPATI <quic_visr@quicinc.com>
In-Reply-To: <73ea5ba2-18c8-abd8-3896-eb9656201f53@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IHn6InOu0g2tCAQk4achWYNMFhGgWF2z
X-Proofpoint-ORIG-GUID: IHn6InOu0g2tCAQk4achWYNMFhGgWF2z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_03,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 mlxlogscore=750
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030150
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/3/2023 7:45 PM, Srinivas Kandagatla wrote:
>
>
> On 03/03/2023 12:57, Ravulapati Vishnu Vardhan Rao wrote:
>> @@ -1064,9 +1064,10 @@ static int tx_macro_hw_params(struct 
>> snd_pcm_substream *substream,
>>                     struct snd_soc_dai *dai)
>>   {
>>       struct snd_soc_component *component = dai->component;
>> -    u32 decimator, sample_rate;
>> +    u32 sample_rate;
>>       int tx_fs_rate;
>>       struct tx_macro *tx = snd_soc_component_get_drvdata(component);
>> +    u8 decimator = 0;
> Minor nit, any reason why decimator is intialized as part of this change.
>
> --srini
Will Remove that..Thanks for review
