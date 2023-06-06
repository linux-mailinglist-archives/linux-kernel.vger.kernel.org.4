Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1608A724BA3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238929AbjFFSpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238887AbjFFSpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:45:10 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2340B170E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 11:45:08 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-565bd368e19so66857517b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 11:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686077107; x=1688669107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0f2HXwtzZPOu2SMs3B1mSn7YTNWPbzVJ1Q8BJIRe3iQ=;
        b=A83iW40wCu/ek1ytLlTmsLhXBj6U+rOa1+tNlTUyFXHdLTSHpOxNJEZdlaEs4eDrTy
         wQ5+SeaERA498ZJRC3fNAX6yBRgALkT/6PEUYCUm8baZ3JtoDqFtoxHMTtNGbAJWN6BB
         tXFQHR8yvXw6omV8rL4HRbVIr4XWMcCXzZyzqqxeFQ1frfH166Bo0KTqliVTZzysmv25
         2KEQMebNF+8GNvhfgeBcJ4phUzq4icwOP63DiSUsEPjrPZfsY8GjbOhysiCFlST/+jgN
         xSL1xbO73eHT5aKWvF9+miiRrdye8izuSAyPoDo0sKNHeXlAY7Xa14EoSaz3c5xI1pVy
         ELgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686077107; x=1688669107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0f2HXwtzZPOu2SMs3B1mSn7YTNWPbzVJ1Q8BJIRe3iQ=;
        b=PVM0ollQzO47+OdPmeRWm7u5RkAZeUpOaYTcE5sKJuQR+YyY9lk+uPVeiQeO8LnY5G
         E2D+Bf9Q1e960vHYtDl1c7iI0WBJzZfShysyruihqwWMM7xrCWzCh2/1X0lP6hFDQADY
         xuN6MHwjTVpmXKdhHS1zyhKGxUp6U4TnJ9ipWeF/7CP6+cREDngWGirI7ohAc3LGwiQ/
         ahRCl2H8wOCJYWz7A0DYlMV4++ECXWv4rc9kAv9JkwsnOIe3ia7f6QkdBCEajfhxe6Qe
         Eand/9YfJ/pp2rYKIq3oC67OI5uBO4Ej2Q27rg97R++wPfVuMgif8kW0UAtHXhcQoPiu
         CCxw==
X-Gm-Message-State: AC+VfDzbXHdt3WBGEs9mfhvf/C+vGB1tUWE19alPzgjOp34LRP1SN+0E
        1bA5olPX7tI9R1rHmklbnhOcvdVHB7F4GtJ0fCkOOy+M9ToRmMBJ
X-Google-Smtp-Source: ACHHUZ4+MgtBI155SVVj6TAoJSeiCWrPjWPUuzvphCBEewj1WdM4RRkNxKwQUZ/tRptVbz6GgSROWt5q331IR/Tg1/A=
X-Received: by 2002:a81:5c03:0:b0:561:baee:ee8 with SMTP id
 q3-20020a815c03000000b00561baee0ee8mr3344440ywb.32.1686077107326; Tue, 06 Jun
 2023 11:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230602162258.63853-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230602162258.63853-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 6 Jun 2023 20:44:55 +0200
Message-ID: <CACRpkdZFwHm--KYxf+NnynPgKz_VJpzZnptTVmFpNxauZ3Pbtg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Do not unexport GPIO on freeing
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
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

On Fri, Jun 2, 2023 at 6:22=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Since the legacy exporting is gone with 2f804aca4832 ("gpiolib:
> Kill unused GPIOF_EXPORT and Co") there is no need to unexport
> GPIO on freeing. Remove that call.
>
> Note, the other users of this functionality do that explicitly,
> except one SH boardfile which doesn't free GPIO anyways, so it
> is safe to drop the call.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Makes sense!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
