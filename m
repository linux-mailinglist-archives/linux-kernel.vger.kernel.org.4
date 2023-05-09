Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF556FD0A8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbjEIVRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbjEIVRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:17:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECC249E6;
        Tue,  9 May 2023 14:17:02 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349KWr7B028841;
        Tue, 9 May 2023 20:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=70oMHm2DIfkB6dX2jvjs4PUxmGxvXk+DziGGIhNNhZ0=;
 b=ZhRgFMOrGHEN0dKUYK/BmV7MOFimHMhQM0mcTaGjA13WZfvmS5iV1qm02e6JMi7HeqfG
 eOYqemLHq8XXA1Tn+CpiKNaW5eLcCwWrUd66l0xPpRbBggOjG7J5D6rvXvReMtePoBeS
 nlgD6jsSnZ4B6BQczcXsKN2XRqpyBCFuASXptbyw2i3nrDGV9odLPXVGMQ71MwGcOqMN
 hYfwhY1qbLNaLaMU8JOXjxWE0oVXX+Fmf9b7yvDKDHzqviBXKUBHrNxwHFpjzImOTmGq
 8OlGvpAAV0yAtKN4tDfTjRQcS96TpKDRq0vSQHJFEsxZSmSzOU/BaSpW9GQz7aupFKky 7w== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qf7862uea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 20:52:15 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 349KqEcm007400
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 20:52:14 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 9 May 2023
 13:52:14 -0700
Message-ID: <b4fa7ae9-da5e-7a94-3b82-00d9200aa67e@quicinc.com>
Date:   Tue, 9 May 2023 13:52:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v12 06/25] mailbox: Add Gunyah message queue mailbox
Content-Language: en-US
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230424231558.70911-1-quic_eberman@quicinc.com>
 <20230424231558.70911-7-quic_eberman@quicinc.com>
 <CABb+yY3ojsGNm1w+QSn2BnbOMdcQZAV+=UYiMiBrs=jujP=pSg@mail.gmail.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <CABb+yY3ojsGNm1w+QSn2BnbOMdcQZAV+=UYiMiBrs=jujP=pSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NR1b7x1z_Uh4grTWEGZSVhySwsBBV_EI
X-Proofpoint-ORIG-GUID: NR1b7x1z_Uh4grTWEGZSVhySwsBBV_EI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_13,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 mlxlogscore=731 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090171
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jassi,

On 5/3/2023 11:21 PM, Jassi Brar wrote:
> On Mon, Apr 24, 2023 at 6:16 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
>>
>> Gunyah message queues are a unidirectional inter-VM pipe for messages up
>> to 1024 bytes. This driver supports pairing a receiver message queue and
>> a transmitter message queue to expose a single mailbox channel.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   Documentation/virt/gunyah/message-queue.rst |   8 +
>>   drivers/mailbox/Makefile                    |   2 +
>>   drivers/mailbox/gunyah-msgq.c               | 210 ++++++++++++++++++++
>>   include/linux/gunyah.h                      |  57 ++++++
>>
> include/linux/gunyah.h  and
> Documentation/virt/gunyah/message-queue.rst would need to exist for
> this patch to apply.
> If you made this patch as the first in series, then I could apply.
> 

The mailbox driver is dependent on patches 3-5. Could [1] be picked up 
in meantime? I'll talk with QC Landing team folks about strategies to 
merge once they finish review.

[1]: 
https://lore.kernel.org/all/20230410161654.1660757-1-quic_eberman@quicinc.com/
