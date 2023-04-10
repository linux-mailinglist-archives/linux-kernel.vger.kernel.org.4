Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A116DC7EA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 16:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjDJOfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 10:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDJOfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 10:35:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D64524E;
        Mon, 10 Apr 2023 07:35:20 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AEUM3F013007;
        Mon, 10 Apr 2023 14:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UMgwG8hgDhYMcCE1N2y8m6s3Gz6llWV5GsBaLDYEGGI=;
 b=i2KQebFTfm3MY4r5aAcmqpKbP69brZ3Cowt6x00Bv5N2pKHPrZz2HKWWMa4M4h6uWZNm
 7OWVI5fC6U/Kh5MwdcUGMSIOTf4qTfrAKFar+7HeQluRn49VniEQ0Rw6DRdNMmTXra0c
 sar0xryuz4Zp1DvIILYcPCgPj4ILTBUZhbTsyI+92CtHAUcRp2oC7mIRggmmTtM8i/TQ
 KfCGaNmZTO1FpXQ7PKsZ/RBiC1lY5pugH63+ySKiRbO70hdQPIQJrJ57wOpi/MmeOMZw
 XdwjvfNGMZFCrGECq0BM6ozU8Vq+0Oh3F9FsID/cW6zSJ3QYV5nVqEF61QcRx6nyhBBf nA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pvm97g0c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 14:35:13 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33AEZCwK028213
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 14:35:12 GMT
Received: from [10.216.41.177] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 10 Apr
 2023 07:35:09 -0700
Message-ID: <4b54b75c-f604-5323-942e-4701e31f47d6@quicinc.com>
Date:   Mon, 10 Apr 2023 20:04:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v6 0/5] Refactor to support multiple download mode
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
References: <1680076012-10785-1-git-send-email-quic_mojha@quicinc.com>
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1680076012-10785-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hnLcWnoNpdjo3V97U9CGe9Zv9-dDVwVt
X-Proofpoint-ORIG-GUID: hnLcWnoNpdjo3V97U9CGe9Zv9-dDVwVt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_09,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304100123
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn and others,

Any further comments on this series ?

-- Mukesh

On 3/29/2023 1:16 PM, Mukesh Ojha wrote:
> Intention of this series to support multiple download mode and
> only modify the required bits during setting tcsr register.
> 
> Other download modes are minidump, full dump, both fulldump + minidump, nodump.
> 
> Latest minidump kernel driver patches has been sent here
> https://lore.kernel.org/lkml/1679491817-2498-1-git-send-email-quic_mojha@quicinc.com/
> 
> Also, this series should be applied on
> https://lore.kernel.org/lkml/1678979666-551-1-git-send-email-quic_mojha@quicinc.com/
> 
> Changes in v6:
>    - Applied suggested API change(at v4) by [dmitry.baryshkov]
> 
> Changes in v5: https://lore.kernel.org/lkml/1680017869-22421-1-git-send-email-quic_mojha@quicinc.com/
>    - Tried to fix the issue reported by kernel test robot
>      https://lore.kernel.org/lkml/202303280535.acb66sQT-lkp@intel.com/
> 
>    - Applied some of the improvement suggested by [Bjorn.andersson]
>   
>      . Dropped 'both' instead support full,mini or mini,full for setting download
>      mode to collect both minidump and full dump.
>      
>      . logging improvement.
>      
> 
> Changes in v4: https://lore.kernel.org/lkml/1679935281-18445-1-git-send-email-quic_mojha@quicinc.com/
>    - val should be shifted within the function [srinivas.kandagatla]
>      i.e new = (old & ~mask) | (val << ffs(mask) - 1);
>    - Added Acked-by [linus.walleij] on pinctrl change.
> 
> Changes in v3 : https://lore.kernel.org/lkml/1679070482-8391-1-git-send-email-quic_mojha@quicinc.com/
>   - Removed [1] from the series and sent as a separate patch[2], although this series
>     should be applied on top [2].
>    [1] https://lore.kernel.org/lkml/1677664555-30191-2-git-send-email-quic_mojha@quicinc.com/
>    [2] https://lore.kernel.org/lkml/1678979666-551-1-git-send-email-quic_mojha@quicinc.com/
>   - Introduce new exported symbol on suggestion from [srinivas.kandagatla]
>   - Use the symbol from drivers/pinctrl/qcom/pinctrl-msm.c.
>   - Addressed comment given by [dmitry.baryshkov]
>   - Converted non-standard Originally-by to Signed-off-by.
> 
> Changes in v2: https://lore.kernel.org/lkml/1677664555-30191-1-git-send-email-quic_mojha@quicinc.com/
>   - Addressed comment made by [bjorn]
>   - Added download mask.
>   - Passed download mode as parameter
>   - Accept human accepatable download mode string.
>   - enable = !!dload_mode
>   - Shifted module param callback to somewhere down in
>     the file so that it no longer need to know the
>     prototype of qcom_scm_set_download_mode()
>   - updated commit text.
> 
> Mukesh Ojha (5):
>    firmware: qcom_scm: provide a read-modify-write function
>    pinctrl: qcom: Use qcom_scm_io_update_field()
>    firmware: scm: Modify only the download bits in TCSR register
>    firmware: qcom_scm: Refactor code to support multiple download mode
>    firmware: qcom_scm: Add multiple download mode support
> 
>   drivers/firmware/Kconfig               | 11 -----
>   drivers/firmware/qcom_scm.c            | 88 ++++++++++++++++++++++++++++++----
>   drivers/pinctrl/qcom/pinctrl-msm.c     | 11 ++---
>   include/linux/firmware/qcom/qcom_scm.h |  2 +
>   4 files changed, 86 insertions(+), 26 deletions(-)
> 
