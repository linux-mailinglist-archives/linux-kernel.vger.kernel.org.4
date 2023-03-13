Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE076B79E1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjCMOGV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Mar 2023 10:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjCMOGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:06:17 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BCC43448;
        Mon, 13 Mar 2023 07:06:15 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id r16so13165252qtx.9;
        Mon, 13 Mar 2023 07:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678716374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JagHu6Zz7NmLi2gnG8VHIuS4GLUxZuf8Z0Ku8bqW0vo=;
        b=WPgPD2szz/PcbeowdD93LBS4VcqXs/zU4WUYNrbgx95aKeIYONE7p1y/BA1BuH3eXN
         cJ3vCrzBcXpgQ7oy9cwDZSFtXinYTVQGWwd4XtZVLVdlyD+wE/il8dMYrUYCjd7M2VyA
         NXFlhfn57stQsVzZd6KOFA0QLrpA1FWbxSJMyYPZUtW2HKh/ZWshdkwrowULMMYmbyM1
         048gvdsKLcUKQWMfS3qurZfhO/pnxCdxoKaNQB5HW1BESbbN8whL7KXcqSxE69jXqNB0
         JpkfzcCKKZ/aOHvUDcwRHREopSoP3WtgiYdCM1ZPXaM10wCbgbR7YO0QxY0DHYrdE+PD
         xxFw==
X-Gm-Message-State: AO0yUKUCJr8yAVMy8xPvSrL9H8WpsUneSE+F2QWiDLahdISf04WA2Wkp
        FWV4LD9t15bu46xYF6GoJtnxBeQoiDuRBA==
X-Google-Smtp-Source: AK7set9kAvMU+ArCW7mddFAMQx1g91yyvevu1HLsfzUksdF8Y1t3G8RyJK8ACTMITyLtUNzOl7l2ig==
X-Received: by 2002:ac8:7d4c:0:b0:3bf:d196:5e27 with SMTP id h12-20020ac87d4c000000b003bfd1965e27mr59973293qtb.20.1678716374271;
        Mon, 13 Mar 2023 07:06:14 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id 2-20020ac82082000000b003bd01b232dbsm5552700qtd.43.2023.03.13.07.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 07:06:14 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id p203so4754027ybb.13;
        Mon, 13 Mar 2023 07:06:13 -0700 (PDT)
X-Received: by 2002:a25:f507:0:b0:b3b:6576:b22b with SMTP id
 a7-20020a25f507000000b00b3b6576b22bmr2855521ybe.12.1678716373647; Mon, 13 Mar
 2023 07:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230312132650.352796-1-krzysztof.kozlowski@linaro.org> <20230312132650.352796-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230312132650.352796-2-krzysztof.kozlowski@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Mar 2023 15:06:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUO8T3LdHk9YaWwQW3Wfg84o3=SiZFMM4qhWj9X96Rctw@mail.gmail.com>
Message-ID: <CAMuHMdUO8T3LdHk9YaWwQW3Wfg84o3=SiZFMM4qhWj9X96Rctw@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: renesas: pwc-rzv2m: drop of_match_ptr for ID table
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for your patch!

On Sun, Mar 12, 2023 at 2:26 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might not be relevant here).  This
> also fixes !CONFIG_OF error:

Only seen with W=1.

>   drivers/soc/renesas/pwc-rzv2m.c:124:34: error: ‘rzv2m_pwc_of_match’ defined but not used [-Werror=unused-const-variable=]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.4.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
