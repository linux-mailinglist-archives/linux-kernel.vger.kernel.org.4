Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B741870687C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjEQMoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjEQMoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:44:09 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51BE2D4E
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:44:06 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-ba82d82bd39so923578276.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684327446; x=1686919446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNevE736BEsxBU0FmwLJIhGqBiG7yoAC/t6/uUIBMdY=;
        b=FMlLS0aECYmfOvG19PTRQ4JzQVOPvgp3keEl4q4lBIcarONNex1FSS2aSSOrdLjxfE
         OYiPfSd3p8dfD1QItx7D8wl2cvYk/x1+YjFMYiLcupDwHagK7bMFjrihVjrw89h1isK/
         BL8m4dOesp9dOvFJIsPhRXwRJJZw0WXMjrRaZLCGs1aGyZghu3sRXCSFqAbHEbi4bEe9
         sb34beQApq2PcsJ82bacmFQQUt6j72BaQNjANrnbsGmWxQJeZKXoqvssjMl8KTkBxSm2
         hNmUL8hfNmz56/sTiGz6zGIXfLgQdcu9zLtf9Q3wfq58AlUNYHc4mTp5/+V36z6r3Z0n
         03CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684327446; x=1686919446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gNevE736BEsxBU0FmwLJIhGqBiG7yoAC/t6/uUIBMdY=;
        b=afKyr4HemXBl06NWXBFj8PyM/v1pB/GH1way0m0NrBB6fVbmxJ6c9ZDzQTHLZjxNlk
         dKGqQBNmaEzfMriQ1e++8jyqiXbFL8zg1ZMW6L1DX6NpAK/fosYLt5FKnHL8eVY/8rBS
         VDzdlb3+PGPQpI9YHOJyOevWXWG2oJ4IHTXbeGFCMrDDIZy8LgW2BSriafk14jTh6+Qi
         2vHKLQNoSFe/NH+bgR5yYZCP9O8GvSXYGA59H0M+Bu+/QQOdxKxYJY/cazzUWsT1gJny
         DZlKxXgX68DmWpyNicPhOgkCgZ4K/UojWbBc5Q46j1ybQSJ5TWtvaFLgenSShIraYKpQ
         DQug==
X-Gm-Message-State: AC+VfDx7DrBMXGawsGYcQcWsJu3ZiRZTy2afhP6W2OHL0ptSKwP2DWu7
        Gf4ODIPGJ90Oeg9dX76tw6+BkfgKZtiGgybfQIn6cg==
X-Google-Smtp-Source: ACHHUZ4prpZ1ZwoDxxoHkrbtIQ9L4j9bzrbZd//ns/O1W/Gj5TZTAbzyimVq3qT7URmcD+Feztnv9pZGkl2jlaxwl+I=
X-Received: by 2002:a25:1504:0:b0:ba7:382f:6380 with SMTP id
 4-20020a251504000000b00ba7382f6380mr12543280ybv.24.1684327445737; Wed, 17 May
 2023 05:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1684220962.git.mazziesaccount@gmail.com>
In-Reply-To: <cover.1684220962.git.mazziesaccount@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 17 May 2023 14:43:54 +0200
Message-ID: <CACRpkdYPZWNTOW6c0q1+q64JRvxUXswQqm6j5N5KaAWO=sSUaQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] fix fwnode_irq_get[_byname()] returnvalue
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andreas Klinger <ak@it-klinger.de>,
        Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Paul Cercueil <paul@crapouillou.net>,
        Wolfram Sang <wsa@kernel.org>,
        Akhil R <akhilrajeev@nvidia.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        netdev@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org
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

On Tue, May 16, 2023 at 9:12=E2=80=AFAM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:

> The fwnode_irq_get() and the fwnode_irq_get_byname() may have returned
> zero if mapping the IRQ fails. This contradicts the
> fwnode_irq_get_byname() documentation. Furthermore, returning zero or
> errno on error is unepected and can easily lead to problems
> like:

Also, zero is not really a valid IRQ, it means NO_IRQ:
https://lwn.net/Articles/470820/

I'll apply the pinctrl patches.

Yours,
Linus Walleij
