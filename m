Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D89E6C656D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjCWKnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjCWKmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:42:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2391E39B93;
        Thu, 23 Mar 2023 03:40:00 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N9c2jD012567;
        Thu, 23 Mar 2023 10:38:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=x4gGfbzba1hFOh69yFSCSNrEAtDOldJBZZWSAOaH1Tk=;
 b=L9F5G/jjhnIKdp/Nx/uu5HDtA7nrpL48Q13W+cpIPOQTNLQ735zPH7cMrYmPfoCFZh9g
 hiVH/eBv/gYVkXX+QRY0HLykYRkovu3s61CKmoJUvcq1EDXDNNzpXwo9jckbYm1uocR7
 HJn9ZXhgLwpH3ExaLUJBo3P+OR/ptidwRSBqE7fg9ag6Nduh9ygCkAMu2Gdt6V9Obu67
 2EUTgajr1uAo/MBV7JeApI2vsQh5AGj8DblSWg6v3md6TVq/XDWbrPtdFoJJNcIMqKbV
 85w63Fb7CJ6+x3eSVxDJIdS/64Gt00bp6HcGWeMRzti7sRV2BJY6Kb8gFFG52Ppi5UNu oA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pgm9x8461-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 10:38:33 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32NAcW6f015397
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 10:38:33 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 23 Mar
 2023 03:38:32 -0700
Message-ID: <3d34a25b-5311-e660-a724-b1c11bbaf5fc@quicinc.com>
Date:   Thu, 23 Mar 2023 03:38:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH v3 1/5] ufs: mcq: Add supporting functions for mcq
 abort
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, <quic_asutoshd@quicinc.com>,
        <quic_cang@quicinc.com>, <bvanassche@acm.org>, <mani@kernel.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Eric Biggers <ebiggers@google.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1679564391.git.quic_nguyenb@quicinc.com>
 <90b7b370269674fd7c0f505b59e0993c5b95a316.1679564391.git.quic_nguyenb@quicinc.com>
 <e251e5c3-152e-3ebe-aa9f-c5cfa36cfc3f@oracle.com>
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <e251e5c3-152e-3ebe-aa9f-c5cfa36cfc3f@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ut5nuLZeD5l4MgNjxhop62huPm-FlNFM
X-Proofpoint-ORIG-GUID: Ut5nuLZeD5l4MgNjxhop62huPm-FlNFM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230080
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/2023 3:07 AM, John Garry wrote:
> On 23/03/2023 09:53, Bao D. Nguyen wrote:
>> +static int ufshcd_mcq_poll_register(void __iomem *reg, u32 mask,
>> +            u32 val, unsigned long timeout_ms)
>> +{
>> +    unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
>> +    int err = 0;
>> +
>> +    /* ignore bits that we don't intend to wait on */
>> +    val = val & mask;
>> +
>> +    while ((readl(reg) & mask) != val) {
>> +        usleep_range(10, 50);
>> +        if (time_after(jiffies, timeout)) {
>> +            err = -ETIMEDOUT;
>> +            break;
>> +        }
>
> This looks just like readl_poll_timeout()
I will make the change in the next revision. Thanks John.
>
>> +    }
>> +
>> +    return err;
>> +}
>

