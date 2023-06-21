Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA69F739193
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjFUVdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFUVdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:33:40 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7159B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:33:39 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-bfe6ea01ff5so1365702276.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687383218; x=1689975218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6mtJxu2dDNF02+pBprjp3JwCVt0pkUhvAR6JSdjzgk=;
        b=mgtth32W59FwEqC/Km5G2zehnzpp7m2UioIe3CZkBFFGFVGG3pmEc8DCbMGiWn+gOQ
         duF2oUW1s8ZjqzoLMQQVDC1dxpXQlWUkHBEL232UAykVCvgKKwYkOKBFOcUvZY4cUCfe
         j1qYJf7X7DPU8aulo/HefJg2wMoJU56sminRD3teMlZSKPVbEh8UWGLecCLZ5peYUqRt
         2RxGcMDdt2NsLJI4g0qHQbQCQylXYUIoJ1rk27ZsDjj6WVKU8tW80Tb/M9Re9LFrGgUj
         fWDyNSMtygFB6mQ+6OR7YdnYbwm4AN02uuBlgCxreM2I3kLDuTbW83TniXT5MsBlmERs
         V1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687383218; x=1689975218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6mtJxu2dDNF02+pBprjp3JwCVt0pkUhvAR6JSdjzgk=;
        b=FyPft28T6XIdEqzNyqFE3/IsZkJR7FgFRhX6oQflzhR/enzJaApd7/iofyytVmKVBe
         Vs72maYi/cs+v6KkBl9/6qVPK6o7fimyztxdwJsl0wjNWZyEFCMV35Ozdh68FMAiJ9SE
         BSt0KQ6HNfBCaNvOfWABrz3BSDvXO24GEXYlAQCBc9VT6xLGI5AlMh78ALgKjPCCDOM5
         a5ASaUOLutG7oRoyfHtNoG2qwG6u+X0GwoeyGJT+NJYUo//HNk6E1EC4anNf7rB8b0vH
         zANWAtxAPu6zI+m1UDZz9jj4kBGKW4ClCd5cN1+/IZbWzVLY75+p4rGkrDwPYB0VDgYo
         dNMw==
X-Gm-Message-State: AC+VfDxB/48qHxjGJ2fRaMvOAJ2ZpA57A9rlvx2eq0nXjBxAFxuv+Jsy
        +OsgHP+UOqBdSNw2g73RWu0XZ9qDs5G9XOyvVJct6A==
X-Google-Smtp-Source: ACHHUZ6YRVQLnj7llg9bunVwb1q3jiG981A5NXf2WhraolhbxfGJ49nhqWzWPwCW8k9lL42JxNfT3RZ6EwT5MlcrFsw=
X-Received: by 2002:a25:ad1e:0:b0:bd6:8725:2258 with SMTP id
 y30-20020a25ad1e000000b00bd687252258mr13318133ybi.60.1687383218657; Wed, 21
 Jun 2023 14:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230621191302.1405623-1-paweldembicki@gmail.com> <20230621191302.1405623-4-paweldembicki@gmail.com>
In-Reply-To: <20230621191302.1405623-4-paweldembicki@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 21 Jun 2023 23:33:27 +0200
Message-ID: <CACRpkdaOUp=4h0g_aZmLTtij5SuVu6_n1N_xUS_JvLidynKerA@mail.gmail.com>
Subject: Re: [PATCH net-next 4/6] net: dsa: vsc73xx: Add bridge support
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 9:14=E2=80=AFPM Pawel Dembicki <paweldembicki@gmail=
.com> wrote:

> This patch adds bridge support for vsc73xx driver.
> It introduce two functions for port_bridge_join and
> vsc73xx_port_bridge_leave handling.
>
> Those functions implement forwarding adjust and use
> dsa_tag_8021q_bridge_* api for adjust VLAN configuration.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Given that we use the approach from the other patches, this
makes perfect sense.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
