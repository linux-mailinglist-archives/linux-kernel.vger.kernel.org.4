Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA5F643571
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiLEUQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiLEUQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:16:49 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1352D275D1;
        Mon,  5 Dec 2022 12:16:49 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id gu23so1184994ejb.10;
        Mon, 05 Dec 2022 12:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/8PD+0FCsCI5+iBj2b9lGbdoNFHsSi0yThSh9yKErQ=;
        b=fUbiS0O5RNRd/6YLOHExF2EWqK3wCnZYEzYQ4vhl8yHzO9NXLOjsX5fBHsMsG/YpO5
         0EuncsVTRMxs4LWoQgA/NRhKu14AudrbM/hnQQb9DQC4LB9c+qntnAXbRNQApfSWxs6V
         j4xx3bRA+KLz+Celw7jK8swAP29jnoPHm74MD/uhy42TMmO0zTzfEumgpztQz96OaGvK
         E/N/JbvJrOhBiqz3bXE4j0RryuTnVT4kxSbGltjKjd391OvIgsl9i5u67jLFFJ61tI/J
         X5nRNnN/n87a4iR+vgfECNf8cvmKsCgWpUBB1GlJUknuMkThb5hDhceDlLS2kZNKPhFw
         OxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/8PD+0FCsCI5+iBj2b9lGbdoNFHsSi0yThSh9yKErQ=;
        b=XQZ3pFxuhYc8K6lbVomIFs/Lfu+KZu/J9GrtvCCdRDkeYh5CP1TM31DDODVrAjKU/a
         FGDg6ViQVtIifycp93H9pwmbspyYxy/1NtMm1tp9G26GMKfZCvTxc8qrEoviRHMll+ns
         9xnQnf9pBPmTKcsXakrooTaWe8qW91pbzrRQ9a5Cb6vpiLl30iMtziPNcMTaiRRciWyN
         FoY3SdUhmyeSKn8JSf2akt/eCqpylU5B/3YOyKLhtu3SEFfdkG2itrMjOifaWidFzwqq
         6utAT9Uj4MYrT7hDJTZUCof7uWjPPRtx//p61kD2GKt6lMXldzPY2HyBWxpsDN2CEwhj
         qT+w==
X-Gm-Message-State: ANoB5pl/fhqktQmehCLWFpLP6SDepJ2Gri8c4cUEIAEUB597wS/+nq5L
        mG6kUgHF/psJg15HfLr37SU=
X-Google-Smtp-Source: AA0mqf74Gku64+ob6YAE4dV316Y74LBb5vnlKktLNPxs0a6p3f6Hx/aBnfk8Np3/5dcuHpYly/Z3Ww==
X-Received: by 2002:a17:906:830f:b0:7c0:a3c6:e788 with SMTP id j15-20020a170906830f00b007c0a3c6e788mr8193345ejx.476.1670271407686;
        Mon, 05 Dec 2022 12:16:47 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id og40-20020a1709071de800b007c0d6b34d54sm3218302ejc.129.2022.12.05.12.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 12:16:47 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 2/5] clk: sunxi-ng: Move SoC driver conditions to dependencies
Date:   Mon, 05 Dec 2022 21:16:46 +0100
Message-ID: <1834760.tdWV9SEqCh@kista>
In-Reply-To: <20221126191319.6404-3-samuel@sholland.org>
References: <20221126191319.6404-1-samuel@sholland.org> <20221126191319.6404-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 26. november 2022 ob 20:13:16 CET je Samuel Holland napisal(a):
> Do not duplicate the same expression on the `default` line, so the two
> lines do not need to be kept in sync. Drivers stay disabled under
> COMPILE_TEST because of the `default ARCH_SUNXI` applied to SUNXI_CCU.
> 
> Three drivers had no conditions.
>  - SUN6I_RTC_CCU and SUN8I_DE2_CCU are used on current hardware
>    regardless of CPU architecture.
>  - SUN8I_R_CCU is only used on pre-H6 SoCs, which means no RISCV SoCs.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


