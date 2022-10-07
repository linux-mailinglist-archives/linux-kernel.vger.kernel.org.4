Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745B15F7F6C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 23:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiJGVF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 17:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJGVFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 17:05:25 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167B971733;
        Fri,  7 Oct 2022 14:05:24 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id d14so3126840ilf.2;
        Fri, 07 Oct 2022 14:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1w+iqaEsBhwauyKajeBJ7twOSMI99Dy/AXJIr5VPGk=;
        b=ZL2z4RIKsU/WRAbXAjtxb2dBeLyeELGbuI1+d31LoloSudsW2LacTFaOu7Zyepzi7u
         /mLolBtT9BIljmYR4ZSKTMm+MkBo7AXXDX/7IH3/22PWSerZp78h/S2zkEvgLLPEVl22
         q++aWsGPYi1beU2UhpzR4/Ig2ziTxHYzdIfU7QThUGC5h4wMFsEIk4/2agUmQ0MwRBDB
         u9lLhqA3Gj3b7g3dxGIX/576JAZsAgRdBRGGyhjAm+G7A+AZcfxT5X/fv+ybQ7UkLjyb
         FWj3Z/QKXqqwaU/CBGF3t4aPa+py9JD5MWCu/JtO+BLyIBXI6mWhqRliK7MnhUuQsYJ4
         DYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1w+iqaEsBhwauyKajeBJ7twOSMI99Dy/AXJIr5VPGk=;
        b=jxEH15SpannG3MQDgx2xWtGHiWj4EN2b0/rksjihu+NUa2Rw+08njqvQjKEDM1hpz1
         EzYvRMGIlj5Vg+a1x/bfqlSVY1+W8Zel0cUw95xv4sxcS2rf0GCAHSrwoOpt/92CDR3T
         fH3UGrDEibjlBElBOyzF/cS2PpMKDnIlORHWcelSAuH1AU1cYJ2J+5+/yiBNAs7bKRct
         5+Nf65hlWeMceWhuFlWlv7af3+c3dXW9vgrUKOTc9R81jxlMnkti+a+/L7vN6MCr98l1
         /rJP+vkkMRLsi09xDLHR0jTliPRRRZuvUgKTO9ALjmJP7pgUjUS7zkBzR4YGiQxHBSpr
         s10Q==
X-Gm-Message-State: ACrzQf3avnSECiDz1Ml6qyKv/aElIwKB97bX3RqbsLYT+KoWhXOSTPJU
        qTbke16fTR2G6yMA31fJN3o=
X-Google-Smtp-Source: AMsMyM7wS3RBhsBWrkuMIweLCvAHxlNbERiQsXAZYUw5Po0RC//7Kj44P4I4rB2ZBbHuttiDN6nNkw==
X-Received: by 2002:a92:cd42:0:b0:2f9:9c9f:b56b with SMTP id v2-20020a92cd42000000b002f99c9fb56bmr3343912ilq.163.1665176723466;
        Fri, 07 Oct 2022 14:05:23 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::b714])
        by smtp.gmail.com with UTF8SMTPSA id d16-20020a026050000000b00362983f80a3sm1249769jaf.30.2022.10.07.14.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 14:05:22 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v8 2/3] pinctrl: qcom: do not reinitialize gpio valid mask
Date:   Fri,  7 Oct 2022 17:04:52 -0400
Message-Id: <20221007210452.79730-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221007022406.kggtrbh52iamn2dv@builder.lan>
References: <20221006232219.37505-1-mailingradian@gmail.com> <20221006232219.37505-3-mailingradian@gmail.com> <20221007022406.kggtrbh52iamn2dv@builder.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Oct 06, 2022 at 07:22:18PM -0400, Richard Acayan wrote:
> > It may be necessary for some devices to specify reserved gpios in the
> > device-specific DTS, in addition to the reserved gpios common to all
> > devices with a given SoC. Remove this bitmap_fill() call so that the
> > settings applied to the gpio valid mask by DTS are not overridden by
> > the driver's reserved gpios.
> > 
> > Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> > ---
> >  drivers/pinctrl/qcom/pinctrl-msm.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> > index a2abfe987ab1..f697e9f64360 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> > +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> > @@ -687,9 +687,8 @@ static int msm_gpio_init_valid_mask(struct gpio_chip *gc,
> >  	const int *reserved = pctrl->soc->reserved_gpios;
> >  	u16 *tmp;
> >  
> > -	/* Driver provided reserved list overrides DT and ACPI */
> > +	/* Driver provided reserved list overrides other settings here */
> 
> IMHO this no longer overrides things, how about changing it to:

Technically, it doesn't. It skips the ACPI settings entirely:

	if (reserved) {
		for (i = 0; reserved[i] >= 0; i++) {
			if (i >= ngpios || reserved[i] >= ngpios) {
				dev_err(pctrl->dev, "invalid list of reserved GPIOs\n");
				return -EINVAL;
			}
			clear_bit(reserved[i], valid_mask);
		}

		return 0;
	}

	/* The number of GPIOs in the ACPI tables */
	len = ret = device_property_count_u16(pctrl->dev, "gpios");
	if (ret < 0)
		return 0;

> 
> 	/* Remove driver-provided reserved GPIOs from valid_mask */

Will do. Let me know if you think the above information changes what the comment
should be.

> 
> 
> The rest of the change looks good and the commit message looks good. So
> please consider updating the comment and feel free to add my
> 
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> 
> Regards,
> Bjorn
> 
> >  	if (reserved) {
> > -		bitmap_fill(valid_mask, ngpios);
> >  		for (i = 0; reserved[i] >= 0; i++) {
> >  			if (i >= ngpios || reserved[i] >= ngpios) {
> >  				dev_err(pctrl->dev, "invalid list of reserved GPIOs\n");
> > -- 
> > 2.38.0
> > 
