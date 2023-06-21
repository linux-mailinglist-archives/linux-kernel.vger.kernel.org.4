Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD420739199
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjFUVfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFUVfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:35:37 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751811B4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:35:36 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-bcd0226607bso11064199276.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687383335; x=1689975335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8a9oVKOS3hKiaurU+C8B/jf21qpSFSdbTRfDL8gXf+M=;
        b=QyXdhBwxRQYaHsD8caUiTbIkKW2bksY1ZMBQROy87n8W67UkkMRKDyO/w8J1+cItRX
         u9h9HbgEZEdBNKmUZZytziB+ZWsC8WFpb+2xQmchnbGd3k5w6KylfhE++iW2n9WzrUo/
         sRZCGi6dkk7pai/citsVzqIqionwaSwUFCxWitNy8soIMhTO0vAL26YMdWD9K7rNDZj3
         Kuf+GlRAjtz8pJ9woo86PwBVUA61y6JufkEURLHDwWUhk/VC9NE0V2OCLcb1VEq7y2bt
         fOiCqGzMi8wTi4KOYvg8nRomJ0v41XFZ1ZnpKzgKbGYtyJQiVKB5jWxqBbkqgPyEHb7/
         7BsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687383335; x=1689975335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8a9oVKOS3hKiaurU+C8B/jf21qpSFSdbTRfDL8gXf+M=;
        b=Orce2iu1lCg5vG9RjwmrbIfatT4oscJ1Vhw2osDjvRhY5s65FpQeJT40nH2o33XNzf
         4Cx+rXyehQZYNzkbxu6p24V1KaV1xIMXjDBbN+Feil7uq242/3G/WFNXdpzO7VAzsetH
         KBxTBNEWy8CxjDs5KfpiF1EuYT3ZwxJr4J7zt+WKBw5yNcpJZU+mHSxoWTxK8kfh8WHE
         Phq9UmFROTtvk6VOdkKZPU45WWiLNpeCJz5oeNTrBuBDBmOmYoK+k8NSfClJLPEnJOLu
         Zir8xMBr7b6fj9zCDqv9S7qv/MncBAinCG8UUuZ/lTuUVo9ehFH1nU7D7ZO2e41fHJPQ
         9N6A==
X-Gm-Message-State: AC+VfDz5OR/eN0GkjVyZmC9WjRkAhOCTxkZrHJjV3S4npvJMyh8EtlIJ
        UtvJJVPC5an6+nrZxGFtHHDraLEQ1VunqjMuY/VW1w==
X-Google-Smtp-Source: ACHHUZ73Y7ww5KI7+S1wZpvD/2S7BPuJld4uWbQgfQLvmOJfdP1VL9ryh8Il7M0BRloVqM1kbxjhL04BYBQ8SjeJD5U=
X-Received: by 2002:a25:42:0:b0:ba1:6bad:9270 with SMTP id 63-20020a250042000000b00ba16bad9270mr15933237yba.27.1687383335686;
 Wed, 21 Jun 2023 14:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230621191302.1405623-1-paweldembicki@gmail.com> <20230621191302.1405623-6-paweldembicki@gmail.com>
In-Reply-To: <20230621191302.1405623-6-paweldembicki@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 21 Jun 2023 23:35:24 +0200
Message-ID: <CACRpkdafXbhW3=6kAS0h6YjiOCcDa_zwhRVVRcun-GNPbroasw@mail.gmail.com>
Subject: Re: [PATCH net-next 6/6] net: dsa: vsc73xx: fix MTU configuration
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

> Switch in MAXLEN register store maximum size of data frame.
> MTU size is 18 bytes smaller than frame size.
>
> Current settings causes problems with packet forwarding.
> This patch fix MTU settings to proper values.
>
> Fixes: fb77ffc6ec86 ("net: dsa: vsc73xx: make the MTU configurable")
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Ooops my bad. Thanks for finding this.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
