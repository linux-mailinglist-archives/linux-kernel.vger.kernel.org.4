Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2049F647249
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiLHOzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiLHOzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:55:12 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037EBA13C1;
        Thu,  8 Dec 2022 06:55:10 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8DKbQC031994;
        Thu, 8 Dec 2022 14:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ITcc+7CMiG7SP5P/weu9Te6FsF1jK+Bv4yiVCELD4MQ=;
 b=kP/q8VpT6lSWg2qCyuorXqkFkesRJ7oYCEykxcSfoOfnk8BmOvmGlHAeoj4wNYAiz1Qq
 7PSi54fXNb5j7CHO3A8mwWmbADXhMFor1AnTrpm/EQ/Kd9IxsKgBgyHociciQ4OR23GP
 ylEYLfjiOHTnvACoFt+9VWwDRgnIdq/bTBDJdI+J6HUWjba/oV6zUDyIf4EtwbSanE3V
 fQZp0bX4Gmko45NmnxRhE383dfn/k+wSeGFitcWOZBShd+CdsUg2yEANMr2F/wfEK5xq
 HHo1WKMfS1ZsyhoH35liSEQP82HZgT0zdxgx15PqQ4OwOvKMoNF+l91jCyORWORkjdJq BQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mb7bc9mht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Dec 2022 14:55:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B8Et58I003065
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Dec 2022 14:55:05 GMT
Received: from [10.216.47.193] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 8 Dec 2022
 06:55:00 -0800
Message-ID: <96264209-b0a5-cf76-06cc-eb067f4a4c7b@quicinc.com>
Date:   Thu, 8 Dec 2022 20:24:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [V3] spi: spi-geni-qcom: Add support for SE DMA mode
Content-Language: en-CA
To:     Doug Anderson <dianders@chromium.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_msavaliy@quicinc.com>,
        <mka@chromium.org>, <swboyd@chromium.org>,
        <quic_vtanuku@quicinc.com>, <vkoul@kernel.org>
References: <1669713814-28876-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=WW-YttMn2+_6MdKwVDQO2stHjiisSdX8vFoOFBMnsjRA@mail.gmail.com>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <CAD=FV=WW-YttMn2+_6MdKwVDQO2stHjiisSdX8vFoOFBMnsjRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ewssD9tz4hOGG4BNwf-Q5L4sVo0Sffd4
X-Proofpoint-ORIG-GUID: ewssD9tz4hOGG4BNwf-Q5L4sVo0Sffd4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_08,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 clxscore=1011 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212080122
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Uploaded V4.


On 12/2/2022 4:10 AM, Doug Anderson wrote:
> Hi,
>
> On Tue, Nov 29, 2022 at 1:23 AM Vijaya Krishna Nivarthi
> <quic_vnivarth@quicinc.com> wrote:
>> @@ -95,6 +97,7 @@ struct spi_geni_master {
>>          struct dma_chan *tx;
>>          struct dma_chan *rx;
>>          int cur_xfer_mode;
>> +       u32 cur_m_cmd;
> In v1, I said: "I don't think you need to store "cur_m_cmd" ..."
> ...you responded: Please note that cur_xfer can be NULL. Added further
> to comments."
>
> I don't see any comments about this.
>
> In any case, I'm still unclear about why this is needed. I guess
> you're looking at the code in handle_se_timeout(). I'll comment there.
>
Removed cur_m_cmd


>> @@ -162,6 +169,45 @@ static void handle_fifo_timeout(struct spi_master *spi,
>>                   */
>>                  mas->abort_failed = true;
>>          }
>> +
>> +unmap_if_dma:
>> +       if (mas->cur_xfer_mode == GENI_SE_DMA) {
>> +               if (mas->cur_m_cmd & SPI_TX_ONLY) {
>> +                       spin_lock_irq(&mas->lock);
>> +                       reinit_completion(&mas->tx_reset_done);
>> +                       writel(1, se->base + SE_DMA_TX_FSM_RST);
>> +                       spin_unlock_irq(&mas->lock);
>> +                       time_left = wait_for_completion_timeout(&mas->tx_reset_done, HZ);
>> +                       if (!time_left)
>> +                               dev_err(mas->dev, "DMA TX RESET failed\n");
>> +               }
>> +               if (mas->cur_m_cmd & SPI_RX_ONLY) {
>> +                       spin_lock_irq(&mas->lock);
>> +                       reinit_completion(&mas->rx_reset_done);
>> +                       writel(1, se->base + SE_DMA_RX_FSM_RST);
>> +                       spin_unlock_irq(&mas->lock);
>> +                       time_left = wait_for_completion_timeout(&mas->rx_reset_done, HZ);
>> +                       if (!time_left)
>> +                               dev_err(mas->dev, "DMA RX RESET failed\n");
>> +               }
>> +
>> +               if (xfer) {
>> +                       if (xfer->tx_buf && xfer->tx_dma)
>> +                               geni_se_tx_dma_unprep(se, xfer->tx_dma, xfer->len);
>> +                       if (xfer->rx_buf && xfer->rx_dma)
>> +                               geni_se_rx_dma_unprep(se, xfer->rx_dma, xfer->len);
>> +               } else {
>> +                       /*
>> +                        * This can happen if a timeout happened and we had to wait
>> +                        * for lock in this function because isr was holding the lock
>> +                        * and handling transfer completion at that time.
>> +                        * isr will set cur_xfer to NULL when done.
>> +                        * Unnecessary error but cannot be helped.
>> +                        * Only do reset, dma_unprep is already done by isr.
>> +                        */
>> +                       dev_err(mas->dev, "Cancel/Abort on completed SPI transfer\n");
>> +               }
> For the above block of code, if "xfer" is NULL then do we actually
> need to issue the DMA TX Reset and the DMA RX Reset? As per your
> comments, the only case "xfer" can be NULL is if the ISR was holding
> the lock and handling the transfer completion at that time. If the ISR
> handled the transfer completion then we're not actually in a bad
> state, right? Thus, couldn't you do:
>
> if (xfer) {
>    if (xfer->tx_buf && xfer->tx_dma) {
>      // Do the FSM reset
>      // Unprepare the DMA
>    }
>    if (xfer->rx_buf && xfer->rx_dma) {
>      // Do the FSM reset
>      // Unprepare the DMA
>    }
> } else {
>    dev_err(...);
> }
>
> That should be fine, right? ...and then we can get rid of the need for
> "cur_m_cmd" as per my previous comment, right?
>
> I'll also ask if we can downgrade the "dev_err" to a "dev_warn". I
> usually reserve dev_err for things that are fatal. Here we think we'll
> probably recover, right?
>

Done.


>> @@ -778,11 +836,39 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
>>           */
>>          spin_lock_irq(&mas->lock);
>>          geni_se_setup_m_cmd(se, m_cmd, FRAGMENTATION);
>> -       if (m_cmd & SPI_TX_ONLY) {
>> +
>> +       if (mas->cur_xfer_mode == GENI_SE_DMA) {
>> +               if (m_cmd & SPI_RX_ONLY) {
>> +                       ret =  geni_se_rx_dma_prep(se, xfer->rx_buf,
>> +                               xfer->len, &xfer->rx_dma);
> In response to v1 I asked if it's really OK to use "xfer->rx_dma" for
> your purposes since it's supposed to be managed by the SPI framework.
>
> It still makes me nervous to use it, even though it seems to work.
> Since we're using it in an undocumented way, I'd be nervous that the
> SPI framework might change what it's doing and break us in the future.
>
> We can only have one TX and one RX transfer at a time anyway. Why
> don't we just have our own "rx_dma" and "tx_dma" in "struct
> spi_geni_master". It's only 16 extra bytes of data and it would make
> me feel less nervous.


Done.


>
> It still would be nice to eventually use the SPI framework to manage
> the mapping, but I agree that can be a future task.
>

Tracking this with a bug.

>> +                       if (ret) {
>> +                               dev_err(mas->dev, "Failed to setup Rx dma %d\n", ret);
>> +                               xfer->rx_dma = 0;
>> +                               goto unlock_and_return;
>> +                       }
>> +               }
>> +               if (m_cmd & SPI_TX_ONLY) {
>> +                       ret =  geni_se_tx_dma_prep(se, (void *)xfer->tx_buf,
>> +                               xfer->len, &xfer->tx_dma);
> In v1 I asked about the above "void *" cast. You pointed out that it
> was to cast away constness. So I agree that you can keep it here for
> now, but could you also post a patch to change geni_se_tx_dma_prep()
> to take a "const void *"? You'll need a cast in _that_ function to
> remove the constness (since dma_map_single() is generic for both TX
> and RX), but it seems like a better place for it. Then a later patch
> could remove the cast here.


Tracking this with a bug.

>
>> +                       if (ret) {
>> +                               dev_err(mas->dev, "Failed to setup Tx dma %d\n", ret);
>> +                               xfer->tx_dma = 0;
>> +                               if (m_cmd & SPI_RX_ONLY && xfer->rx_dma) {
> Don't need "&& xfer->rx_dma". You _just_ mapped it above and if it had
> failed it would have returned an error. you don't need to
> double-check. You can trust that the framework knows what it's doing
> and won't return NULL to you. If it did return NULL to you because of
> a bug, it's not necessarily better to just silently skip unpreparing
> anyway.


Done.


>
>> @@ -823,39 +913,66 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
>>
>>          spin_lock(&mas->lock);
>>
>> -       if ((m_irq & M_RX_FIFO_WATERMARK_EN) || (m_irq & M_RX_FIFO_LAST_EN))
>> -               geni_spi_handle_rx(mas);
>> -
>> -       if (m_irq & M_TX_FIFO_WATERMARK_EN)
>> -               geni_spi_handle_tx(mas);
>> -
>> -       if (m_irq & M_CMD_DONE_EN) {
>> -               if (mas->cur_xfer) {
>> +       if (mas->cur_xfer_mode == GENI_SE_FIFO) {
>> +               if ((m_irq & M_RX_FIFO_WATERMARK_EN) || (m_irq & M_RX_FIFO_LAST_EN))
>> +                       geni_spi_handle_rx(mas);
>> +
>> +               if (m_irq & M_TX_FIFO_WATERMARK_EN)
>> +                       geni_spi_handle_tx(mas);
>> +
>> +               if (m_irq & M_CMD_DONE_EN) {
>> +                       if (mas->cur_xfer) {
>> +                               spi_finalize_current_transfer(spi);
>> +                               mas->cur_xfer = NULL;
>> +                               /*
>> +                                * If this happens, then a CMD_DONE came before all the
>> +                                * Tx buffer bytes were sent out. This is unusual, log
>> +                                * this condition and disable the WM interrupt to
>> +                                * prevent the system from stalling due an interrupt
>> +                                * storm.
>> +                                *
>> +                                * If this happens when all Rx bytes haven't been
>> +                                * received, log the condition. The only known time
>> +                                * this can happen is if bits_per_word != 8 and some
>> +                                * registers that expect xfer lengths in num spi_words
>> +                                * weren't written correctly.
>> +                                */
>> +                               if (mas->tx_rem_bytes) {
>> +                                       writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
>> +                                       dev_err(mas->dev, "Premature done. tx_rem = %d bpw%d\n",
>> +                                               mas->tx_rem_bytes, mas->cur_bits_per_word);
>> +                               }
>> +                               if (mas->rx_rem_bytes)
>> +                                       dev_err(mas->dev, "Premature done. rx_rem = %d bpw%d\n",
>> +                                               mas->rx_rem_bytes, mas->cur_bits_per_word);
>> +                       } else {
>> +                               complete(&mas->cs_done);
> Question: did you try actually using the chip select with your new
> GENI_SE_DMA? Does it work? I ask because I don't see anything that
> completes the "cs_done" in the DMA case of the ISR and I don't see
> anything in spi_geni_set_cs() that forces it to FIFO mode. Note: if
> you're only testing on trogdor/herobrine boards, you'd have to change
> them to not use a GPIO for chip select.


Forced FIFO in spi_geni_set_cs

Thank you,

Vijay/


>
> -Doug
