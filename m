Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BF75FF9BF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 13:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJOLPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 07:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiJOLPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 07:15:17 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1144C31EC6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 04:15:11 -0700 (PDT)
Received: from [192.168.1.101] (95.49.31.41.neoplus.adsl.tpnet.pl [95.49.31.41])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 010F13F311;
        Sat, 15 Oct 2022 13:15:08 +0200 (CEST)
Message-ID: <517ccf1b-3ac4-6190-5039-4ef3f4de9840@somainline.org>
Date:   Sat, 15 Oct 2022 13:15:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/2] soc: qcom: stats: Mark device as having no PM support
To:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org
References: <20221015004654.3930122-1-swboyd@chromium.org>
 <20221015004654.3930122-2-swboyd@chromium.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221015004654.3930122-2-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.10.2022 02:46, Stephen Boyd wrote:
> This driver purely exposes information from memory to the kernel. Let's
> mark it as not having any device PM functionality, so that during
> suspend we skip even trying to call a suspend function on this device.
> This clears up suspend logs more than anything else, but it also shaves
> a few cycles off suspend.
> 
> Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  drivers/soc/qcom/qcom_stats.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/soc/qcom/qcom_stats.c b/drivers/soc/qcom/qcom_stats.c
> index d6bfd1bbdc2a..d89453a77408 100644
> --- a/drivers/soc/qcom/qcom_stats.c
> +++ b/drivers/soc/qcom/qcom_stats.c
> @@ -217,6 +217,8 @@ static int qcom_stats_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, root);
>  
> +	device_set_pm_not_required(&pdev->dev);
> +
>  	return 0;
>  }
>  
