Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A31C6E54DC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 00:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjDQW4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 18:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjDQW4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 18:56:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AEA49DA;
        Mon, 17 Apr 2023 15:55:45 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HMNHSY014460;
        Mon, 17 Apr 2023 22:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7U+aHnfVAWUr9+TgSNykvL0n3P5vsDx6kCg/xTLyFvg=;
 b=G/Q7DQViTwou247edvk6fNgzaop+rCC+pjdvGHdB08RfHv0CZAU/IThB95fKCBKE+9x1
 6f3NunIQFoKIEj4HDCWC4WWeF3EchKEjiKooNIbu0D9zLU1Uj4B4tiDeOAbla+On9Caw
 ZjlTGY5sYvzkywQeip+CrLseP7HAY+B7LSq41JtZBNEfB1LTWB6TfKj02bParXbjIXls
 SfVqZewrU8pWjQ8fyB6smaktS4MqBM0maugOY9RpKml75QFpze6fzD7XPGQMQw62jH8+
 y2n1AcSebXxWB1y6+m0vfBP2X97jHufZNnYYHjlK0I4LxNNrQ1qYev56aOsGOaCL0zVn Dg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q12stsueu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 22:55:32 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33HMtVb7013987
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 22:55:31 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 17 Apr
 2023 15:55:30 -0700
Message-ID: <c8e95fd5-5761-b9aa-2877-6a8827a76f21@quicinc.com>
Date:   Mon, 17 Apr 2023 15:55:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v11 24/26] virt: gunyah: Add irqfd interface
Content-Language: en-US
To:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-25-quic_eberman@quicinc.com>
 <a8dc6572-0a48-f772-2d8c-6329d632e0b4@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <a8dc6572-0a48-f772-2d8c-6329d632e0b4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UzFcKxxxsI1y1ILA5uReQsN0DsCewJjX
X-Proofpoint-ORIG-GUID: UzFcKxxxsI1y1ILA5uReQsN0DsCewJjX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxscore=0 impostorscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170202
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/2023 7:27 AM, Alex Elder wrote:
> On 3/3/23 7:06 PM, Elliot Berman wrote:

[snip]

>> +
>> +static int irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode, 
>> int sync, void *key)
>> +{
>> +    struct gh_irqfd *irqfd = container_of(wait, struct gh_irqfd, wait);
>> +    __poll_t flags = key_to_poll(key);
>> +    u64 enable_mask = GH_BELL_NONBLOCK;
>> +    u64 old_flags;
>> +    int ret = 0;
>> +
>> +    if (flags & EPOLLIN) {
>> +        if (irqfd->ghrsc) {
>> +            ret = gh_hypercall_bell_send(irqfd->ghrsc->capid, 
>> enable_mask, &old_flags);
> 
> I commented elsewhere that you might support passing a null
> pointer as the last argument above (since you don't use the
> result).
> 
>> +            if (ret)
>> +                pr_err_ratelimited("Failed to inject interrupt %d: 
>> %d\n",
>> +                        irqfd->ticket.label, ret);
>> +        } else
>> +            pr_err_ratelimited("Premature injection of interrupt\n");
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static void irqfd_ptable_queue_proc(struct file *file, 
>> wait_queue_head_t *wqh, poll_table *pt)
>> +{
>> +    struct gh_irqfd *irq_ctx = container_of(pt, struct gh_irqfd, pt);
>> +
>> +    add_wait_queue(wqh, &irq_ctx->wait);
>> +}
>> +
>> +static int gh_irqfd_populate(struct gh_vm_resource_ticket *ticket, 
>> struct gh_resource *ghrsc)
>> +{
>> +    struct gh_irqfd *irqfd = container_of(ticket, struct gh_irqfd, 
>> ticket);
>> +    u64 enable_mask = GH_BELL_NONBLOCK;
>> +    u64 ack_mask = ~0;
> 
> Why is the ACK mask ~0?
> 
> I guess I don't know details about this hypercall (do you document
> them somewhere?), so it's hard to judge whether or why this is the
> right thing to use.  The enable_mask is just GH_BELL_NONBLOCK,
> which is just BIT(32).
> 

I talked to our hypervisor folks and they mentioned we can simplify 
this. In v12, enable_mask and ack_mask can just be "1" (BIT(0)). We had 
chosen bit 32 arbitrarily.

[snip]

> 
>> +    }
>> +
>> +    irqfd->ghrsc = ghrsc;
>> +    if (irqfd->level) {
> 
> I think I don't understand this part of the code well
> enough to know this.  What happens if level is false?
> 

If level is false, then guest is assumed to set up IRQ on its side as 
edge-triggered. In that case, we don't need to configure the enable 
mask/ack mask because the doorbell flags aren't polled.

[snip]

>> +/**
>> + * struct gh_fn_irqfd_arg - Arguments to create an irqfd function
>> + * @fd: an eventfd which when written to will raise a doorbell
>> + * @label: Label of the doorbell created on the guest VM
>> + * @flags: GH_IRQFD_LEVEL configures the corresponding doorbell to 
>> behave
>> + *         like a level triggered interrupt.
>> + * @padding: padding bytes
>> + */
>> +struct gh_fn_irqfd_arg {
>> +    __u32 fd;
> 
> Should the "fd" field be signed?  Should it be an int?  (Perhaps
> you're trying to define a fixed kernel API, so __s32 if signed would
> be better.)
> 

It looked to me like some interfaces use __u32 and some use __s32. Is 
one technically correct?
