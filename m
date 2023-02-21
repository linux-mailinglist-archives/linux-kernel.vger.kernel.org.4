Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7793369E968
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 22:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjBUVXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 16:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBUVXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 16:23:18 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1A844B2;
        Tue, 21 Feb 2023 13:23:17 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LCZoRI015712;
        Tue, 21 Feb 2023 21:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ovWj8UmzoKvy/G0pIzs9xOPymSnbtxoCS3AGeSJ+cBA=;
 b=B8a2BQDPKkCCn0rZ8h/WARjkQYZ7KyBs5mlChLOnb/5UAFUYr0owuDwTbrFvhzPF07Hy
 uslXy/WWO/1x1uhs+8TTVe9c8Qp1OgmsO2TGWpRTinJ1hFGMpohoqEbBwLb/1ELwLjYz
 dAtYCpTG/lfFkg5pBdjsFKpQlE/3IE+vbhgyIPYFYDe4IbE9R2CZ8HrEh5wLKJjiTv+C
 fqyNL779BtxhImyCFXXD9FYZbES+pf1HJt2ZODPd5zLOwQ9p+rd679hHvkRTFe2W/t5u
 JyKAJy0gbfa3xEv7kBbcAJIO8J8LbLcit+OkccnPV5fHoYmx6ZVZFDQqewgXjR9mbNeX 3A== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ntpw9rrh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 21:22:54 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31LLMrcZ012877
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 21:22:53 GMT
Received: from [10.110.71.80] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 21 Feb
 2023 13:22:51 -0800
Message-ID: <7aa025a1-b211-f04c-9169-236102fe27fe@quicinc.com>
Date:   Tue, 21 Feb 2023 13:22:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 15/26] gunyah: rsc_mgr: Add platform ops on
 mem_lend/mem_reclaim
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alex Elder <elder@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
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
 <20230214212448.3318756-1-quic_eberman@quicinc.com>
 <963d84e8-7b91-c278-1978-4e73d73f7c6f@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <963d84e8-7b91-c278-1978-4e73d73f7c6f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BDrpy9BYGEbZnz3_yiaFgW_COdaF98o2
X-Proofpoint-GUID: BDrpy9BYGEbZnz3_yiaFgW_COdaF98o2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_12,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210185
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/21/2023 6:51 AM, Srinivas Kandagatla wrote:
> 
> 
> On 14/02/2023 21:24, Elliot Berman wrote:
[snip]
>> +
>> +static struct gunyah_rm_platform_ops *rm_platform_ops;
>> +static DECLARE_RWSEM(rm_platform_ops_lock);
> 
> Why do we need this read/write lock or this global rm_platform_ops here, 
> AFAIU, there will be only one instance of platform_ops per platform.
> 
> This should be a core part of the gunyah and its driver early setup, 
> that should give us pretty much lock less behaviour.
> 
> We should be able to determine by Hypervisor UUID that its on Qualcomm 
> platform or not, during early gunyah setup which should help us setup 
> the platfrom ops accordingly.
> 
> This should also help cleanup some of the gunyah code that was added 
> futher down in this patchset.

I'm guessing the direction to take is:

   config GUNYAH
     select QCOM_SCM if ARCH_QCOM

and have vm_mgr call directly into qcom_scm driver if the UID matches?

We have an Android requirement to enable CONFIG_GUNYAH=y and 
CONFIG_QCOM_SCM=m, but it wouldn't be possible with this design. The 
platform hooks implementation allows GUNYAH and QCOM_SCM to be enabled 
without setting lower bound of the other.

- Elliot
