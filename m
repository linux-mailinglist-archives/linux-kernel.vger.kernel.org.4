Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C68E613F0E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJaUec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJaUea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:34:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AAC12D21
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 13:34:29 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n12so32272815eja.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 13:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dsp3vKZHMgvy2ZaBOBHTAANbpVIvX0BBnL2C4mQELqE=;
        b=BkSeJCIgiNSHZmpS3d19qfP33bZMAbAn1YH2THLYyH+QzW2ocW2cmLJaKhPOVe2Df+
         YoFtsWQ4saN0WcQJ8Sp3Y2YEp4PatkaL+Te9PyV3nmg7StrDm7XbBtgB83+/lDCZBu3E
         U644kx4TFBSnda4mdPcx87BIJrwSYY/CV/lPCkDr11JEHJtWI5YwgtQQgLg9Ou4g4Nfn
         6J4wUUtyz7+UQDguDWa95sbs38sA7qV5Q/711+i0BmxEa+xD6CKFewJEw35OA9BodeE5
         GaBOArTKjg0kwFCZMN/85qml0TyFDYDgD7xDT9VYKtbYj1qRNSwRMsBiO0dBWwE2EDuf
         lNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dsp3vKZHMgvy2ZaBOBHTAANbpVIvX0BBnL2C4mQELqE=;
        b=cR/Con+Q55TYYNKpbJmevilvW9lu+jRATGYdSKw0RnLibBCq0cjvTZCstWzwdXfawp
         DlBsgpiBXOnRXvXXSUcl84BzUaIH2bV0toNJGjeIYTcw/eD+fTCFGaWCT/TLR2BYu5zn
         PsUspieLwN3uv0lpSsbY4pkNt1pkyUeIyujgxpcIm9UZani9tE6IYbG+114zNLBkc/Dd
         3gCOD40TnaRsSKBRLQazFq/j2pXSda7tPrgRijE0QUgRM1N5T+Qk9OopStU63HKsglRI
         dRI770KNKG4pDYisJQlT2BXanx3ijaGEuecx40Gi+7mGT3zSdA53w+yQcBRyzbfx4bS4
         KErQ==
X-Gm-Message-State: ACrzQf3LttVS8B0Dvn5uwIyvPPYpgiTh0GViNr4H7yGPh8S0xpumOQtX
        Y8pWgunkiltmnpy+HRAxCSb9+svrQXm0Knt4l8w3aw==
X-Google-Smtp-Source: AMsMyM4h4xR8ejfUMsp5LserMBr0wwRu/+V7iszigRYVIhPUXULQ15K0r0Udv6GSb7nVVqLh75MTsvmcFRTdo6kkGsI=
X-Received: by 2002:a17:906:3394:b0:78e:11ea:8528 with SMTP id
 v20-20020a170906339400b0078e11ea8528mr2901eja.190.1667248467919; Mon, 31 Oct
 2022 13:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221024121601.156514-1-ulf.hansson@linaro.org>
In-Reply-To: <20221024121601.156514-1-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 31 Oct 2022 21:34:16 +0100
Message-ID: <CACRpkdacfO5DEbRpg94koMDgHrOkn1vpymzP91OeLg3h3B5sHQ@mail.gmail.com>
Subject: Re: [PATCH] amba: Drop redundant assignments of the system PM callbacks
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 2:16 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> If the system PM callbacks haven't been assigned, the PM core falls back to
> invoke the corresponding the pm_generic_* helpers for the device. Let's
> rely on this behaviour and drop the redundant assignments.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I think the AMBA patches normally go in through Russell's
patch tracker.

Yours,
Linus Walleij
