Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FB96BB43E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjCONPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjCONPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:15:41 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36644A2270
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:15:26 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54184571389so218460187b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678886125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKgeEmw/6W0SWieMcWQ02VSSFIpAhVBllMmTeozBA90=;
        b=vnKbivHAWG4rRuutoxN8eNw484KPYMNhikRTBCt8G/nWJuT69AWcQiGAq8f69sOa6u
         z0xnNp6NlQJ+5qJQ5XNP1rwgAEwQkJaWScn+EXWKbsPqx/VDj2x3Kbs8usgF/oxIIyOD
         thzxE07NGt8bNJsMIpQ8TDvtzffeR47nm0n70N2+rpwrjyhwSUgxwNU/liuL8+3UFEi2
         2vok6HunFiuEViEPIohmbPY9mVjHqCY+tN6e9Z2EZiHfhgwo5xor2AemgU0zrwpVzlKu
         iVMffQO0GexUOU7LAIn9v/lVZ2wreHQyVOCiGbXnQzCpAqN05aJAo7UxjcUWuqY+CC45
         8NAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678886125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKgeEmw/6W0SWieMcWQ02VSSFIpAhVBllMmTeozBA90=;
        b=h1SU7cX55yNvyv+s7q11qd6O18ovZDcJh4skF4WeRMnZEMN33cY43TcSHEWQtDCeil
         wUb67W1DHcu+9qBvkbVXJAjTcIQKOUg7bv7QcCK8c5aLKPNZcPCBmuniqJoPRHsu2unz
         Nb6naHLnv+5bI+sHvPhf0fZsAiu/FDPpvPF6panzia5+hp/cRCqDxrrVJs4LaeUCHbSh
         9a6zXDyxweQuVhCeZqVljDRBCHSpaN+73TeLB2Pdte+Uz187wOrkA/srQoNoE6ONt8nC
         K/rwcHrFlis1JPNPFwHySq3EpRVzN4vCSpHYLaVAItVp62AsMYUv8H+j9mm7w9J9OcDp
         9FvA==
X-Gm-Message-State: AO0yUKW7UUvVI2ycv+vnXZX/+yj0JC4h91/83pXI/CABpn9r2fkR20of
        nayUAfSb8lkAaJNb+7vsqmJGYH6lQPM1gCVbMaiXaw==
X-Google-Smtp-Source: AK7set8wwlb4JftADZ2nivxvmDTdDwmo8imStsXd2xZrBkPcNMUIXCXOSzOGwgYGRe3Ii1cmgJgP/sIa1U6H5U0/7wQ=
X-Received: by 2002:a05:690c:445:b0:53d:2dcf:890d with SMTP id
 bj5-20020a05690c044500b0053d2dcf890dmr13772804ywb.4.1678886125155; Wed, 15
 Mar 2023 06:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230315130917.3633491-1-a.fatoum@pengutronix.de>
In-Reply-To: <20230315130917.3633491-1-a.fatoum@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Mar 2023 14:15:13 +0100
Message-ID: <CACRpkdbowrfYZpNKA32S8GT=8x_h+ZW4gd2Kj6FZkP1SZmDEPw@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: dsa: realtek: fix out-of-bounds access
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, kernel@pengutronix.de,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 2:09=E2=80=AFPM Ahmad Fatoum <a.fatoum@pengutronix.=
de> wrote:

> The probe function sets priv->chip_data to (void *)priv + sizeof(*priv)
> with the expectation that priv has enough trailing space.
>
> However, only realtek-smi actually allocated this chip_data space.
> Do likewise in realtek-mdio to fix out-of-bounds accesses.
>
> Fixes: aac94001067d ("net: dsa: realtek: add new mdio interface for drive=
rs")
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

That this worked for so long is kind of scary, and the reason why we run Ka=
san
over so much code, I don't know if Kasan would have found this one.

Rewriting the whole world in Rust will fix this problem, but it will
take a while...

Yours,
Linus Walleij
