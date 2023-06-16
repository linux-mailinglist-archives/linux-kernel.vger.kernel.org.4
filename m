Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDB47326A5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 07:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbjFPFbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 01:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjFPFbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:31:35 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E4E2943;
        Thu, 15 Jun 2023 22:31:33 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 58B3A40901;
        Fri, 16 Jun 2023 10:31:28 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1686893489; bh=W3BlNMaiG3cHQL4Ng0ytzSXIonyV1hxmRIBmdcXY2DA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=43O0re6ckxF+pQP5jc8kmicy2CjfzN4Fztdb4MQIovS2GMHHP8RD0DnSF5ofvMito
         +IoGeQLlyTHvVsZULfGobaaTH4nJ1uUP/wcMUSbtHYkZyYI20779H8OVPHSBWiaTDq
         sY4nLro8MukesWGvHnLi+vtRdvufQShqqaiNVNNc0JUQi758R4M5WCk+/njE5d6qnE
         wYsX7iBx6KEo6pYa3PVzesoYOIOrbSkUdpyx/LSc2JLc3hJl30CT/8Hnln37YEqw5H
         9VDr5IDYReVyTTRRn8CCVeP98XqMaKjmNj3YulIF3gnUGAYDIBBk+vHXnpVNFAsoLS
         K8sesLLznxnUQ==
MIME-Version: 1.0
Date:   Fri, 16 Jun 2023 10:31:26 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: venus: core: Set up secure memory ranges for
 SC7180
In-Reply-To: <20230616-topic-sc7180_venus_lawp-v1-1-15a8f44d474e@linaro.org>
References: <20230616-topic-sc7180_venus_lawp-v1-1-15a8f44d474e@linaro.org>
Message-ID: <8adfa758ba13e70a3cd28a9c8a45738f@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konrad Dybcio писал(а) 16.06.2023 04:36:
> Not all SC7180 devices ship with ChromeOS firmware. WoA devices use
> Android-like TZ, which uses PAS for image authentication. That requires
> the predefined virtual address ranges to be passed via scm calls.
> Define them to enable Venus on non-CrOS SC7180 devices.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

This does indeed bring up the venus for me now. Thanks! 

Tested-by: Nikita Travkin <nikita@trvn.ru> # Aspire 1

> ---
>  drivers/media/platform/qcom/venus/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 2ae867cb4c48..bee1b4c98060 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -760,6 +760,10 @@ static const struct venus_resources sc7180_res = {
>  	.vmem_size = 0,
>  	.vmem_addr = 0,
>  	.dma_mask = 0xe0000000 - 1,
> +	.cp_start = 0,
> +	.cp_size = 0x70800000,
> +	.cp_nonpixel_start = 0x1000000,
> +	.cp_nonpixel_size = 0x24800000,
>  	.fwname = "qcom/venus-5.4/venus.mdt",
>  };
>  
> 
> ---
> base-commit: 925294c9aa184801cc0a451b69a18dd0fe7d847d
> change-id: 20230616-topic-sc7180_venus_lawp-965e5fd18c7a
> 
> Best regards,
