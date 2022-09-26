Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA8F5EB30E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiIZVY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiIZVYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:24:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5AEA1A61;
        Mon, 26 Sep 2022 14:24:21 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QKw89X017711;
        Mon, 26 Sep 2022 21:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=bXAKkCAntPpulCJau4s1xvZy9zCHXEPKoWOESym2gbs=;
 b=EkgDyKW0iDTMKvairHXWjeMpY3HZ9zznJRh/gTdJVsnyZbjbUpXkYVyeSeIGnkhZIpyB
 /oECWwXFtk99cv3bgvBjC1pxbzmE/xbRDZqUM9jOjnM5hbMacKIbioy56zRnY5SJLT5b
 cbTvw/mJiiXw0wERdGQlkGXzsfFHob7jbe6iHJ0YL1hJsRrwu48IAMRblz5nqmJ2XOGt
 GZtBQ7X/mnoWWa9pA9fcJ9spfGCD6yOf8TZehxUsHMt3nGOru+IiNANrS8L2QDHMSMdE
 cY3vLCgsCFn5Ex4Dl7MCPG7ZreR9h/ehTztLRLUxK2pcEznuuM59NZ8BIEvgT6T9tb4m 7w== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ju9p69uj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 21:23:47 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28QLNkCX019848
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 21:23:46 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 26 Sep 2022 14:23:46 -0700
Date:   Mon, 26 Sep 2022 14:23:45 -0700
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <quic_nguyenb@quicinc.com>, <quic_xiaosenh@quicinc.com>,
        <quic_cang@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <quic_rampraka@quicinc.com>, <quic_richardp@quicinc.com>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <bvanassche@acm.org>, <avri.altman@wdc.com>, <beanhuo@micron.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v1 06/16] ufs: core: mcq: Calculate queue depth
Message-ID: <20220926212345.GB15228@asutoshd-linux1.qualcomm.com>
References: <cover.1663894792.git.quic_asutoshd@quicinc.com>
 <e0a5115eac57ee19df10bae2e3411cbbc7943303.1663894792.git.quic_asutoshd@quicinc.com>
 <20220926152222.GG101994@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20220926152222.GG101994@thinkpad>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cIhSFhImtXEUo0d7kU2NmWVIH4uikPi1
X-Proofpoint-GUID: cIhSFhImtXEUo0d7kU2NmWVIH4uikPi1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_09,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209260132
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26 2022 at 08:22 -0700, Manivannan Sadhasivam wrote:
>On Thu, Sep 22, 2022 at 06:05:13PM -0700, Asutosh Das wrote:
>> The ufs device defines the supported queuedepth by
>> bqueuedepth which has a max value of 256.
>> The HC defines MAC (Max Active Commands) that define
>> the max number of commands that in flight to the ufs
>> device.
>> Calculate and configure the nutrs based on both these
>> values.
>>
>> Co-developed-by: Can Guo <quic_cang@quicinc.com>
>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
>> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
>> ---

[...]

>>
>> +/**
>> + * ufshcd_mcq_decide_queue_depth - decide the queue depth
>
>ufshcd_mcq_calc_queue_depth - Calculate MCQ queue depth
>
The name ufshcd_mcq_decide_queue_depth was suggested by Bart in his comments.
I don't have a strong opinion on the name, if you do, plmk and I'd change it.

>> + * @hba - per adapter instance

[...]

>> +static int ufs_qcom_get_hba_mac(struct ufs_hba *hba)
>> +{
>> +	/* Default is 32, but Qualcomm HC supports upto 64 */
>
>Hmm, then this should come from ufshcd, no?
>
I'm not sure I understand this comment, please can you elaborate?

>Thanks,
>Mani
