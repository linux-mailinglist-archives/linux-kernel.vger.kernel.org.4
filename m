Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D21A677990
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjAWKtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjAWKsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:48:45 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE2015569
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:48:38 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id e3so10342162wru.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xUVs15KkMYg/lOZfsKh5uaV6K+tz2DAgJfE3k7IQtmk=;
        b=jjD2YKphApLPv1bjx17k+4kKaGTqVyabYxoEYYixuf3A4AvVpRbRfAI9z9agB375x2
         xjUu1dkTCkBdnTHtc9IOGs3ZWvcZQpQdxJSyc7oM3vdhdx0N5Afta9SIQwQVKfjc73ul
         ZYq3u2i+JBZXTJaGpAShOIOweiI0PCAY1v9aFfsncOnl30N1EHyvxBHpVZGUmwiDO5dN
         QvOmb1IVKJp2IgP8SeHkY1WYr9hlvmnA/ynDkISb2JjmKwqjIOLpW3+YGAocsLkESBGo
         Bc/918chw0QhVFAAOzmd8agGeTRoLE1i3kUJdYTUfeukIuAxZM7qecHaOD/X10v+IG5q
         H4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUVs15KkMYg/lOZfsKh5uaV6K+tz2DAgJfE3k7IQtmk=;
        b=u3IPY3HK81NlIdMQ2skoHW4LvvtlA8gTgT91qiYcklcAzCw/J/3XDZzxRvaT+/YLTP
         S7JJddAm56S+GvpWbRw+K+ywsIPfr0kuVSeUmvM50PihIvPwiJV0rhxHTb8f33QVwp+7
         tWGsxJCynSpn6PQKG1Xa15EDA/B6OzSfibRIH+25kICg9pAWyUWSlMz+C/e8+oixA3gk
         IeutdC122nqJrzDLhN9120gr3BiJdQnAb5MRNlATCdQoiQ9yfUMpsXjJcj7nm8mJBKRn
         9Q/WDnJIolA0mVqDym3e6GWcPK6CgWXJCh6UCsi382/RFEbiYPWUzaVOJ1WM1FjQBpYd
         N3Ow==
X-Gm-Message-State: AFqh2kpzfaqaQD+JzhnqVx2smWEyrckURZ7O9QMAsSobJfu37/y09QgV
        TwuzrGUSJ4nGVW8S44c1A+vYbGdHdNNLrMSv
X-Google-Smtp-Source: AMrXdXvC9iO/i18vyEk6bT6Inj0bgYpYRMo5UeUgpdPDG3EkaOpRwjaGyVhXg1o7xdSEhq9oPjvFSQ==
X-Received: by 2002:a5d:5c13:0:b0:2bd:d84d:bbc2 with SMTP id cc19-20020a5d5c13000000b002bdd84dbbc2mr22687044wrb.46.1674470917344;
        Mon, 23 Jan 2023 02:48:37 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id q15-20020a5d574f000000b00272c0767b4asm4041803wrw.109.2023.01.23.02.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 02:48:36 -0800 (PST)
Date:   Mon, 23 Jan 2023 12:48:35 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH 04/10] dt-bindings: phy: qcom,qmp-usb: Document SM8550
 compatible
Message-ID: <Y85mA3limH9u/NHe@linaro.org>
References: <20221116120157.2706810-1-abel.vesa@linaro.org>
 <20221116120157.2706810-5-abel.vesa@linaro.org>
 <Y3TpzgQ1JaFs5sNk@hovoldconsulting.com>
 <Y85fOgfjEUBMnWar@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y85fOgfjEUBMnWar@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-23 11:19:38, Johan Hovold wrote:
> On Wed, Nov 16, 2022 at 02:46:54PM +0100, Johan Hovold wrote:
> > On Wed, Nov 16, 2022 at 02:01:51PM +0200, Abel Vesa wrote:
> > > Add the SM8550 compatible to the list.
> > > 
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > ---
> > >  .../devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml       | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
> > > index 0c6b3ba7346b..cba2a252baf8 100644
> > > --- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
> > > +++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
> > > @@ -37,6 +37,7 @@ properties:
> > >        - qcom,sm8350-qmp-usb3-phy
> > >        - qcom,sm8350-qmp-usb3-uni-phy
> > >        - qcom,sm8450-qmp-usb3-phy
> > > +      - qcom,sm8550-qmp-usb3-phy
> > 
> > This one too should be based on sc8280xp rather than the legacy binding
> > scheme.
> 
> I can't seem to find a v2 of this one adding a new-style binding for
> sm8550.
> 
> Note that the corresponding dts changes have already been merged:
> 
> 	https://lore.kernel.org/all/20230119004533.1869870-2-abel.vesa@linaro.org/

As we discussed on Friday, I intend to apply the same strategy as
for pcie. I haven't managed to send the v2 for this one yet.
The order is, UFS, PCIe and then USB. Since the patchsets are based
on each other, I'm trying to make sure PCIe is in the proper shape
before moving on to USB.

> 
> Johan
