Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751F368D66E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 13:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjBGMZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 07:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjBGMZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 07:25:44 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CFE37F26
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 04:25:42 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id k13so5969885wrh.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 04:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EnZqUDs+vOL9eLigF5zhRBTNLnRQCkndCOjGhTOrE2Y=;
        b=JM441Qqy+1fZmCJblSylYs6tj2fTsSrjmHEBvTFWYOCXkTdIp6bWHaNlTrN/gMI2LM
         +tuwvNETO57Xy5HH6EfrZRKMyVf5msaPShQfmXx5XED+SpBUl7jrNqS6AJwoyd0xTSQB
         bjYsDhCfsOMCJuRHlUUxwP17LalQGdrQgi7aBZ4qtuheMEg3/7vbWf9Z8gU/sWwMqNMa
         llN5umaTQX3fhTYJBh41eGqGHccL+Ui1Zu6pNkua9T54lMbevLn+tj62Or9yLKAdYieF
         PIfUwyWXLHo7TC3hefPdfd6MUo0MXo6dynyMJgFbMAY1tgtBEgreMERHEAgr5+wi/Zjn
         LtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnZqUDs+vOL9eLigF5zhRBTNLnRQCkndCOjGhTOrE2Y=;
        b=mwqWKCXZR1AFYOWuoDVIz8ElbhQOtuJXCZ872bt+rnR428omNEn5dMwYqtdDzdrNpb
         5avUlLly50eythb/ffz+hyWC7I2PvyDjV6KVCaIn2SzBp+zc5DEozMeTypBQnqar9BFs
         W4GAoZchxrj0TZP+Q1OCAuN2jIkGaGvHp/TMvsf+GT00n+uv2lPv//Fu8N91R7Yl6TuG
         +cj6B+rs0qn1ock9a+UFtTKETocjwuX9BnwkvUCn0fNUiGRg3YQhO1ZxdRzEQuySfoWW
         A/lJ9/CjNoWijiEcspwl5UKR5vOzdJb+FIyn5ErKoU2S2hTMUw9eYvJlXQ1s9lupSmdl
         5y2Q==
X-Gm-Message-State: AO0yUKWUUZmJkpEAHFHQ0fL44HhcXCg94IesAzC0A+NX1II1RUs0xPtb
        DVMoZE0OQ3QYDVMY82CRyplsyw==
X-Google-Smtp-Source: AK7set96v9kQl3blLgDHsC9KtC7U5aHC8Yd0qc798XB5lCqQIh/WZdWAaO6kvfN+pCiHtWLrDSOvog==
X-Received: by 2002:a5d:4144:0:b0:2c3:e5f5:9fa9 with SMTP id c4-20020a5d4144000000b002c3e5f59fa9mr2444692wrq.67.1675772740668;
        Tue, 07 Feb 2023 04:25:40 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id x18-20020adfffd2000000b002c3f1223059sm2099785wrs.36.2023.02.07.04.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 04:25:40 -0800 (PST)
Date:   Tue, 7 Feb 2023 14:25:38 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
Subject: Re: [RFC v3 4/7] phy: qcom: Add QCOM SNPS eUSB2 repeater driver
Message-ID: <Y+JDQt/T7pXh2/P7@linaro.org>
References: <20230202133816.4026990-1-abel.vesa@linaro.org>
 <20230202133816.4026990-5-abel.vesa@linaro.org>
 <6f326ed7-6799-b965-fe3a-1f046546ed44@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f326ed7-6799-b965-fe3a-1f046546ed44@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-02-03 18:51:13, Dmitry Baryshkov wrote:
> On 02/02/2023 15:38, Abel Vesa wrote:
> > PM8550B contains a eUSB2 repeater used for making the eUSB2 from
> > SM8550 USB 2.0 compliant. This can be modelled SW-wise as a Phy.
> > So add a new phy driver for it.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >   drivers/phy/qualcomm/Kconfig                  |   9 +
> >   drivers/phy/qualcomm/Makefile                 |   1 +
> >   .../phy/qualcomm/phy-qcom-eusb2-repeater.c    | 278 ++++++++++++++++++
> >   3 files changed, 288 insertions(+)
> >   create mode 100644 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
> > 

[ ... ]

> > +
> > +static int eusb2_repeater_init(struct phy *phy)
> > +{
> > +	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
> > +	const struct eusb2_repeater_init_tbl *init_tbl = rptr->cfg->init_tbl;
> > +	int num = rptr->cfg->init_tbl_num;
> > +	int ret = 0;
> > +	u32 val;
> > +	int i;
> > +
> > +	ret = regulator_bulk_enable(rptr->cfg->num_vregs, rptr->vregs);
> > +	if (ret)
> > +		return ret;
> > +
> > +	regmap_update_bits(rptr->regmap, rptr->base + EUSB2_EN_CTL1,
> > +				EUSB2_RPTR_EN, EUSB2_RPTR_EN);
> > +
> > +	for (i = 0; i < num; i++)
> > +		regmap_update_bits(rptr->regmap,
> > +					rptr->base + init_tbl[i].offset,
> > +					init_tbl[i].val, init_tbl[i].val);
> 
> I'd move this to a separate function. Then you can use it in the set_mode()
> too.
> 

I don't think this is necessary in set_mode.

> > +
> > +	ret = regmap_read_poll_timeout(rptr->regmap,
> > +					rptr->base + EUSB2_RPTR_STATUS, val,
> > +					val & RPTR_OK, 10, 5);
> > +	if (ret)
> > +		dev_err(rptr->dev, "initialization timed-out\n");
> > +
> > +	return ret;
> > +}
> > +

[ ... ]
