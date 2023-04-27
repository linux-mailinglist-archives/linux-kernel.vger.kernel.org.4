Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD926F07C0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243934AbjD0Ozr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjD0Ozp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:55:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDA81B8;
        Thu, 27 Apr 2023 07:55:43 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33REUYRh005271;
        Thu, 27 Apr 2023 14:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iBQavXz+ItIIWLPZ1d11gTZVibRiTh6uStR9DopKvVY=;
 b=VvzHbk8wtOI4vnthVjleM7aKGpEZRIQWmwfQPbeqUiPQZQIzQNMQ/+cFDiDy+T785qlr
 Ok9BI8FUcYUBaCFzApmIxDh6Intyyc5zn4yH8bvMiRtAu27NK2JwcSebWeVQjAgi273t
 d2wTvgnQeFjZNqSlky3+bsXJcj24tdrkranWDppxvhML3FvjhLyp5irdatuG2RX//o+z
 /9SA+OMFp/s3AfXXgaHXhbDj6+Ilx1+WyHKcin2GH1CjnPe3wTgLpVnENoaCvBFuX27m
 OED1skNNTGMJWrZnM9UjJDDCK+iNls7DazkhHFUuGFDKXzwG5Iu8oXPoAmHTAljRQfjI rw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q7dh2hvtx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 14:54:21 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33REs0b9026052
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 14:54:00 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 27 Apr
 2023 07:54:00 -0700
Message-ID: <33ee6958-8109-5f67-a69d-0c514cdb9717@quicinc.com>
Date:   Thu, 27 Apr 2023 07:54:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 1/1] scsi: ufs: core: correct utp_transfer_cmd_desc
 size
Content-Language: en-US
To:     Avri Altman <Avri.Altman@wdc.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "mani@kernel.org" <mani@kernel.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Alice Chao" <alice.chao@mediatek.com>,
        open list <linux-kernel@vger.kernel.org>
References: <4b778dbcfd1fc40140292166834f13e8d5b8e4d2.1682575115.git.quic_nguyenb@quicinc.com>
 <DM6PR04MB65750D13F7417242DB51E98CFC6A9@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <DM6PR04MB65750D13F7417242DB51E98CFC6A9@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: I5tdfg9rFyNjguJGfYVjwdGEe0_KTshO
X-Proofpoint-GUID: I5tdfg9rFyNjguJGfYVjwdGEe0_KTshO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_07,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304270130
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/2023 2:57 AM, Avri Altman wrote:
>> When allocating memory for the UTP Command Descriptor
>> hba->ucdl_base_addr in ufshcd_memory_alloc(), the macro
>> sizeof_utp_transfer_cmd_desc() is used to calculate the size of the memory
>> allocation. This macro includes the prd_table as part of the UTP Command
>> Descriptor memory. However, when freeing this memory in the
>> ufshcd_release_sdb_queue(), the sizeof(struct utp_transfer_cmd_desc) is
>> used, and it does not include the prd_table size for the memory to be freed.
>> This results in a mismatch of memory size allocated/freed.
>>
>> Similarly, the ufshcd_mcq_get_tag() incorrectly uses the sizeof(struct
>> utp_transfer_cmd_desc) to find the tag number.
>> This results in failing to probe.
>>
>> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> Looks like this fix is suggested here as well -
> https://www.spinics.net/lists/linux-scsi/msg184092.html

Hi Avri, Thanks. Yes, that patch should cover half of the issues raised 
by my patch.

Let me request the owner to include the change in 
ufshcd_release_sdb_queue() as well.

> Thanks,
> Avri
>
>> ---
>>   drivers/ufs/core/ufs-mcq.c | 2 +-
>>   drivers/ufs/core/ufshcd.c  | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c index
>> 202ff71..b7c5f39 100644
>> --- a/drivers/ufs/core/ufs-mcq.c
>> +++ b/drivers/ufs/core/ufs-mcq.c
>> @@ -265,7 +265,7 @@ static int ufshcd_mcq_get_tag(struct ufs_hba *hba,
>>          addr = (le64_to_cpu(cqe->command_desc_base_addr) & CQE_UCD_BA) -
>>                  hba->ucdl_dma_addr;
>>
>> -       return div_u64(addr, sizeof(struct utp_transfer_cmd_desc));
>> +       return div_u64(addr, sizeof_utp_transfer_cmd_desc(hba));
>>   }
>>
>>   static void ufshcd_mcq_process_cqe(struct ufs_hba *hba, diff --git
>> a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c index
>> 9434328..b009e55 100644
>> --- a/drivers/ufs/core/ufshcd.c
>> +++ b/drivers/ufs/core/ufshcd.c
>> @@ -8444,7 +8444,7 @@ static void ufshcd_release_sdb_queue(struct
>> ufs_hba *hba, int nutrs)  {
>>          size_t ucdl_size, utrdl_size;
>>
>> -       ucdl_size = sizeof(struct utp_transfer_cmd_desc) * nutrs;
>> +       ucdl_size = sizeof_utp_transfer_cmd_desc(hba) * nutrs;
>>          dmam_free_coherent(hba->dev, ucdl_size, hba->ucdl_base_addr,
>>                             hba->ucdl_dma_addr);
>>
>> --
>> 2.7.4


