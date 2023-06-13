Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A523772EB2C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjFMSm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjFMSmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:42:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48E4106;
        Tue, 13 Jun 2023 11:42:53 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DDKH7q028476;
        Tue, 13 Jun 2023 18:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fTlsN8esNeyKANJBVAaYXQB0ML5QINO34Ut1iaCsjj4=;
 b=nwEFccf5vLi8IQBwA7Q2aOnaHhsego/2Hy4BMFekMvGzMZAcEMxB+myuSkz+ijxBal2l
 Elve+Il2os/zgmLRumlV9k6qh4C4OqJJsNIsKDv+2OKAeOpoQDpGXVjxN0S7dx6hIakY
 xVDX+bAX/XEup9mWrn8wILkE2AkRNtcQHaeDhn72W//DIkew83aypvO5/Folh0TutfpJ
 x4nfkJtsrMN77wej7O5ICcNg/lPiRhNI3iQLjvddYzcauGRKTbTMtW/BBIyl18J8/02T
 /zqGcOx2SLdacA/ZsNflaDWrvGXPhFnk16WfVoTMIx0Yp5rSGStx7e8nG0IwtWHH+Lq9 JQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r6nqh1c60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 18:42:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35DIgmqY014592
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 18:42:48 GMT
Received: from [10.216.12.219] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 13 Jun
 2023 11:42:45 -0700
Message-ID: <3ae416ff-a64c-4b1c-ae35-6672385e05e4@quicinc.com>
Date:   Wed, 14 Jun 2023 00:12:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] spi: spi-geni-qcom: Add SPI SLAVE mode support for
 GENI based QuPv3
Content-Language: en-CA
To:     Praveen Talari <quic_ptalari@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <broonie@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>,
        <quic_arandive@quicinc.com>
References: <20230613065229.5619-1-quic_ptalari@quicinc.com>
 <20230613065229.5619-3-quic_ptalari@quicinc.com>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <20230613065229.5619-3-quic_ptalari@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MhyW-aAwNCQ43fIG1aI_f9SBSV8am9GO
X-Proofpoint-ORIG-GUID: MhyW-aAwNCQ43fIG1aI_f9SBSV8am9GO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_20,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130164
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


On 6/13/2023 12:22 PM, Praveen Talari wrote:
> Add SPI SLAVE mode support for GENI based QuPv3.
>
> Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
> ---
>   drivers/spi/spi-geni-qcom.c | 55 +++++++++++++++++++++++++++++++++----
>   1 file changed, 49 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 206cc04bb1ed..2e3ae29e79e0 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -12,6 +12,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/pm_opp.h>
>   #include <linux/pm_runtime.h>
> +#include <linux/property.h>
>   #include <linux/soc/qcom/geni-se.h>
>   #include <linux/spi/spi.h>
>   #include <linux/spinlock.h>
> @@ -52,6 +53,9 @@
>   #define SPI_CS_CLK_DELAY_MSK		GENMASK(19, 10)
>   #define SPI_CS_CLK_DELAY_SHFT		10
>   
> +#define SE_SPI_SLAVE_EN				(0x2BC)
> +#define SPI_SLAVE_EN				BIT(0)
> +
>   /* M_CMD OP codes for SPI */
>   #define SPI_TX_ONLY		1
>   #define SPI_RX_ONLY		2
> @@ -99,6 +103,24 @@ struct spi_geni_master {
>   	int cur_xfer_mode;
>   };
>   
> +static struct spi_master *get_spi_master(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct spi_master *spi = platform_get_drvdata(pdev);
> +
> +	return spi;
> +}

I would recommend to drop this function.

The objective of this is to retrieve spi_master

The call sequence is probe() => geni_init() => get_spi_master()

probe() already has access to spi_master

why not simply pass it down to geni_init()?

Thank you.

> +
> +static void spi_slv_setup(struct spi_geni_master *mas)
> +{
> +	struct geni_se *se = &mas->se;
> +
> +	writel(SPI_SLAVE_EN, se->base + SE_SPI_SLAVE_EN);
> +	writel(GENI_IO_MUX_0_EN, se->base + GENI_OUTPUT_CTRL);
> +	writel(START_TRIGGER, se->base + SE_GENI_CFG_SEQ_START);
> +	dev_info(mas->dev, "spi slave setup done\n");
> +}
> +
>   static int get_spi_clk_cfg(unsigned int speed_hz,
>   			struct spi_geni_master *mas,
>   			unsigned int *clk_idx,
> @@ -140,12 +162,18 @@ static void handle_se_timeout(struct spi_master *spi,
>   	const struct spi_transfer *xfer;
>   
>   	spin_lock_irq(&mas->lock);
> -	reinit_completion(&mas->cancel_done);
>   	if (mas->cur_xfer_mode == GENI_SE_FIFO)
>   		writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
>   
>   	xfer = mas->cur_xfer;
>   	mas->cur_xfer = NULL;
> +
> +	if (spi->slave) {
> +		spin_unlock_irq(&mas->lock);
> +		goto unmap_if_dma;
> +	}
> +
> +	reinit_completion(&mas->cancel_done);
>   	geni_se_cancel_m_cmd(se);
>   	spin_unlock_irq(&mas->lock);
>   
> @@ -541,6 +569,8 @@ static bool geni_can_dma(struct spi_controller *ctlr,
>   
>   	if (mas->cur_xfer_mode == GENI_GPI_DMA)
>   		return true;
> +	if (ctlr->slave)
> +		return true;
>   
>   	len = get_xfer_len_in_words(xfer, mas);
>   	fifo_size = mas->tx_fifo_depth * mas->fifo_width_bits / mas->cur_bits_per_word;
> @@ -619,6 +649,7 @@ static void spi_geni_release_dma_chan(struct spi_geni_master *mas)
>   
>   static int spi_geni_init(struct spi_geni_master *mas)
>   {
> +	struct spi_master *spi = get_spi_master(mas->dev);
>   	struct geni_se *se = &mas->se;
>   	unsigned int proto, major, minor, ver;
>   	u32 spi_tx_cfg, fifo_disable;
> @@ -627,7 +658,14 @@ static int spi_geni_init(struct spi_geni_master *mas)
>   	pm_runtime_get_sync(mas->dev);
>   
>   	proto = geni_se_read_proto(se);
> -	if (proto != GENI_SE_SPI) {
> +
> +	if (spi->slave) {
> +		if (proto != GENI_SE_SPI_SLAVE) {
> +			dev_err(mas->dev, "Invalid proto %d\n", proto);
> +			goto out_pm;
> +		}
> +		spi_slv_setup(mas);
> +	} else if (proto != GENI_SE_SPI) {
>   		dev_err(mas->dev, "Invalid proto %d\n", proto);
>   		goto out_pm;
>   	}
> @@ -677,9 +715,11 @@ static int spi_geni_init(struct spi_geni_master *mas)
>   	}
>   
>   	/* We always control CS manually */
> -	spi_tx_cfg = readl(se->base + SE_SPI_TRANS_CFG);
> -	spi_tx_cfg &= ~CS_TOGGLE;
> -	writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
> +	if (!spi->slave) {
> +		spi_tx_cfg = readl(se->base + SE_SPI_TRANS_CFG);
> +		spi_tx_cfg &= ~CS_TOGGLE;
> +		writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
> +	}
>   
>   out_pm:
>   	pm_runtime_put(mas->dev);
> @@ -1072,6 +1112,9 @@ static int spi_geni_probe(struct platform_device *pdev)
>   	pm_runtime_set_autosuspend_delay(&pdev->dev, 250);
>   	pm_runtime_enable(dev);
>   
> +	if (device_property_read_bool(&pdev->dev, "qcom,slv-ctrl"))
> +		spi->slave = true;
> +
>   	ret = geni_icc_get(&mas->se, NULL);
>   	if (ret)
>   		goto spi_geni_probe_runtime_disable;
> @@ -1092,7 +1135,7 @@ static int spi_geni_probe(struct platform_device *pdev)
>   	 * for dma (gsi) mode, the gsi will set cs based on params passed in
>   	 * TRE
>   	 */
> -	if (mas->cur_xfer_mode == GENI_SE_FIFO)
> +	if (!spi->slave && mas->cur_xfer_mode == GENI_SE_FIFO)
>   		spi->set_cs = spi_geni_set_cs;
>   
>   	ret = request_irq(mas->irq, geni_spi_isr, 0, dev_name(dev), spi);
