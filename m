Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5611C67D7B2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 22:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjAZV1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 16:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjAZV1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:27:42 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CD93EFED;
        Thu, 26 Jan 2023 13:27:41 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QKr5qU003063;
        Thu, 26 Jan 2023 21:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eub/xV2CndV03ABVthGsowvrdm8zTqb73Ay8YAMFLgU=;
 b=EnMCtFwqCgXYn7qv6B4+uwnY25L8e33icayzlkYrvcWoZn5ml+/jvO48LNg+ZpNliGcU
 /slccjyiWkdtX3fuJEJAo5RJ2xeLiTvG7kU6qkOU6hW27BqxlJps4dWv6SpS+nhvTLaU
 36t6TLuvJnySJ9SfffvkKBphkJY1+iHIoUGIrAh//Lw1QAnPwzHh6wrtSL0ahaHKag3o
 yhbzr2VupoZVjIvhGzirHDwFf6mndVkE3U0dJwfONMNj+DhCPIFoYUJa/JVuHPu4tsxC
 GEQm8KwNs1W3Q13gikhpY6XlQTI9O3hYgD0SzOAMtQlmIRZEkTYWhfLq772omIgzJ58G qQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nbp1v9bh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 21:27:24 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30QLRNUo021049
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 21:27:23 GMT
Received: from [10.110.106.42] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 26 Jan
 2023 13:27:22 -0800
Message-ID: <6bafae1a-61b3-887a-14fc-77d389509f4f@quicinc.com>
Date:   Thu, 26 Jan 2023 13:27:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v7 10/20] gunyah: rsc_mgr: Add resource manager RPC core
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
References: <20221121140009.2353512-1-quic_eberman@quicinc.com>
 <20221121140009.2353512-11-quic_eberman@quicinc.com>
 <Y3uYRvrCZNnbDiY5@kroah.com>
 <425a8fe9-24b6-26c7-9150-0d3fb76430be@quicinc.com>
 <Y5gbFhVpuDoZ2ZmY@kroah.com>
 <f0f4243f-4cbe-0aa2-19b6-047d791207ab@quicinc.com>
Content-Language: en-US
In-Reply-To: <f0f4243f-4cbe-0aa2-19b6-047d791207ab@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: beyvsiomKsGMAhOhYtuXkCyYCDsnp1bK
X-Proofpoint-GUID: beyvsiomKsGMAhOhYtuXkCyYCDsnp1bK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=663 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260201
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/15/2022 6:25 PM, Elliot Berman wrote:
> 
> 
> On 12/12/2022 10:26 PM, Greg Kroah-Hartman wrote:
>> On Mon, Dec 12, 2022 at 03:46:53PM -0800, Elliot Berman wrote:
>>>
>>> Reference counting is not needed on the gh_rm_rpc object because its 
>>> only
>>> client (the VM manager) is torn down before the gh_rm_rpc.
>>
>> So again, who controls the lifecycle of it?  Where is the reference
>> count for the structure as it is pointing to reference counted memory?
> 
> Had some internal review and I think I'm now taking better care of this 
> (and the device situation in the other mail). I will send out next 
> revision soon.

Hello Greg,

I've sent v9 series and wanted to get your feedback on the changes to 
the patches that you had suggested.

https://lore.kernel.org/all/20230120224627.4053418-10-quic_eberman@quicinc.com/

Thanks,
Elliot
