Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEADF640C4B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbiLBRhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbiLBRhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:37:17 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C501BECE57;
        Fri,  2 Dec 2022 09:37:14 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B2Fn9xN025312;
        Fri, 2 Dec 2022 17:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nLuJYlUdgqeoAFaxbHZW8sNgxRvH8gdJDXsdBrG1C0Y=;
 b=gSSM4d6cYPKpuXi6S7y936/vrOwm8yh2fcovvkKgFUq2GGEujC3kZqWdAJR5dFymjs8t
 jgzUk/cHleHT1NzfBlxJfNrfJYHnlT2rcZ1/EI1bi2scJEab2M2EjIbxKubUfXniNKw9
 91y7v1xYoSLSJ++GKT2kCDzmYiHG9rVUG/USGVD9rwGjBUaTZpclbgKGO2uTQidFYRAF
 ldFQO8VH0j98Hl9SeO/w99egV0ujRa1EsovZoI0TgjWoC9A3JJwJgWGnBnbR6gDMYcvm
 MvT/hCB2TQC8/AFG5MEEEeRe1Z7L3cZTDtYYkh9Lgcls/Pyn/ipQnQMTk3n66eBnWXvP Jg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m6k3ynv1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 17:37:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B2Hb7EV011570
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Dec 2022 17:37:07 GMT
Received: from [10.216.34.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 2 Dec 2022
 09:37:02 -0800
Message-ID: <4fcee4ed-1f6e-7fa6-32cc-8f91aca3855c@quicinc.com>
Date:   Fri, 2 Dec 2022 23:06:59 +0530
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
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ANXl5PpFUhsbpAMshzUn4fbI_Q6kuoAx
X-Proofpoint-ORIG-GUID: ANXl5PpFUhsbpAMshzUn4fbI_Q6kuoAx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_10,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212020139
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


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
>
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

Agree. Will test this change and apply for next version.

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
>
> It still would be nice to eventually use the SPI framework to manage
> the mapping, but I agree that can be a future task.
>
Agree. Will add xx_dma to spi_geni_master and use same instead of dmas 
in xfer.

Next step would be to move mapping to framework and remove the xx_dma 
from spi_geni_master.

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
>
Agree.

Will post next patches as suggested, actually will probably raise a bug 
to track feedback for this patch.

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
Agree, will remove.
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
>
No I did not test it with chip select as I was using herobrine.

Agreed that it would be broken for a board which doesn't use GPIO for cs.

Will apply cs_done for SE_DMA mode as well, test it with change to not 
use GPIO for cs and upload next version.

Thank you very much.

-Vijay/


> -Doug
