Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F3172A3F1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjFIUAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjFIUAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:00:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA44210D;
        Fri,  9 Jun 2023 13:00:31 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359JXQDX023055;
        Fri, 9 Jun 2023 20:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hNSFKWryMT4l8OSN2viRKRuPpy4F59qui6oi84nwnZc=;
 b=hocPd0owKosziZRgIVGQxfUiVGYcXC6of1dJfsZlC2pQ6apE8NpgSbQs7qCkp83+DC1U
 0aKFDpCNrP2bdplAOCy87PAmtLaV/mw89V7a1LrzDRtD2O4i/TCxFx3CTZoR4ikGR/r2
 IIx2teYx1jNEYGfPWcV3KUiGp2H8oGYKq2UIYupOqwjs9XKq0bsP/E1YByO21atZW1qu
 rrgJcAxTdVr+RCNSM4i+E48ffL3EDqLABzutGIKBXSJn0aFEPEE9o2kqFgOZfMDDN6/+
 pEeohxxG8DlH38JDoxK8QvgGlPInFJUukWQdVEi2WS5QMRfwwze75cjxly1XnC4TNb7g Bg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r3vu4hstr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 20:00:18 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 359K0Hql030988
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jun 2023 20:00:17 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 9 Jun 2023
 13:00:16 -0700
Message-ID: <5a026df6-05d2-42ef-21dd-e0f70071fc90@quicinc.com>
Date:   Fri, 9 Jun 2023 13:00:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v13 16/24] virt: gunyah: Translate gh_rm_hyp_resource into
 gunyah_resource
Content-Language: en-US
To:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
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
        Andy Gross <agross@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-17-quic_eberman@quicinc.com>
 <91d52a40-98c5-3d79-79af-7a21b41acfc4@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <91d52a40-98c5-3d79-79af-7a21b41acfc4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -Fe6BvKa1-udwQSoo5shOSKtZwc-7S-E
X-Proofpoint-ORIG-GUID: -Fe6BvKa1-udwQSoo5shOSKtZwc-7S-E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_14,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=978
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090167
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/2023 12:49 PM, Alex Elder wrote:
> On 5/9/23 3:47 PM, Elliot Berman wrote:
>> When booting a Gunyah virtual machine, the host VM may gain capabilities
>> to interact with resources for the guest virtual machine. Examples of
>> such resources are vCPUs or message queues. To use those resources, we
>> need to translate the RM response into a gunyah_resource structure which
>> are useful to Linux drivers. Presently, Linux drivers need only to know
>> the type of resource, the capability ID, and an interrupt.
>>
>> On ARM64 systems, the interrupt reported by Gunyah is the GIC interrupt
>> ID number and always a SPI.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> 
> Please zero the automatic variable in the place I suggest it.
> I have two other comments/questions.  Otherwise, this looks good.
> 
> Reviewed-by: Alex Elder <elder@linaro.org>
> 
>> ---

...

>> +struct gh_resource *gh_rm_alloc_resource(struct gh_rm *rm, struct 
>> gh_rm_hyp_resource *hyp_resource)
>> +{
>> +    struct gh_resource *ghrsc;
>> +    int ret;
>> +
>> +    ghrsc = kzalloc(sizeof(*ghrsc), GFP_KERNEL);
>> +    if (!ghrsc)
>> +        return NULL;
>> +
>> +    ghrsc->type = hyp_resource->type;
>> +    ghrsc->capid = le64_to_cpu(hyp_resource->cap_id);
>> +    ghrsc->irq = IRQ_NOTCONNECTED;
>> +    ghrsc->rm_label = le32_to_cpu(hyp_resource->resource_label);
>> +    if (hyp_resource->virq) {
>> +        struct gh_irq_chip_data irq_data = {
>> +            .gh_virq = le32_to_cpu(hyp_resource->virq),
>> +        };
>> +
>> +        ret = irq_domain_alloc_irqs(rm->irq_domain, 1, NUMA_NO_NODE, 
>> &irq_data);
>> +        if (ret < 0) {
>> +            dev_err(rm->dev,
>> +                "Failed to allocate interrupt for resource %d label: 
>> %d: %d\n",
>> +                ghrsc->type, ghrsc->rm_label, ghrsc->irq);
> 
> Is it reasonable to return in this case without indicating to the
> caller that something is wrong?
> 

I wasn't sure what to do here since this is unexpected edge case. Not 
returning would cause a client's "request_irq" to fail down the line if 
the client was interested in the irq. I had picked not to return since 
this error doesn't put us in an unrecoverable state. No one currently 
wants to try to recover from that error, so I'm really just deferring 
the real error handling until later.

I can return ret here.

>> +        } else {
>> +            ghrsc->irq = ret;
>> +        }
>> +    }
>> +
>> +    return ghrsc;

...
