Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D02B731C66
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345165AbjFOPXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345131AbjFOPXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:23:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4286268A;
        Thu, 15 Jun 2023 08:23:18 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F99SZ9021244;
        Thu, 15 Jun 2023 15:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lXDkh9Ioj/i7AsHQRhCycsHoCHLy67EWMphr83ltGGI=;
 b=RdCwfsYjnF9UiZ4GTkB9hwF5RXvAze7t4zsH/5jnRTw2pxilvUETCOy37abS6JiCY06o
 tb8fJFoL4SfulhFSnSTorWCyKa7LiEUO3BHdWylfovmsZYDqSjw0ZOUcElFTLpv5PIyY
 KWsoIte2cjyeM6RwHt0ash5rbDmxSuhQYyPzFmiUYd2kFFuNKRI+wIKt6KIzw1xuXKQu
 SvvZoCaablB9NFyBARLw6chgFx/dVRSzp2zwuS/Yf/zHGKCyVT6cIpIjm5EoxqL0GiMe
 P9pr8VMmP5wnjn2kbsDjN6Kt4yx8FcLFn25pHRC0HdudaCum1VbCqRmu0RepI+MVWFLf Tw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7u8c9hsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 15:23:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35FFN8Zs002629
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 15:23:08 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 15 Jun
 2023 08:23:07 -0700
Message-ID: <af6fb581-42c7-2619-82ce-8bd590ec629e@quicinc.com>
Date:   Thu, 15 Jun 2023 09:23:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] accel/qaic: Call DRM helper function to destroy prime GEM
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        <quic_carlv@quicinc.com>, <quic_pkanojiy@quicinc.com>,
        <sukrut.bellary@linux.com>, <sumit.semwal@linaro.org>
CC:     <ogabbay@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-media@vger.kernel.org>
References: <20230614161528.11710-1-quic_jhugo@quicinc.com>
 <87ce15c9-670e-f270-94b7-580b0a54f59f@amd.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <87ce15c9-670e-f270-94b7-580b0a54f59f@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hUxM7iksB7MhaGd6cTFMcjdglreF6WMh
X-Proofpoint-GUID: hUxM7iksB7MhaGd6cTFMcjdglreF6WMh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_11,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 mlxlogscore=868 malwarescore=0
 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150134
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/2023 1:05 AM, Christian König wrote:
> 
> 
> Am 14.06.23 um 18:15 schrieb Jeffrey Hugo:
>> From: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
>>
>> smatch warning:
>>     drivers/accel/qaic/qaic_data.c:620 qaic_free_object() error:
>>         dereferencing freed memory 'obj->import_attach'
>>
>> obj->import_attach is detached and freed using dma_buf_detach().
>> But used after free to decrease the dmabuf ref count using
>> dma_buf_put().
>>
>> drm_prime_gem_destroy() handles this issue and performs the proper clean
>> up instead of open coding it in the driver.
>>
>> Fixes: ff13be830333 ("accel/qaic: Add datapath")
>> Reported-by: Sukrut Bellary <sukrut.bellary@linux.com>
>> Closes: 
>> https://lore.kernel.org/all/20230610021200.377452-1-sukrut.bellary@linux.com/ 
>>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
>> Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>
>> Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
>> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>

Thanks for the guidance and review!
