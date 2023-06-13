Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625FE72E7DB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239339AbjFMQHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbjFMQHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:07:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BDAA0;
        Tue, 13 Jun 2023 09:07:10 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DAkVw4004535;
        Tue, 13 Jun 2023 16:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rOkfD0VbuvCThFWC0VDMkt5Me6BqDMFsKBlBpWGcBE0=;
 b=LMB/LvOBUlhHfn1VzUhUjPwJK5AGFIj9Yeasfy/xMfnzdihWWvdVxulgsRHqRIzxjLXl
 D+qf7d7XhWLYNExo8BtGJ78CKWyBDZZLt/lvJ6ZUrxp1DDOxitvA2kLutDAG6YLFKCx4
 jpJ7nIHIWf8NpCc0dobXcqbpc4/59rvQXhE6ISPkh+2O9IH3wQO7kzj8VpXarJr/h9ps
 fb1+OhN6C8SoQOv/jbCS0MPkv74IY2Z1l4YlTayGCQTrTJdLb56iMgb7KUOfWFeMT4K3
 0hpx2qP2QyiPXno2yXKvH+Ahu8i3JyCgWbjkv1xwgAwvl3Mla0ySZccijHwXM2Y6h5iN zQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r68x9a7fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 16:07:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35DG74A9002280
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 16:07:04 GMT
Received: from [10.216.12.219] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 13 Jun
 2023 09:07:00 -0700
Message-ID: <02dabcc8-2340-2188-f6a8-51513b147e7c@quicinc.com>
Date:   Tue, 13 Jun 2023 21:36:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] soc: qcom: geni-se: Do not bother about enable/disable of
 interrupts in secondary sequencer for non-uart modes
Content-Language: en-CA
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     Doug Anderson <dianders@chromium.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_msavaliy@quicinc.com>,
        <mka@chromium.org>, <swboyd@chromium.org>,
        <quic_vtanuku@quicinc.com>
References: <1685729609-26871-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=Uy=ELwg2jhtFSrpndw-GxUO=0NTKotNymi3sqwG=ggnQ@mail.gmail.com>
 <af4c131a-b97d-a8e8-957d-77c31d3c816a@quicinc.com>
In-Reply-To: <af4c131a-b97d-a8e8-957d-77c31d3c816a@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5qZaDfeNdUiV3yIX0wyNFaWxOn7w0Dyf
X-Proofpoint-ORIG-GUID: 5qZaDfeNdUiV3yIX0wyNFaWxOn7w0Dyf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_18,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_spam policy=outbound score=95 phishscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 spamscore=95 suspectscore=0
 mlxlogscore=-127 mlxscore=95 adultscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130142
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 6/12/2023 7:09 PM, Vijaya Krishna Nivarthi wrote:
> Hi,
>
> Thank you very much for the review...
>
>
> On 6/7/2023 9:41 PM, Doug Anderson wrote:
>> Hi,
>>
>> On Fri, Jun 2, 2023 at 11:13 AM Vijaya Krishna Nivarthi
>> <quic_vnivarth@quicinc.com> wrote:
>>> The select_fifo/dma_mode() functions in geni driver enable/disable
>>> interrupts (secondary included) conditionally for non-uart modes, while
>>> uart is supposed to manage this internally.
>>> However, only uart uses secondary IRQs while spi, i2c do not care about
>>> these at all making their enablement (or disablement) totally 
>>> unnecessary
>>> for these protos.
>>>
>>> Drop enabling/disabling secondary IRQs for non-uart modes.
>>> This doesn't solve any observed problem but only gets rid of code 
>>> pieces
>>> that are not required.
>>>
>>> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
>>> ---
>>>   drivers/soc/qcom/qcom-geni-se.c | 24 ++++--------------------
>>>   1 file changed, 4 insertions(+), 20 deletions(-)
>> This seems like a nice cleanup to me. It's still odd that the general
>> code has a special case for UART, but I guess the alternative is to
>> duplicate the exact same logic for both the i2c and SPI drivers. I
>> won't insist on that, though I wouldn't be opposed to it either.
>>
>> I guess one comment, though: should we also remove the code that
>> messes with "SE_GENI_S_IRQ_EN" in geni_se_select_gpi_mode()?
>
>
> Right now we have gpi-dma mode support for i2c and spi but not for uart.
>
> Even when gpi-dma support is added, uart driver's interrupt handler 
> would not be invoked so I believe it would be safe to drop that code 
> from geni_se_select_gpi_mode() too.
>
> I will post v2 dropping same after some more lookup.


Looking at this once again, I am more inclined towards leaving alone 
gpi_mode() for now.

It probably needs cleanup but we want to take that up at a later time.

Meanwhile its not causing much harm as we don't switch modes dynamically 
for gpi case, so we are not losing much time there reading from and 
writing to registers.

Please let know your thoughts.

Thank you,

Vijay/


>
> -Vijay/
>
>
>>
>> -Doug
