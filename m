Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FED86A0693
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbjBWKuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjBWKuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:50:22 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9026F4DE07;
        Thu, 23 Feb 2023 02:50:21 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31N4aVSV010238;
        Thu, 23 Feb 2023 10:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dpHHOTQL0vu/OdGcZRzOHJHSAOCpbEnrKs2wec7UtXM=;
 b=l3FEZ24rd/C1dU7DfeQ1v3T/Vu02ZxSFhIUzMjihRwkVHEpDkQaMa4qrQnk53B7iZs6S
 PAOIxs71o6aUTZ/7/Be3WsOTbSkRuRH334vy0WgwtRVK3qJO8dOXh3K4MeZ704eXv5a1
 MMsYRqnly8GxhdiARDi3V3kbO+PlUQE+Uq0V0d4vb6PgcXs3HtVYnLw+91oLlq0Rapti
 Qj4X19As+KzTtu8T633aW09dC9gEjGk9hlkIIsCVJ1/cjhptgYBBk3A6GhJsewDbLpgQ
 Z3EMvOVDFRcLMBf10GKKHCtn+nfJaxlfVIKd/Mo0Es3OYbUa8U29Czoq9bPCXAc9VFTa +A== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwydks1um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 10:50:08 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31NAo7Kg019864
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 10:50:07 GMT
Received: from [10.239.155.136] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 23 Feb
 2023 02:50:01 -0800
Message-ID: <3b26b123-0bd1-24ed-f6d7-36e08296a5a5@quicinc.com>
Date:   Thu, 23 Feb 2023 18:49:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 4/7] scsi: ufs: core: Add hwq print for debug
Content-Language: en-US
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
To:     Po-Wen Kao <powen.kao@mediatek.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <quic_ziqichen@quicinc.com>
CC:     <wsd_upstream@mediatek.com>, <peter.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <alice.chao@mediatek.com>,
        <naomi.chu@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <cc.chou@mediatek.com>, <eddie.huang@mediatek.com>,
        <mason.zhang@mediatek.com>, <chaotian.jing@mediatek.com>,
        <jiajie.hao@mediatek.com>, <quic_cang@quicinc.com>,
        <quic_asutoshd@quicinc.com>
References: <20230222030427.957-1-powen.kao@mediatek.com>
 <20230222030427.957-5-powen.kao@mediatek.com>
 <1b9c2bc9-a349-062a-597c-336804c05394@quicinc.com>
In-Reply-To: <1b9c2bc9-a349-062a-597c-336804c05394@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: quNqPQ_udvQ72idyPGPky3KIo3iE9Cyk
X-Proofpoint-GUID: quNqPQ_udvQ72idyPGPky3KIo3iE9Cyk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_06,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxlogscore=906
 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302230092
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/23/2023 6:14 PM, Ziqi Chen wrote:

> Hi Po-Wen,
>
> On 2/22/2023 11:04 AM, Po-Wen Kao wrote:
>> +void ufshcd_mcq_print_hwqs(struct ufs_hba *hba, unsigned long bitmap)
>> +{
>> +    int id, i;
>> +    char prefix[15];
>> +
>> +    if (!is_mcq_enabled(hba))
>> +        return;
>> +
>> +    for_each_set_bit(id, &bitmap, hba->nr_hw_queues) {
>> +        snprintf(prefix, sizeof(prefix), "q%d SQCFG: ", id);
>> +        ufshcd_hex_dump(prefix,
>> +            hba->mcq_base + MCQ_QCFG_SIZE * id, MCQ_QCFG_SQ_SIZE);
>
> Is your purpose dump per hardware queue registers here?  If yes, why 
> don't use ufsmcq_readl() to save to a buffer and then use 
> ufshcd_hex_dump()
>
> to dump ? Are you sure ufshcd_hex_dump() can dump register directly?
>
>> +
>> +        snprintf(prefix, sizeof(prefix), "q%d CQCFG: ", id);
>> +        ufshcd_hex_dump(prefix,
>> +            hba->mcq_base + MCQ_QCFG_SIZE * id + MCQ_QCFG_SQ_SIZE, 
>> MCQ_QCFG_CQ_SIZE);
> Same to above comment.
>> +
>> +        for (i = 0; i < OPR_MAX ; i++) {
>> +            snprintf(prefix, sizeof(prefix), "q%d OPR%d: ", id, i);
>> +            ufshcd_hex_dump(prefix, mcq_opr_base(hba, i, id), 
>> mcq_opr_size[i]);
> Same.
>> +        }
>> +    }
>> +}
>> +
>>
>>   @@ -574,7 +569,16 @@ void ufshcd_print_trs(struct ufs_hba *hba, 
>> unsigned long bitmap, bool pr_prdt)
>>           if (pr_prdt)
>>               ufshcd_hex_dump("UPIU PRDT: ", lrbp->ucd_prdt_ptr,
>>                   ufshcd_sg_entry_size(hba) * prdt_length);
>> +
>> +        if (is_mcq_enabled(hba)) {
>> +            cmd = lrbp->cmd;
>> +            if (!cmd)
>> +                return;
>> +            hwq = ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(cmd));
>> +            ufshcd_mcq_print_hwqs(hba, 1 << hwq->id);
>
> Calling registers dump function in ufshcd_print_trs() is not 
> reasonable, eg.. for each aborted request, it would print out all hwq 
> registers, it's not make sense.
>
> I think we should move it out of ufshcd_print_trs().

One more thing,  ufshcd_err_handler() pass hba-> outstanding_reqs to 
ufshcd_print_trs() as the 2nd parameter, but the hba-> outstanding_reqs 
is not used in MCQ mode.

I am making a change to print trs for MCQ mode by trying to get bitmap 
of started Reqs from block layer .

My opinion is keeping ufshcd_print_trs just print UPIU details , don't 
invoke register dump.

>
>> +        }
>>       }
>> +
>>   }
>
>
> Best Regards,
>
> Ziqi
>
