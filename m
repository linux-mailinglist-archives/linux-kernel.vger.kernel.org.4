Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A512073917D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjFUV20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjFUV2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:28:24 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF1810CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:28:23 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-bff4f1e93caso986132276.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687382902; x=1689974902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I23QwpbRVC93I2xN0J8C9PPNt1nuyTNz6gUJBDkbm84=;
        b=copINrrPigwq5XhYM0SrXJMptbcqpEzn+RkQM4XMh3yKWGKY9ONl1YvTPhC3Z+Ikxp
         YQqob2hF6oFAB5uT1bjoNbOK4Q+vd1uk0a0mvxrjoULfEfq4ubxQBg258ewBeDabFQfp
         TJKjbcbMYiTJtrSlXGCDgCyl5FlfqU3K5Qf2Y3IgViEbAFAGET4dMKTuC3ivF8GmNl1D
         OzmWfUPRqYLq4g/f24oe5CkcEZwzlcYtqUSHVDU24tyK2iuSDszNSEfYI2uzXXqpNjoL
         ptR+ptbrjuZ8l22N0ShYP5Tp05IfhKVRGe+2yy1BOavGWypIoS7gQ81kpsd+zj6RJaM5
         cw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687382902; x=1689974902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I23QwpbRVC93I2xN0J8C9PPNt1nuyTNz6gUJBDkbm84=;
        b=eKFMMClFr0ew4UV3C/PQU+2QoecXa9Y2ZNkIA2Vuv+WdnYqo5GZVPk07XOoKPrpxzl
         2lsGeboBAO0DlOxjTudezYxmM5DjioOIkitBk+uEREhJwAtVGYt2a+RfuwS7N/Dt5cMi
         5UZnIoNjt8DNpn6jNDqi+IlTcXJxOUs9z/pWsv67Ib2LXc8ehqtHBHuw4o6Q/OOvx6SB
         iYFfYby9/EA44CyGyaHCFDlh8DuN91/r8AsYN1YkTAgRUSDJ0+nkCGqL4sBfR7G58zeS
         ARaaITL4OU2XyBqpCNbM5tZn1O7c9HhbxJMM60wSe9bkr9VXo19piaqXvHbDu7l1WiFe
         YCRA==
X-Gm-Message-State: AC+VfDxngGZ46ybV1cz21ZTEyDv+vofjvq8G/NiaPoVWoVA+H2b29Inz
        DacncowXxBn0867PS/6VlhsXMLgVGlkmEKiFoiLf3g==
X-Google-Smtp-Source: ACHHUZ4yERI5vFsl4RR99IkTQFRJT6kLO4bTKnqG2lAKzNozcmaIEuZz/O0vXYKegBPiwDcRHCIDPhtvjxixs6ZIqCc=
X-Received: by 2002:a25:df84:0:b0:bcc:f2cc:73e with SMTP id
 w126-20020a25df84000000b00bccf2cc073emr13862828ybg.22.1687382902657; Wed, 21
 Jun 2023 14:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230621191302.1405623-1-paweldembicki@gmail.com> <20230621191302.1405623-2-paweldembicki@gmail.com>
In-Reply-To: <20230621191302.1405623-2-paweldembicki@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 21 Jun 2023 23:28:11 +0200
Message-ID: <CACRpkdaAgW+ya50AHTi7QZqLe_HzFDZD7km5ieViruv-GCCHtQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/6] net: dsa: vsc73xx: add port_stp_state_set function
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

On Wed, Jun 21, 2023 at 9:13=E2=80=AFPM Pawel Dembicki <paweldembicki@gmail=
.com> wrote:

> This isn't fully functional implementation of 802.1D, but
> port_stp_state_set is required for future tag8021q operations.
>
> This implementation handle properly all states, but vsc 73xx don't
> forward STP packets.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

I think it is a best effort and should be merged.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
