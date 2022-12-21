Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7277F652C73
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 06:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbiLUFj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 00:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiLUFjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 00:39:22 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2461D33A;
        Tue, 20 Dec 2022 21:39:21 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BL5Hrgs026599;
        Wed, 21 Dec 2022 05:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=D8KWVeGSbq9zikjeHsg8jvAfVBHKlzhqOjkQpLjMGzo=;
 b=PF+Q7kWhWQ6iPB8PI4ZD1fJ11cxHNIhos/JIU0a7ZnJfxH2/SOW28L+3fvIQuPqnr0Lf
 NRvUTR27sSffTZPcwA90P/8ts2N5H9ZwDcpTAtOGb0F3YiCPplMVkWHKTUynqEdZSy1g
 BUXoWvyguC4xmMNwjie9cft6rVlHBo/fP4t7jVijPlfv36pxownxN6v1GVS8AY4V9M3a
 8Qqwu67VwPjnoA9K9ssEw15jP2hBmWxOCWbhRzIY5RGjR0+sSjHc+wH0DCB4kSYz6yYW
 oveT5XGLoIkw7evc0Jo65CpqmO26J+/vekqfb8QTztqIk3yEBDIK1nE+XqnYElLQv/Zb qw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mk85xth3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 05:39:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BL5dBTo005644
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 05:39:11 GMT
Received: from [10.206.24.249] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 21:39:06 -0800
Message-ID: <e63e27df-7e46-337c-f22a-ccd1bbcd0c28@quicinc.com>
Date:   Wed, 21 Dec 2022 11:09:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] spmi: Add check for remove callback in spmi_drv_remove
 API
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <quic_kamalw@quicinc.com>, <sboyd@kernel.org>,
        <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>
References: <1670145780-13111-1-git-send-email-quic_jprakash@quicinc.com>
 <1670145780-13111-2-git-send-email-quic_jprakash@quicinc.com>
 <Y5hqMFw0xl6lmJYL@kroah.com>
 <367fdcef-7360-055a-897b-71a66063b4ba@quicinc.com>
 <Y5iVqrnlX8NoiOkl@kroah.com>
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <Y5iVqrnlX8NoiOkl@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ypJ1RWrLRe0TrPWhuJnOXCDa-FmzMhK7
X-Proofpoint-GUID: ypJ1RWrLRe0TrPWhuJnOXCDa-FmzMhK7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_01,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=522 bulkscore=0 adultscore=0
 spamscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212210038
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On 12/13/2022 8:39 PM, Greg KH wrote:
> On Tue, Dec 13, 2022 at 07:12:10PM +0530, Jishnu Prakash wrote:
>> Hi Greg
> 
> Hi, please do not top-post :(
> 
>> These are two SPMI drivers without remove callbacks defined:
>>
>> drivers/mfd/qcom-spmi-pmic.c
>> drivers/mfd/hi6421-spmi-pmic.c
> 
> Great, they should be fixed up now, right?
> 

Our QCOM SPMI PMIC driver allocates resources in its probe using only 
devm_() APIs and does not require any other cleanup. It doesn't seem 
right to add an empty remove callback to it just to avoid this crash, it
seems the better solution architecturally is to call the remove function 
only if it's defined.

In addition, I could see that other buses like PCI and AMBA do check for 
the remove API being defined for their drivers before calling it:

AMBA example: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/amba/bus.c#n328

PCI example: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pci-driver.c#n474


>> We made this change after noticing an issue internally with the first one
>> above, there was a crash when trying to remove it with rmmod, which is fixed
>> by this change.
> 
> Then please say that in the changelog text, otherwise we have no idea
> _why_ this is needed.  All you said was "add this new check _IF_" and we
> have no idea what the answer to "if" is :(
> 

I have uploaded the change with an updated title and commit text, can 
you please have a look?

> thanks,
> 
> greg k-h
Thanks,
Jishnu
