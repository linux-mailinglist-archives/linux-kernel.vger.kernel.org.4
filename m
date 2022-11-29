Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A186263C748
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 19:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbiK2Sl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 13:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbiK2SlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 13:41:24 -0500
X-Greylist: delayed 1087 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Nov 2022 10:41:20 PST
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3621843AD5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 10:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=zrPLVXc1wxhnRG45/ElMpwAglQX6PxOgC3lXR1KUK+k=; b=dFI0SyaARzE1Q3N7p5DCgkrJXG
        I/X6+e1ncC7HlpKCT0CIr4UJDnjdCuu+lUNnL/c0z6blwqsHwWrU/qIRaN+n3Wk1RvVimGH/0q0Nd
        /zMONw7GaKI4ZMgL+wQP/8OcOB3aMFMTeLKDeExQrXvKcudOoY607zR5zLMvS/Wxb2pRRuxv0KWP1
        a6SqwmW09pz+ti8pid+HEe7pWacx0QZzH05w9I1RO5tBsKeT8LecUOuv3MrpMsBByePI6QEcE8pcA
        722HJpJNq1MJZyvbMbjuLR9znCMpb9VAS2PM00yeTogBj16/+frwrjt3yNwiUOo/dsIHvIS46Ep4W
        zmQQITMQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1p05G9-000JbQ-5z; Tue, 29 Nov 2022 19:23:09 +0100
Received: from [136.25.87.181] (helo=[192.168.86.22])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1p05G8-0001eX-Ju; Tue, 29 Nov 2022 19:23:08 +0100
Message-ID: <bbacb73a-6904-d196-ab4a-3e388bcab56c@metafoo.de>
Date:   Tue, 29 Nov 2022 10:23:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/1] iio: imx8qxp-adc: fix irq flood when call
 imx8qxp_adc_read_raw()
Content-Language: en-US
To:     Frank Li <Frank.Li@nxp.com>, Cai Huoqing <cai.huoqing@linux.dev>,
        Haibo Chen <haibo.chen@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:NXP i.MX 8QXP ADC DRIVER" <linux-iio@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     imx@lists.linux.dev
References: <20221129164531.2164660-1-Frank.Li@nxp.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20221129164531.2164660-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.7/26735/Tue Nov 29 09:18:47 2022)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 08:45, Frank Li wrote:
		       readl(adc->regs + IMX8QXP_ADR_ADC_FCTRL));
> @@ -272,6 +275,10 @@ static irqreturn_t imx8qxp_adc_isr(int irq, void *dev_id)
>   	if (fifo_count)
>   		complete(&adc->completion);

Shouldn't the completion be triggered after the reading of the samples? 
otherwise you have a race condition on a multi-processor system.

>   
> +	for (i = 0; i < fifo_count; i++)
> +		adc->fifo[i] = FIELD_GET(IMX8QXP_ADC_RESFIFO_VAL_MASK,
> +				readl_relaxed(adc->regs + IMX8QXP_ADR_ADC_RESFIFO));
> +
>   	return IRQ_HANDLED;
>   }
>   

