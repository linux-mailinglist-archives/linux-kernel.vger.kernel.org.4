Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87266EE474
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbjDYPH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbjDYPHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:07:22 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35F5B0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 08:07:20 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-32b1ee270ebso15275235ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 08:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682435240; x=1685027240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpYAGainFDoBezMAz2LIC0vmyd867yd+Zieo+NHOeqA=;
        b=gthEI2ttMvW0cxQg5Il2ZqJitHKt9MbBKB7ONvoq6jSgrGsjkmfIx8Ta6ORB8VgLD8
         KqP31IxAKsdhS1ltIyuJZLaHYIxhz+nDGCQAFgy/LTr8kBJGiqUudRCxVC1+ft/wYKDp
         aMejtIB+NGInfIdG8T2bUl8GtFjppw3eFEu0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682435240; x=1685027240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpYAGainFDoBezMAz2LIC0vmyd867yd+Zieo+NHOeqA=;
        b=Yve1i248bP+477S+jBdM8vOCzBTUue+ZaazMSl4JtD8eY64v6aQrJH4qb5yklLF9iy
         BSm/5nz2dpe9rW8+5IMtMvzgz8vjcIP7mG1rHndAQVdvblXQtIBIBKtUsPNpnbsLX6ti
         xwone5mj9dE3jeFia0c4BVoObY4aLeVewQRDrNgYVvp9byhfmGeYq3GUmR/yz1TDZ70A
         G7TokEyotG5vUoNATM1EtoR1amDTGZeoasLkIwOH+Tvv+9Ta3w226HXXFfOG7xcenbV7
         9PSG9YrWi/xt3cvtjYP1syaFc4SvNy3beE5zX4UkIAJjrcs+zYvSYbBDZx15B5uX3T55
         7+6A==
X-Gm-Message-State: AAQBX9fdH+uoJQ5O6QJ3bf0gpXBDifLBy80gnBFq/cH5B1CmfyP11NUY
        G195TAe5CXPZw4733q3uvCleO9n8+QmaivFVFEw=
X-Google-Smtp-Source: AKy350ZINjfFyHlrMnLCoJ7Djm7pSj4QsbAANT2iksr8yrH/fmnuWSve9ZuTruqtOTHoH7+GeaGYgQ==
X-Received: by 2002:a92:cf45:0:b0:328:7326:b715 with SMTP id c5-20020a92cf45000000b003287326b715mr8071744ilr.31.1682435239788;
        Tue, 25 Apr 2023 08:07:19 -0700 (PDT)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id m30-20020a056638271e00b00411bd20d4cbsm1704894jav.121.2023.04.25.08.07.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 08:07:18 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-32ec968434eso87515ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 08:07:18 -0700 (PDT)
X-Received: by 2002:a05:6e02:1d96:b0:32a:dc6a:3b97 with SMTP id
 h22-20020a056e021d9600b0032adc6a3b97mr320927ila.0.1682435237664; Tue, 25 Apr
 2023 08:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <1682412128-1913-1-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1682412128-1913-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Apr 2023 08:07:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UKpe2rixisrp213w57dF6zgFK909v1-inTNXiu=FVLjA@mail.gmail.com>
Message-ID: <CAD=FV=UKpe2rixisrp213w57dF6zgFK909v1-inTNXiu=FVLjA@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Correct CS_TOGGLE bit in SPI_TRANS_CFG
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 25, 2023 at 1:42=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> The CS_TOGGLE bit when set is supposed to instruct FW to
> toggle CS line between words. The driver with intent of
> disabling this behaviour has been unsetting BIT(0). This has
> not caused any trouble so far because the original BIT(1)
> is untouched and BIT(0) likely wasn't being used.
>
> Correct this to prevent a potential future bug.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/spi/spi-geni-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index ba7be50..8a7d1c2 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -35,7 +35,7 @@
>  #define CS_DEMUX_OUTPUT_SEL    GENMASK(3, 0)
>
>  #define SE_SPI_TRANS_CFG       0x25c
> -#define CS_TOGGLE              BIT(0)
> +#define CS_TOGGLE              BIT(1)

Looks right to me from the datasheet I have access to. It's definitely
specified in an odd way on the datasheet, which lists bit 1 as this,
bit 2 and 3 as reserved, but bit 0 is absent. ...but seems like this
is really supposed to be 1.

I guess this never mattered because all we ever did was clear the bit
at init time and it must have already been cleared? ...and, of course,
on many Chromebooks we moved to just using a GPIO...

Fixes: 561de45f72bd ("spi: spi-geni-qcom: Add SPI driver support for
GENI based QUP")
Reviewed-by: Douglas Anderson <dianders@chromium.org>
