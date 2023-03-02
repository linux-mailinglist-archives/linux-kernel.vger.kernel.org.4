Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322DD6A78D3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 02:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjCBBWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 20:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBBWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 20:22:14 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2437460B3;
        Wed,  1 Mar 2023 17:22:12 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321N0PVj032491;
        Thu, 2 Mar 2023 01:21:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hyQxkgFzuSR8YZ5Bl4NrASAhqzVQh3AgpefjsIf0GmI=;
 b=SuqCfRao7BN/vIPCbYrZeOSYl/QVRUJYsGX8MY370+Y2OjKZPjnRIXCeAtuGxoGI2rqD
 OC/5rjtyl9Wtpxi2c2wKcMCrXx9rZfRdB6cLkLWraDKnGY9zTq/kShPvBBL/i0c1K5bk
 oqoDXXvZVdit6VsVF7AMRJXgDeON1FM30iz5IK4Ud6anZjMyG692Bg1c6V4soAbmjKG4
 etByXyEDmZdWdWO8+BZb8D0DwnTNLJugn4buwMNEQfw9FSqAL76V4zI8GTyu+m9NE1F0
 8RAn6ZmcOeJkbnAVgjn3luVnktZWcCYBUxhFUUUv8oFhyp7lFCiQ2duR0Iijs1Hm0GH1 Zw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p24yut3sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 01:21:55 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3221Ltdf019789
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Mar 2023 01:21:55 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 1 Mar 2023
 17:21:53 -0800
Message-ID: <d01e4b1f-862b-410f-66bb-9b8158e76807@quicinc.com>
Date:   Wed, 1 Mar 2023 17:21:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 04/26] virt: gunyah: Add hypercalls to identify Gunyah
Content-Language: en-US
To:     Alex Elder <alex.elder@linaro.org>, Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Prakruthi Deepak Heragu" <quic_pheragu@quicinc.com>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214211229.3239350-5-quic_eberman@quicinc.com>
 <4eb2e494-d987-5eb7-3513-be58eb87c9af@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <4eb2e494-d987-5eb7-3513-be58eb87c9af@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: R_DQVLllJKNcTXXTtSy5zqtfT2bjjag2
X-Proofpoint-ORIG-GUID: R_DQVLllJKNcTXXTtSy5zqtfT2bjjag2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_17,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020008
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/2023 4:09 PM, Alex Elder wrote:
> On 2/14/23 3:12 PM, Elliot Berman wrote:
>> +
>> +void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp 
>> *hyp_identity);
> 
> Since this is a user space API, you *could* consider having
> this function return an int.  Just in case there's a future
> reason that a failure could occur, or that you want to
> supply some other information.  If this truly doesn't make
> sense, it's fine as-is...
> 

I'm not sure what was meant by user space API. However, hypervisor API 
doesn't provision a return value. r0 is usually the return value for 
most other Gunyah hypercalls except for this one -- instead, it's the 
api_info field.

The other kind of error we could get is at hypercall "transport" layer, 
but the hvc instruction doesn't fail and if we ever change the hypercall 
transport, I'm sure there will be a lot of other changes to consider as 
well.

Thanks,
Elliot

