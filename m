Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3327371282D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243827AbjEZOYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243836AbjEZOYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:24:32 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2931B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 07:24:30 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-33818ccd411so6113685ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 07:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685111069; x=1687703069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2LUpd1ShEDkP8CxxjKODFmXxczpxGXQR/flSSmLeAU=;
        b=ne13yQwUmqh9jxNsdhaT1R6WUvJiXqOP/cNJKrmOahUCjbf8bWTJ8WKjJu+SSqIG2o
         GVNULc0LC8OwfXW6pfXaBWMWuYZHL7nZbDKkzxoDLB82aFlfSixKwHjBac9cgdb+fgKx
         q4lwKHCFsM7AxMro8OaW+NWx1s9I+TTbDFeAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685111069; x=1687703069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2LUpd1ShEDkP8CxxjKODFmXxczpxGXQR/flSSmLeAU=;
        b=X2pPmndQzLSVFYKIwLgx/t76uotaH5KqLXQr2lkpbv/4IzRq5QaYrJfQQT0F7+oBXr
         WZn2MDWy429e139UQOo9o8sSzL5I6Q6zp/QZUbdY+lIozB+9fUKp+KOMdWjmCCtrjvDU
         Uh2cpA7wCPaelqwSQ8T4U2UdiGjWhtBDoBTqHMCQaZ8wvE1BDSWR6ASlhktjHCYuFsK6
         UL3ifN5/uGZWYTItLltu0KfXN6gCzaUNSaLMvkjFMICpJoq1OEhfMrRAW69FGhiQFjz4
         FVnmTeXgJjVUhcmdc4H+Y3nsWgm+hobxzFhkn4/92rDevlUSKc+71Phot0ZJX7Ee8VW4
         Y1qw==
X-Gm-Message-State: AC+VfDyBqSfOKAzUNUMj6cjiyLzYaLWfJ6U9K2pxKOqmlwR5XC8WoHt2
        JqGUVWkNwjiH+I9DJ8cSMn05YpipzudAa4EOmwc=
X-Google-Smtp-Source: ACHHUZ6vwaC7X30zUKta4uaOn9ifV7+sHrVrFU2J45QjLaA3BcX5aPJmpncVVOVPhTaIzWu1WMhOHg==
X-Received: by 2002:a92:d390:0:b0:33a:1a98:559e with SMTP id o16-20020a92d390000000b0033a1a98559emr1936926ilo.1.1685111069074;
        Fri, 26 May 2023 07:24:29 -0700 (PDT)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id w16-20020a92d2d0000000b0033355fa5440sm1007077ilg.37.2023.05.26.07.24.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 07:24:28 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-33164ec77ccso152905ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 07:24:27 -0700 (PDT)
X-Received: by 2002:a92:cdaa:0:b0:320:9759:bf6b with SMTP id
 g10-20020a92cdaa000000b003209759bf6bmr79542ild.3.1685111067417; Fri, 26 May
 2023 07:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230526100801.16310-1-uwu@icenowy.me>
In-Reply-To: <20230526100801.16310-1-uwu@icenowy.me>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 26 May 2023 07:24:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UxrFVZXn+dtgamttTVopWMSVbxYsHCGG_tS+3OTXbHiw@mail.gmail.com>
Message-ID: <CAD=FV=UxrFVZXn+dtgamttTVopWMSVbxYsHCGG_tS+3OTXbHiw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8173-elm: remove panel model
 number in DT
To:     Icenowy Zheng <uwu@icenowy.me>,
        Pin-yen Lin <treapking@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 26, 2023 at 3:09=E2=80=AFAM Icenowy Zheng <uwu@icenowy.me> wrot=
e:
>
> Currently a specific panel number is used in the Elm DTSI, which is
> corresponded to a 12" panel. However, according to the official Chrome
> OS devices document, Elm refers to Acer Chromebook R13, which, as the
> name specifies, uses a 13.3" panel, which comes with EDID information.
>
> As the kernel currently prioritizes the hardcoded timing parameters
> matched with the panel number compatible, a wrong timing will be applied
> to the 13.3" panel on Acer Chromebook R13, which leads to blank display.
>
> Because the Elm DTSI is shared with Hana board, and Hana corresponds to
> multiple devices from 11" to 14", a certain panel model number shouldn't
> be present, and driving the panel according to its EDID information is
> necessary.
>
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

We went through a bunch of back-and-forth here but in the end in the
ChromeOS tree we have "edp-panel" as the "compatible" here in the
ChromeOS 5.15 tree and this makes sense.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

...in theory one would wish for a "Fixes" tag, but I think in previous
discussions it was decided that it was too complicated. Hardcoding the
other compatible string has always been technically wrong, but I guess
it worked at some point in time. The more correct way (as you're doing
here) needs the DP AUX bus support and the generic eDP panels, both of
which are significantly newer than the elm dts. So I guess leaving no
"Fixes" tag is OK, or perhaps you could do the somewhat weak:

Fixes: c2d94f72140a ("arm64: dts: mediatek: mt8173-elm: Move display
to ps8640 auxiliary bus")
