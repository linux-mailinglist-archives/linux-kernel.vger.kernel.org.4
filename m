Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52366C0540
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjCSVI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjCSVIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:08:53 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9CA16ACB
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 14:08:50 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i6so10872468ybu.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 14:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679260130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfSyRT4jJwd9W24svxQ9EDCyYtC7di4+g/hlpe+rd8o=;
        b=m0FmP+q5r0iJovOIyHQxjLzwz38FdQRSCWtfuPSD1WNLnjtq5oN4693rM4zrxwObKS
         N0RcuBNpe/1iR7NZX5H5M/1HAmX+BHI1v4Y0RXCQ0/PUeleczBC2xA7RIhStCDLQZZ5U
         H1NYuudO+FSVB0zEJOAjIGc0kdGbHK7Pl/c2hRX6G6+X/k9xSGVsnJriV8ZoTtZY4JQG
         nvpys8YMPPa4If+tz/DQrMaRS4n1GpX7YQW8yveZEkTu5Zpd4VBPgwWLuqS5PZU7ammX
         4cDogbDh0tL+pdpxP2Bh6uumAWIb5pC2f1ikXP+2CI4J1bxg1KnQZYhhDg/f63dQNoW+
         Gwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679260130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfSyRT4jJwd9W24svxQ9EDCyYtC7di4+g/hlpe+rd8o=;
        b=kBxsogVGGctQVKugvLADdLjJrRAlkOiRMLdSML/Kfl+R8W6N5oUZJKz4vgA8c25e+W
         MrUgyj0GXWi3EzEizfjPIFh7d2/TSSWWIgUR2vfiGQfRXsrWOrjCBV2zjtnF8NLA7dw3
         4XkIJRFF1HCcd1J5pBlSatS0hgzzZME34jTdLpf1QzpTJAzQWWgzI+qt60cEu+8rCK5g
         +gnb1rITv6FJeQ9IRNAUd3tEBzY5YSYsJBFc58EDQqPmWgArvHCZMn6LVMRFYPcPnuuN
         y3meSLOc9shC5hA+jXgcCCkwDRn7nbnRBlmHJcZTr2VNNW/WV6vYJpspIR5iW1d3Zbjt
         BIIQ==
X-Gm-Message-State: AO0yUKU88Jao3wsdMocqHRhZbWhi33Vk/vpyBj4pFlX4C/flWttqVkvp
        iaZPXP5FHZ6XnvCdhL57go/q2ah+C2WYg2/wHqX05A==
X-Google-Smtp-Source: AK7set8tqfgMfikrp6PWWSvzsGlguYVorCR3NvJYNPvGZiy72l1HII+50LrB3R7O02q5Sw+NRIUpn5WvZUN4F9ZBpDQ=
X-Received: by 2002:a05:6902:102d:b0:a6b:bc64:a0af with SMTP id
 x13-20020a056902102d00b00a6bbc64a0afmr4120603ybt.4.1679260129834; Sun, 19 Mar
 2023 14:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230315215027.30685-1-asmaa@nvidia.com> <20230315215027.30685-3-asmaa@nvidia.com>
In-Reply-To: <20230315215027.30685-3-asmaa@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 19 Mar 2023 22:08:38 +0100
Message-ID: <CACRpkdaayJ6aO4weq8uAJqOcahQ16PW1Xez6pwgeapB6e0feYg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] pinctrl: mlxbf3: Add pinctrl driver support
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     andy.shevchenko@gmail.com, bgolaszewski@baylibre.com,
        niyas.sait@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 10:50=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> wr=
ote:

> NVIDIA BlueField-3 SoC has a few pins that can be used as GPIOs
> or take the default hardware functionality. Add a driver for
> the pin muxing.
>
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>

Patch applied! As stated earlier there is no build time dependency
between the GPIO and pinctrl patches so they can go in separately.

Yours,
Linus Walleij
