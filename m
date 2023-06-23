Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A15B73C42A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjFWWig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjFWWie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:38:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9828195;
        Fri, 23 Jun 2023 15:38:33 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NM0CV2020915;
        Fri, 23 Jun 2023 22:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Lkk7I2+IYh68ojJ88vO1tjD2YjVsZK55v9XQRtsp3FQ=;
 b=eq/u832igTA2KuUpT3iC4ttAoLhnznde9iuYxAIo94K60jl3w2A3P8O/J/kjcwCqPobm
 uOlB7rGsQc7VtW7MkDA7C+qjU7nTmO7DnpkX9s8I0hSxxYWIl+xjY5/uMP+cFhf5x0sL
 arVbuiaq/b40pmViG5WBArKPUk63WxJ76b4psmPBffvISmVrPqQz5lM2C0JiMiI8Iv1U
 lGr669ZKX37nTveZSup4Zt5Tx6+yvqPSlW4hQYd4uFz/foBh2wFUzVQOehYozzvv2rtg
 +gofVqSXHX44cmwNxoq0aTCvGpjFT8pEybftg3LNfHFhVMQfYCG5/7+mN5anzVlg3jfq zA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rcurrk0qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 22:37:59 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35NMbwJR015376
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 22:37:58 GMT
Received: from [10.110.109.161] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 23 Jun
 2023 15:37:57 -0700
Message-ID: <9f30e9f9-280e-b381-fecc-2a032c1117af@quicinc.com>
Date:   Fri, 23 Jun 2023 15:37:55 -0700
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
 <ed0397eb-da17-fbee-647e-f3a2a57577fe@quicinc.com>
In-Reply-To: <ed0397eb-da17-fbee-647e-f3a2a57577fe@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _FYRk7PT04XMXr5Zf8zMOWSTWAk_QCFv
X-Proofpoint-ORIG-GUID: _FYRk7PT04XMXr5Zf8zMOWSTWAk_QCFv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_12,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxlogscore=986 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230204
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

On 3/13/2023 1:32 PM, Wesley Cheng wrote:
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
>>> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>>
>> My Signed-off-by tag is being misused here.
>>
>> I wrote a chunk of the code in this patch as PoC that I shared in a 
>> separate topic branch.
>> It was incomplete and not intended for upstream yet. (lacked locking, 
>> several fixme parts, etc..)
>> The rest of the code in this patch is completely new to me.
>>
> 
> Sorry about this.  I cherry picked the change directly from your branch, 
> so it carried your signed off tag with it.  Will make to include them 
> properly next time.
> 

I'm about ready to submit the next revision for this set of changes, and 
I was wondering how we should handle the changes you made on:
https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=feature_interrupters

I did make some modifications to some of the interrupter fixme tags you 
had, and also updated the xhci-sideband APIs with the proper logic.  I 
don't believe it is correct for me to submit a set of patches authored 
by you without your signed off tag. (checkpatch throws an error saying 
the author did not sign off on the change)

Thanks
Wesley Cheng
