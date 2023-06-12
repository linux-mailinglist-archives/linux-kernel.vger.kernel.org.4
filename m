Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C090F72C630
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 15:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjFLNkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 09:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236792AbjFLNkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:40:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5C8F9;
        Mon, 12 Jun 2023 06:40:02 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CBTGKk016177;
        Mon, 12 Jun 2023 13:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dTh/cPZmvz7n2CRHX7vIMDQfnSsCXzDIiq1YM27NImI=;
 b=PdXDCv8jhS/2MpfekdQUYKYIrArqusHS/IBOd5c76lr6scYho/n2fscpxrPj0Mbpth6w
 84aQToHVSCEhWMIyL5zB+qBWGgXV/sp+PbP4A2jAVN/dYmY631k9qhvRrgPtUd61F+Fz
 vMJzPK2W8MZb7JlJaVtM13UR6HJEou7zoWyz0tI8lVNLMeAGCxaQyKo+SrBROphDJHjg
 oH2zZOxQX6t/2zu5IrUd6UlKmeZuzRAr8pdVUR7SONJck1B0lKtgZqZYXTQdOh4agAQi
 Y5+Qt2+5lpQpZaqQfBc3Qm4Ej0iON6uO2OJNRc6Kgs7x/1Xi2rRPXmOpwr+jVDelSK7s Ww== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r4jfe3e16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 13:39:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35CDdwxs024526
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 13:39:58 GMT
Received: from [10.217.219.131] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 12 Jun
 2023 06:39:55 -0700
Message-ID: <af4c131a-b97d-a8e8-957d-77c31d3c816a@quicinc.com>
Date:   Mon, 12 Jun 2023 19:09:52 +0530
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
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <CAD=FV=Uy=ELwg2jhtFSrpndw-GxUO=0NTKotNymi3sqwG=ggnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oaa35-xyGBgWOsKsYED45dn4O7BwJkvL
X-Proofpoint-GUID: oaa35-xyGBgWOsKsYED45dn4O7BwJkvL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_06,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=28 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 spamscore=28 clxscore=1015 bulkscore=0 mlxlogscore=41
 suspectscore=0 mlxscore=28 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120117
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you very much for the review...


On 6/7/2023 9:41 PM, Doug Anderson wrote:
> Hi,
>
> On Fri, Jun 2, 2023 at 11:13 AM Vijaya Krishna Nivarthi
> <quic_vnivarth@quicinc.com> wrote:
>> The select_fifo/dma_mode() functions in geni driver enable/disable
>> interrupts (secondary included) conditionally for non-uart modes, while
>> uart is supposed to manage this internally.
>> However, only uart uses secondary IRQs while spi, i2c do not care about
>> these at all making their enablement (or disablement) totally unnecessary
>> for these protos.
>>
>> Drop enabling/disabling secondary IRQs for non-uart modes.
>> This doesn't solve any observed problem but only gets rid of code pieces
>> that are not required.
>>
>> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
>> ---
>>   drivers/soc/qcom/qcom-geni-se.c | 24 ++++--------------------
>>   1 file changed, 4 insertions(+), 20 deletions(-)
> This seems like a nice cleanup to me. It's still odd that the general
> code has a special case for UART, but I guess the alternative is to
> duplicate the exact same logic for both the i2c and SPI drivers. I
> won't insist on that, though I wouldn't be opposed to it either.
>
> I guess one comment, though: should we also remove the code that
> messes with "SE_GENI_S_IRQ_EN" in geni_se_select_gpi_mode()?


Right now we have gpi-dma mode support for i2c and spi but not for uart.

Even when gpi-dma support is added, uart driver's interrupt handler 
would not be invoked so I believe it would be safe to drop that code 
from geni_se_select_gpi_mode() too.

I will post v2 dropping same after some more lookup.

-Vijay/


>
> -Doug
