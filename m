Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514F56E9578
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjDTNMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjDTNMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:12:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5022E4682;
        Thu, 20 Apr 2023 06:12:02 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KAqGQ1014688;
        Thu, 20 Apr 2023 13:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0jljsrmUppcwSKHyFsOd4C0aYf9NL+4CxNuCriY8lIY=;
 b=kRR2e2HBo3PjUvAr4rRLYyQe++PUeE0B7e7uQ2Hfv4V84p9T/6KAHgvXzNyvtTjZS4VI
 lNg7Vf2U6yvWWXTVbnv+FbWBPnHnqjIBRuHvqGECv6dNAIGDu67UbngBcDAbJECHvuwj
 ISMEWoHWLLNgz3RuCNqOb7FNqtkZrHwrAgxYHeKx0tycsGBG2Cf2N9K4Fi4kiIoewBAc
 ddcdSJoRVYXiAl5A/PdNBRxNwt/HBRHsjMHpk5Z4XR1xV2PM1SfA9PmiNOX/avzKK/ex
 vH7dCahkbEnbDz62HH3J8aHA7oHX2DSypETbMLOeeYxzL2dXggnRXIhROkm6q0TXRSqU uw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q31t1rp6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 13:11:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33KDBuX3012253
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 13:11:56 GMT
Received: from [10.216.24.183] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 20 Apr
 2023 06:11:51 -0700
Message-ID: <5e3b204e-bca3-f6d5-3330-f26985a00486@quicinc.com>
Date:   Thu, 20 Apr 2023 18:41:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 3/3] spi: spi-qcom-qspi: Add DMA mode support
Content-Language: en-CA
To:     Doug Anderson <dianders@chromium.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_msavaliy@quicinc.com>, <mka@chromium.org>,
        <swboyd@chromium.org>, <quic_vtanuku@quicinc.com>
References: <1681481153-24036-1-git-send-email-quic_vnivarth@quicinc.com>
 <1681481153-24036-4-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=VKY-0vX271G+EQQ5kC3gTqpPPyTGE0xHWPBncVUhZufQ@mail.gmail.com>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <CAD=FV=VKY-0vX271G+EQQ5kC3gTqpPPyTGE0xHWPBncVUhZufQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9rDZWIl29BHdgW7obRtKGYLh3HOL7hI2
X-Proofpoint-GUID: 9rDZWIl29BHdgW7obRtKGYLh3HOL7hI2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_09,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200107
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

Uploaded v4 with below...


On 4/15/2023 3:35 AM, Doug Anderson wrote:
> Hi,
>
> On Fri, Apr 14, 2023 at 7:06 AM Vijaya Krishna Nivarthi
> <quic_vnivarth@quicinc.com> wrote:
>> @@ -14,7 +16,6 @@
>>   #include <linux/spi/spi.h>
>>   #include <linux/spi/spi-mem.h>
>>
>> -
> Drop unrelated whitespace change.


Done

>
>
>> @@ -108,6 +110,10 @@
>>   #define RD_FIFO_RESET          0x0030
>>   #define RESET_FIFO             BIT(0)
>>
>> +#define NEXT_DMA_DESC_ADDR             0x0040
>> +#define CURRENT_DMA_DESC_ADDR  0x0044
>> +#define CURRENT_MEM_ADDR               0x0048
> Looking at the above with a correctly configured editor (tab size=8)
> the numbers don't line up. The first and 3rd have one too many tabs.
>

Corrected

>> @@ -120,6 +126,27 @@ enum qspi_dir {
>>          QSPI_WRITE,
>>   };
>>
>> +struct qspi_cmd_desc {
>> +       u32 data_address;
>> +       u32 next_descriptor;
>> +       u32 direction:1;
>> +       u32 multi_io_mode:3;
>> +       u32 reserved1:4;
>> +       u32 fragment:1;
>> +       u32 reserved2:7;
>> +       u32 length:16;
>> +       /*
>> +        * This marks end of HW cmd descriptor
>> +        * Fields down below are for SW usage to
>> +        * copy data from DMA buffer to rx buffer
>> +        */
>> +       u8 *bounce_src;
>> +       u8 *bounce_dst;
>> +       u32 bounce_length;
>> +};
>> +
>> +#define QSPI_MAX_NUM_DESC 5
> Nothing uses QSPI_MAX_NUM_DESC. Drop it.


Done

>
>
>> @@ -137,11 +164,36 @@ enum qspi_clocks {
>>          QSPI_NUM_CLKS
>>   };
>>
>> +enum qspi_xfer_mode {
>> +       QSPI_INVALID,
>> +       QSPI_FIFO,
>> +       QSPI_DMA
>> +};
> Why bother with INVALID? It's either FIFO or DMA, right?


Dropped

>
>
>> +/* number of entries in sgt returned from spi framework that we can support */
>> +#define QSPI_MAX_SG 5
> Is the above a hardware limitation, or just because you are statically
> allocating arrays? Please clarify in the comment. Would it make sense
> to just dynamically allocate the arrays and remove the need for this
> limitation?


Added comment.

Dynamic allocation may not be required here as we dont expect too many 
cmd descriptors to be necessary.

>
>> +/* 3 descriptors for head, aligned part and tail */
>> +#define QSPI_NUM_CMD_DESC 3
>> +
>> +/* 2 descriptors for head, tail */
>> +#define QSPI_NUM_DAT_DESC 2
>> +
>>   struct qcom_qspi {
>>          void __iomem *base;
>>          struct device *dev;
>>          struct clk_bulk_data *clks;
>>          struct qspi_xfer xfer;
>> +       struct dma_pool *dma_cmd_pool;
>> +       struct dma_pool *dma_data_pool;
>> +       dma_addr_t dma_cmd_desc[QSPI_NUM_CMD_DESC*QSPI_MAX_SG];
>> +       dma_addr_t dma_data_desc[QSPI_NUM_DAT_DESC*QSPI_MAX_SG];
>> +       void *virt_cmd_desc[QSPI_NUM_CMD_DESC*QSPI_MAX_SG];
>> +       void *virt_data_desc[QSPI_NUM_DAT_DESC*QSPI_MAX_SG];
>> +       unsigned int n_cmd_desc;
>> +       unsigned int n_data_desc;
>> +       int xfer_mode;
> Instead of "int", shouldn't xfer_mode be "enum qspi_xfer_mode"?
> Although below I'm proposing that xfer_mode can just be completely
> dropped from this structure.
>

Done

>> @@ -151,18 +203,25 @@ struct qcom_qspi {
>>   static u32 qspi_buswidth_to_iomode(struct qcom_qspi *ctrl,
>>                                     unsigned int buswidth)
>>   {
>> +       u32 ret;
>> +
>> +       /* for DMA we don't write to PIO_XFER_CFG register, so don't shift */
>>          switch (buswidth) {
>>          case 1:
>> -               return SDR_1BIT << MULTI_IO_MODE_SHFT;
>> +               ret = (ctrl->xfer_mode == QSPI_DMA ? SDR_1BIT : SDR_1BIT << MULTI_IO_MODE_SHFT);
>> +               break;
>>          case 2:
>> -               return SDR_2BIT << MULTI_IO_MODE_SHFT;
>> +               ret = (ctrl->xfer_mode == QSPI_DMA ? SDR_2BIT : SDR_2BIT << MULTI_IO_MODE_SHFT);
>> +               break;
>>          case 4:
>> -               return SDR_4BIT << MULTI_IO_MODE_SHFT;
>> +               ret = (ctrl->xfer_mode == QSPI_DMA ? SDR_4BIT : SDR_4BIT << MULTI_IO_MODE_SHFT);
>> +               break;
>>          default:
>>                  dev_warn_once(ctrl->dev,
>>                                  "Unexpected bus width: %u\n", buswidth);
>> -               return SDR_1BIT << MULTI_IO_MODE_SHFT;
>> +               ret = (ctrl->xfer_mode == QSPI_DMA ? SDR_1BIT : SDR_1BIT << MULTI_IO_MODE_SHFT);
>>          }
>> +       return ret;
> Wouldn't it be easier to do the test once at the end? In other words,
> in the switch statement "ret" never contains the shift and then at the
> end:
>
> if (ctrl->xfer_mode != QSPI_DMA)
>    ret <<= MULTI_IO_MODE_SHFT;
> return ret;
>
> ...or, even better, just always return the unshifted mode and do the
> shifting unconditionally in qcom_qspi_pio_xfer_cfg(). Then you never
> need to look at xfer_mode to decide.
>

Agree, Done

>> @@ -241,12 +316,16 @@ static int qcom_qspi_set_speed(struct qcom_qspi *ctrl, unsigned long speed_hz)
>>                  return ret;
>>          }
>>
>> +       avg_bw_cpu = Bps_to_icc(speed_hz);
>>          /*
>> -        * Set BW quota for CPU as driver supports FIFO mode only.
>> -        * We don't have explicit peak requirement so keep it equal to avg_bw.
>> +        * Set BW quota for CPU for FIFO to avg_bw
>> +        * as we don't have explicit peak requirement.
>> +        * TBD TBD TBD - change this as required for DMA.
>> +        * As of now same peak requirement seems to be working.
>>           */
>> -       avg_bw_cpu = Bps_to_icc(speed_hz);
>> -       ret = icc_set_bw(ctrl->icc_path_cpu_to_qspi, avg_bw_cpu, avg_bw_cpu);
>> +       peak_bw_cpu = ctrl->xfer_mode == QSPI_FIFO ? avg_bw_cpu : avg_bw_cpu;
>> +
>> +       ret = icc_set_bw(ctrl->icc_path_cpu_to_qspi, avg_bw_cpu, peak_bw_cpu);
> The change to this function is completely a no-op, right? You check
> the mode against QSPI_FIFO but you set the "peak_bw_cpu" to the same
> thing in both modes. ...and the thing you set it to is exactly the
> same as the function set it to before your patch.
>
> ...so drop all the changes you made to this function.
>

Dropped

>> @@ -258,6 +337,190 @@ static int qcom_qspi_set_speed(struct qcom_qspi *ctrl, unsigned long speed_hz)
>>          return 0;
>>   }
>>
>> +/* aligned to 32 bytes, not to cross 1KB boundary */
>> +#define QSPI_ALIGN_REQ         32
>> +#define QSPI_BOUNDARY_REQ      1024
>> +
>> +static int qcom_qspi_alloc_desc(struct qcom_qspi *ctrl, uint8_t *virt_ptr,
>> +                       dma_addr_t dma_ptr, uint32_t n_bytes)
> Why is "n_bytes" "uint32_t" instead of just "u32"? Please just use
> "u32" consistently in this file.
>

Done

>
>> +               }
>> +       }
>> +       return 0;
>> +
>> +cleanup:
>> +       dev_err(ctrl->dev, "ERROR cleanup in setup_dma_desc\n");
>> +       for (i = 0; i < ctrl->n_data_desc; i++)
>> +               dma_pool_free(ctrl->dma_data_pool, ctrl->virt_data_desc[i],
>> +                                 ctrl->dma_data_desc[i]);
>> +       ctrl->n_data_desc = 0;
>> +
>> +       for (i = 0; i < ctrl->n_cmd_desc; i++)
>> +               dma_pool_free(ctrl->dma_cmd_pool, ctrl->virt_cmd_desc[i],
>> +                                 ctrl->dma_cmd_desc[i]);
>> +       ctrl->n_cmd_desc = 0;
>> +       return ret;
>> +}
>> +
>> +static void qcom_qspi_dma_xfer(struct qcom_qspi *ctrl)
>> +{
>> +       /* Ack any previous interrupts that might be hanging around */
>> +       writel(DMA_CHAIN_DONE, ctrl->base + MSTR_INT_STATUS);
> Do we really need the above? Maybe we can drop it and (in a separate
> patch) drop the similar statement in qcom_qspi_pio_xfer()?
>
> If this is truly needed for some reason, then it seems like in both
> cases you should ack _all_ interrupts (the FIFO plus the DMA ones)
> since we might be switching back and forth between the two modes and
> thus any old interrupts that are "hanging around" could be from
> either. ...but I think you can just drop it. If there are really any
> interrupts "hanging around" we're in pretty bad shape.
>

Dropped

>> +       /* Setup new interrupts */
>> +       writel(DMA_CHAIN_DONE, ctrl->base + MSTR_INT_EN);
>> +
>> +       /* flush all writes */
>> +       wmb();
> Why do you need this explicit wmb()? I'm fairly sure that this is
> handled automatically by the fact that you're using writel() and not
> writel_relaxed(). writel() documents that it is "ordered relative to
> any prior Normal memory access" and certainly it's ordered relative to
> IO writes to the same device.
>

Dropped

>> +
>> +       /* kick off transfer */
>> +       writel((uint32_t)(uintptr_t)(ctrl->dma_cmd_desc)[0], ctrl->base + NEXT_DMA_DESC_ADDR);
> It feels like there's one too many casts here. Shouldn't this just be
> "(u32)(ctrl->dma_cmd_desc[0])"?


Changed

>
>> +}
>> +
>> +/* Switch to DMA if transfer length exceeds this */
>> +#define QSPI_MAX_BYTES_FIFO 64
>> +
>> +static bool qcom_qspi_can_dma(struct spi_controller *ctlr,
>> +                        struct spi_device *slv, struct spi_transfer *xfer)
>> +{
>> +       return xfer->len > QSPI_MAX_BYTES_FIFO ? true : false;
> No need for the "? true : false". Just:
>
> return xfer->len > QSPI_MAX_BYTES_FIFO;
>

Correct. Done.

>> @@ -290,7 +555,25 @@ static int qcom_qspi_transfer_one(struct spi_master *master,
>>          ctrl->xfer.is_last = list_is_last(&xfer->transfer_list,
>>                                            &master->cur_msg->transfers);
>>          ctrl->xfer.rem_bytes = xfer->len;
>> -       qcom_qspi_pio_xfer(ctrl);
>> +
>> +       if (qcom_qspi_can_dma(master, slv, xfer)) {
> Maybe it would be better to check if either "xfer->rx_sg.nents" or
> "xfer->tx_sg.nents" is non-zero. That indicates that the SPI framework
> is expecting you to do DMA.
>

Yes, changed.

>> +               ctrl->xfer_mode = QSPI_DMA;
>> +               ctrl->iomode = qspi_buswidth_to_iomode(ctrl, ctrl->xfer.buswidth);
> Don't store iomode in the "ctrl" structure (remove it from that
> struct). Just make it a local variable in qcom_qspi_setup_dma_desc()
> and then pass it in to the one place that needs it:
> qcom_qspi_alloc_desc()
>

Done

>> +               mstr_cfg |= DMA_ENABLE;
>> +               writel(mstr_cfg, ctrl->base + MSTR_CONFIG);
> nit: I seem to remember IO writes to the controller taking a
> non-trivial amount of time. Maybe worth it to do?
>
> if (!(mstr_cfg & DMA_ENABLE)) {
>    mstr_cfg |= DMA_ENABLE;
>    writel(mstr_cfg, ctrl->base + MSTR_CONFIG);
> }
>
> ...similar for the "else" case below.
>

Done

>> @@ -328,6 +611,40 @@ static int qcom_qspi_prepare_message(struct spi_master *master,
>>          return 0;
>>   }
>>
>> +static int qcom_qspi_alloc_dma(struct qcom_qspi *ctrl)
>> +{
>> +       /* allocate for cmd descriptors pool */
>> +       ctrl->dma_cmd_pool = dma_pool_create("qspi cmd desc pool",
>> +               ctrl->dev, sizeof(struct qspi_cmd_desc), 0, 0);
> Instead of dma_pool_create(), use dmam_pool_create(). That looks to be
> the (oddly named) devm version of the function. Then you can fully get
> rid of qcom_qspi_free_dma() and also the dma_pool_destroy() in your
> error handling below.
>
> It also seems really weird that the "data" pool has such strict
> alignment requirements and you do a whole ton of work to meet those
> requirements, but the "cmd" pool has no alignment requirements at all.
> Is this really correct?
>

Used dmam version.

Yes only the data addresses need to be aligned; there is no constraint 
for cmd descriptors.

>> +       if (!ctrl->dma_cmd_pool) {
>> +               dev_err(ctrl->dev, "Could not create dma pool for cmd_desc\n");
> nit: no need for an error message here. You can assume that allocation
> failures will already print a warning splat and you don't need another
> one for this incredibly unlikely event.
>

Dropped

>> @@ -426,27 +743,63 @@ static irqreturn_t qcom_qspi_irq(int irq, void *dev_id)
>>          int_status = readl(ctrl->base + MSTR_INT_STATUS);
>>          writel(int_status, ctrl->base + MSTR_INT_STATUS);
>>
>> -       if (ctrl->xfer.dir == QSPI_WRITE) {
>> -               if (int_status & WR_FIFO_EMPTY)
>> -                       ret = pio_write(ctrl);
>> -       } else {
>> -               if (int_status & RESP_FIFO_RDY)
>> -                       ret = pio_read(ctrl);
>> -       }
>> -
>> -       if (int_status & QSPI_ERR_IRQS) {
>> -               if (int_status & RESP_FIFO_UNDERRUN)
>> -                       dev_err(ctrl->dev, "IRQ error: FIFO underrun\n");
>> -               if (int_status & WR_FIFO_OVERRUN)
>> -                       dev_err(ctrl->dev, "IRQ error: FIFO overrun\n");
>> -               if (int_status & HRESP_FROM_NOC_ERR)
>> -                       dev_err(ctrl->dev, "IRQ error: NOC response error\n");
>> -               ret = IRQ_HANDLED;
>> -       }
>> -
>> -       if (!ctrl->xfer.rem_bytes) {
>> -               writel(0, ctrl->base + MSTR_INT_EN);
>> -               spi_finalize_current_transfer(dev_get_drvdata(ctrl->dev));
>> +       switch (ctrl->xfer_mode) {
>> +       case QSPI_FIFO:
> I don't think you really need to check xfer_mode here, do you? If
> xfer_mode is FIFO then only the FIFO-related interrupts are enabled.
> If xfer_mode is DMA then only the DMA-related interrupts are enabled.
>
> In fact, I think you can fully get rid of the "xfer_mode" structure
> member completely. It's completely redundant.
>

I think the xfer_mode is required to conditionally cleanup in 
handle_err() and isr()

I have retained it for now; it also seems to help keep isr() more readable.

>> @@ -487,6 +840,9 @@ static int qcom_qspi_probe(struct platform_device *pdev)
>>          if (ret)
>>                  return ret;
>>
>> +       /* set default mode to FIFO */
>> +       ctrl->xfer_mode = QSPI_FIFO;
> Get rid of this initialization. Above I'm suggesting getting rid of
> "xfter" mode altogether, but in any case, we should be setting this
> before each transfer so the initialization doesn't do anything useful.
>

Done

>> @@ -556,10 +923,15 @@ static int qcom_qspi_probe(struct platform_device *pdev)
>>   static void qcom_qspi_remove(struct platform_device *pdev)
>>   {
>>          struct spi_master *master = platform_get_drvdata(pdev);
>> +       struct qcom_qspi *ctrl;
>> +
>> +       ctrl = spi_master_get_devdata(master);
>>
>>          /* Unregister _before_ disabling pm_runtime() so we stop transfers */
>>          spi_unregister_master(master);
>>
>> +       qcom_qspi_free_dma(ctrl);
>> +
>>          pm_runtime_disable(&pdev->dev);
> To make this the reverse order of probe the qcom_qspi_free_dma() call
> should be _after_ the pm_runtime_disable(), although above I'm
> suggesting fully getting rid of qcom_qspi_free_dma() so maybe the
> point is moot.
