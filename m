Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07EF739165
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjFUVVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjFUVVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:21:39 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26328197
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:21:39 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-bff0beb2d82so1062257276.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687382498; x=1689974498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJhQ30NhWl7/OdcQCb1MHwxXooSD4x+4fGnUYsMhMUA=;
        b=Kaoxs46Myw+gTIY7JoDCzA4dtBwXCgc373+VVL+dIq7Oj5waVGo3c03H81SlwqplpZ
         EM8MaYG8b4A10sVSATHlaL1VCYY8s6gx68AiwiSmedCnZEofbFE+CKL+QSMMZsoNUxMe
         lkELCTen+n/oI3zy/91IdoKUGgaNRBzWyAAJo7aT1NfjNd9MDvUTviChBIda6T3PrBbR
         zozKQvGIWnaR3Yt9hqy71fB79o43fdkf84VutOEZL0yYyI/aVdWLENVIN77doiUWfJQ9
         t+r59kXS/Sr8miohDnwe/V219KJWXdfuD0Lf0/tE+Dqep13kOSqVlyhRv/JupT5BldZz
         Rxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687382498; x=1689974498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJhQ30NhWl7/OdcQCb1MHwxXooSD4x+4fGnUYsMhMUA=;
        b=KD39DUh4ASTfNu2WKeyz+4xdrsQS+VQz8IxpfkQBfUX6hJwETBXOmM93HGSOaemGbv
         VzR6p4QCUSccUuZM68f5MUv7Y3AsKjMjaRjAZlUc3172YlLKMCz7blBM/s208w7ibBT2
         CqqLLI28QyNXBzH6W+fYm4fSNWvgtktmkChHFxgkD/EEKVatSMYQO9Fez7nxGe1hs36m
         f+061KC8XAru7vzXzEnGrnVDMpu1GYDxDW8tWWncDUJqeO6VfqeSSRHfcCgqfy/5NuCH
         XqUIUrCd4XJvbEVpagJQaY8FWiiZb+2L6Lv174G4M425sAxZk+k6XygN7PjbfxstQC4p
         Zj3g==
X-Gm-Message-State: AC+VfDwQIp/uoHZncDF/miRbqa53adsOi010vGbGNS6UIcanmOdSMA6q
        e+Y/L+8kv9ag+wHizqD7keUKTdsae+C+2sikv+z3jW7CVjhhDXaV
X-Google-Smtp-Source: ACHHUZ7u1AWWojXutb/GAoUzEygsCOrr+vVHH4++h1ueHhmP4IsLVnyaJCcNPk+wFTdOdGUCah53b1tymvnSmBRNANE=
X-Received: by 2002:a25:d791:0:b0:bc4:78ac:9216 with SMTP id
 o139-20020a25d791000000b00bc478ac9216mr13482172ybg.61.1687382498350; Wed, 21
 Jun 2023 14:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230621191302.1405623-1-paweldembicki@gmail.com>
In-Reply-To: <20230621191302.1405623-1-paweldembicki@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 21 Jun 2023 23:21:27 +0200
Message-ID: <CACRpkda4N4U73Q=qqkAh4QmcXjM3KuZK_Mp3DzZPCMATy10PMA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/6] net: dsa: vsc73xx: convert to PHYLINK
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 9:13=E2=80=AFPM Pawel Dembicki <paweldembicki@gmail=
.com> wrote:

> This patch replaces the adjust_link api with the phylink apis that provid=
e
> equivalent functionality.
>
> The remaining functionality from the adjust_link is now covered in the
> phylink_mac_link_* and phylink_mac_config.
>
> Removes:
> .adjust_link
> Adds:
> .phylink_get_caps
> .phylink_mac_link_down
> .phylink_mac_link_up
> .phylink_mac_link_down
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Thanks for doing this!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
