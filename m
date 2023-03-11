Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB116B612D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 22:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjCKVtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 16:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCKVtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 16:49:15 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F70D4743D
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:49:12 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-536af432ee5so170314887b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678571352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TpdXBJ4tecgiTETU5KnmLKGnqvFo0uE6wI/ZwKi060=;
        b=nE/bwkjay8CbXb4jPjZdl/Xsenzw4L3dSxsKJNwylYD1kFCBR/VR29gvUWor8ha8a9
         28VY66ubXweop+orgHdwvtya2h6b46vDvAGq8/5HMdpUy6HndbuJeZ+WwZmpkJnxTPav
         MX0ZDk1UddZSqZ/ChtapzciOcUAyP+xqRa1gLni8+GvQex7Wn5L+r/meix4mfGaWjH8l
         BQEkhMS1JufERKr2Nz4Gj5LTnVTHWLuPOJzsF6U/WBX2qdeeJa3qhpEn9tc9yCbfV3xo
         Pj/5WWV0AOLzBzELjebOlRM33/gK2NCRG6PPnz7Fs9ifuYTqStjgc2AeFAayc7MoncpV
         DjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678571352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1TpdXBJ4tecgiTETU5KnmLKGnqvFo0uE6wI/ZwKi060=;
        b=IlclmgbrMbOhTQ6KDgWEldnjzAs/D5ubEWBE8cPdD1B8WRBHj34P0pEcvrhC4jWqvk
         tUlIeL3ECB4n9h7KxL4MOlgLjaEoJJ3hFFNJ+PPWUJxb7JWt1ayd9xjbQmPzFXteEoyz
         BPqyS0z6kq0ZdQx7yL6GP+mvcTQIUxV8ivWszr0UQE9dN7MSBA6hXwnn5Z3+AsUI/lv5
         c8Mp4oJWmlsJtGbGAxGCQxKH53GZHYu2ruXgYmMHRHVIGnKqBjgTf3VUn9vTBYLME9Pl
         29Wue3+SN60/EWLBgDWlnv9Ib7nRNGaWgmAuNaJI+OqXaab/0GfZZ4k4DaMgO0mMRTPJ
         f4iw==
X-Gm-Message-State: AO0yUKWOxIQneY9Zh8EAp34+qBe6cZC9HvJKdA3oB65E+Xd0dXpvEOrC
        35BxmxGn3+w7cnoma5RC1FyEid2viAKMOST38Djopg==
X-Google-Smtp-Source: AK7set963Uvk9/kPnpPMiLrCaYWls2se8kVKHqPvoVj8mQ7gkyPTgu5X5El+InCrUfj2HTmmNHTNnoloTVd+fRthoCw=
X-Received: by 2002:a81:b705:0:b0:535:fe26:acc with SMTP id
 v5-20020a81b705000000b00535fe260accmr19655281ywh.10.1678571351836; Sat, 11
 Mar 2023 13:49:11 -0800 (PST)
MIME-Version: 1.0
References: <20230311111307.251123-1-krzysztof.kozlowski@linaro.org> <20230311111307.251123-6-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230311111307.251123-6-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 11 Mar 2023 22:49:00 +0100
Message-ID: <CACRpkdb_t+RNSaxq-h6nz8R6Z6d=SD75m5w1tzVFn-qa5pdyVQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] gpio: sama5d2-piobu: drop of_match_ptr for ID table
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mun Yew Tham <mun.yew.tham@intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Nandor Han <nandor.han@ge.com>,
        Semi Malinen <semi.malinen@ge.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 12:13=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might not be relevant here).
>
>   drivers/gpio/gpio-sama5d2-piobu.c:230:34: error: =E2=80=98sama5d2_piobu=
_ids=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
