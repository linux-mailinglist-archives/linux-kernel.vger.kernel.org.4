Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0656BAA63
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 09:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjCOIEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 04:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjCOIEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 04:04:35 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3310823306
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 01:04:27 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id n125so4541956ybg.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 01:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678867466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+zV0RFa8oIGvR8so6Lb7nDRwP3ctkQ16ptH6NCpKUY=;
        b=qY5/Bw8dUq8MYbVZia3UMIeCV7qmnjHMeYaTOQE7JWUOdLDOKn/fJcIYEeF6Z38rs/
         deLSzQtS7C1TnR/+RkrI/pTtP7iHJXvo1DWjAN1eoxk650NuTFz4TC7s+pZgRjVBdctc
         us9fn/LfZxkpV+RoH5rGoSJqHyyJyrcG9RNFwomxDFBpEi4f6xB5r1X4ONTnw6Al4GEK
         Zu5K5kA2Zt6f3RVWqsN1xjC6LX1nAgGk3yjMI9A/1VMsRqVpLnEzpZSVA+YwAMi9AVZi
         b8OsJDhv0ahJgtgNFF3T9brcT1oduLiHHMXrmIUE/zInum9bpOBb8kC588KZS/l4O+fe
         H0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678867466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+zV0RFa8oIGvR8so6Lb7nDRwP3ctkQ16ptH6NCpKUY=;
        b=Hdzx2FzQh4PndVf6ocbeRyObz6oAk04DxqdkKOfyPCDPAM5cRR+hBM39Jio25JfX5F
         FnAYEZOf0bsdDjskgpBkn1x/vaStEl5olEKClrMnbpTzV0SFGpE4HsaY4LOkBt/bKhGu
         MKtg6jJhg7POJnv6GQR4FuYS3MdCaOl/v6Gyl9dwnG03v2pX7Q4Ks5O4QexKn6uDsBSr
         BPftrq2vpJ9KM8H2rxgIPn9HEUzLbpfslC8oUVikcG/C5GeWi4uNdqEOafoKNBBYMN4M
         W4eOPdz9D3BoyywPd+wThOxSMyljMWUMxEbyoUV57RoNt+ctDZ5IhYKlIi7afdyqvEEc
         6kUg==
X-Gm-Message-State: AO0yUKXWO2woLB8BowE2JBA2jqDCOSOT8T0ECWHCqivEXlhum0bjAqOa
        fQaqbD6yKEmIxo+qVYgKQt8irtRZkj0sjWLzXictdg==
X-Google-Smtp-Source: AK7set8OklXSPGzCdENW3Fmdkp8oZ9PjQvODAAlE8618tRjhBD249J3mc0P/EGE19AQZWSLy35WGJ+YXjJy+I1PHQD4=
X-Received: by 2002:a5b:1cb:0:b0:a6b:bc64:a0af with SMTP id
 f11-20020a5b01cb000000b00a6bbc64a0afmr25410441ybp.4.1678867466394; Wed, 15
 Mar 2023 01:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230314225535.1321736-1-sre@kernel.org> <20230314225535.1321736-11-sre@kernel.org>
In-Reply-To: <20230314225535.1321736-11-sre@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Mar 2023 09:04:15 +0100
Message-ID: <CACRpkdZ0j8HQzzXtDbVcxAJkBsdRXUKNJm3BmLB583JfnetAWw@mail.gmail.com>
Subject: Re: [PATCHv2 10/12] power: supply: generic-adc-battery: add
 temperature support
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 11:55=E2=80=AFPM Sebastian Reichel <sre@kernel.org>=
 wrote:

> From: Sebastian Reichel <sebastian.reichel@collabora.com>
>
> Another typical thing to monitor via an ADC line is
> the battery temperature.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

>  static bool gab_charge_finished(struct gab *adc_bat)
> @@ -115,6 +118,8 @@ static int gab_get_property(struct power_supply *psy,
>                 return read_channel(adc_bat, GAB_CURRENT, &val->intval);
>         case POWER_SUPPLY_PROP_POWER_NOW:
>                 return read_channel(adc_bat, GAB_POWER, &val->intval);
> +       case POWER_SUPPLY_PROP_TEMP:
> +               return read_channel(adc_bat, GAB_TEMP, &val->intval);

Hm. I wonder if these should rather all use read_channel_processed()?

The difference is that you will then support ADCs with internal scaling
which is beneficial. Most of the time it doesn't matter.

Yours,
Linus Walleij
