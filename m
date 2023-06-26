Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D3073D845
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 09:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjFZHOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 03:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFZHOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 03:14:05 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9D31AC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 00:14:04 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4008324d85bso29510851cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 00:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687763643; x=1690355643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUSGWbCXntBTkO9sHXbN7XbI0NcyxewHoKY9x8+FCk8=;
        b=JQ3i5hlcNNawUt+qj1ljvA9FJ0Im+H88QY9lY05bsjAfE2q4m3iA7PEHWrmPaE1svp
         eIXan4f1hjUYaqBfHrgo4b/wXDBjcNxZTM3uFou/50/XKrjQc6Inmjw1nzFW4EZ6eR9n
         jIvNa++eL6AecOt5OvPJxesVDzGww348vywSvZ5jMMLFg3LzAERssj6kgf4VTV+L2dhm
         onXiThYPyPJdNNVINgulXcAniCGeB1+R7105zc2ZzfXRKs5635n/aiRQSWXIUMd8Bs6f
         GIbHcXqO1TFlvRR/aA9hjo/J1DsELauFYWTF2zKiEJqFJYAZEoTkC+TuZi9LAq/Axly0
         ccPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687763643; x=1690355643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUSGWbCXntBTkO9sHXbN7XbI0NcyxewHoKY9x8+FCk8=;
        b=MYSXAQwjE3KfEkyexpVGnyEtSpVxok2kcgI8Y236nlUBkOEjHQY3xFlYIAa8SpTuuh
         ASlL6Gr49F/V263kItU3APSVGYTzBZS6UF/Te1rHXAkKgNcNGDRUAkCeodt1gEcKBC3b
         1UxORDI6QNaG3EpVOvMAdr0Oom68/3aLMg6dw8iiibD8D/ouyVFWRoqfmnhSRLpl5ljg
         1HP2+C5ZCkU+J1071qad+U61GxlWqrzeT9Vn/TMt7fsyIB1t40DhbX5fMgUlLai05uPG
         /OEXVYu1RL27+paj+yPmWdi7JIRJQoP99uhOtpgaE8S8icgBL9bWUEfMBQy89QHoFI2/
         tZgw==
X-Gm-Message-State: AC+VfDwJSNZ5pBzdp7uarbua6dHqjsY8Pzp2Xom6WCG7lIefbVI/uHX+
        3OrpSprewcYnVKO4eRYJnZhNd8dYH52cYRPP+3zFAA==
X-Google-Smtp-Source: ACHHUZ4kyVjT45z1qW52OYC5r21iJ5DWdiLHWlP21TQ+BkuBeujtoRUUWblnmXCOaleIiMVQenOTn9I5XN2vy1AbFm0=
X-Received: by 2002:a05:622a:104c:b0:3f0:b4ee:6f4c with SMTP id
 f12-20020a05622a104c00b003f0b4ee6f4cmr35747340qte.41.1687763643515; Mon, 26
 Jun 2023 00:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230625162817.100397-1-krzysztof.kozlowski@linaro.org> <20230625162817.100397-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230625162817.100397-2-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 26 Jun 2023 09:13:51 +0200
Message-ID: <CACRpkdZ5U4XA40j4MoMpp11mcrPf-NU+c35TPmk064w0xdk7Dw@mail.gmail.com>
Subject: Re: [PATCH v4 01/24] Input: gpio_keys_polled - Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Sangwon Jee <jeesw@melfas.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Andi Shyti <andi.shyti@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 6:28=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
