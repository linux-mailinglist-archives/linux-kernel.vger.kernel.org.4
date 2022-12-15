Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2242A64D53B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 03:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiLOCHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 21:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiLOCHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 21:07:06 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DC336C42;
        Wed, 14 Dec 2022 18:07:05 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BELoELT007319;
        Thu, 15 Dec 2022 02:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gE007DxYZgdgs2mVn1V5/kYJmCVeBF+/XYbJuzRSCfs=;
 b=U95QCCl3JNSo7AE8GJeAgCSbEUiKI6YcqL/JbsDUIFFSB3eyJSEZyvTQ/WPkLlgoBaHB
 Ehy9txYSaq4pRcYSbpQyDao44EM2E4UunhyWFPZ6MdvFycnNVhlXONbdxIlR+WdncMkF
 VnkOx5VE6tGLmw+elYSOscjRcACX2LT0G81BFLkmGYP95RJLzu5T3Ed/dNVSZUsCDTKf
 1cw/u39VFMyefyx/GH93gic3XFZCpFH2TvNvU16kJZTZ+/p/4LTzyG891vKiKlJZ1UAK
 Uuz5c73OfdZpjQjr5Nlyo6S9phTplHUJtFvhcmTH7/+whBGvz2M9wJG+hS8qMFPG/QAP UQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mf6rkjy79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 02:06:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BF26f3I022214
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 02:06:41 GMT
Received: from [10.253.35.151] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 14 Dec
 2022 18:06:37 -0800
Message-ID: <4ebba197-b6b8-8acc-d5dc-e4b36c17a4c1@quicinc.com>
Date:   Thu, 15 Dec 2022 10:06:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH v2 2/3] ufs: core: mcq: Add Event Specific Interrupt
 enable and config APIs
To:     Bart Van Assche <bvanassche@acm.org>, <quic_asutoshd@quicinc.com>,
        <mani@kernel.org>, <stanley.chu@mediatek.com>,
        <adrian.hunter@intel.com>, <beanhuo@micron.com>,
        <avri.altman@wdc.com>, <junwoo80.lee@samsung.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        "open list" <linux-kernel@vger.kernel.org>
References: <1670990763-30806-1-git-send-email-quic_cang@quicinc.com>
 <1670990763-30806-3-git-send-email-quic_cang@quicinc.com>
 <1e224fa1-7cb3-25cb-8e63-df42b137e96a@acm.org>
Content-Language: en-US
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <1e224fa1-7cb3-25cb-8e63-df42b137e96a@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Pmb9Y0qZE_EftX02cQRFi07XvVrRn1TT
X-Proofpoint-ORIG-GUID: Pmb9Y0qZE_EftX02cQRFi07XvVrRn1TT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_12,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 mlxlogscore=819 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212150013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On 12/15/2022 9:05 AM, Bart Van Assche wrote:
> On 12/13/22 20:06, Can Guo wrote:
>> Add two APIs to enable ESI and config ESI base addresses.
>
> If this patch is reposted, please change "APIs" into "functions" and 
> add a sentence to explain that calls to the exported functions will be 
> added by the next patch in this series.
>
> Thanks,
>
> Bart.


Thank you Bart for your review. I will upload a new version to adopt 
your comments.

Best Regard,

Can Guo.

