Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A9D72DB51
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240547AbjFMHnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240584AbjFMHnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:43:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262911730;
        Tue, 13 Jun 2023 00:42:47 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D7IDpk020275;
        Tue, 13 Jun 2023 07:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/jnThA7BHjWqYdWXMcGO9sxX8nn+HT9Gb4SdhNturuU=;
 b=TsbYOphiPt3wtCCqsnUU9Zdd6AC2PAawFcmOynrWFSw+1bqwY3O38OdOqJWj3X3HKmSM
 xWX+UEB68gqLseHBgfo57pIxHEHxfPS7llhIaK7rsiCJHJSPmOHcwgp1IUTamwARwCQL
 AkCAooCrQFs/qtkAddte3n+PQH+YUAeXU7ICKfyBWEWPPSDRkw9IvG//q2Urlc3hgUGD
 dPbR5Fms/Ez771eV1f4/grd6XSCboYebpZRx7Gh3xR0KztmUfxyl1Z8PJjdg2gpdabmh
 sA4oyxn16XXTaULqh0+4ilV/L/d4/fPLJ7KJxJ/3L5VHh5/2MDTQdaEWrh/xLRC5Kz0b rw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r6km402jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 07:42:37 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35D7ganZ027543
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 07:42:36 GMT
Received: from [10.218.20.114] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 13 Jun
 2023 00:42:32 -0700
Message-ID: <886b1665-cbb9-e302-eb2d-b7ff9fd242a8@quicinc.com>
Date:   Tue, 13 Jun 2023 13:12:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] spi: spi-geni-qcom: Add SPI SLAVE mode support for
 GENI based QuPv3
To:     Praveen Talari <quic_ptalari@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <broonie@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>,
        <quic_vnivarth@quicinc.com>, <quic_arandive@quicinc.com>
References: <20230613065229.5619-1-quic_ptalari@quicinc.com>
 <20230613065229.5619-3-quic_ptalari@quicinc.com>
Content-Language: en-US
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
In-Reply-To: <20230613065229.5619-3-quic_ptalari@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fvhy8oDZ0A3JjwHWvHFMYubGKVUR2URt
X-Proofpoint-GUID: fvhy8oDZ0A3JjwHWvHFMYubGKVUR2URt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 impostorscore=0 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306130067
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



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

Should we update this property "qcom,slv-ctrl" in device tree bindings
as well !!


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

-Shazad
