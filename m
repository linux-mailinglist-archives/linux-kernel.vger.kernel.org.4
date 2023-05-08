Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805186FB1FA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjEHNqj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 May 2023 09:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbjEHNqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:46:34 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5BD35B0A;
        Mon,  8 May 2023 06:46:31 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-559e53d1195so65155497b3.2;
        Mon, 08 May 2023 06:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683553590; x=1686145590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lnn9QmU+bAqBRyGIgIXitUiyVvpirFH0AVkWB2ciMck=;
        b=Z51pBs+JszzZpsGkjkiPquZokhyKpIgC7NxnlfIyxiB4JTpwcH0qiKcY4aQkWozKzq
         oQiV3fZNpeF5iaROJRvggz29RUNNR6HXT6Xa+GJxYFYN9rWZ7SxSbBBx+/CFcLQnGDrr
         Kdn0kdeEsCOI7qkX3B7xncysAvhD9kmbUT9AIquNzJJ23lKuYsXIxmXzDUWcjJ2OC9dR
         44v8MIBv0bN07bJlRCf4ax1/xb7XA9l344LcOjMCDHhb4SxDgQcZczElGCp/ou2uWf1V
         9y3vJXnb5+PM4dcSmdT1SpXsvQdVA/HzKn6TP7ntvNpZDZg+KHSrmUgyYHfU+Oj5PVvs
         94iA==
X-Gm-Message-State: AC+VfDyV+NVrD7v1hoJJ/zwi/mf8lMVGPHoY31OZjTfHOBv8gWplXdpA
        GpDafsT7hXzYxdYrclYiK/aFFairJA62XA==
X-Google-Smtp-Source: ACHHUZ7yfdIPbT2AR0CXHze69khAw0Y3vrftdYa9vUHLsEQj+yKVihIcz8Z52h51hnBqGPFs0Vvmtw==
X-Received: by 2002:a81:7d03:0:b0:55d:8f0a:1bdd with SMTP id y3-20020a817d03000000b0055d8f0a1bddmr11097709ywc.49.1683553590608;
        Mon, 08 May 2023 06:46:30 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id c64-20020a0df343000000b0055aafcef659sm2531209ywf.5.2023.05.08.06.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 06:46:30 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-b9e6ec482b3so6026898276.3;
        Mon, 08 May 2023 06:46:30 -0700 (PDT)
X-Received: by 2002:a25:d40c:0:b0:b9e:45e1:2081 with SMTP id
 m12-20020a25d40c000000b00b9e45e12081mr13515883ybf.45.1683553589838; Mon, 08
 May 2023 06:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230508104557.47889-1-wsa+renesas@sang-engineering.com> <20230508104557.47889-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230508104557.47889-4-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 May 2023 15:46:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV3cR7duY412HWJh+TuchfMTAJgpO2kgv1Nh_ZcRS77Qg@mail.gmail.com>
Message-ID: <CAMuHMdV3cR7duY412HWJh+TuchfMTAJgpO2kgv1Nh_ZcRS77Qg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] arm64: dts: renesas: ulcb-kf: add regulators for
 PCIe ch1
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
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

On Mon, May 8, 2023 at 12:46 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Without them, no power, so cards do not get recognized.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

LGTM (modulo changes to the bindings), so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
