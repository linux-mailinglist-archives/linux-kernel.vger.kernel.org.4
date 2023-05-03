Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D776F5942
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjECNrL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 3 May 2023 09:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjECNrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:47:08 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D80C59FB;
        Wed,  3 May 2023 06:47:06 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-b9a6ab9ede3so7264789276.2;
        Wed, 03 May 2023 06:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683121625; x=1685713625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8fvBW6URQPQ1oJY9J3VwE1viOASAnv8GGw4ZkuvWUo=;
        b=YtA95SpuqBrRTcr0Xb2NB21buvubrZ7kuWfWSThBxZkwTe4NQtk2vt91XiW6xn5MPf
         vFnVDAFQ4D6+38KbXBovgJ1KwZIxKB4o7aRw/6sqdusmT5WlxEQ1KokvpYGySZ1plYSl
         /tmFBvyuY6UxZD9TD9IpzdUOiNQqNZ1dESXhT9p55Kx2M/MS+SCsfZxmgF97YQgyAXpW
         Z27aN9uMltsUDSn0CDq9nrl7Y8xTpdWNNMnN2sIuQ6qHznxYpqe6yGN+ouMUf0/lP5No
         hVO0RgDFtdKNC7xBIJpuFdk+zNQNkBvYSJ6h8AdsDGGGTeq2tm76AR1bS18H8IrZaUcb
         KJDQ==
X-Gm-Message-State: AC+VfDylO+3e0avGUR2p8Jon6Nm76PItPk5UO5Dv9JiDDUHqJIWbwGQw
        bCjgIIzoP6tQpTKkA4TzRCmSHKcnqkqyfQ==
X-Google-Smtp-Source: ACHHUZ41uXWXRn93BDdcDV7J7JtZFAjkN9WnxIvWgHa5Ng63H+765D2QxaXRLxJ4hmuXyvvX5KuK2Q==
X-Received: by 2002:a25:c83:0:b0:b9e:5aad:edda with SMTP id 125-20020a250c83000000b00b9e5aadeddamr6238844ybm.4.1683121625398;
        Wed, 03 May 2023 06:47:05 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id y10-20020a5b0f4a000000b00b8f51af1364sm7958218ybr.53.2023.05.03.06.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 06:47:04 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-b9a6ab9ede3so7264717276.2;
        Wed, 03 May 2023 06:47:04 -0700 (PDT)
X-Received: by 2002:a25:2803:0:b0:b98:ddf4:7146 with SMTP id
 o3-20020a252803000000b00b98ddf47146mr21412759ybo.21.1683121624299; Wed, 03
 May 2023 06:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230503125746.331835-1-glaubitz@physik.fu-berlin.de>
In-Reply-To: <20230503125746.331835-1-glaubitz@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 May 2023 15:46:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWxp16uzqZ1R2ViZHSbqYcHSjWNVJDM1_Qne3kfaG6pVQ@mail.gmail.com>
Message-ID: <CAMuHMdWxp16uzqZ1R2ViZHSbqYcHSjWNVJDM1_Qne3kfaG6pVQ@mail.gmail.com>
Subject: Re: [PATCH] sh: j2: Use ioremap() to translate device tree address
 into kernel memory
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 2:59 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> Addresses the following warning when building j2_defconfig:
>
> arch/sh/kernel/cpu/sh2/probe.c: In function 'scan_cache':
> arch/sh/kernel/cpu/sh2/probe.c:24:16: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>    24 |  j2_ccr_base = (u32 __iomem *)of_flat_dt_translate_address(node);
>       |
>
> Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
