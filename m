Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91F46A160E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 05:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjBXE5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 23:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBXE5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 23:57:50 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBAECD;
        Thu, 23 Feb 2023 20:57:48 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NMt6b5016824;
        Fri, 24 Feb 2023 04:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yEFr9mqBSM+77RpXzMaJ+bXxm7iJZ9D439V7ItuU9HM=;
 b=kqZzSZzSMY8UkWNy4VCDTpowdMMx/FDS38TFmQlG0yuLn92L5qIaJ2YPX3hYq+2nZ89h
 az9RwchpuC2DVRJskKgzyGxhTqyEd4aoX9b5fKjmOl8bFpWtjN/5KPO+FDW7/vZBuobS
 N1SzZ+mlghG1FsVruuYcBmjJ7aTKSOq3PoOyok3mlBUPbthJ+cMOjqqk5fsHjsREaAht
 spB/mw98sKXeiN6Vp3PCw1myd4203CwHfy70OL7l3tHpoW8uZjjmzfM6DHLK772hCT76
 vfTGFhf/kxzQZHqeItRG0coqCahOvzxN1Jyu03ZosX4b2CxrJNh5vtVHeBf8PzTBl9IQ Qg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwypbun1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 04:57:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31O4vfhN006117
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 04:57:41 GMT
Received: from [10.206.28.191] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 23 Feb
 2023 20:57:38 -0800
Message-ID: <3a189c0a-e82b-a80b-ac63-0f2c703b2eaa@quicinc.com>
Date:   Fri, 24 Feb 2023 10:27:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/2] usb: gadget: composite: Draw 100mA current if not
 configured
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        =?UTF-8?B?SsOzIMOBZ2lsYSBCaXRzY2g=?= <jgilab@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1677156121-30364-1-git-send-email-quic_prashk@quicinc.com>
 <1677156121-30364-3-git-send-email-quic_prashk@quicinc.com>
 <20230223201019.3a5njywzchztcs5e@synopsys.com>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <20230223201019.3a5njywzchztcs5e@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: la712Sw4HRDwyv_qwjiwYDMGaH3jN5It
X-Proofpoint-GUID: la712Sw4HRDwyv_qwjiwYDMGaH3jN5It
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_02,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=613 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240038
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24-02-23 01:40 am, Thinh Nguyen wrote:
> On Thu, Feb 23, 2023, Prashanth K wrote:
>> Currently we don't change the current value if device isn't in
>> configured state. But the battery charging specification says,
> 
> Can you provide the spec section also?
> 
1.2 Background
1.4.13 Standard Downstream Port

Did you mean to add these in the commit message?
>> device can draw up to 100mA of current if its in unconfigured
> 
> Is this related to being self-powered?
I think its applicable for bus-powered devices.

Thanks
Prashanth K
