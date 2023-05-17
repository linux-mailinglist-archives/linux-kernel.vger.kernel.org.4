Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C207067D2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjEQMRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjEQMRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:17:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5687E193;
        Wed, 17 May 2023 05:17:08 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34H95TZ8007786;
        Wed, 17 May 2023 12:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UBF2k+pxdnd1i8kOldh05iPyM10d3+OkAcIwwYPjPdU=;
 b=am+sF3aCSVqcae92f/O6WqXErTEc+9CdUq6u85/Ns7MvsgUANvXYWgX3pRClOmy04gtL
 bLBfujCCJTmX9NFTMB4dz24BSLcX7USVLAoxmxvsWIEh5NxpQk32ZyBz6F89OmzaVkhy
 YZiq2KGtrMqGbIefacSvRaJmzVAGOtdja3rGm4Tkv4NRC3/Gw4epoQpfXOYO9y20QMvv
 eZL47JNl3HcMHIqc7WTSjyDETsLHvVsEzS+1aJtVId7tR4/b7RfsYo37Sgrqs8kVNgWv
 R+jZ9IOw8pM3bM6ppMi8d/QsOE74PleJRLV10ivGwN427bWaDXg+MfIQykl2mES6cZ5u XA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qme0ma098-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 12:16:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34HCGwC1014096
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 12:16:58 GMT
Received: from [10.216.9.165] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 17 May
 2023 05:16:54 -0700
Message-ID: <27ed4b11-14bf-081f-619e-75789d8caced@quicinc.com>
Date:   Wed, 17 May 2023 17:46:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] spi: spi-geni-qcom: Do not do DMA map/unmap inside
 driver, use framework instead
Content-Language: en-CA
To:     Doug Anderson <dianders@chromium.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_msavaliy@quicinc.com>,
        <mka@chromium.org>, <swboyd@chromium.org>,
        <quic_vtanuku@quicinc.com>, <quic_ptalari@quicinc.com>
References: <1683911265-3395-1-git-send-email-quic_vnivarth@quicinc.com>
 <1683911265-3395-3-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=WbMFDsC7dVjLNrtwi-hDEbSx9R8XzVGFW902OSKSFWjA@mail.gmail.com>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <CAD=FV=WbMFDsC7dVjLNrtwi-hDEbSx9R8XzVGFW902OSKSFWjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -pqy6nmmC3uwL53HLKZT9h9FfX-1H9Zl
X-Proofpoint-ORIG-GUID: -pqy6nmmC3uwL53HLKZT9h9FfX-1H9Zl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170100
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you very much for the review...


On 5/15/2023 9:43 PM, Doug Anderson wrote:
> Hi,
>
> On Fri, May 12, 2023 at 10:07 AM Vijaya Krishna Nivarthi
> <quic_vnivarth@quicinc.com> wrote:
>> @@ -836,35 +858,24 @@ static int setup_se_xfer(struct spi_transfer *xfer,
>>          geni_se_setup_m_cmd(se, m_cmd, FRAGMENTATION);
>>
>>          if (mas->cur_xfer_mode == GENI_SE_DMA) {
>> +               dma_addr_t dma_ptr_sg;
>> +               unsigned int dma_len_sg;
>> +
>>                  if (m_cmd & SPI_RX_ONLY) {
>> -                       ret =  geni_se_rx_dma_prep(se, xfer->rx_buf,
>> -                               xfer->len, &mas->rx_se_dma);
>> -                       if (ret) {
>> -                               dev_err(mas->dev, "Failed to setup Rx dma %d\n", ret);
>> -                               mas->rx_se_dma = 0;
>> -                               goto unlock_and_return;
>> -                       }
>> +                       dma_ptr_sg = sg_dma_address(xfer->rx_sg.sgl);
>> +                       dma_len_sg = sg_dma_len(xfer->rx_sg.sgl);
>> +                       geni_se_rx_init_dma(se, &dma_ptr_sg, dma_len_sg);
> nit: probably don't need local variables if you change patch set #1
> like I suggested and don't pass in a pointer for the iova.
>
Done.

> One last question: should you call:
>
> dma_set_max_seg_size(dev, INT_MAX)
>
> ...in your probe function? I don't think you have any limitations of
> maximum segment size, right? Right now if you don't set anything it
> looks as if it considers your max to be 64K. That would cause the SPI
> framework to break things up into multiple chunks which would make you
> fall back to FIFO mode, right?


Actually we would need to call:

dma_set_max_seg_size(dev->parent, INT_MAX)

Please note that in probe()

spi->dma_map_dev = dev->parent;

and in __spi_map_msg()

tx_dev = ctlr->dma_map_dev;

ret = spi_map_buf(ctlr, tx_dev, &xfer->tx_sg,...


Since the dev->parent is QUP containing other SEs and its max_seg_size 
seems to be getting set from elsewhere than code (perhaps kernel 
scripts) it seemed safer not to modify that.

So I made below change and uploaded v2...

spi->max_dma_len = 0xffff0; /* 24 bits for tx/rx dma length */

which actually doesnt help much because spi_map_buf() picks the lower of 
these 2 but added it anyway

desc_len = min_t(size_t, max_seg_size, ctlr->max_dma_len);


Any case as next step we will look into scatter list support to DMA; and 
practically we may not have transfers over 64KB, so its ok for now?

Thank you,

Vijay/


>
> Other than that this looks good to me.
>
> -Doug
