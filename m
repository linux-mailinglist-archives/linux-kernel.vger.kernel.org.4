Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E755B4293
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 00:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiIIWos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 18:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiIIWoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 18:44:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503B125EB;
        Fri,  9 Sep 2022 15:44:42 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289MeJrX015693;
        Fri, 9 Sep 2022 22:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5VSAvl4MpEJJL3ZgqfEcxzGo7P0NUZPOM8t93DEhOo0=;
 b=BidfJ3Wxc0W2V8ubNp+Y34pA3hzbO3wrlmkYG3RnNYa8s0UnA5d2CSbFRtH0RK+lreNs
 ZPj4ImKHM2TO/RWv4g8RSL9yUpKSPQo0qTM1v+kkGyAICtqn1hlhLeCCfTBdgb/0CU08
 lLL3kAkwC3Wtpo4JlAwGjAG3WGP/cRXHBaEY1mO2dJp9Nlkr/Oa+GozxgUjS4IMrf1I2
 GsCXY88VuFPr/UNWzAz8BKEv9iJ40efPsUtQ2dUPeMrRGpx6fe4RHtDTuZAroydgKRh5
 cgS3C/ex2C3o+YmvvJiR3XZWltGqlP1of/RS9RVlfvTiR0G/vGLDo/byLgZK6QVH1Vld UQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jg3c227nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 22:43:33 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 289MhXaL017376
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Sep 2022 22:43:33 GMT
Received: from [10.110.3.137] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 9 Sep 2022
 15:43:32 -0700
Message-ID: <6e703439-6269-e7ff-33c0-93a204f329d2@quicinc.com>
Date:   Fri, 9 Sep 2022 15:43:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [RFC PATCH v3 4/4] ufs: host: qcom: Add MCQ support
To:     Bart Van Assche <bvanassche@acm.org>, <quic_nguyenb@quicinc.com>,
        <quic_xiaosenh@quicinc.com>, <stanley.chu@mediatek.com>,
        <adrian.hunter@intel.com>, <avri.altman@wdc.com>,
        <mani@kernel.org>, <quic_cang@quicinc.com>, <beanhuo@micron.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1662157846.git.quic_asutoshd@quicinc.com>
 <260533ec3a80442b73d3999727bf0a9861462eba.1662157846.git.quic_asutoshd@quicinc.com>
 <3ea54f9b-896d-c70b-9024-4dc4f99ec2d4@acm.org>
From:   "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>
In-Reply-To: <3ea54f9b-896d-c70b-9024-4dc4f99ec2d4@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ipXi89kmF6va25GTgp_-oumEUfO78jLS
X-Proofpoint-ORIG-GUID: ipXi89kmF6va25GTgp_-oumEUfO78jLS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_10,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090078
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bart,
Thanks for taking a look.

On 9/8/2022 3:30 PM, Bart Van Assche wrote:
> On 9/2/22 15:41, Asutosh Das wrote:
>> +static int ufs_qcom_get_hba_mac(struct ufs_hba *hba)
>> +{
>> +    return MAX_SUPP_MAC;
>> +}
> 
> The above implementation is not sufficient to convince me that the 
> get_hba_mac vop is useful. Please remove this vop and use MAX_SUPP_MAC 
> directly where ufshcd_mcq_vops_get_hba_mac() is called.
> 
The default value of MAC is 32 but it can have a max value of 256.
Here it has a value of 64.
So I think this vops would be helpful for other HC vendors as well who 
may have a different value than the default.

> Thanks,
> 
> Bart.

-asd
