Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF716E95D7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjDTN2F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Apr 2023 09:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjDTN2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:28:01 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D3E44AD;
        Thu, 20 Apr 2023 06:28:00 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-552ae3e2cbeso39943237b3.13;
        Thu, 20 Apr 2023 06:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681997279; x=1684589279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxB0qoVRVba+5OX5hj1c4aGT/qN0CF45NAyg3sDE75s=;
        b=foHyIsesKa97NOOVcF2zTe62EKmGvVUv4lmYxXUk/InHUKJ0n9WiSmn1N1REndT243
         433Fe2c8Qx031+06tdbLw796RcEiBsg0m2agCAYfpUuyzqSDtVny4NvaPeHjmqJaKJez
         q7sDNJSGCaN4BqUDPBr7xwr7remZYOk+UQyFix41Qji6pi+VGov+HaZyQtWUwRpZRMVS
         1yDnOcOWJWXiCpdleylaoYMrxTwyhw+8avltj+0RlkdtlbiUKe/JSvjQzL7bpgVjD8GX
         C/WmUFTAbOYo/WlEoGwCSAT2CaWKAEhLtYbYiXO4YBFnNs7CHuqpxtyx8F1TmaVTMxGJ
         qOHQ==
X-Gm-Message-State: AAQBX9dHwksRxzcWNjy16yYOVsVts5aK19F5qIfbVvWKTkLG7lz3bPs7
        GAyeHKO4fy7glMgh+14d7bSmkpvOBfNlWC0n
X-Google-Smtp-Source: AKy350ZQ0w3KCbZbLtUMmp7JGx7IP2ERoImSg6VYOvjWw2V1mzNewKdA/YtxpGScHkem/eIGq2V/lg==
X-Received: by 2002:a0d:c782:0:b0:541:7e07:ed65 with SMTP id j124-20020a0dc782000000b005417e07ed65mr806116ywd.5.1681997279530;
        Thu, 20 Apr 2023 06:27:59 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id b129-20020a816787000000b00545a08184a7sm342589ywc.55.2023.04.20.06.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 06:27:59 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-54fa9da5e5bso41860377b3.1;
        Thu, 20 Apr 2023 06:27:59 -0700 (PDT)
X-Received: by 2002:a81:c251:0:b0:545:eb3b:2711 with SMTP id
 t17-20020a81c251000000b00545eb3b2711mr818496ywg.35.1681997278824; Thu, 20 Apr
 2023 06:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230411100346.299768-1-biju.das.jz@bp.renesas.com> <20230411100346.299768-8-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230411100346.299768-8-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 20 Apr 2023 15:27:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWpYzVq7BrtFHQZa8wnU6ESmnwuk5zGjBrS3A-txvfGUQ@mail.gmail.com>
Message-ID: <CAMuHMdWpYzVq7BrtFHQZa8wnU6ESmnwuk5zGjBrS3A-txvfGUQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] arm64: dts: renesas: rzg2l-smarc: Link DSI with ADV7535
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Tue, Apr 11, 2023 at 12:04 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Enable DSI and ADV7535 and link DSI with ADV7535 on RZ/G2L SMARC EVK.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Linked DSI with ADV7535.
>  * Added CEC clock and clock names
>  * Added hotplug detection interrupt.
>  * Removed pinctrl properties as it is defined in common.
>  * Removed Rb tag from Geert as there are too many changes.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.5, after patches 1-6.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
