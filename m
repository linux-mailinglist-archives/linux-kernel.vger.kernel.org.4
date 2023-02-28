Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A1E6A62D5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjB1WuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjB1WuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:50:15 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4713647F;
        Tue, 28 Feb 2023 14:50:10 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31SMnrnE003559;
        Tue, 28 Feb 2023 22:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8hbj9FVsC8MkAvZTRgwp0ubCfbbv/XN8YWwY7/fEfH4=;
 b=lp0Liu19f7poMWbgng0o0JCywYnoE1r6yAr/BDHxJOJqc4qghEf1JzYAQJyAEVAW8uzV
 9d7bL1TdgteD1lF/uzP+/VtrIlJI4EiCTLpXkDZY4H+zFJoSyD+NqRKa1X2K3RBunzQ6
 EUt++kBiFjLHNG6efi0qKH7UrLN9MPByut5URONTvzQmNlhMbsyBcHeM0/x66BOat+7r
 oGvGXUj7GbKxUXFg3vjzkdAdA7XXV/yyydEMjMjtpbtKyZZ7w0AaiTMfqZa39NRd8aTb
 /msiDPJQ5eW6KxL1zm2WN88h22KswahNfqAmI4i65T7YLidYRbSdfACG6muDNbVw23qM 9g== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p1cq5tkpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 22:49:53 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31SMnqLX021718
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 22:49:52 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Feb
 2023 14:49:51 -0800
Message-ID: <8fe7f45d-aadc-d680-3651-f981575e56a4@quicinc.com>
Date:   Tue, 28 Feb 2023 14:49:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 08/26] gunyah: rsc_mgr: Add resource manager RPC core
Content-Language: en-US
To:     Alex Elder <alex.elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alex Elder <elder@linaro.org>,
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212327.3310128-1-quic_eberman@quicinc.com>
 <d69f9699-b4d9-7a3a-71b1-7e6fe72c4f82@linaro.org>
 <94ebe2f0-0baf-21c0-45d5-c5bc4df9ad94@quicinc.com>
 <44a59ea4-da6e-e96a-5e89-dfd41db72823@linaro.org>
 <cd61963d-eb4c-9a4f-d48f-7a633bfd4be3@quicinc.com>
 <e75b8b9e-c870-6342-f7e4-32492d5f77be@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <e75b8b9e-c870-6342-f7e4-32492d5f77be@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aOh0ZTiIg987GvqhUF6OJfychBQpIVdX
X-Proofpoint-ORIG-GUID: aOh0ZTiIg987GvqhUF6OJfychBQpIVdX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_17,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 mlxlogscore=895 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280184
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/27/2023 4:52 PM, Alex Elder wrote:
> On 2/23/23 5:13 PM, Elliot Berman wrote:
>>> TBH, gunyah.c should be merged as part of resource manager, and check 
>>> if uuids and features in probe before proceeding further.
>>>
>>
>>
>> Ah -- gunyah_rsc_mgr.ko has symbol dependency on gunyah-msgq.ko. 
>> gunyah-msgq.ko has symbol dependency on gunyah.ko. gunyah.ko doesn't 
>> have any probe and does all its work on module_init.
>>
>> In order to merge gunyah.c with resource manager, I would need to 
>> incorporate message queue mailbox into resource manager. IMO, this 
>> rapidly moves towards a mega-module which was discouraged previously.
> 
> I missed this discussion; why was it discouraged?
> 
> I can think of some reasons why I guess.  But I don't see what
> problem comes from linking together a "mega module" that's made
> up of well-isolated source files that expose minimal APIs to
> one another.  All inter-dependent modules will required at once
> anyway; I don't understand the benefit of implementing them
> separately.  Can you explain, or provide some context?  Thanks.

I came from some earlier comments from Dmitry:

https://lore.kernel.org/all/250945d2-3940-9830-63e5-beec5f44010b@linaro.org/

Earlier comments from Dmitry were about having bus and drivers in same 
module. I think same comment applies with mailbox built into the 
gunyah.ko (message queue is the provider and rsr_mgr is the consumer).

Thanks,
Elliot
