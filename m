Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED17666C62
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbjALIaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbjALIaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:30:11 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C002A4D4A2;
        Thu, 12 Jan 2023 00:30:10 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30C71Ft0024075;
        Thu, 12 Jan 2023 08:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1KeFc0rxwtO+4MEFc4bvKbcwwnsyekLp+W9OB910U98=;
 b=Wtz/kqvQK6y8SDwVp/5nZYqpczHMFbaOBEgjZHI6r//MMtP8j/vEpq5GHF7qQ70wIeA+
 UFhTHTFsq+VE2Rf43UksETkkAT4RHkbPMcqoZY9bNc9GpDRy4U2WLreQPI5m+9igsT/j
 1zwURYBX++awLsytHiLD87KrbtbQu5nEhi3t2qGZodWK50ES8wKSwTVZy6M9IYJs9kBm
 y2Sn7k6arAENOi4b9gRux+00Vv69+hZoO2eLMMQcACoYcJwCCq19fWJD31RR3ycR6pcT
 gInhQn0zYFkUzICm/fvMqP7HDsG5PMKFC/XrdzUqK26WElzWZRRfapEhoTNALWTpZwGO 4g== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2d75056b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 08:29:58 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30C8Tv8X024688
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 08:29:57 GMT
Received: from [10.216.26.66] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 12 Jan
 2023 00:29:55 -0800
Message-ID: <c0112826-1a65-e1cc-db98-e692a312ecb0@quicinc.com>
Date:   Thu, 12 Jan 2023 13:59:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] pstore/ram: Rework logic for detecting ramoops
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        <keescook@chromium.org>, <tony.luck@intel.com>
CC:     <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1673428065-22356-1-git-send-email-quic_mojha@quicinc.com>
 <217ebecf-3630-b423-ea0b-037e0943e17b@igalia.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <217ebecf-3630-b423-ea0b-037e0943e17b@igalia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4ZmMDIfZOMuyLs09CWnqK2ojVjMlbm4D
X-Proofpoint-GUID: 4ZmMDIfZOMuyLs09CWnqK2ojVjMlbm4D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_04,2023-01-11_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 mlxlogscore=963 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120059
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guilherme,

On 1/11/2023 6:31 PM, Guilherme G. Piccoli wrote:
> Thanks for the patch Mukesh! I don't have a DT hardware at hand right
> now, so cannot test this one myself. I'll just provide a (really) minor
> feedback, something to address in a potential V2 or even in merge time,
> see below.
> 
> 
> On 11/01/2023 06:07, Mukesh Ojha wrote:
>> The reserved memory region for ramoops is assumed to be at a fixed
>> and known location when read from the devicetree. This is not desirable
>> in environments where it is preferred the region to be dynamically
>> allocated at runtime, as opposed to being fixed at compile time.
>>
>> Also, Some of the platforms might be still expecting dedicated
> 
> I'd write "Also, some" instead of upper "Some".

> 
>> memory region for ramoops node where the region is known
>> beforehand and platform_get_resource() is used in that case.
>>
>> So, Add logic to detect the start and size of the ramoops memory
> 
> Same here, maybe "So, add".
> 

Thanks for the review.

Will fix it along with other comments.
Also, let me know if we need to change binding or document update as well.

-Mukesh

> Really minor nits, though!
> Cheers
> 
> 
> Guilherme
