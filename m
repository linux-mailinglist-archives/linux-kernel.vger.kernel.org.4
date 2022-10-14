Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A835FF1A0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 17:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiJNPoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 11:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiJNPoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:44:20 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D005E27B16
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 08:44:19 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29EF5Aqb026572;
        Fri, 14 Oct 2022 17:44:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=I4/sERsHtwpHF60gr5qHYhwhb45dHPOk41nFbouWbSE=;
 b=kcDna8ws2Y7ik5h5ZneO1//hkySzT1WLNZdOI+O7x4yUSE61iAAfaMwHJESZ73FrIGTR
 I2kp2K1rNeWLqO3XI3mn2epFqrTYMGkMbBxwEOMq8HvM1NVdiVt1ZpJreXvSNqVmAwYp
 dIZK1eM6HfWyIkKX2RYOUShvfMD8Ra+1nSe2eqt+kvdXSXVB873UP/AXH8kiWl+UY0vJ
 xp4N3RMiS997goacp32tNG5B+NkWUmnnrVEMMokQVylITfc7/YiduzFbDTn5dOeKdvnb
 qpsaiHaJzquK8uJ9acMvpf256ow6hOZGa4FxD0RidzfCe0VrbmR1GukqSEXh30MfS1K9 0g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k769qsyu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 17:44:10 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ABDEA10002A;
        Fri, 14 Oct 2022 17:44:05 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A651E237D96;
        Fri, 14 Oct 2022 17:44:05 +0200 (CEST)
Received: from [10.48.0.213] (10.75.127.50) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Fri, 14 Oct
 2022 17:44:04 +0200
Message-ID: <f9306425-632f-b20f-3d01-43d4393632b7@foss.st.com>
Date:   Fri, 14 Oct 2022 17:44:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] nvmem: stm32: add warning when upper OTPs are updated
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20221014170426.1.Ifa806ff30d7c669ba9a3df9c6b64698a2dcc073a@changeid>
From:   Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20221014170426.1.Ifa806ff30d7c669ba9a3df9c6b64698a2dcc073a@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_09,2022-10-14_01,2022-06-22_01
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/14/22 17:04, Patrick Delaunay wrote:
> As the upper OTPs are ECC protected, they support only one 32 bits word
> programming.
> For a second modification of this word, these ECC become invalid and
> this OTP will be no more accessible, the shadowed value is invalid.
>
> This patch adds a warning to indicate an upper OTP update, because this
> operation is dangerous as OTP is not locked by the driver after the first
> update to avoid a second update.
>
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
>
>   drivers/nvmem/stm32-romem.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
> index 354be526897f..e3c3c333b5d1 100644
> --- a/drivers/nvmem/stm32-romem.c
> +++ b/drivers/nvmem/stm32-romem.c
> @@ -133,6 +133,9 @@ static int stm32_bsec_write(void *context, unsigned int offset, void *buf,
>   		}
>   	}
>   
> +	if (offset + bytes >= priv->lower * 4)


Here I miss a dependency for "priv->lower" with a other preliminary 
patch for STM32MP13x support.


> +		dev_warn(dev, "Update of upper OTPs with ECC protection (word programming, only once)\n");
> +
>   	return 0;
>   }
>   


Sorry,

I will sent a V2 soon


Patrick

