Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F126DFA07
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjDLP3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjDLP3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:29:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B426A68;
        Wed, 12 Apr 2023 08:28:55 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CEunsJ012342;
        Wed, 12 Apr 2023 15:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ckZ0QKNXfFrb2CCdjIPdjgJpy9739alPUMnQiAxDvYU=;
 b=X4Gq0AuwLA7ji5PrdotNXfVohsXm1C5fsrnlyBOgx/Pfp3MWdCUEAgn7vXOLadL5pxS+
 rXkkC2tqgFcMeSOvjlxurrBRFHvDrBmsbBhOjSgUGR6/UEyl21+4h34YG5D6dLg5su3k
 Mw/LIrabHp9pPOZNU9F5W5AasUPNMuaks0z5g3Pc/rXNQwU1xevWMF8VAnhpVB3g6bjc
 t+157Aebt4mGnZMO4agLCvk03r5PkNlVtJphJwyykI8H2gwltjvIiASa9eVLX1lKrgly
 NsKTLWWyYmgydzFG2LLg9hWEyxbzE80m1+sAu0noH26uMTuAEsfZuMFR66X2rontABNV RQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pw9b9jxas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 15:28:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33CFSotw022163
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 15:28:50 GMT
Received: from [10.216.35.198] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 12 Apr
 2023 08:28:45 -0700
Message-ID: <cfe7aa31-242e-2fa5-6483-7a635139c785@quicinc.com>
Date:   Wed, 12 Apr 2023 20:58:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] spi: spi-qcom-qspi: Add DMA mode support
Content-Language: en-CA
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <robh+dt@kernel.org>,
        <vkoul@kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <dianders@chromium.org>,
        <mka@chromium.org>, <quic_vtanuku@quicinc.com>
References: <1680631400-28865-1-git-send-email-quic_vnivarth@quicinc.com>
 <1680631400-28865-3-git-send-email-quic_vnivarth@quicinc.com>
 <CAE-0n53zOKQ+MwNP9nkse2hO4xfxC6T8tRJ0h_vB3gMibC_=Ug@mail.gmail.com>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <CAE-0n53zOKQ+MwNP9nkse2hO4xfxC6T8tRJ0h_vB3gMibC_=Ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xXIjFtrvgxkctlfbDCX9wqGcJkk_-DxT
X-Proofpoint-ORIG-GUID: xXIjFtrvgxkctlfbDCX9wqGcJkk_-DxT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_06,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120135
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the review...


On 4/5/2023 2:15 AM, Stephen Boyd wrote:
> Quoting Vijaya Krishna Nivarthi (2023-04-04 11:03:20)
>> For performance improvement in terms of number of interrupts.
>> Code flow for DMA mode...
>> Allocate for DMA pools in probe()
>> For xfers with len > 64 bytes, return true from can_dma()
>> Thus framework creates and maps an sg table for each xfer buffer.
>> In transfer_one() enable DMA in MSTR_CONFIG.
>> Split the dma buffer of each entry of sgt into a maximum of 3 parts...
>> Unaligned head, aligned middle and tail.
>> For each part create a dma_cmd_descriptor.
>> For head and tail allocate dma_data_descriptors
>>    For tx, copy the data into allocated data descriptors
>>    For rx, remember the original buffers to copy from-
>>    allocated descriptors after xfer is complete
>> For middle part use the aligned dma buffer.
>> Link each dma_cmd_descriptor to next.
>> Thus create a chain of descriptors.
>> Kick-off the xfer by copying 1st cmd descriptor to-
>> NEXT_DMA_DESC_ADDR register.
>> On receiving DMA_CHAIN_DONE interrupt, complete the xfer and-
>> free descriptors.
>> If timeout happens handle error by freeing descriptors.
>> In remove() free DMA pools.
>>
> Write a real commit text, and not psuedo-code for the patch. It should
> sell us on wanting to review the patch, and help us understand the
> importance of the change. The "how" comes from reading the patch
> and code itself.


Modified.

>> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
>> ---
>>   drivers/spi/spi-qcom-qspi.c | 429 ++++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 398 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
>> index fab1553..64c3bec 100644
>> --- a/drivers/spi/spi-qcom-qspi.c
>> +++ b/drivers/spi/spi-qcom-qspi.c
>> @@ -13,7 +13,8 @@
>>   #include <linux/pm_opp.h>
>>   #include <linux/spi/spi.h>
>>   #include <linux/spi/spi-mem.h>
>> -
>> +#include <linux/dmapool.h>
>> +#include <linux/dma-mapping.h>
> Sort this alphabetically like all the other headers here.


Done

>>   #define QSPI_NUM_CS            2
>>   #define QSPI_BYTES_PER_WORD    4
>> @@ -62,6 +63,7 @@
>>   #define WR_FIFO_FULL           BIT(10)
>>   #define WR_FIFO_OVERRUN                BIT(11)
>>   #define TRANSACTION_DONE       BIT(16)
>> +#define DMA_CHAIN_DONE         BIT(31)
>>   #define QSPI_ERR_IRQS          (RESP_FIFO_UNDERRUN | HRESP_FROM_NOC_ERR | \
>>                                   WR_FIFO_OVERRUN)
>>   #define QSPI_ALL_IRQS          (QSPI_ERR_IRQS | RESP_FIFO_RDY | \
>> @@ -108,6 +110,10 @@
>>   #define RD_FIFO_RESET          0x0030
>>   #define RESET_FIFO             BIT(0)
>>
>> +#define NEXT_DMA_DESC_ADDR             0x0040
>> +#define CURRENT_DMA_DESC_ADDR  0x0044
>> +#define CURRENT_MEM_ADDR               0x0048
>> +
>>   #define CUR_MEM_ADDR           0x0048
>>   #define HW_VERSION             0x004c
>>   #define RD_FIFO                        0x0050
>> @@ -120,6 +126,22 @@ enum qspi_dir {
>>          QSPI_WRITE,
>>   };
>>
>> +struct qspi_cmd_desc {
>> +       uint32_t data_address;
> Use u32/u8 instead of uint32_t/uint8_t


Done

>> +       uint32_t next_descriptor;
>> +       uint32_t direction:1;
>> +       uint32_t multi_io_mode:3;
>> +       uint32_t reserved1:4;
>> +       uint32_t fragment:1;
>> +       uint32_t reserved2:7;
>> +       uint32_t length:16;
>> +       //------------------------//
>> +       uint8_t *bounce_src;
>> +       uint8_t *bounce_dst;
>> +       uint32_t bounce_length;
>> +};
>> +
>> +#define QSPI_MAX_NUM_DESC 5
>>   struct qspi_xfer {
>>          union {
>>                  const void *tx_buf;
>> @@ -137,11 +159,30 @@ enum qspi_clocks {
>>          QSPI_NUM_CLKS
>>   };
>>
>> +enum qspi_xfer_mode {
>> +       QSPI_INVALID,
>> +       QSPI_FIFO,
>> +       QSPI_DMA
>> +};
>> +
>> +/* number of entries in sgt returned from spi framework that we can support */
>> +#define QSPI_QCOM_MAX_SG 5
>> +
>>   struct qcom_qspi {
>>          void __iomem *base;
>>          struct device *dev;
>>          struct clk_bulk_data *clks;
>>          struct qspi_xfer xfer;
>> +       struct dma_pool *dma_cmd_pool;
>> +       struct dma_pool *dma_data_pool;
>> +       dma_addr_t dma_cmd_desc[3*QSPI_QCOM_MAX_SG];
> Make a define for 3 and 2 and then a define for each equation?


Made defines for 3 and 2

>> +       dma_addr_t dma_data_desc[2*QSPI_QCOM_MAX_SG];
>> +       void *virt_cmd_desc[3*QSPI_QCOM_MAX_SG];
>> +       void *virt_data_desc[2*QSPI_QCOM_MAX_SG];
>> +       unsigned int n_cmd_desc;
>> +       unsigned int n_data_desc;
>> +       int xfer_mode;
>> +       u32 iomode;
> Good use of u32


Thank you

>
>>          struct icc_path *icc_path_cpu_to_qspi;
>>          unsigned long last_speed;
>>          /* Lock to protect data accessed by IRQs */
>> @@ -258,6 +326,186 @@ static int qcom_qspi_set_speed(struct qcom_qspi *ctrl, unsigned long speed_hz)
>>          return 0;
>>   }
>>
>> +/* aligned to 32 bytes, not to cross 1KB boundary */
>> +#define QSPI_ALIGN_REQ         32
>> +#define QSPI_BOUNDARY_REQ      1024
>> +
>> +int qcom_qspi_alloc_desc(struct qcom_qspi *ctrl, uint8_t *virt_ptr,
>> +                       dma_addr_t dma_ptr, uint32_t n_bytes)
>> +{
>> +       struct qspi_cmd_desc *virt_cmd_desc, *prev;
>> +       uint8_t *virt_data_desc;
>> +       dma_addr_t dma_cmd_desc, dma_data_desc;
>> +
>> +       if (virt_ptr && n_bytes >= QSPI_ALIGN_REQ) {
>> +               dev_err(ctrl->dev,
>> +                       "Exiting to avert memory overwrite, n_bytes-%d\n", n_bytes);
>> +               return -ENOMEM;
>> +       }
>> +
>> +       /* allocate for dma cmd descriptor */
>> +       virt_cmd_desc = (struct qspi_cmd_desc *)dma_pool_alloc(ctrl->dma_cmd_pool,
>> +               GFP_KERNEL, &dma_cmd_desc);
>> +       if (!virt_cmd_desc) {
>> +               dev_err(ctrl->dev,
>> +                       "Could not allocate for cmd_desc\n");
>> +               return -ENOMEM;
>> +       }
>> +       ctrl->virt_cmd_desc[ctrl->n_cmd_desc] = virt_cmd_desc;
>> +       ctrl->dma_cmd_desc[ctrl->n_cmd_desc] = dma_cmd_desc;
>> +       ctrl->n_cmd_desc++;
>> +
>> +       /* allocate for dma data descriptor if unaligned else use pre-aligned */
>> +       if (virt_ptr) {
>> +               virt_data_desc = (uint8_t *)dma_pool_zalloc(ctrl->dma_data_pool,
>> +                       GFP_KERNEL, &dma_data_desc);
>> +               if (!virt_data_desc) {
>> +                       dev_err(ctrl->dev,
>> +                               "Could not allocate for data_desc\n");
>> +                       return -ENOMEM;
>> +               }
>> +               ctrl->virt_data_desc[ctrl->n_data_desc] = virt_data_desc;
>> +               ctrl->dma_data_desc[ctrl->n_data_desc] = dma_data_desc;
>> +               ctrl->n_data_desc++;
>> +
>> +               /*
>> +                * for tx copy xfer data into allocated buffer
>> +                * for rx setup bounce info to copy after xfer
>> +                */
>> +               if (ctrl->xfer.dir == QSPI_WRITE) {
>> +                       memcpy(virt_data_desc, virt_ptr, n_bytes);
>> +               } else {
>> +                       virt_cmd_desc->bounce_src = virt_data_desc;
>> +                       virt_cmd_desc->bounce_dst = virt_ptr;
>> +                       virt_cmd_desc->bounce_length = n_bytes;
>> +               }
>> +       } else {
>> +               dma_data_desc = dma_ptr;
>> +       }
>> +
>> +       /* setup cmd descriptor */
>> +       virt_cmd_desc->data_address = (uint32_t)(uintptr_t)(dma_data_desc);
> Why does this need to be casted?


Agreed not required, removed.

>> +       virt_cmd_desc->next_descriptor = 0;
>> +       virt_cmd_desc->direction = ctrl->xfer.dir;
>> +       virt_cmd_desc->multi_io_mode = ctrl->iomode;
>> +       virt_cmd_desc->reserved1 = 0;
>> +       virt_cmd_desc->fragment = 0;
>> +       virt_cmd_desc->reserved2 = 0;
>> +       virt_cmd_desc->length = n_bytes;
>> +
>> +       /* update previous descriptor */
>> +       if (ctrl->n_cmd_desc >= 2) {
>> +               prev = (ctrl->virt_cmd_desc)[ctrl->n_cmd_desc - 2];
>> +               prev->next_descriptor = dma_cmd_desc;
>> +               prev->fragment = 1;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int qcom_qspi_setup_dma_desc(struct qcom_qspi *ctrl,
>> +                               struct spi_transfer *xfer)
>> +{
>> +       int ret;
>> +       struct sg_table *sgt;
>> +       unsigned int sg_total_len = 0;
>> +       dma_addr_t dma_ptr_sg;
>> +       unsigned int dma_len_sg;
>> +       uint32_t prolog_bytes, aligned_bytes, epilog_bytes;
>> +       dma_addr_t aligned_ptr;
> Don't put types in the variable name.


Renamed

>
>> +       int ii;
> Why double i?


Renamed

>
>> +       uint8_t *byte_ptr;
>> +
>> +       if (ctrl->n_cmd_desc || ctrl->n_data_desc) {
>> +               dev_err(ctrl->dev, "Remnant dma buffers cmd-%d, data-%d\n",
>> +                       ctrl->n_cmd_desc, ctrl->n_data_desc);
>> +               return -EIO;
>> +       }
>> +
>> +       sgt = (ctrl->xfer.dir == QSPI_READ) ? &xfer->rx_sg : &xfer->tx_sg;
>> +       if (!sgt->nents || sgt->nents > QSPI_QCOM_MAX_SG) {
>> +               dev_err(ctrl->dev, "Cannot handle %d entries in scatter list\n", sgt->nents);
