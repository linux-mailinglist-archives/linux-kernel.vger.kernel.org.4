Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A64C739196
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjFUVem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFUVel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:34:41 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544E71BC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:34:40 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-784f7f7deddso2059865241.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687383279; x=1689975279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERhjKrk8uNuT8fJftN6Wzv13k5nYu7dMLPTKhrBK3z4=;
        b=aYGnvnNXHBjMNbmulhIQhX8SaBIFKZ7yqzr1tKO4nLxmy8HFg6SE992IK7obG5rzCX
         jCUPt3cDMPKNPy5VyNefi/qW8u6xg8+lwSNyuf4nD6xlaeNRYlVPiiI/RtQFnIoHu5E1
         XzubqUR3Dl/e3+ExdXUqdvmi++G3kxt9ABtmRHD6WSP7WSuCtnGSwmBCW/HLnLqQDmPu
         P6UEpiMLCtflVbUnB7RSeZMSB2skbjC+L7XwusnWiBOxWUZCFJrrOzd2A8ciwEi0EyeN
         pm1DS4rka5jemYVxM8jUxmFZwMdUMJ5XI5goq5HOt8i67BUbRf4IDhhdvwFxIg7KRzma
         XPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687383279; x=1689975279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERhjKrk8uNuT8fJftN6Wzv13k5nYu7dMLPTKhrBK3z4=;
        b=T3jjqKB2Z9m/l53V5OJQZR7hmwr9xluCMZoGx2jEGv5eY6EfXpjVL2bipL1Mxk/4o+
         B9VL3M6VsnaADJE5OLVI99B9y0/xHwH69XBJVlXuhRQc5w8irOTjuwhJKbVMnHSioReU
         /KnMCAdliB4ES/GxcFOYvOsUzR8/3JcoC27/4JA4zsSJH26eOEMYWXrRHxSygQz5W5Jj
         FZTiH3/tDqPJeRvdo27D0wXh7ZklfT+f1Ibznm2ThEMywQdjum+4M7ip/pvOl7rqYRal
         HqUihIXz3WU6YRYKy7Z0Pd+ELO7bIiYhg4QLMspLNIRYccFbWf//ckKLkSWpBkSGMxZ0
         N5ig==
X-Gm-Message-State: AC+VfDy6raXoU+obv9ObL1b1n1Z3Tl7YaIwik5g6qX1e8YsbbN92rEsv
        7/7lFfgZs85HkbB0LHTcAYY4PqfylPZHApXowUGftQ==
X-Google-Smtp-Source: ACHHUZ46aDuspJOarRL79lYzMGYqEwkTT5JRnSSANc5yEURsqqhVLj46v6MxmEOQjpuP2GHM1lq45BhbCoWHJISjTgk=
X-Received: by 2002:a67:f6c2:0:b0:43f:58a1:b22c with SMTP id
 v2-20020a67f6c2000000b0043f58a1b22cmr6794552vso.16.1687383279464; Wed, 21 Jun
 2023 14:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230621191302.1405623-1-paweldembicki@gmail.com> <20230621191302.1405623-5-paweldembicki@gmail.com>
In-Reply-To: <20230621191302.1405623-5-paweldembicki@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 21 Jun 2023 23:34:28 +0200
Message-ID: <CACRpkdaZC9AWRMv-=sQH4DghD3H6WO_9JTdJ4jg+EbM+WAEeKg@mail.gmail.com>
Subject: Re: [PATCH net-next 5/6] net: dsa: vsc73xx: Add vlan filtering
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 9:14=E2=80=AFPM Pawel Dembicki <paweldembicki@gmail=
.com> wrote:

> This patch implement vlan filtering for vsc73xx driver.
>
> After vlan filtering start, switch is reconfigured from QinQ to simple
> vlan aware mode. It's required, because VSC73XX chips haven't support
> for inner vlan tag filter.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
