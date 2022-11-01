Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05376614DCE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiKAPHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiKAPHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:07:09 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A631DF0E;
        Tue,  1 Nov 2022 08:00:59 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id k15so5634101pfg.2;
        Tue, 01 Nov 2022 08:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gun1iY/Ev7jUkuPSB5eGYnxQ+oJQPhXUeqVegBkXHI0=;
        b=F8RZQLTL/seSsqRJF8M8PkO+NKjm4qG2RUiIZXcv8I8+svBagNBE0IRbqKT9pIM19t
         x5lGd7F36/1OJoZK1a2x7Hv0hwTSH+kSDvKDiO4trR8Lhfj07FEuPCj/BwWj/KoUGmzF
         wpFWg+SYdG68+qU0JrYa1sEGmW3H/Sug1K2Wd3JsqRi4jq3d+B0XLURxNssxslRDjlhr
         PKjLD/Uqir5GKAjM/qjZEIpln4s0FWykznAJi71WV+0yFIw4hXYe+tJxJsqcl4kBEtAs
         M7VJdFhlywnU3lg/Fke5hAo9xsF7oQ79XKj8Rk7CH0uz/G3Tu/MExhW8OgyK8eIliwXN
         3/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gun1iY/Ev7jUkuPSB5eGYnxQ+oJQPhXUeqVegBkXHI0=;
        b=QaOBHVpWW2bgkZgGpHKSVV9x7UVr3MXYtpoPCd8HNJqLFmQT1VN0VmCVhIYXnDqcTk
         OEkKaLc36fWJdKQGKkMInqzMeFrWvANveJTZ7pDYTboG/YhK8SG9cNwkGoFit++z4FRi
         MeOldv8WW/mwl+C8E0OLvf5Ewu9BfgNuHp1ZTvQui1yB80bBKmfFohBOVECu9aSEmxyt
         UHbyRZ3UwBWj3yDyOa9R2UL6e7t82Ij0iZxPrWez4ny9Pt14RXr8MvMMTxdd0s3vv/2h
         zBzuDJpspom6Wv4Lv01kUYiSezcLd9ZHXbedKmR5jql0WrakpC9/njwP3zY1QOu5CRa/
         Ywtg==
X-Gm-Message-State: ACrzQf1t6p5+1YK8Ahrwbu+ZlHiVadQPi/vJbvUConim+wKGg5D+JhE6
        Kfo2zq7DBFhM/GDmwTD896c=
X-Google-Smtp-Source: AMsMyM5+aZe/e/LqwyaP0o9+9aMalBMSzYKbdT2Y6WqjvE1WoFfK2aSORVEqoDEjsBm0zxw4r1lUCg==
X-Received: by 2002:a63:fb0b:0:b0:46f:a98b:5685 with SMTP id o11-20020a63fb0b000000b0046fa98b5685mr12248746pgh.393.1667314812821;
        Tue, 01 Nov 2022 08:00:12 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090a088800b0020087d7e778sm6048005pjc.37.2022.11.01.08.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 08:00:12 -0700 (PDT)
Date:   Tue, 1 Nov 2022 08:00:08 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Alistair Francis <alistair@alistair23.me>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        shawnguo@kernel.org, rydberg@bitmath.org, alistair23@gmail.com,
        s.hauer@pengutronix.de, andreas@kemnade.info
Subject: Re: [PATCH v10 2/4] dt-bindings: input: Add Cypress TT21000
 touchscreen controller
Message-ID: <Y2E0eFq1xZthd3Os@google.com>
References: <20221026114908.191472-1-alistair@alistair23.me>
 <20221026114908.191472-3-alistair@alistair23.me>
 <Y2BfCkVhE9GNdjWI@google.com>
 <CAL_JsqKppGZ2Dm3GiDY-e4TvLSvcc-EHwafXNwfoSD1AHzz=GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKppGZ2Dm3GiDY-e4TvLSvcc-EHwafXNwfoSD1AHzz=GA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 06:50:23AM -0500, Rob Herring wrote:
> On Mon, Oct 31, 2022 at 6:49 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > On Wed, Oct 26, 2022 at 09:49:06PM +1000, Alistair Francis wrote:
> > > Add the Cypress TrueTouch Generation 5 touchscreen device tree bindings
> > > documentation. It can use I2C or SPI bus.
> > > This touchscreen can handle some defined zone that are designed and
> > > sent as button. To be able to customize the keycode sent, the
> > > "linux,code" property in a "button" sub-node can be used.
> > >
> > > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > Applied, thank you.
> 
> It looks like you applied v8, not this version. linux-next now has a warning:
> 
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.example.dtb:
> touchscreen@24: Unevaluated properties are not allowed
> ('#address-cells', '#size-cells' were unexpected)
>         From schema:
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml

Oops, should be fixed now.

-- 
Dmitry
