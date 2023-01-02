Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3321E65AFC1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjABKqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjABKq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:46:27 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F882AF;
        Mon,  2 Jan 2023 02:46:26 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 302A9WxH011645;
        Mon, 2 Jan 2023 10:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mzLGNLJpxiIxYeCOgaG6eZehc2b4S0rmBkztxRJLXAI=;
 b=ksPeoc9iIGbViAYjqsdokF3bF8iG/a1B1HC4Eu96jXdO3NMNA7NA18qetPIsUwMa+qgx
 nwdKPego+Se3UVTIQwqpyOYuyckrBwfkhe5LXof8wViysASmBP1oReVWKbarWG2bhWIw
 tUBDIc9nKOXVvHu1xgagj53CEMf63guZEZ8loFP2FcYCSJjar/f8sAVv5eiKB+CO8sqZ
 crLa5Ji+sR0FAnsMwUhE5te/m+OyeUbj70fxdmUe1bi6sFKl4dwN9XaSbPCFguBumMoG
 gUUrQ6qU+Z9mdiIdj9F1DaDSxv1N/cQf0WZT8MK097yYeJSBtXgSr+adC/XABR0kMIDL +Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mtasqapcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 10:46:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 302AkFLd028662
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 2 Jan 2023 10:46:15 GMT
Received: from [10.206.28.191] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 2 Jan 2023
 02:46:12 -0800
Message-ID: <27041361-dcbd-a50c-3f3a-f774c8cf05b8@quicinc.com>
Date:   Mon, 2 Jan 2023 16:16:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: usb: gadget: f_uac2: Fix incorrect increment of bNumEndpoints
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Pavel Hofman <pavel.hofman@ivitera.com>,
        Joe Perches <joe@perches.com>, Julian Scheel <julian@jusst.de>,
        Colin Ian King <colin.i.king@gmail.com>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1669193290-24263-1-git-send-email-quic_prashk@quicinc.com>
 <Y6XBrF1vLclcJm3w@kroah.com>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <Y6XBrF1vLclcJm3w@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: N3afoVov4V8K6ovU28_ocuCdJ1YV9Qw-
X-Proofpoint-GUID: N3afoVov4V8K6ovU28_ocuCdJ1YV9Qw-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_06,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=327
 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301020098
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23-12-22 08:26 pm, Greg Kroah-Hartman wrote:
> On Wed, Nov 23, 2022 at 02:18:10PM +0530, Prashanth K wrote:
>> Currently connect/disconnect of USB cable calls afunc_bind and
>> eventually increments the bNumEndpoints. And performing multiple
>> plugin/plugout will incorrectly increment bNumEndpoints on the
>> next plug-in leading to invalid configuration of descriptor and
>> hence enumeration failure.
>>
>> Fix this by resetting the value of bNumEndpoints to 1 on every
>> afunc_bind call.
>>
>> Signed-off-by: Pratham Pratap <quic_ppratap@quicinc.com>
>> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> 
> Who authored this, Pratham or you?
>
Its authored by Pratham, but I'm upstreaming it.
> And why no "[PATCH]" in the subject line?
> 
I was under the impression that [PATCH] is not used for v1.
Will fix this in next patch

> What commit id does this fix?
> 
Will add the Fixes tag also in next patch
> thanks,
> 
> greg k-h
Thanks
Prashanth K
