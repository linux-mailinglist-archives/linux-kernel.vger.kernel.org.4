Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB586BA96F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjCOHgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjCOHgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:36:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1797F2597C;
        Wed, 15 Mar 2023 00:33:19 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32F6mvEs017010;
        Wed, 15 Mar 2023 07:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LH+TSvTjRGvXKwA78t2b1ZRjLec2Gy2NWtX1+MviS8k=;
 b=YCuWAkTqCAK3AtTsKsm8mv996en94G02v4IkyEbt5sjf6fIIn771kQDGhc8StQg3BZSB
 Tdlbi9EYNyxPXmwB45ZX5t10Jfur30WXQhRdrM6gDPytuCT6ezHp1t63tAGqJP+wx0JA
 MHj1jASEveBduvjVNNTRDUNO0fog0MhnYqBlKg77ithx8uZyYuzjcjxMr4tKHKK31g4O
 Lt9m3FHKyli0a/bLs4Blh+XVRSW9ZIORa+dxFqJ9YP/s7TpyGkdU/EhHpgy/e8Qxlcg2
 4uj19i+SHO6z5h1ZJwxUywNO21ZZO4u5kZadP/Z5UQ6/St7YjAmJm8H3RN7eHdSusjv5 aw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pb2cr0ub9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 07:31:17 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32F7VGjZ002580
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 07:31:16 GMT
Received: from [10.239.155.136] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Mar
 2023 00:31:12 -0700
Message-ID: <52bd8c2d-31f6-1f69-1d83-cf21ee66aec8@quicinc.com>
Date:   Wed, 15 Mar 2023 15:31:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] scsi: ufs: core: print trs for pending requests in MCQ
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
References: <1678792597-3232-1-git-send-email-quic_ziqichen@quicinc.com>
 <bde102c7-ab4f-a301-072f-8d6b7acde8a8@acm.org>
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
In-Reply-To: <bde102c7-ab4f-a301-072f-8d6b7acde8a8@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AsiB4Ym38SApLA7cckQgK6xKoVWTq-WD
X-Proofpoint-GUID: AsiB4Ym38SApLA7cckQgK6xKoVWTq-WD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_03,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150063
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sure

Best Regards,
Ziqi

On 3/15/2023 2:09 AM, Bart Van Assche wrote:
> On 3/14/23 04:16, Ziqi Chen wrote:
>> +static bool ufshcd_print_tr_iter(struct request *req, void *priv)
>> +{
>> +    struct scsi_device *sdev = req->q->queuedata;
>> +    struct Scsi_Host *shost = sdev->host;
>> +    struct ufs_hba *hba = shost_priv(shost);
>> +
>> +    if (!IS_ERR_OR_NULL(hba))
>> +        ufshcd_print_tr(hba, req->tag, *(bool *)priv);
> 
> I think that the "if (!IS_ERR_OR_NULL(hba))" code can be removed safely. 
> Otherwise this patch looks good to me.
> 
> Thanks,
> 
> Bart.
