Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7657420B4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjF2HAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjF2HAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:00:19 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5EB1BE1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 00:00:17 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bb3a77abd7bso361697276.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 00:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688022017; x=1690614017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1O2td54UAVvMVuiHOPam6KGvjm+KGijM26LEk6Y/MBE=;
        b=JmdDx3z6fCj+K4c0xRA6XjxR78jrsvayHIjM0U8C0Hy+I+RVzUWwwS/5sYC4ndPE7j
         sdkBkgiwI8psDVD2SDOsS+GMyDHBmWbGAQB0a9GfrgRFFrf2MmqleQLrYHh2rNY0ZUET
         SDMWP7vO9mdzelze4P7w3f41QlqLYklynBSm21Qyt7HwflLUtyFOVZPRKliijgto2u+l
         kgph69R6elFZU991wDmc8vuNZXtlZmLWrd3JUn2ma2hmQLz2O9OcQfvePlioQOfc8/Av
         uB6ljxB2QOZEOtqh47y23n4io3kTu02FSr/XUhDei/DsadG2B2L0vRksYbiJECpyO3bl
         rBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688022017; x=1690614017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1O2td54UAVvMVuiHOPam6KGvjm+KGijM26LEk6Y/MBE=;
        b=COe7lGLRLMfxyV89mG9FmZfUPK3bzINE6aHSIXZGE0hJXSDJX3h+ntCnyg4n92rgmt
         m6cU5lPTaovQcWKM0h0NKHNTwmP+oYz6yxxDfu2GoYBGOq4wM5KxbZH/xrzLYStbhWQf
         AkhEE3Run/Ahmg2Fvau4f9VpjTVm9JokyHRKdu1m1WG2Q2nlQBjpys4AjzdwcrqvToBb
         vE0gxHKABGwxiFoO7E8K3YPMhc1o8Tc7IncJm+6Hhiey3mJAsJYyFQn9s/troBl/rtub
         yHO4WdPufUMklYmH06zHMzsgJuL0kyFCp6xilCW8+jfpy6aegXL5OWS7WIdHclb0Tb6b
         7wyA==
X-Gm-Message-State: AC+VfDwt2Mom+6ySk+2KYhKncTXxrkid+z3bstFqAoQ/cfmlvPFuQRxX
        cvh/SMAAdbwcOq+CEvqqepNRPr0wJhOXvdqVMlekNw==
X-Google-Smtp-Source: ACHHUZ7xKpLRzmTr3/h+3Fd4K9nni98PVt0vXCb0o/8t1wqkT4btUTSQTnT4V/xz/0EbFSpZKZbLNyop53TGoJ9VcL4=
X-Received: by 2002:a25:b195:0:b0:bc6:cf90:a286 with SMTP id
 h21-20020a25b195000000b00bc6cf90a286mr34342655ybj.36.1688022016763; Thu, 29
 Jun 2023 00:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230628133021.500477-1-eblanc@baylibre.com> <20230628133021.500477-3-eblanc@baylibre.com>
In-Reply-To: <20230628133021.500477-3-eblanc@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 29 Jun 2023 09:00:05 +0200
Message-ID: <CACRpkdbtH-GtoZ5pJJCMu3sj2RB1=skqRV0nZ0qoZfXaVTNuqw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] pinctrl: tps6594: Add driver for TPS6594 pinctrl
 and GPIOs
To:     Esteban Blanc <eblanc@baylibre.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com, u-kumar1@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 3:30=E2=80=AFPM Esteban Blanc <eblanc@baylibre.com>=
 wrote:

> TI TPS6594 PMIC has 11 GPIOs which can be used
> for different functions.
>
> This patch adds a pinctrl and GPIO drivers in
> order to use those functions.
>
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>

That's a very compact and nice driver. Surely good enough for
me to merge!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
