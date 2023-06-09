Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99787291C5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239138AbjFIHwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238947AbjFIHvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:51:32 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3816468F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:50:49 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-bad0c4f6f50so2197037276.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 00:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686297048; x=1688889048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2cdBW2Mj+SXNwvwcmaMfvn9vGgTGDb3aldi7qM0FW4=;
        b=QRfj1lAj6qrW35HA4Jbny7ps8mFhM+5OtqT/QQ3+fzPkcQ3jonOXAWsLO0bRStdrNp
         JEFqjpnRS6mVxoUT6NcO41jGMJVdzSRDhz1eOpiOOwOaXNfYREtI8rUQqeYQZbXwTSUV
         CKYIES3M5S2yh0UhSKElNYrzzi6hgRrmmFeE8rW9/xL6YTUpUF3eWeA7rSzZ65b9Dt/8
         s+hEvAYXKfv8nVA9SCGpphZfnhwR4nz9MTltLxObf6bKhmBz+FNLrpdks6VvsgVA1R3E
         66kqz85dbkRKbj3qeHi2P75myeZOiC6ZoaEWsb0WUpI1EUUjz6ivJ3F0JyZBeNA8Cg4r
         4k1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686297048; x=1688889048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2cdBW2Mj+SXNwvwcmaMfvn9vGgTGDb3aldi7qM0FW4=;
        b=LFjxnsmOt0DLMRy8svyFtiWEbXpLw7eFn+rkiDq1iMeKHrC1Sw+TFVR8DIiHsXD3qc
         gMwGPKsekZu3uGI/FwfVAqdGEWQjo82X7d4x/ddLDuY+2BVNZHnYHm3jc1BN5mqAxOZv
         Wv8vT5Zvd14gnYkNqNMIqZnsCsBYJTcUlzH8Iq4PyC72Gr8G8XHbXMBk/IymwzO662LY
         YffWEVOhhPJd13Kh4fbYaNKE0wlq22SouWseP1WfifZ6jnjq0Nx1qRMbMD6lwmz/Waea
         Sys72vJG2splvz1ynTJ9pozokVWl8JsWbdsZN8tkKlj7cJyeXbI4II01uFYz3lrvMMNt
         IgTw==
X-Gm-Message-State: AC+VfDyt0yDLeX47wSWIS1XJRQyTBcocgWVxAB4btqHtaK2VUluip5CQ
        55aoR06k1un3imcSLvnZh9lO0JBKiEGlGiDPsTQCog==
X-Google-Smtp-Source: ACHHUZ6VxExrksH/syijxzGAVPfotWL9Iavo6MOv8iMAl0+OtFlw9eEv+9fDhDiPQ33DN1/gnp2GtZrimvY635G7MjQ=
X-Received: by 2002:a25:6008:0:b0:ba1:6bad:9270 with SMTP id
 u8-20020a256008000000b00ba16bad9270mr2587471ybb.27.1686297048725; Fri, 09 Jun
 2023 00:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230608162130.55015-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230608162130.55015-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Jun 2023 09:50:37 +0200
Message-ID: <CACRpkdbaf3UzW+x6emER5J5KJUQoJmdipwY_RQp0Ovj2N6RnsA@mail.gmail.com>
Subject: Re: [rfc, rft, PATCH v1 1/1] gpio: aggregator: Introduce delay
 support for individual output pins
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Alexander Stein <linux@ew.tq-group.com>
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

On Thu, Jun 8, 2023 at 6:22=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The aggregator mode can also handle properties of the platform, that
> do not belong to the GPIO controller itself. One of such a property
> is signal delay line. Intdoduce support of it.
(...)
> I don't like the idea of gpio-delay or similar. We have already GPIO
> aggregator that incorporates the GPIO proxy / forwarder functionality.

You are right. This is the right solution going forward IMO.

Yours,
Linus Walleij
