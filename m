Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB79664802
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238600AbjAJSCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238689AbjAJR6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:58:11 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91684E45;
        Tue, 10 Jan 2023 09:57:52 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AFZiON027412;
        Tue, 10 Jan 2023 17:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VSAB5O5zW1UEm3r5V4pm/Pjdzw+2Z5dVjrGb0q+FBDk=;
 b=D7N1UAdyF9dOyccRGi/0TivY+QuGO0sx7sMhPJfh9QE4TDzkgPYl+OpKPTmjSJuoHr8a
 kLnXuUI1Enh/qN/an8+8P65cf9+nUwYuIMfVOanbRCAbpyKmtqlklNbMh+IOSM3//VTO
 8TO/uHE0CLc+pkztyMFB6CdqPxrCpIO2+AcOxWepcliSGUB8fs8Qn+9xAGrBeMqc/mO9
 m2R3usIbvaN0uq3eplndoNwy0/cW85W8SehEs/nD3w9znnWL/F+hykAo8zqLf1EFrFwy
 mONbzri+nHH2g4i3Zq0i5edm2yOvvGUMI2VR1w6UIWdVc16sEvCVGz6PO7aSPbqz6s9M Rw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n0q28jq5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 17:57:41 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30AHvfS3008504
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 17:57:41 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 10 Jan
 2023 09:57:40 -0800
Message-ID: <8f47229a-2785-5f54-f7d1-a42299de64fe@quicinc.com>
Date:   Tue, 10 Jan 2023 09:57:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH v8 07/28] mailbox: Allow direct registration to a channel
To:     Alex Elder <elder@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-8-quic_eberman@quicinc.com>
 <942f20cc-87d3-d014-1527-8d3d3e1ae44b@linaro.org>
Content-Language: en-US
In-Reply-To: <942f20cc-87d3-d014-1527-8d3d3e1ae44b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: q_MOPBZQ5d9shU7caoByWgMe7_Y2jAZx
X-Proofpoint-GUID: q_MOPBZQ5d9shU7caoByWgMe7_Y2jAZx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_07,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100115
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/2023 1:34 PM, Alex Elder wrote:
> On 12/19/22 4:58 PM, Elliot Berman wrote:
>> Support virtual mailbox controllers and clients which are not platform
>> devices or come from the devicetree by allowing them to match client to
>> channel via some other mechanism.
> 
> The new function behaves very much like mbox_request_channel()
> did before.
> 
> The new function differs from omap_mbox_request_channel() in that
> it can change the if chan->txdone_method is TXDONE_BY_POLL, it
> is changed to TXDONE_BY_ACK if the client's knows_txdone field is
> set.  Is this OK?  Why?

Both of the current drivers that use mbox_bind_client use TXDONE_BY_IRQ, 
so this doesn't cause issue for checking whether the client has 
txdone_method.

> 
> It also assumes chan->mbox->ops->startup us non-null (though that
> isn't really a problem).
> 
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   drivers/mailbox/mailbox.c      | 96 ++++++++++++++++++++++++----------
>>   drivers/mailbox/omap-mailbox.c | 18 ++-----
>>   drivers/mailbox/pcc.c          | 18 ++-----
>>   include/linux/mailbox_client.h |  1 +
>>   4 files changed, 76 insertions(+), 57 deletions(-)
>>
>> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
>> index 4229b9b5da98..adf36c05fa43 100644
>> --- a/drivers/mailbox/mailbox.c
>> +++ b/drivers/mailbox/mailbox.c
>> @@ -317,6 +317,71 @@ int mbox_flush(struct mbox_chan *chan, unsigned 
>> long timeout)
>>   }
>>   EXPORT_SYMBOL_GPL(mbox_flush);
>> +static int __mbox_bind_client(struct mbox_chan *chan, struct 
>> mbox_client *cl)
> 
> There should be an unbind_client() call.  At a minimum, you are
> calling try_module_get(), and the matching module_put() call
> would belong there.  And even though one might just call
> module_put() elsewhere for this, it would be cleaner to have
> a function that similarly encapsulates the shutdown call
> as well.

The function for this is "mbox_free_channel".

Thanks,
Elliot
