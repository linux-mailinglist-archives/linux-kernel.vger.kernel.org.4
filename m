Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AE2704F68
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjEPNfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjEPNfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:35:50 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175143C06
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:35:50 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-55a14807e4cso243566117b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684244149; x=1686836149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1yAAOloDNM7X0iqPZL9223AhWrL8SIh2nCxErMOL2w=;
        b=q3UJKqo3MBw4y1jWGgtncTa0nyxwIRafjaR57UdmvvJXYCe5uC27Q6y6H8u64nRjrR
         lmNvxzgE9FGjNnPUEAyHFjC8L3TvTOvvYDJxWwrlIALzzlreRxDvouIulSLua7pDzmvj
         HmCPc6vkal6BjaUgxKXv/YYm2oD+53V8IXfbhlNYvlqi7zeaVn+dPo72wKxvaPxNvwUp
         V9Mu2yoQS5BJZK6vxPcSe4gztq6hOWupyZ/moFEVd1FxHN5TjM0QqCHyuX4TfkaXkC2b
         09bcMri9IFaww/9VK6BO9cQH1WP93kCKSlME9g6N6WUaYIjJYdP7BwGjJJUU7sIQV8Uf
         swJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684244149; x=1686836149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1yAAOloDNM7X0iqPZL9223AhWrL8SIh2nCxErMOL2w=;
        b=OZD9OxiPjNUkGDulfuKwusbVspIR9g9YAlYwVToWcYtUJp5pGUgyWy9O69QQBT/aSM
         F6FXKXX9Q5WdCbu2Vy6GjPbC8onEBlh1aiFTiGJ5kDQzrMzDPkquwcHonj8o/bg5XaWM
         4j+Q2Zdis/uSeb9kyLNBT+gNiUq61bra7YXqnwgQM08qoJRcq5JLhA1ixl/IppkThFK5
         Zb5c9PhrWLib7Q072s4D9l0Ijn74/8Wt/231hyN+W/6mAoEtmAuvn7/lF4faaHfdOVag
         oBVG6gdlWH5e3oh3DgrYfF645kAG2HHaQRPrx+h/bIw/bSuzHhCSdMENI/qKwsKbLcqO
         uqlw==
X-Gm-Message-State: AC+VfDy7Pej+wp0+3rBx3Bbrre2iDsdt9LbQDPlPvBBzCV55Pk4J1uCr
        rUBlvUto8yP7vmTzWnEGr4uJRcL9k0gLPMz1TxrTVw==
X-Google-Smtp-Source: ACHHUZ4uHc9B+/Qvhk9soY/Pz4CS9+qWx3ZmruZUsWf9Gwv88ZJ9L3AXfS9fMw3ZH3rfangkqNcoojQNltq36qBuOA0=
X-Received: by 2002:a0d:db93:0:b0:55a:2fbb:4790 with SMTP id
 d141-20020a0ddb93000000b0055a2fbb4790mr32697225ywe.12.1684244149273; Tue, 16
 May 2023 06:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230515174026.494496-1-afd@ti.com>
In-Reply-To: <20230515174026.494496-1-afd@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 May 2023 15:35:38 +0200
Message-ID: <CACRpkdbb3jub08rPGaX0orY9tRf738ba029Qw5aVT-HyNLz2SQ@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: twl4030: Use devm_gpiochip_add_data() to
 simplify remove path
To:     Andrew Davis <afd@ti.com>
Cc:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, May 15, 2023 at 7:40=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:

> Use devm version of gpiochip add function to handle removal for us.
>
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
