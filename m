Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCAA705E16
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 05:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjEQD1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 23:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjEQD0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 23:26:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E827F3C07;
        Tue, 16 May 2023 20:26:30 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34H2udgV032440;
        Wed, 17 May 2023 03:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HmmCijOrb4yVr1n/H8Ak4RhDHBrqeGMDmGSnhfMa82w=;
 b=mHLUM9k2IusSTp2VAbBT+3xtmAxzU+9bMEf7BDE4w1Q9lZ7SyTh9iPRZwL+l9500xhEr
 txhnEwKrh5oNiaBSD0SYLfNq1FAdJs4NUiMpTlEH9E0ws1ndfkg3XCvJ8ede0sROTCfq
 ozXjxi125F14QuJ6L66pht1kinEg6N9+lh33zbFVq4CdUjUVI4PDnb62C09/kduCcqUP
 0mGWpTob0+XMlM38WsW1XWLOq3AtCXcIQouLnfaHgPdU8bYZJ8ywG9+lhG3UlAG7gyou
 l4eIdnEV1CQ+e8lcan8WVuALyrYQDr4e6zNSSJW2tbxPAhoplBekYaFemyMfEf42+nXV sg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qm74pa2de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 03:26:13 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34H3Q05d017233
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 03:26:00 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 16 May
 2023 20:25:59 -0700
Message-ID: <8626b0e2-66dd-73de-7b6e-8074e49b78d2@quicinc.com>
Date:   Tue, 16 May 2023 20:25:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 5/7] ufs: mcq: Added ufshcd_mcq_abort()
Content-Language: en-US
To:     Stanley Chu <chu.stanley@gmail.com>
CC:     <quic_asutoshd@quicinc.com>, <quic_cang@quicinc.com>,
        <bvanassche@acm.org>, <mani@kernel.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Alice Chao" <alice.chao@mediatek.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1683872601.git.quic_nguyenb@quicinc.com>
 <45743dac476e3b2bffb17eaf915fe7f48f87bbac.1683872601.git.quic_nguyenb@quicinc.com>
 <CAGaU9a_EVkPa0eVMFmqmJ2fEkTy+XD7nKezMX0S0uQDeWkr10Q@mail.gmail.com>
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <CAGaU9a_EVkPa0eVMFmqmJ2fEkTy+XD7nKezMX0S0uQDeWkr10Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YoUl1kE51kVV5JzF5s-G-6hw9Bt1ABN0
X-Proofpoint-ORIG-GUID: YoUl1kE51kVV5JzF5s-G-6hw9Bt1ABN0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=930 suspectscore=0
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170028
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/2023 8:15 PM, Stanley Chu wrote:
> Hi Bao D.
> 
>> @@ -7562,6 +7561,12 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
>>          if (is_mcq_enabled(hba))
>>                  goto release;
> 
> Should we remove the above lines because the code below will not be
> executed in the MCQ path?
Thanks Stanley. It was my silly rebase mistake :-(. I will fix it.

Thanks,
Bao
> 
>>
>> +       if (is_mcq_enabled(hba)) {
>> +               /* MCQ mode. Branch off to handle abort for mcq mode */
>> +               err = ufshcd_mcq_abort(cmd);
>> +               goto release;
>> +       }
>> +
>>          /* Skip task abort in case previous aborts failed and report failure */
>>          if (lrbp->req_abort_skip) {
>>                  dev_err(hba->dev, "%s: skipping abort\n", __func__);
>> --
>> 2.7.4
>>

