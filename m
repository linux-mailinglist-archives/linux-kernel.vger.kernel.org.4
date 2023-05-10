Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE786FE0DB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237616AbjEJO5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237146AbjEJO5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:57:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C201DF;
        Wed, 10 May 2023 07:57:11 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34AE8D0k014769;
        Wed, 10 May 2023 14:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sM0lPnSnMR85dWalCPE6DM0jV4KlJsaqVN8HJDT/jJI=;
 b=HccFqMlxfqarfy4KiEqPD+LE6H8SSUECSowCbYHa/CELhlaOlLxqwWGXLHh+2ONzJKyT
 jOw689IWLCk+KY5iDo6oo6wzw4Ey2TZqMEpAeUnEZwYv9B8uvzkJzIPQsEj1ufkYCJ7X
 gyBqE81K0cAXufwF3Eb6ZzQGbHxfH55VLQIwUFiTeEuSenP5KXmOWeI5a1ml8MFZAy2g
 w/8rqVYSoYZLNoo+CjPKlC0H23rI+LZWRW9SK31xsVWwR78lU/c36VH+oCHRwh3PKN5G
 NnouW4Ic3YobTe1gMtRcAnAEbP7Arf0ZqaCdkS8KR+WVgD42Go7E3E/4cAFV6UdYqa77 yg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qfw3d1s17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 14:57:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34AEv49n028154
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 14:57:04 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 10 May
 2023 07:57:04 -0700
Message-ID: <2d1fb58f-f98b-ba17-65e9-9ea4b467102a@quicinc.com>
Date:   Wed, 10 May 2023 08:57:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] accel/qaic: silence some uninitialized variable warnings
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
CC:     Oded Gabbay <ogabbay@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <d11ee378-7b06-4b5e-b56f-d66174be1ab3@kili.mountain>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <d11ee378-7b06-4b5e-b56f-d66174be1ab3@kili.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Mug3i2VXkPTwLSIbbbTCpYZj0m2y0eCw
X-Proofpoint-GUID: Mug3i2VXkPTwLSIbbbTCpYZj0m2y0eCw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 mlxlogscore=846 mlxscore=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305100121
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/2023 4:41 AM, Dan Carpenter wrote:
> Smatch complains that these are not initialized if get_cntl_version()
> fails but we still print them in the debug message.  Not the end of
> the world, but true enough.  Let's just initialize them to a dummy value
> to make the checker happy.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks for the cleanup.

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

Could use a fixes tag, and also I'd prefer to maintain the style of 
sorting the variable declaration lines by line length.  Given the minor 
nature of these nits, I plan to address them.
