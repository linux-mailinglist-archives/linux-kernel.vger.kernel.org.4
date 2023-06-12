Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5F072CA9A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjFLPr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236659AbjFLPrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:47:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C20710CC;
        Mon, 12 Jun 2023 08:47:24 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CE01lY011062;
        Mon, 12 Jun 2023 15:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=c87XOzdDuRMdz3dpGgxfIYZgND1DCuLkfZzv0++v1uQ=;
 b=Bw1VU3NyyUzzZXgDPJtYb1QzyRI5ndvSOaVuUfYZFjHJOMivGYq8BZ+XRqvL5KFa+hob
 lZ/R2XYH/gZzyBU8TG2jGZHGhqY0vAcbJMGpcCOscxSpRn5WHYs0QTfFR9jMXrvrvd5U
 Fzx+ZzOaz7idvR9IizWyRBvN0lCICSt6b5cZoZZyRRvHk9gOgdTBHBYIjxRNRVNGDODW
 EJkUU/siqw4FRtjNY6t8zUnzofNrwT2FuHFGs9ExJ+9NbYQe8v6EpGeL7GZg9m9YRSTT
 8l8jrhdw8x31STuJ3hV2Re0mJGfHX2veWxaFXi1+FjzZYMTcIpfxqMTOpIXs+3zOotAs eQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r4ehtux5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 15:47:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35CFlD68015398
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 15:47:13 GMT
Received: from [10.50.14.38] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 12 Jun
 2023 08:47:09 -0700
Message-ID: <d4476c3b-9923-dde2-8338-9f67ebfc729f@quicinc.com>
Date:   Mon, 12 Jun 2023 21:17:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] accel/qaic: Fix dereferencing freed memory
Content-Language: en-US
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Sukrut Bellary <sukrut.bellary@linux.com>,
        "Oded Gabbay" <ogabbay@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-media@vger.kernel.org>
References: <20230610021200.377452-1-sukrut.bellary@linux.com>
 <fc979a4e-c30a-2606-9eec-afbba4fdd774@amd.com>
 <e3a867a8-284b-7250-b1b2-1956f533f6b0@quicinc.com>
 <ff196b04-e8c5-52d9-852b-9a9cc7eecdd0@amd.com>
 <b5e5c141-b5df-e24d-8fa4-94297d561cec@quicinc.com>
From:   Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
In-Reply-To: <b5e5c141-b5df-e24d-8fa4-94297d561cec@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: H6edwVznO1IQawd9XFNZmgfKwTUAO_qQ
X-Proofpoint-ORIG-GUID: H6edwVznO1IQawd9XFNZmgfKwTUAO_qQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_06,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306120136
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/2023 8:39 PM, Jeffrey Hugo wrote:
> On 6/12/2023 7:21 AM, Christian König wrote:
>> Am 12.06.23 um 15:03 schrieb Pranjal Ramajor Asha Kanojiya:
>>>
>>>
>>> On 6/12/2023 4:52 PM, Christian König wrote:
>>>>
>>>>
>>>> Am 10.06.23 um 04:12 schrieb Sukrut Bellary:
>>>>> smatch warning:
>>>>>     drivers/accel/qaic/qaic_data.c:620 qaic_free_object() error:
>>>>>         dereferencing freed memory 'obj->import_attach'
>>>>>
>>>>> obj->import_attach is detached and freed using dma_buf_detach().
>>>>> But used after free to decrease the dmabuf ref count using
>>>>> dma_buf_put().
>>>>>
>>>>> Fixes: ff13be830333 ("accel/qaic: Add datapath")
>>>>> Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
>>>>> ---
>>>>>   drivers/accel/qaic/qaic_data.c | 4 +++-
>>>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/accel/qaic/qaic_data.c 
>>>>> b/drivers/accel/qaic/qaic_data.c
>>>>> index e42c1f9ffff8..7cba4d680ea8 100644
>>>>> --- a/drivers/accel/qaic/qaic_data.c
>>>>> +++ b/drivers/accel/qaic/qaic_data.c
>>>>> @@ -613,11 +613,13 @@ static int qaic_gem_object_mmap(struct 
>>>>> drm_gem_object *obj, struct vm_area_struc
>>>>>   static void qaic_free_object(struct drm_gem_object *obj)
>>>>>   {
>>>>>       struct qaic_bo *bo = to_qaic_bo(obj);
>>>>> +    struct dma_buf *dmabuf;
>>>>
>>>> Maybe move that variable into the if.
>>>>
>>>>>       if (obj->import_attach) {
>>>>>           /* DMABUF/PRIME Path */
>>>>> +        dmabuf = obj->import_attach->dmabuf;
>>>>>           dma_buf_detach(obj->import_attach->dmabuf, 
>>>>> obj->import_attach);
>>>>> -        dma_buf_put(obj->import_attach->dmabuf);
>>>>> +        dma_buf_put(dmabuf);
>>>>
>>>> I strongly assume you are not using the GEM prime helpers for this?
>>>>
>>>> Christian.
>>>
>>> Driver uses drm_gem_prime_fd_to_handle() helper function but it also 
>>> registers for ->gem_prime_import() which is internally called by 
>>> drm_gem_prime_fd_to_handle(). All the operations done in 
>>> gem_prime_import() are undone here.
>>
>> Then why don't you use drm_prime_gem_destroy() which is the cleanup 
>> helper for imports created by ->gem_prime_import() ?
>>
>> That looks pretty much identical to what you do here manually.
> 
> I think destroy() wasn't used because we are new to DRM and sometimes 
> confused by the multitude of options.  I appreciate the suggestion and 
> will follow up to see if destroy() will work here, or identify what 
> would prevent the use of it.
> 
> -Jeff

Thank you Christian for your suggestion. I agree with you driver can use 
  drm_prime_gem_destroy() here.
