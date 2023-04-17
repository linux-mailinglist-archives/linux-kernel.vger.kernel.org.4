Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1FA6E4DD9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjDQP5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjDQP5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:57:34 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2DE184;
        Mon, 17 Apr 2023 08:57:32 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HEWn3A008676;
        Mon, 17 Apr 2023 15:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=I5acRLSYZjT2lEhvUhH7cVOEx6g5kRueap6fbmpuQz8=;
 b=bi6WKlALkLfGkbK1wFUUrhwQwvCRsLdW2uzhQzCd+euKH/ZcvJZO66v3lRwARXErdKI3
 qRYeaBqDqVxcmWKuXj6EgOMO6Os5ziH/hLTnl9mCRhfx/efRD+2ovX6ZRjG/xExYvgEz
 cPDBenbilkdsiV7QoA9Zs8+jiaDXfMSn+ftK4ajPoQ3k4Est5ERpcFgzMXt9RWJ4Abwb
 XYpfw+K/lyLK9DM0+yINh+4UShlguCRdtLWC5L6WcBJ2cKUzFuqk/+C74CtavmIYgQR0
 EH6oQxyb7Y2anhjGa5yNUcZuzrPt0HFkl0Fi/KQG45nlkRH7+kyK6j5Q8Cf1NGaA3Pji 1w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q17yhr9w2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 15:57:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33HFvOOj027676
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 15:57:24 GMT
Received: from [10.218.15.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 17 Apr
 2023 08:57:19 -0700
Message-ID: <46249e7e-ac2c-00d3-b3b0-7b15848e7b7c@quicinc.com>
Date:   Mon, 17 Apr 2023 21:27:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 3/3] spi: spi-qcom-qspi: Add DMA mode support
Content-Language: en-CA
To:     Doug Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_msavaliy@quicinc.com>, <mka@chromium.org>,
        <swboyd@chromium.org>, <quic_vtanuku@quicinc.com>
References: <1681481153-24036-1-git-send-email-quic_vnivarth@quicinc.com>
 <1681481153-24036-4-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=VKY-0vX271G+EQQ5kC3gTqpPPyTGE0xHWPBncVUhZufQ@mail.gmail.com>
 <30a752c9-3ea0-43d3-959a-da2e8b526cb4@sirena.org.uk>
 <CAD=FV=VCbcUnf42tK-HV8j=71BXXytxku_0rGjKyhyR3WG4SUw@mail.gmail.com>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <CAD=FV=VCbcUnf42tK-HV8j=71BXXytxku_0rGjKyhyR3WG4SUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AqcRcTXQqIZUwffgh8McwtrRXa-u90Wz
X-Proofpoint-GUID: AqcRcTXQqIZUwffgh8McwtrRXa-u90Wz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_10,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170143
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 4/17/2023 7:37 PM, Doug Anderson wrote:
> Hi,
>
> On Mon, Apr 17, 2023 at 5:12 AM Mark Brown <broonie@kernel.org> wrote:
>> On Fri, Apr 14, 2023 at 03:05:58PM -0700, Doug Anderson wrote:
>>
>>> Having alignment requirements like this doesn't seem like it should be
>>> that unusual, though, and that's why it feels like the logic belongs
>>> in the SPI core. In fact, it seems like this is _supposed_ to be
>>> handled in the SPI core, but it isn't? In "spi.h" I see
>>> "dma_alignment" that claims to be exactly what you need. As far as I
>>> can tell, though, the core doesn't use this? ...so I'm kinda confused.
>>> As far as I can tell this doesn't do anything and thus anyone setting
>>> it today is broken?
>> SPI consumers should only be providing dmaable buffers.
> Ah, I think I see.
>
> 1. In "struct spi_transfer" the @tx_buf and @rx_buf are documented to
> have "dma-safe memory".
>
> 2. On ARM64 anyway, I see "ARCH_DMA_MINALIGN" is 128.
>
> So there is no reason to do any special rules to force alignment to
> 32-bytes because that's already guaranteed. Presumably that means you
> can drop a whole pile of code and things will still work fine.
>
> -Doug


Thank you very much Mark and Doug for review and inputs.


spi_map_buf is taking into consideration max_dma_len (in spi.h) when it 
is set.

For example if set to 1024 instead of 65536(the actual max_dma_len of 
HW), 4 entries are created in the sg_table for a buffer of size 4096.

However, Like Doug pointed, dma_alignment is not being used by core.

Some drivers seem to be setting both of these in probe() but 
dma_alignment is probably not taking effect.

Is it up to the SPI consumers to read this and ensure they are providing 
dmaable buffers of required alignment?


The dma_addresses coming from core are aligned for larger sized buffers 
but for small ones like 1 and 3 bytes they are not aligned.

Hence if the code handing the alignment part is not present, smaller 
transfers fail.

For example, Below debug patch does

a) all transfers in DMA

b) prints DMA addresses and lengths

====== patch start ======

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index 60c4f554..8d24022 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -438,8 +438,14 @@ static int qcom_qspi_setup_dma_desc(struct 
qcom_qspi *ctrl,
                 return -EINVAL;
         }

-       for (i = 0; i < sgt->nents; i++)
+       for (i = 0; i < sgt->nents; i++) {
+               dma_addr_t temp_addr;
                 sg_total_len += sg_dma_len(sgt->sgl + i);
+
+               temp_addr = sg_dma_address(sgt->sgl + i);
+               dev_err_ratelimited(ctrl->dev, "%s pilli-20230417 i-%d, 
nents-%d, len-%d, dma_address-%pad\n",
+                               __func__, i, sgt->nents, 
sg_dma_len(sgt->sgl + i), &temp_addr);
+       }
         if (sg_total_len != xfer->len) {
                 dev_err(ctrl->dev, "Data lengths mismatch\n");
                 return -EINVAL;
@@ -517,6 +523,7 @@ static void qcom_qspi_dma_xfer(struct qcom_qspi *ctrl)
  static bool qcom_qspi_can_dma(struct spi_controller *ctlr,
                          struct spi_device *slv, struct spi_transfer *xfer)
  {
+       return true;
         return xfer->len > QSPI_MAX_BYTES_FIFO ? true : false;
  }

====== patch end =======

and below is sample outcome...

[   23.620397] qcom_qspi 88dc000.spi: qcom_qspi_setup_dma_desc 
pilli-20230417 i-0, nents-1, len-1, dma_address-0x00000000fff3e000
[   23.638392] qcom_qspi 88dc000.spi: qcom_qspi_setup_dma_desc 
pilli-20230417 i-0, nents-1, len-3, dma_address-0x00000000fff3f001
[   23.650238] qcom_qspi 88dc000.spi: qcom_qspi_setup_dma_desc 
pilli-20230417 i-0, nents-1, len-1, dma_address-0x00000000fff40004
[   23.662039] qcom_qspi 88dc000.spi: qcom_qspi_setup_dma_desc 
pilli-20230417 i-0, nents-1, len-8, dma_address-0x00000000fff44080
[   23.673965] qcom_qspi 88dc000.spi: qcom_qspi_setup_dma_desc 
pilli-20230417 i-0, nents-1, len-1, dma_address-0x00000000fff44000
[   23.685749] qcom_qspi 88dc000.spi: qcom_qspi_setup_dma_desc 
pilli-20230417 i-0, nents-1, len-3, dma_address-0x00000000fff40001
[   23.697630] qcom_qspi 88dc000.spi: qcom_qspi_setup_dma_desc 
pilli-20230417 i-0, nents-1, len-1, dma_address-0x00000000fff3f004
[   23.709552] qcom_qspi 88dc000.spi: qcom_qspi_setup_dma_desc 
pilli-20230417 i-0, nents-1, len-8, dma_address-0x00000000fff3e600
[   23.721460] qcom_qspi 88dc000.spi: qcom_qspi_setup_dma_desc 
pilli-20230417 i-0, nents-1, len-1, dma_address-0x00000000fff3e000
[   23.733257] qcom_qspi 88dc000.spi: qcom_qspi_setup_dma_desc 
pilli-20230417 i-0, nents-1, len-3, dma_address-0x00000000fff3f001

If we use the dma_address from sg table as is, transfers fail.

I have not checked the spi-nor driver, but is it the consumer driver's 
job to ensure required alignment in all cases?

Can you Please comment?

Thank you,

-Vijay/


