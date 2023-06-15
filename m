Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3804B7312AC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238236AbjFOIuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245018AbjFOIsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:48:32 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1697A2D6D;
        Thu, 15 Jun 2023 01:47:44 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F6Zuum016146;
        Thu, 15 Jun 2023 10:47:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=2Uw0OO2d1PspJCO4EJYYYgI2JrkAhJ2sdxcuh6mFlpM=;
 b=xVhhHeGQk1l7ea79uw+yuhQ39SZI4WchooY3/cPP3xFjGN11KZFtl5B2mrsJT17TbKUR
 f8AxrLwehKRpHX962cLr7dPjY4Maf1nEhKaa9et2RAk0pO6MHKdZUJ2THHbUuDqMbX13
 enx87+NiOynbQebC7D874lgHe01VUvCbJl/T0ER5o2of+EOa90i8ut1ddOfE/8MxujkP
 +buyV31H7D95FBblYNWlPxWqYxHdLKYwLVcbabYeTEGcMayVKwCBK+hPDQ8i9UpeSod0
 LWysLZG/ObVHsv4PayIaIb+J1v86Lb0j6+o1kpunQx1HQ82uV4ak+nVIUM7oBfsOPcI4 +w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r7wgx169a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 10:47:36 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0FB9810004B;
        Thu, 15 Jun 2023 10:47:31 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 079F721862A;
        Thu, 15 Jun 2023 10:47:31 +0200 (CEST)
Received: from [10.201.21.9] (10.201.21.9) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 15 Jun
 2023 10:47:30 +0200
Message-ID: <f95a6dbe-f774-7778-9cd8-aba0677b9413@foss.st.com>
Date:   Thu, 15 Jun 2023 10:47:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V7 1/3] rpmsg: core: Add signal API support
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Sarannya S <quic_sarannya@quicinc.com>,
        <quic_bjorande@quicinc.com>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <mathieu.poirier@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>
References: <1682160127-18103-1-git-send-email-quic_sarannya@quicinc.com>
 <1682160127-18103-2-git-send-email-quic_sarannya@quicinc.com>
 <c44d8942-83e5-01ec-491b-bac1fb27de99@foss.st.com>
 <20230614152435.2quoctx6ouvw4ous@ripper>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <20230614152435.2quoctx6ouvw4ous@ripper>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.9]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_05,2023-06-14_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/14/23 17:24, Bjorn Andersson wrote:
> On Mon, Apr 24, 2023 at 02:49:29PM +0200, Arnaud POULIQUEN wrote:
>> Hello,
>>
>> On 4/22/23 12:42, Sarannya S wrote:
>>> From: Deepak Kumar Singh <quic_deesin@quicinc.com>
>>>
>>> Some transports like Glink support the state notifications between
>>> clients using flow control signals similar to serial protocol signals.
>>> Local glink client drivers can send and receive flow control status
>>> to glink clients running on remote processors.
>>>
>>> Add APIs to support sending and receiving of flow control status by
>>> rpmsg clients.
>>>
>>> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
>>> Signed-off-by: Sarannya S <quic_sarannya@quicinc.com>
>>> ---
>>>  drivers/rpmsg/rpmsg_core.c     | 21 +++++++++++++++++++++
>>>  drivers/rpmsg/rpmsg_internal.h |  2 ++
>>>  include/linux/rpmsg.h          | 15 +++++++++++++++
>>>  3 files changed, 38 insertions(+)
>>>
>>> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
>>> index a2207c0..e8bbe05 100644
>>> --- a/drivers/rpmsg/rpmsg_core.c
>>> +++ b/drivers/rpmsg/rpmsg_core.c
>>> @@ -331,6 +331,25 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
>>>  EXPORT_SYMBOL(rpmsg_trysend_offchannel);
>>>  
>>>  /**
>>> + * rpmsg_set_flow_control() - sets/clears serial flow control signals
>>> + * @ept:	the rpmsg endpoint
>>> + * @enable:	pause/resume incoming data flow	
>>> + * @dst:	destination address of the endpoint
>>> + *
>>> + * Return: 0 on success and an appropriate error value on failure.
>>> + */
>>> +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable, u32 dst)
>>> +{
>>> +	if (WARN_ON(!ept))
>>> +		return -EINVAL;
>>> +	if (!ept->ops->set_flow_control)
>>> +		return -ENXIO;
>>
>> Here we return an error if the backend does not implement the ops.
>> But the set_flow_control ops is optional.
>> Should we return 0 instead with a debug message?
>>
> 
> It seems reasonable to allow the software to react to the absence of
> flow control support, so a debug message wouldn't help.
> 
> But advertising that more explicitly by returning something like
> EOPNOTSUPP seems better.

Right, this seems more reliable.

Thanks,
Arnaud

> 
> Regards,
> Bjorn
