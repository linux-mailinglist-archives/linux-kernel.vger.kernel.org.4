Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D235FE394
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJMUzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJMUzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:55:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CD357888;
        Thu, 13 Oct 2022 13:55:01 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29DKRjkZ028461;
        Thu, 13 Oct 2022 20:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3cgLBKJ0TTYjcPeIF+PUk3iZ5s/oK3No0mEb7w+6cQc=;
 b=j8fOx8CQu8RLBgs/eofgBDjqyFnj9i1kcP12vLs45HqE7en/pyRl4ePwgeLnKaX6ej5p
 WX6lNh5f0QoyMby161ivcjcYEq6TJDGTO/rVBEKkqyjQLOBLFK+D8H8z8ZPaPbJHclr9
 2tqRHTEh4M7UcFG5AjdoxiGPjIc0BmyJOAcEVJ5Z1rJTCuVnDAG3H4yCDL4SJT06ZWVS
 XNnjr7oA/cdDMNkLkxxuzms1aVMKp7bXJUQy2TUHWc4V2DJdlh5VLvv3GMeKuw5IFOQW
 ZC8qc7zf0QxYsfzOzYxz79+aEWo3gZZKhor6bHzY7De8pyVaLL63GhJ+7SExez+ntlIw oQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k6mkdrwkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 20:54:38 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29DKscHA010299
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 20:54:38 GMT
Received: from [10.110.38.147] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 13 Oct
 2022 13:54:36 -0700
Message-ID: <0640f0a5-19c1-55d2-229a-37751a18118f@quicinc.com>
Date:   Thu, 13 Oct 2022 13:54:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 13/13] tty: gunyah: Add tty console driver for RM
 Console Services
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jirislaby@kernel.org>,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
 <20221011000840.289033-14-quic_eberman@quicinc.com>
 <7438406d-b446-201e-0ec3-5cf0a5b9f32c@kernel.org>
 <85ca7eb4-3e0c-4ffb-8bac-a435594ca0f7@app.fastmail.com>
 <b7cca9c7-5170-bf40-c030-d676944b03c6@quicinc.com>
 <Y0Zk2hN4uEbxCp56@kroah.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <Y0Zk2hN4uEbxCp56@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hbID-XQjcqGdsWVOrIjkPsQcGwnYKEmX
X-Proofpoint-ORIG-GUID: hbID-XQjcqGdsWVOrIjkPsQcGwnYKEmX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_08,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=875 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130117
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2022 11:55 PM, Greg Kroah-Hartman wrote:
> On Tue, Oct 11, 2022 at 03:04:47PM -0700, Elliot Berman wrote:
>>
>>
>> On 10/11/2022 4:09 AM, Arnd Bergmann wrote:
>>> On Tue, Oct 11, 2022, at 8:02 AM, Jiri Slaby wrote:
>>>> On 11. 10. 22, 2:08, Elliot Berman wrote:
>>>>> +
>>>>> +	/* below are for printk console.
>>>>> +	 * gh_rm_console_* calls will sleep and console_write can be called from
>>>>> +	 * atomic ctx. Two xmit buffers are used. The active buffer is tracked with
>>>>> +	 * co_xmit_idx. Writes go into the co_xmit_buf[co_xmit_idx] buffer.
>>>>> +	 * A work is scheduled to flush the bytes. The work will swap the active buffer
>>>>> +	 * and write out the other buffer.
>>>>> +	 */
>>>>
>>>> Ugh, why? This is too ugly and unnecessary. What about passing the kfifo
>>>> to gh_rm_console_write() instead? You do memcpy() there anyway.
>>>
>>> Another problem here is that you really want the console output to be
>>> printed from atomic context, otherwise one would never see e.g. the
>>> output of a panic() call. Having a deferred write is probably fine for
>>> normal tty operations, but you probably want a different device for the
>>> console here, e.g. the hvc_dcc driver.
>>>
>>
>> Yes, that is our perspective on the RM console driver as well. I'll make
>> this more explicit in the Kconfig/commit text. We expect most VMs
>> (especially Linux) to use some other console mechanism provided by their
>> VMM. I'm submitting here because we are presently using RM console on some
>> of our VMs where we have other ways to collects logs on panic. It also makes
>> it easier to implement a simple virtual machine manager that does not want
>> to virtualize a serial device or have a virtio stack.
> 
> The whole goal of virtio was so that we would not have all of these
> random custom drivers for new hypervisors all over the place, requiring
> custom userspace interaction with them.
> 
> Please use virtio, that's what it is there for, don't create a new
> console device if you do not have to.

We have a lightweight VM product use case today that doesn't want to 
support an entire virtio stack just for a console. This VM already has a 
Gunyah stack present, and to facilitate their console needs, we want to 
give them the Gunyah console.

There are a few other hypervisors that also provide a console facility 
in Linux: Xen, ePAPR hypervisor and z/VM.

Thanks,
Elliot
