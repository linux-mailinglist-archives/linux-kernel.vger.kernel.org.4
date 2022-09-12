Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5545B5DF8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 18:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiILQPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 12:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiILQPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 12:15:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66663AE48;
        Mon, 12 Sep 2022 09:15:44 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CFjau4031896;
        Mon, 12 Sep 2022 16:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gnR+YojUuEd0bVWU42W0Pr2xBddSG3/PEPBepBydQ0k=;
 b=gNBopqY422xspqj+SNgn5fpVWhLiRWLuNfyKr8nDEqdB31v5+qblFRGOx0O0WkhKlR5w
 dZXNWzUNpUWvhbdHyEv8HEzf3TgKi6XfKCLhj0BbO/h/PsR9Ah66f2S48m+RJJ6ek9iE
 YuPxNxvaKiIuikl3Su6p5v7J8K/Aac/wdPSi7w+moZ1W9yI5TszXxfP/hWhHH1xyiSdh
 53IiyewtrS4Em5b7zyTtnF/BUBGZkpO6NdO+ixFSxaCVPfzOYhxEUusQ+MSIRKBmWr41
 OQ8dydfa9B9Q1ADWTqNWx8sdyW8Vhk3LZ9N/eMnwiTGqoE545CuCPBqWIanzR7auK6Eq 3Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgkve5bee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 16:15:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28CGAc61019012
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 16:10:38 GMT
Received: from [10.216.1.65] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 12 Sep
 2022 09:10:34 -0700
Message-ID: <af79fc4d-4996-bb2c-7388-2d9afd991e7a@quicinc.com>
Date:   Mon, 12 Sep 2022 21:40:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 0/5] PCI: qcom: Add system suspend & resume support
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mka@chromium.org>,
        <quic_vbadigan@quicinc.com>, <quic_hemantk@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <manivannan.sadhasivam@linaro.org>,
        <swboyd@chromium.org>, <dmitry.baryshkov@linaro.org>
References: <20220909195110.GA310839@bhelgaas>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20220909195110.GA310839@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pOrH7y_uVO0H9huKk6qwUGbjsy7BMYH_
X-Proofpoint-GUID: pOrH7y_uVO0H9huKk6qwUGbjsy7BMYH_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_11,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209120055
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/10/2022 1:21 AM, Bjorn Helgaas wrote:
> On Fri, Sep 09, 2022 at 02:14:39PM +0530, Krishna chaitanya chundru wrote:
>> Add suspend and resume syscore ops.
>>
>> When system suspends, and if the link is in L1ss, disable the clocks
>> and power down the phy so that system enters into low power state by
>> parking link in L1ss to save the maximum power. And when the system
>> resumes, enable the clocks back and power on phy if they are disabled
>> in the suspend path.
>>
>> we are doing this only when link is in l1ss but not in L2/L3 as
>> nowhere we are forcing link to L2/L3 by sending PME turn off.
>>
>> is_suspended flag indicates if the clocks are disabled in the suspend
>> path or not.
>>
>> There is access to Ep PCIe space to mask MSI/MSIX after pm suspend ops
>> (getting hit by affinity changes while making CPUs offline during suspend,
>> this will happen after devices are suspended (all phases of suspend ops)).
>> When registered with pm ops there is a crash due to un-clocked access,
>> as in the pm suspend op clocks are disabled. So, registering with syscore
>> ops which will called after making CPUs offline.
>>
>> Make GDSC always on to ensure controller and its dependent clocks
>> won't go down during system suspend.
>>
>> Krishna chaitanya chundru (5):
>>    PCI: qcom: Add system suspend and resume support
>>    PCI: qcom: Add retry logic for link to be stable in L1ss
>>    phy: core: Add support for phy power down & power up
>>    phy: qcom: Add power down/up callbacks to pcie phy
>>    clk: qcom: Alwaya on pcie gdsc
> This seems fairly ugly because it doesn't fit nicely into the PM
> framework.  Why is this a qcom-specific thing?  What about other
> DWC-based controllers?
We wanted to allow system S3 state by turning off all PCIe clocks but at 
the same time
retaining NVMe device in D0 state and PCIe link in l1ss state.

Here nothing really specific to DWC as PCIe controller remains intact.

And the Qcom PHY allows this scheme  (that is to retain the link state 
in l1ss
even though all pcie clocks are turned off).

Since clocks are completely managed by qcom platform driver, we are 
trying to manage them
during S3/S0 transitions with PM callbacks.
>>   drivers/clk/qcom/gcc-sc7280.c            |   2 +-
>>   drivers/pci/controller/dwc/pcie-qcom.c   | 156 ++++++++++++++++++++++++++++++-
>>   drivers/phy/phy-core.c                   |  30 ++++++
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c |  50 ++++++++++
>>   include/linux/phy/phy.h                  |  20 ++++
>>   5 files changed, 256 insertions(+), 2 deletions(-)
>>
>> -- 
>> 2.7.4
>>
