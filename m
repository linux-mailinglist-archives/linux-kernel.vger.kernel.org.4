Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B856187FE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiKCSx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiKCSx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:53:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DF7F7E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 11:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667501584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AqzuI69gQNwIQyN1bVrCnvnBiSoLwcFO0iBFEG4BdBo=;
        b=DvrGlhzfdV32KfcRoS5YNUj1FZO5kIKdaZgQCsEG4hmn4LwxD6l7D4lYUoLDDG9EglG/r1
        7kxKs9/s5FUERLRuoPDzhMI0teCvUlsT6ehToztej/qe7gpvx07AkWPFy/hD/O+Ta1MO/z
        ibT+zp550eVSZ3dRfkSTXuJSP0iGhMA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-303-Crfc_Md8P3Sa25W1s_0vfQ-1; Thu, 03 Nov 2022 14:53:03 -0400
X-MC-Unique: Crfc_Md8P3Sa25W1s_0vfQ-1
Received: by mail-qk1-f200.google.com with SMTP id br12-20020a05620a460c00b006fa52448320so2752666qkb.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 11:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqzuI69gQNwIQyN1bVrCnvnBiSoLwcFO0iBFEG4BdBo=;
        b=lbW7chJeq+f3ym8gQBzzz8Z78NgyeTHjqsI2Z9z25rVDWmyQkHvRrD7iJObPngyfkg
         1ywC0Fvcz8mWgP8Vx7qeqwe3SBOz/nQGUeJefBvcD4jQMgWXQtKpkSKTLHYgl+QvU1bD
         kMkBt9o7ssqxTWK2e4LpInJ2D6ko3jzlqRaquYfa6LIMIPl1UAnjcWwq8D6sKiTq6GUh
         q16QJXtUL4QlHfvD11wjw5kxsvTLJNEs5HQBUzHxUhFORQB4yyXMgC/kDcDXfYy1uses
         UzcCTpIg4E772kH18xRhGED6Np2vaPCdCIf0NmkFBsKxFMnj1FmoELRh3B8L4pGAazGy
         /fwA==
X-Gm-Message-State: ACrzQf18UUyddcREC6ZubfrFseksAJ0M9pZ6FVpo5Eb3LlFkpI0yXOuO
        WK7kx3wmNUrTFErHoY2VmDxp9cse7gIZzLkHbbb8NsAhCkfuZtmC+4TYfOujXhw6jPludPrE+U/
        nG1v6qWXkbaPVzwqUX+kAxuEw
X-Received: by 2002:a05:622a:620b:b0:3a5:30c2:bf0d with SMTP id hj11-20020a05622a620b00b003a530c2bf0dmr16996678qtb.306.1667501583438;
        Thu, 03 Nov 2022 11:53:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5QkyI/NSOnvv19pCgS3K/W8SwFYEZHIYC9AjRoZ7kVkM71dJl9o/BUr2Kqg80BDoHJ3Hz6RA==
X-Received: by 2002:a05:622a:620b:b0:3a5:30c2:bf0d with SMTP id hj11-20020a05622a620b00b003a530c2bf0dmr16996664qtb.306.1667501583234;
        Thu, 03 Nov 2022 11:53:03 -0700 (PDT)
Received: from halaney-x13s (068-188-102-130.biz.spectrum.com. [68.188.102.130])
        by smtp.gmail.com with ESMTPSA id ch3-20020a05622a40c300b0039d085a2571sm965235qtb.55.2022.11.03.11.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 11:53:02 -0700 (PDT)
Date:   Thu, 3 Nov 2022 13:53:00 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: qcom: sc8280xp: Rectify UFS reset pins
Message-ID: <20221103185300.qlmp7syopca5qmgx@halaney-x13s>
References: <20221103181051.26912-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103181051.26912-1-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 11:10:51AM -0700, Bjorn Andersson wrote:
> From: Anjana Hari <quic_ahari@quicinc.com>
> 
> UFS reset pin offsets are wrongly configured for SC8280XP,
> correcting the same for both UFS instances here.
> 
> Signed-off-by: Anjana Hari <quic_ahari@quicinc.com>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # QDrive3

Functionally I saw no difference using ufs_mem_hc that I can notice.

From what I see in the downstream source the prior diff looks proper,
but I found a hardware document that says after diff is proper,
hence the R-B. I'll trust the hardware doc.

Thanks,
Andrew

> ---
>  drivers/pinctrl/qcom/pinctrl-sc8280xp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-sc8280xp.c b/drivers/pinctrl/qcom/pinctrl-sc8280xp.c
> index aa2075390f3e..e96c00686a25 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sc8280xp.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sc8280xp.c
> @@ -1873,8 +1873,8 @@ static const struct msm_pingroup sc8280xp_groups[] = {
>  	[225] = PINGROUP(225, hs3_mi2s, phase_flag, _, _, _, _, egpio),
>  	[226] = PINGROUP(226, hs3_mi2s, phase_flag, _, _, _, _, egpio),
>  	[227] = PINGROUP(227, hs3_mi2s, phase_flag, _, _, _, _, egpio),
> -	[228] = UFS_RESET(ufs_reset, 0xf1004),
> -	[229] = UFS_RESET(ufs1_reset, 0xf3004),
> +	[228] = UFS_RESET(ufs_reset, 0xf1000),
> +	[229] = UFS_RESET(ufs1_reset, 0xf3000),
>  	[230] = SDC_QDSD_PINGROUP(sdc2_clk, 0xe8000, 14, 6),
>  	[231] = SDC_QDSD_PINGROUP(sdc2_cmd, 0xe8000, 11, 3),
>  	[232] = SDC_QDSD_PINGROUP(sdc2_data, 0xe8000, 9, 0),
> -- 
> 2.17.1
> 

