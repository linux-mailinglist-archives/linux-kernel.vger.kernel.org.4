Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFBB735DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 21:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjFSTvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 15:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjFSTvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:51:22 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30364106;
        Mon, 19 Jun 2023 12:51:21 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-987accb4349so427209566b.0;
        Mon, 19 Jun 2023 12:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687204279; x=1689796279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sd0Z4QXfggzwHtnXjPLZAClg5L7keAUm3VKoUQTaD/E=;
        b=EJ4G6ji/n65WTVFd+8fUKpKE/pPADTSbANE84/FVL/5xaqN9lrz6hUYxCruKjB00T3
         A+PzuCjKDLHT/NHQBzW77tyuTB/iOEdzUo5QQoHANdWUOMYd80KyJtTl8KnusjARFyRY
         P2Dq86RDh4y69k3YOc4/sWJMnCzw3f6PBs+45PAHWzERKRIuN0osGyfLtDbjMFYffkNL
         y16PhKmWZm42f2MUP9VOa+W2O3RPpB7FkwOFxbxbG2lw2CDrtIRT8xLrVvOWI4kv0nOf
         ag7kxQF7Tfqx9QJWbEq6cfwBXoU/ZfvRMu27Y9+ttAESU2F7kuB0gnH4TL1efzIPyEFL
         9SIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687204279; x=1689796279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sd0Z4QXfggzwHtnXjPLZAClg5L7keAUm3VKoUQTaD/E=;
        b=BnJeWnixcRVcn2mMc06wavPfo6yVOxbwPYzrO7oCdGzVV7FGcnxblNf1DEnG9egIOQ
         VLV5ztodqPIQKf/XTemURLMDayNDhqIrJxn5z+r4ystufPOt4+olD7yHVwVCTV1fn3uc
         +LH2RBtvVQ8A854nUCR0ivZN+VrXTXu0LVSGOt3a2upOUkHKzboxm5eMF4+y2u62vHyg
         7bGGGyUwc06FqUVanwB3ZwDLMhZYMIPgRCcEPRwk9hBLLPK1r7bytAdJZzX7PDAoXqO/
         sLiOg8ULSPL87awZh6EhZ4Pn2j+zwWpY51JgAcJUbtYWp2L8EMcJlFBxLoBkW1TF0sYT
         OJeg==
X-Gm-Message-State: AC+VfDxQKWrn6aWIL8gmYlVFhjqQIRMYHCoROO7Hg2f60LOIEmUez71x
        hKbGI0+FANkTkPj1cuc4mKzCc6InYC5Im2a49NyYe4vaSv4=
X-Google-Smtp-Source: ACHHUZ63TBsrxqGLzHLhPqGvnsA2IbglzQC0C14yaOFsZ83BWmNwv/AKD9ZicJVSWO/8KUat6yXXiS0uTl+xZQU81/M=
X-Received: by 2002:a17:907:7faa:b0:988:2111:bb2d with SMTP id
 qk42-20020a1709077faa00b009882111bb2dmr7590179ejc.7.1687204279367; Mon, 19
 Jun 2023 12:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <TYZPR01MB5556B56D834E02F41C44D81DC95FA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
In-Reply-To: <TYZPR01MB5556B56D834E02F41C44D81DC95FA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 19 Jun 2023 21:51:08 +0200
Message-ID: <CAFBinCAJ1E6JKmFTuaJwGpd_MBzHMZ0mMj-1AE3TNeB2_72nZA@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-mx-sdhc: Fix initialization frozen issue
To:     Ziyang Huang <hzyitc@outlook.com>
Cc:     ulf.hansson@linaro.org, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

first of all: thank you for this patch!

On Mon, Jun 19, 2023 at 7:36=E2=80=AFPM Ziyang Huang <hzyitc@outlook.com> w=
rote:
>
> Commit 4bc31edebde5 ("mmc: core: Set HS clock speed before sending
> HS CMD13") set HS clock (52MHz) before switching to HS mode. For this
> freq, FCLK_DIV5 will be selected and div value is 10 (reg value is 9).
> Then we set rx_clk_phase to 11 or 15 which is out of range and make
> hardware frozen. After we send command request, no irq will be
> interrupted and the mmc driver will keep to wait for request finished,
> even durning rebooting.
I think this is the exact same problem I reported some days ago: [0]
Ulf is questioning whether we properly support 52MHz clocks correctly,
so I think you're onto something!

So this is an excellent finding! I can confirm that using rx_clk_phase
of 1 makes my Odroid-C1 eMMC work again :-)

> So let's set a common value - 1 just for initialization. Then let
> meson_mx_sdhc_execute_tuning() to find the accurate value for data
> transfer.
As far as I know unconditionally using value 1 can negatively affect
other devices.
I'm assuming that you're testing on an Odroid-C1 or similar board with
HS200 eMMC:
On those SoC + eMMC combinations we do support. But on other boards
(for example Meson8b EC-100 / Endless Mini) there's no HS200 support
because the eMMC is connected with 3.3V IO lines. So tuning is not
executed there (if I recall correctly).

What do you think about adding a special case for the 51MHz "actual
clock rate" and adding a comment that it was found by manual testing?
For some reason (that I don't understand) Amlogic's vendor driver
maxes out at 47.22MHz (presumably because they limit themselves to
using FCLK_DIV3 as input only - but I don't get why...).


Best regards,
Martin


[0] https://lore.kernel.org/linux-amlogic/CAFBinCD0RT0p-jk86W0JuMT3ufohRh1R=
qWCcM35DKZJpuc10HQ@mail.gmail.com/
[1] https://lore.kernel.org/linux-amlogic/CAPDyKFpS-UwiaRPMqSpX0mNPrS5p=3Dy=
Jzu3g0=3DpGyCkWHSYyqWg@mail.gmail.com/
