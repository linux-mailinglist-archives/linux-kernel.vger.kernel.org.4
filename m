Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EBE72FC57
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243929AbjFNL1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243898AbjFNL1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:27:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9111BE8;
        Wed, 14 Jun 2023 04:27:18 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EBRB0d031193;
        Wed, 14 Jun 2023 11:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kkZNys5Fb+Cp3QOxi+B+IruG1qBTaH5is3prwH98gJM=;
 b=hT8BlI8aMjeqFke76YtxCrBOQdn5hnMTFMdHIqEJqKJAYAWyzrtCMR20kI2jAfIaxESm
 iXnuRMqeTUnm3hfs8bnOXW+HmPaG5Xzlv6+P/BoBgsGEw4pRDQPSht8yXvqagKG2PzW/
 7Sd96lmKaO8RshWpapWvM9c1AJ5ky1N9hmIGlyRhWxaQM4Y1ypHxcZxyy9hvYRg/OAjO
 bu7aejauSBPs40MCSp/raOSsLEXiqrQeXMPZf92ILm5MJPXR1bOjITa7momVvtmKUCzl
 yDGNGScYEbGPeeYsit3ceQleSF29+M933GT82Z7ZHB9UASNKeBTtHZc21RmNIsLTOCu8 fg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r78c78pts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 11:27:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35EBRAOL024277
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 11:27:10 GMT
Received: from [10.218.15.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 14 Jun
 2023 04:27:06 -0700
Message-ID: <5ad2ea54-cb81-436b-296a-b3cc850c8c38@quicinc.com>
Date:   Wed, 14 Jun 2023 16:57:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] soc: qcom: geni-se: Do not bother about enable/disable of
 interrupts in secondary sequencer for non-uart modes
Content-Language: en-CA
To:     Doug Anderson <dianders@chromium.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_msavaliy@quicinc.com>,
        <mka@chromium.org>, <swboyd@chromium.org>,
        <quic_vtanuku@quicinc.com>
References: <1685729609-26871-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=Uy=ELwg2jhtFSrpndw-GxUO=0NTKotNymi3sqwG=ggnQ@mail.gmail.com>
 <af4c131a-b97d-a8e8-957d-77c31d3c816a@quicinc.com>
 <02dabcc8-2340-2188-f6a8-51513b147e7c@quicinc.com>
 <CAD=FV=WwcpyvMem08rOXrBMUWW_7ADgfGZGEnEFDky+96pSdpQ@mail.gmail.com>
 <39b5a025-d678-57d4-9e97-432ee1763186@quicinc.com>
 <CAD=FV=Wwj=1Pt9vaWTABi2GDXS4qGV-5RvSbZuGJdgWXRh_OyA@mail.gmail.com>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <CAD=FV=Wwj=1Pt9vaWTABi2GDXS4qGV-5RvSbZuGJdgWXRh_OyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uFHUtcO8uGONBJWzC9Rj-mqNcWrFEQqK
X-Proofpoint-ORIG-GUID: uFHUtcO8uGONBJWzC9Rj-mqNcWrFEQqK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_07,2023-06-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_spam policy=outbound score=99 priorityscore=1501
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=99 spamscore=99
 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0
 mlxlogscore=-188 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140098
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 6/14/2023 12:44 AM, Doug Anderson wrote:
> Hi,
>
> On Tue, Jun 13, 2023 at 11:24 AM Vijaya Krishna Nivarthi
> <quic_vnivarth@quicinc.com> wrote:
>> Hi,
>>
>>
>> On 6/13/2023 11:27 PM, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Tue, Jun 13, 2023 at 9:07 AM Vijaya Krishna Nivarthi
>>> <quic_vnivarth@quicinc.com> wrote:
>>>> Hi,
>>>>
>>>>
>>>> On 6/12/2023 7:09 PM, Vijaya Krishna Nivarthi wrote:
>>>>> Hi,
>>>>>
>>>>> Thank you very much for the review...
>>>>>
>>>>>
>>>>> On 6/7/2023 9:41 PM, Doug Anderson wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Fri, Jun 2, 2023 at 11:13 AM Vijaya Krishna Nivarthi
>>>>>> <quic_vnivarth@quicinc.com> wrote:
>>>>>>> The select_fifo/dma_mode() functions in geni driver enable/disable
>>>>>>> interrupts (secondary included) conditionally for non-uart modes, while
>>>>>>> uart is supposed to manage this internally.
>>>>>>> However, only uart uses secondary IRQs while spi, i2c do not care about
>>>>>>> these at all making their enablement (or disablement) totally
>>>>>>> unnecessary
>>>>>>> for these protos.
>>>>>>>
>>>>>>> Drop enabling/disabling secondary IRQs for non-uart modes.
>>>>>>> This doesn't solve any observed problem but only gets rid of code
>>>>>>> pieces
>>>>>>> that are not required.
>>>>>>>
>>>>>>> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
>>>>>>> ---
>>>>>>>     drivers/soc/qcom/qcom-geni-se.c | 24 ++++--------------------
>>>>>>>     1 file changed, 4 insertions(+), 20 deletions(-)
>>>>>> This seems like a nice cleanup to me. It's still odd that the general
>>>>>> code has a special case for UART, but I guess the alternative is to
>>>>>> duplicate the exact same logic for both the i2c and SPI drivers. I
>>>>>> won't insist on that, though I wouldn't be opposed to it either.
>>>>>>
>>>>>> I guess one comment, though: should we also remove the code that
>>>>>> messes with "SE_GENI_S_IRQ_EN" in geni_se_select_gpi_mode()?
>>>>> Right now we have gpi-dma mode support for i2c and spi but not for uart.
>>>>>
>>>>> Even when gpi-dma support is added, uart driver's interrupt handler
>>>>> would not be invoked so I believe it would be safe to drop that code
>>>>> from geni_se_select_gpi_mode() too.
>>>>>
>>>>> I will post v2 dropping same after some more lookup.
>>>> Looking at this once again, I am more inclined towards leaving alone
>>>> gpi_mode() for now.
>>>>
>>>> It probably needs cleanup but we want to take that up at a later time.
>>>>
>>>> Meanwhile its not causing much harm as we don't switch modes dynamically
>>>> for gpi case, so we are not losing much time there reading from and
>>>> writing to registers.
>>>>
>>>> Please let know your thoughts.
>>> It's not really about the time needed for the extra register writes,
>>> but just someone trying to understand the code who might be trying to
>>> figure out what bits are relevant. The bits related to the secondary
>>> sequencer's interrupts don't do anything useful when we're using the
>>> controller for i2c/spi, so why not delete them?
>>
>> Agreed the s_irqs are not useful for spi/i2c but Right now I am not
>> really sure how uart + gsi mode is going to look like.
>>
>> So how about we move the part that messes with s_irq in gpi_mode() into
>> a *if(proto == GENI_SE_UART)* conditional?
>>
>> Understand we are adding to weirdness but Would that be ok for now?
> For the non-GPI DMA path and for the PIO path we don't touch the
> "S_IRQ" for UART either (we don't touch any IRQs for the UART). ...so
> it doesn't seem right to be tweaking with the S_IRQ for UART. I would
> say delete it and if/when the UART needs GPI mode then we can figure
> out what to do.
>
> I'd actually wonder if GPI will ever be implemented for UART anyway.
> The whole idea of GPI is to allow sharing a port between more than one
> user. Each user could submit a "transaction" and they'd get the port
> for the duration of that transaction. After the transaction was done
> then another user would be able to grab the port. Typically UART isn't
> used like this. I'm not saying that it couldn't be done, but just
> saying that it would be a pretty non-standard way of using a UART...


Agreed on both.

Uploading v2 dropping from gpi_mode()

Thank you.

-Vijay/


>
> -Doug
