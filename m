Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E97D73E2C8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjFZPGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjFZPGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:06:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC356D3;
        Mon, 26 Jun 2023 08:06:01 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35QAYQr2000870;
        Mon, 26 Jun 2023 15:05:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=IdtCwDjHqmXMfxmzwDZMSg9ypgdODVVb+Pq+cftBNow=;
 b=Qd0fF8i39cELqb2ccIS94MzQ/tREKTQUmXOX+qr2f8Sasm6YHQWKKD7c1FLoVNYL3eg8
 /dSdL+3Ii99oqB4oCqdIk0MIaSoCezuuxaw38wvlG6GQJTyWIyT54Nc6nit7z3ok/pnT
 zk+1xip+ZXh509JNIz9sO596OC17YAF2x/a5VQhSTxv6UfDewln0Tx0Fwp48o/znn7LX
 mgskrCx8itqkNRq8tvo39rZIDKLPfQpYT/v+Da+j5fxJZkCFQGbTIn3jbB3J43niYrZ6
 HcLUnQAKJSTI9hmWa9VwoFcR83cwvoPjkX43B71vi9IVtstrI4tH9R75MGLvvhkYPfFG iw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rev821xbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 15:05:28 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35QF5RTW028970
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 15:05:27 GMT
Received: from [10.110.49.97] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 26 Jun
 2023 08:05:26 -0700
Message-ID: <f0606765-d643-06b8-9c44-960b6f52bd00@quicinc.com>
Date:   Mon, 26 Jun 2023 08:05:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 01/28] xhci: Add support to allocate several
 interrupters
Content-Language: en-US
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
 <ed0397eb-da17-fbee-647e-f3a2a57577fe@quicinc.com>
 <9f30e9f9-280e-b381-fecc-2a032c1117af@quicinc.com>
 <da468fe6-709c-b6e6-159d-10f76d296307@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <da468fe6-709c-b6e6-159d-10f76d296307@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5D7z_PDWYDVj5u53kIqTXqnKn4F8kFD3
X-Proofpoint-GUID: 5D7z_PDWYDVj5u53kIqTXqnKn4F8kFD3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_12,2023-06-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260136
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

On 6/26/2023 6:55 AM, Mathias Nyman wrote:
> On 24.6.2023 1.37, Wesley Cheng wrote:
>> Hi Mathias,
>>
>> On 3/13/2023 1:32 PM, Wesley Cheng wrote:
>>> Hi Mathias,
>>>
>>> On 3/10/2023 7:07 AM, Mathias Nyman wrote:
>>>> On 9.3.2023 1.57, Wesley Cheng wrote:
>>>>> From: Mathias Nyman <mathias.nyman@linux.intel.com>
>>>>>
>>>>> Introduce xHCI APIs to allow for clients to allocate and free
>>>>> interrupters.  This allocates an array of interrupters, which is 
>>>>> based on
>>>>> the max_interrupters parameter.  The primary interrupter is set as the
>>>>> first entry in the array, and secondary interrupters following after.
>>>>>
>>>>
>>>> I'm thinking about changing this offloading xHCI API
>>>> xhci should be aware and keep track of which devices and endpoints that
>>>> are offloaded to avoid device getting offloaded twice, avoid xhci 
>>>> driver
>>>> from queuing anything itself for these, and act properly if the 
>>>> offloaded
>>>> device or entire host is removed.
>>>>
>>>> So first thing audio side would need to do do is register/create an
>>>> offload entry for the device using the API:
>>>>
>>>> struct xhci_sideband *xhci_sideband_register(struct usb_device *udev)
>>>>
>>>> (xHCI specs calls offload sideband)
>>>> Then endpoints and interrupters can be added and removed from this
>>>> offload entry
>>>>
>>>> I have some early thoughts written as non-compiling code in:
>>>>
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git 
>>>> feature_interrupters
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=feature_interrupters 
>>>>
>>>>
>>>> Let me know what you think about this.
>>>>
>>>>> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>>>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>>>>
>>>> My Signed-off-by tag is being misused here.
>>>>
>>>> I wrote a chunk of the code in this patch as PoC that I shared in a 
>>>> separate topic branch.
>>>> It was incomplete and not intended for upstream yet. (lacked 
>>>> locking, several fixme parts, etc..)
>>>> The rest of the code in this patch is completely new to me.
>>>>
>>>
>>> Sorry about this.  I cherry picked the change directly from your 
>>> branch, so it carried your signed off tag with it.  Will make to 
>>> include them properly next time.
>>>
>>
>> I'm about ready to submit the next revision for this set of changes, 
>> and I was wondering how we should handle the changes you made on:
>> https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=feature_interrupters 
>>
>>
>> I did make some modifications to some of the interrupter fixme tags 
>> you had, and also updated the xhci-sideband APIs with the proper 
>> logic.  I don't believe it is correct for me to submit a set of 
>> patches authored by you without your signed off tag. (checkpatch 
>> throws an error saying the author did not sign off on the change)
>>
> 
> Note that the first patch "xhci: split allocate interrupter into 
> separate alloacte and add parts"
> is already in usb-next on its way to 6.5
> 
> Maybe Co-developed-by would work in this case, with a small explanation 
> at the end of the commit message.
> Something like:
> 
> Locking, DMA something and feataure x added by Wesley Cheng to
> complete original concept code by Mathias
> 
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> Co-developed-by: Wesley Cheng <quic_wcheng@quicinc.com>
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> 

Sounds good!  Thanks for helping with a non-technical question :).  Just 
wanted to make sure I wasn't overstepping anywhere.

Thanks
Wesley Cheng
