Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C8D635B10
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237635AbiKWLG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237567AbiKWLGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:06:04 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD55BBC;
        Wed, 23 Nov 2022 03:05:09 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANAapRm023568;
        Wed, 23 Nov 2022 12:04:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=u0sShtivsgK/20XBxCveeAhPRdkeUJsHdC8lqu1cuGU=;
 b=Eg240EFQCP7w8o+l4HFuPIv4z4pgaDZZUT9YTRzpEYf5NNFxEr3HvWzQUb9IRNSCt8Uo
 CyXtcytbZhL7PM/FRT8YJ1n1XIkh6PpkeRJ95DIQMHnWp2d3f3357cqMszu2PAj9DVBT
 aKgSQmD6Z5Ij2vKyHvw87cOQcZA9SUyUyZJlF/U+jLmruAHiBEILu951zRkDUkXtiLMh
 xxzOv9E+D6kBXxGEWQOuL1Jr4hj/DKcdEI9uhfhC7xHLVOPVDQukR0GrcJnwCMqr6hmI
 TFd7fTNvMKtXgOPVWlq/ebzIY+57NHlKMR+nfHmT/WD61oUuB8z9QDziJV2jdg8hCTZl Lw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3m10c4e1wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 12:04:43 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 13458100034;
        Wed, 23 Nov 2022 12:04:38 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0DD0421A229;
        Wed, 23 Nov 2022 12:04:38 +0100 (CET)
Received: from [10.48.1.102] (10.48.1.102) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Wed, 23 Nov
 2022 12:04:37 +0100
Message-ID: <f7a2a680-4879-b6cf-3546-e890b3c96e32@foss.st.com>
Date:   Wed, 23 Nov 2022 12:04:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/3] iio: adc: stm32: add smart calibration
Content-Language: en-US
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221115103124.70074-1-olivier.moysan@foss.st.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20221115103124.70074-1-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.1.102]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_05,2022-11-23_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/22 11:31, Olivier Moysan wrote:
> Refine offset and linear calibration strategy for STM32MP15 and
> STM32MP13 SoCs:
> 
> - offset calibration
> This calibration depends on factors such as temperature and voltage.
> As it is not time consuming, it's worth doing it on each ADC
> start, to get the best accuracy. There is no need to save these data.
> 
> - linear calibration
> This calibration is basically SoC dependent, so it can be done only once.
> When this calibration has been performed at boot stage, the ADC kernel
> driver can retrieve the calibration data from the ADC registers.
> Otherwise, the linear calibration is performed once by the ADC driver.
> The backup of these data, allows to restore them on successive ADC starts.
> 
> Olivier Moysan (3):
>   iio: adc: stm32-adc: smart calibration support
>   iio: adc: stm32-adc: improve calibration error log
>   iio: adc: stm32-adc: add debugfs to read raw calibration result

Hi Olivier,

For the series, you can add my:
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,
Fabrice

> 
>  drivers/iio/adc/stm32-adc-core.h |   1 +
>  drivers/iio/adc/stm32-adc.c      | 135 ++++++++++++++++++-------------
>  2 files changed, 78 insertions(+), 58 deletions(-)
> 
