Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF656ED9B6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 03:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbjDYBSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 21:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjDYBSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 21:18:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877F64ED9;
        Mon, 24 Apr 2023 18:18:03 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P17Zh9018261;
        Tue, 25 Apr 2023 01:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LERFdXcjVsFCSOZUAfrxaZzzvQVZ0km1XAFRXQ+kCQ0=;
 b=AnQnZy3xIwN8Ianz46csf3zMDVKU8wO+r3Me9Iho4hjOJ7WU0yzAI0DL6SxiY3tkfPkC
 cSni4Thg1hZtO3V6AulkxnGBuTyfp9gfWLX0z2JbtKNfbqb9+Eq3i2nGYSXGtipai4TA
 +E+R0SBrg5NDaOOaQpZ00KYo6QdIwmh0MKCTprKlgi0lQOVQYfYVBla76inxLi7OCEgy
 gH1HK1Myoo4wx2HUkwrfefMeDFZPtkGSHWSlU3mLkv7OUvB0p+5W8lU9AMvAeNQHlOrW
 K5i/wyGWpy2Ae796fmE8YHKycFvo2PO/bTfxwf0ReMoro6n32zSPK8S7FTcHQJgnHdpB LQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q5ndpt2vj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 01:17:30 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33P1HTbl012769
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 01:17:29 GMT
Received: from [10.110.17.95] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 24 Apr
 2023 18:17:26 -0700
Message-ID: <579b6a18-624d-8071-e326-fc69028d3fc5@quicinc.com>
Date:   Mon, 24 Apr 2023 18:17:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 01/28] xhci: Add support to allocate several
 interrupters
Content-Language: en-US
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <agross@kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <bgoswami@quicinc.com>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <tiwai@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <20230308235751.495-2-quic_wcheng@quicinc.com>
 <a45ff335-0563-85c7-3b31-d6ca23a54a3f@linux.intel.com>
 <6024f762-6085-10cd-e73a-9031722b2334@quicinc.com>
In-Reply-To: <6024f762-6085-10cd-e73a-9031722b2334@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: z0dwS-2-H847QR2W6V6IV0XIC_kqxSbN
X-Proofpoint-ORIG-GUID: z0dwS-2-H847QR2W6V6IV0XIC_kqxSbN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_01,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250008
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

On 3/13/2023 1:08 PM, Wesley Cheng wrote:
> Hi Mathias,
> 
> On 3/10/2023 7:07 AM, Mathias Nyman wrote:
>> On 9.3.2023 1.57, Wesley Cheng wrote:
>>> From: Mathias Nyman <mathias.nyman@linux.intel.com>
>>>
>>> Introduce xHCI APIs to allow for clients to allocate and free
>>> interrupters.  This allocates an array of interrupters, which is 
>>> based on
>>> the max_interrupters parameter.  The primary interrupter is set as the
>>> first entry in the array, and secondary interrupters following after.
>>>
>>
>> I'm thinking about changing this offloading xHCI API
>> xhci should be aware and keep track of which devices and endpoints that
>> are offloaded to avoid device getting offloaded twice, avoid xhci driver
>> from queuing anything itself for these, and act properly if the offloaded
>> device or entire host is removed.
>>
>> So first thing audio side would need to do do is register/create an
>> offload entry for the device using the API:
>>
>> struct xhci_sideband *xhci_sideband_register(struct usb_device *udev)
>>
>> (xHCI specs calls offload sideband)
>> Then endpoints and interrupters can be added and removed from this
>> offload entry
>>
>> I have some early thoughts written as non-compiling code in:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git 
>> feature_interrupters
>> https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=feature_interrupters 
>>
>>
>> Let me know what you think about this.
>>
> 
> The concept/framework you built looks good to me.  Makes sense to have 
> XHCI better maintain the offloading users.  One thing I would request is 
> to move xhci-sideband.h to the include directory since the class driver 
> levels would need to be able to reference the structure and APIs you've 
> exposed.
> 
> I have yet to try it with our implementation, but I'll work on plugging 
> it in and fix any issues I see along the way.

Sorry for the late reply on some of the efforts on adding your new 
xhci-sideband driver.

I saw your comments with respect to building the SG table for rings with 
multiple segments, ie stream xfer rings.  I had tried some things to 
achieve the page links, but after reviewing some of the Linux memory 
APIs, I'm not sure we can achieve it.  This is because we're not simply 
relying on the direct DMA ops here to build the SG table.  In the IOMMU 
mapped cases, it calls in iommu_dma_get_sgtable(), which has some 
convoluted logic to build the sgt.

Instead of allocating one sgt with multiple sgls (based on # of ring 
segments), would it make sense to just build multiple sgts for each ring 
segment?  The vendor class driver could still fetch the required memory 
information to translate each sgt to a physical address and ring segment 
linking can happen within the external DSP if it supports it.

Thanks
Wesley Cheng
