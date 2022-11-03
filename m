Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C001618605
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiKCRRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiKCRRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:17:09 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF22A2F4;
        Thu,  3 Nov 2022 10:17:08 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so5875565pjk.2;
        Thu, 03 Nov 2022 10:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jMLMgTZnXG3qE89gvGIdlg9xWS4kfSGRYT+JSAUdRFU=;
        b=BgB2QdomzPzge4VbrqFYuwzmD3h1QhxfbsY4GqKYtF5a7n/NJTfmNYMPOXy/hbqOWI
         UOogT5U8gyicW6RQR/+0gY1M5xA06FG71qdz5iPYkpXjkd8COGd6E2KRPV/wJhK/hn0T
         91kPejzsqsK6/+/s8S3Ya4F6JXYNJCFwcE0RmL9LN4LgpLulk8sGgCby2gcfyRjPHGoe
         dNGSpDbtye5tFxt1gNOkjao1EjHsmyUC3l2C0CqCKRCZwq9rWrfOQdV4Um3RsRQ6Lvq/
         98nWPLYjLm7G2YQ3inoFWS4IrlRIm5o311J2uVLnqg75THYPSf2Ql8OZ0HAVZrMVTTcN
         6ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMLMgTZnXG3qE89gvGIdlg9xWS4kfSGRYT+JSAUdRFU=;
        b=2FgAn38WhSWWw+eHyrTO1A3zNlSOMLPNNLMvY2Fkg8zJ02J3VfSj0AOicpTAXfEdmd
         rhwWmAPpz2sLhdI/OvI3TlUFD7xMuTmVxU2otZoLbIAJo5ZLApLizBaLp1o0pfpy4fGV
         2qRIXXZChmOP34IvkhySQ081I6PzUonS3/2jWbar4kP//71G21o9B4nXeSVWCi8pKo5h
         jfXDr86GNec6I9y2Hd+bMXOfSUNjywkxGQkUWnWKbn0nYLSnAfYmpSKQLB9M1Qntiw84
         Bq4psa7VvK5C89nhGUjCcvpj+8UOm/0DuEKO6Ug8w34P+uBF/WvHCXq7+jkG9Fg4cHm5
         1e0g==
X-Gm-Message-State: ACrzQf3XUzLRveE5Lz8yZv5dPDOdWStjIstJWd5Ay8Jwb8bIEevlNgE3
        z3SYNH5cNNg5+Txzp4PihCk=
X-Google-Smtp-Source: AMsMyM4KXsk3pLBuAZJaQZE/nBZ7r1WJ0vPUvs2KpVzcs1jk2iH8wiq9zdv9D3GGG8xHFXhOLj6fbw==
X-Received: by 2002:a17:90b:70a:b0:211:f163:ddff with SMTP id s10-20020a17090b070a00b00211f163ddffmr31949799pjz.202.1667495827938;
        Thu, 03 Nov 2022 10:17:07 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id d14-20020aa797ae000000b0056ddd2ac8f1sm960026pfq.211.2022.11.03.10.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:17:07 -0700 (PDT)
Date:   Thu, 3 Nov 2022 10:17:03 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Quentin Schulz <foss+kernel@0leil.net>
Cc:     hadess@hadess.net, hdegoede@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, heiko@sntech.de,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: Re: [RFC PATCH 0/7] fix reset line polarity for Goodix touchscreen
 controllers
Message-ID: <Y2P3jyz1L0yKsCk8@google.com>
References: <20221103-upstream-goodix-reset-v1-0-87b49ae589f1@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103-upstream-goodix-reset-v1-0-87b49ae589f1@theobroma-systems.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Thu, Nov 03, 2022 at 03:43:45PM +0100, Quentin Schulz wrote:
> The Goodix touchscreen controller has a reset line active low. It happens to
> also be used to configure its i2c address at runtime. If the reset line is
> incorrectly asserted, the address will be wrongly configured. This cost me a few
> hours yesterday, trying to figure out why the touchscreen wouldn't work.
> 
> The driver is "asserting" this reset GPIO by setting its output to 0, probably
> to reflect the physical state of the line. However, this relies on the fact that
> the Device Tree node setting the reset line polarity to active high, which is
> incorrect since the reset is active low in hardware.
> 
> To fix this inconsistency, the polarity is inverted to not confuse the user
> about the reset line polarity.
> 
> This is marked as RFC because it breaks DT compatibility and also the Google
> CoachZ device is the only one with an active low polarity for the reset GPIO
> in DT, so not sure if it is a typo or its state is actually inverted (so GPIO
> active high to drive the reset line low). Changing it anyways since the polarity
> is changed in the driver so it needs to be changed in DT too.

I would like to get gpio handling into a better shape, but the above is
completely incorrect. "goodix,gt7375p" that is used in CoachZ and other
Google designs is using i2c-hid compatible firmware and is not being
driven by drivers/input/touchscreen/goodix.c driver, but rather by
i2c-hid + hid-multitouch combo.

You should not be touching arch/arm64/boot/dts/qcom/sc7180* at all.

> 
> I'm all ears if there's a better way to handle this. We could document this in
> the DT binding but this kinda breaks the promise we make that the DT is not
> bound to the driver implementation.

I think Hans has already voiced concerns about x86 devices using these
devices and having GPIO data encoded in the driver, so we need to
accommodate them. On DT side we can add a quirk to gpiolib-of.c to
[maybe temporary] override polarity of reset GPIO lines, then update DTS
to match the reality.

Thanks.

-- 
Dmitry
