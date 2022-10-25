Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAE360D633
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 23:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiJYVd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 17:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiJYVd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 17:33:56 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6097F107A85
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 14:33:55 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id d16so1036721iof.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 14:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aqCyDzBlgI0lxrRS0dVDOBPWnZoyypnDJaDYBUnhBSA=;
        b=ZbCWAHeaKy2n264Ub+ghiRtRmway0DRQ071l6WoJpSS1lHbUdOyzGEWfAkv7NZ3/Bp
         lfMxjFqVrLNEI+69N5m/udrQUiRi6+nWfEelZXmTmYKjEXJDakIn6pCkOxktYlUE0UHW
         NGy62ZV/grMkxizRvH/hcWpI+4d2bBPCfKpSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqCyDzBlgI0lxrRS0dVDOBPWnZoyypnDJaDYBUnhBSA=;
        b=yP4AV2xhg2fs7lMqgKOwD5/B/OuQYPezs9wPQX+pKZR5hAgM/m4vCbpBMsFZYRW7oz
         q8ZfnNvXY3/f8nPMx24qyy+PtVv0h6gRJWFFu9SvIkssZCVdyfchBWnH2jXxHwiMhGeu
         nODNFZOaeeo8B7qI2wdTp5nt/q9GtjfDXf2S3CILF4d6DO85QJl8R6rmUuIlaNetwgEw
         N3DwYNU95ERf4mR4LEu1OFHjyTWWutqd+B8dZ0nT0ZVSGu2F/Ci2Q751aIcfXrD36TIp
         831EacYjRcYW+/vQzYmeKgpuUkra/5gUxy3MENtxoehz+2Qy/Mv5Cf7/sOBMJzkFRZoz
         jlXg==
X-Gm-Message-State: ACrzQf2Ooy1f4vn/oQ7Ofo59RMfZkXZeipf5SolpDxH0cRyTa6d6BwbJ
        yFMHGJqIsDKvmfdUnhPwYgoYvw==
X-Google-Smtp-Source: AMsMyM697VIOL/dbE1vPoZgpCLB2Ws+ra6abn/XsvHDNZhHcaNpAUdaRm0Fv/A2x82DlF7T0Pz/cAw==
X-Received: by 2002:a05:6602:2ac9:b0:6bc:17dd:3800 with SMTP id m9-20020a0566022ac900b006bc17dd3800mr22880722iov.72.1666733634729;
        Tue, 25 Oct 2022 14:33:54 -0700 (PDT)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id h12-20020a92c08c000000b003001f822301sm1356232ile.81.2022.10.25.14.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 14:33:54 -0700 (PDT)
Date:   Tue, 25 Oct 2022 21:33:53 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH] thermal: qcom-spmi-temp-alarm: Log the actual max stage
 2 threshold
Message-ID: <Y1hWQXnl7ko0EJDw@google.com>
References: <20221025171453.1.I13c2a23f276fb63bfc225aeab0bf0db9560a90e0@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221025171453.1.I13c2a23f276fb63bfc225aeab0bf0db9560a90e0@changeid>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just saw that Luca already posted a similar patch:

https://lore.kernel.org/lkml/CAHLCerN+-5qKsRmpuF55RdeUMZJZuiZJ-7O4LnM8+QuHJfs0mQ@mail.gmail.com/T/

Please disregard this one.

On Tue, Oct 25, 2022 at 05:15:08PM +0000, Matthias Kaehlcke wrote:
> If the critical trip point of the thermal zone is higher than
> the max threshold of the PMIC log the actual max threshold of the
> chip, not the gen1 max threshold of 140°C.
> 
> Reported-by: Luca Weiss <luca.weiss@fairphone.com>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> index be785ab37e53..bdfe2129c357 100644
> --- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> +++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> @@ -252,7 +252,8 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
>  			disable_s2_shutdown = true;
>  		else
>  			dev_warn(chip->dev,
> -				 "No ADC is configured and critical temperature is above the maximum stage 2 threshold of 140 C! Configuring stage 2 shutdown at 140 C.\n");
> +				 "No ADC is configured and critical temperature is above the maximum stage 2 threshold of %d C! Configuring stage 2 shutdown at %d C.\n",
> +				 stage2_threshold_max / 1000, stage2_threshold_max / 1000);
>  	}
>  
>  skip:
> -- 
> 2.38.0.135.g90850a2211-goog
> 
