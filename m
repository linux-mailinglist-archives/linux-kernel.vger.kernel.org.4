Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399586B7602
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjCMLbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjCMLas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:30:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9B062D82;
        Mon, 13 Mar 2023 04:30:25 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DBAwZ7011505;
        Mon, 13 Mar 2023 11:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GCDRlWhgsHLTAazD4f3BhOMbT5LEvvKtXFVVcMsoPCA=;
 b=QQnJAArsy5fAnglW92jO5DaOLsY5zOyzCg5Bb48rHwEfvSlgHbPCcmhEqBpoMZmOzjZh
 iRmAUZB/RGtQMz8G2dQIrPmGzFKpVlVC8DK85PXAyLGGnBklK3MVcMkqjcD1KL2o4aAe
 UNug3ifRYKJombdRSmk4qUUjx/emIoilasb/w0QzxHgQqZsWKIFf2k3Bxls3hvN87dyO
 +sdwnE8G3YUpcPWE/2EmGr8gyeiBMyUiBtAWkgTy5WSDMoQopeXybwFBE45PvyGOB9IO
 Cuq8sfBWc0weKJHnyYg2DHOMwTrzLG/tWbHwfXMdFJrk4+xXHPLKUINFpmmskJWvKErb PQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p8fbncyy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 11:29:58 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32DBTwl3009257
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 11:29:58 GMT
Received: from [10.239.155.136] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 13 Mar
 2023 04:29:54 -0700
Message-ID: <aed019c6-9729-1892-2c8f-c97bcc7efd35@quicinc.com>
Date:   Mon, 13 Mar 2023 19:29:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1] scsi: ufs: core: print trs for pending requests in MCQ
 mode
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, <quic_asutoshd@quicinc.com>,
        <quic_cang@quicinc.com>, <quic_nguyenb@quicinc.com>,
        <mani@kernel.org>, <stanley.chu@mediatek.com>,
        <adrian.hunter@intel.com>, <beanhuo@micron.com>,
        <avri.altman@wdc.com>, <junwoo80.lee@samsung.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1678338122-88611-1-git-send-email-quic_ziqichen@quicinc.com>
 <3d858407-481b-a55b-4aa9-513e4a4ca44e@acm.org>
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
In-Reply-To: <3d858407-481b-a55b-4aa9-513e4a4ca44e@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dmpS9neOlYwQLTFFDySKd_rO1KgXs2c2
X-Proofpoint-GUID: dmpS9neOlYwQLTFFDySKd_rO1KgXs2c2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_05,2023-03-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130095
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

Good idea, let met re-design it.

Thanks,
Ziqi

On 3/10/2023 1:28 AM, Bart Van Assche wrote:
> On 3/8/23 21:01, Ziqi Chen wrote:
>> +static void ufshcd_print_trs_all(struct ufs_hba *hba, bool pr_prdt)
>> +{
>> +    const struct ufshcd_lrb *lrbp;
>> +    int tag;
>> +
>> +    for (tag = 0; tag < hba->nutrs; tag++) {
>> +        lrbp = &hba->lrb[tag];
>> +
>> +        if (lrbp->cmd)
>> +            ufshcd_print_tr(hba, tag, pr_prdt);
>>       }
>>   }
> 
> There is a race in this code: lrbp->cmd may be cleared after it has been 
> read and before or while ufshcd_print_tr() is in progress. How about 
> preventing that race by blk_mq_tagset_busy_iter() to iterate over 
> pending SCSI commands?
> 
> Thanks,
> 
> Bart.
