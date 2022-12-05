Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AF9643680
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiLEVJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbiLEVIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:08:40 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F464CF9;
        Mon,  5 Dec 2022 13:08:28 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id t17so1564650eju.1;
        Mon, 05 Dec 2022 13:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agcdnOZfTcz01ftPLLH5YMZ3Fbx9lBJzltNoiQrFR+s=;
        b=j6yTJsTL8qepaX8DqJDzhxPqyMFSSr9UHtJaYRq7pFTo1scVBVAoPoNO9fd+w9+mtw
         KlVZ8BQQoW6Jn+Ssdy7FYNrxyHTyRAx9Rmmjusl795QXgGtD49cmNWIi9YMjZWiCluIt
         7NMLQHB2P4TURyMU2Ynj0YtMRw2QgqGQ1NK+iU9u4+QpyYNL0nVYfqQaxb7rVBES6q5q
         Hre4+TyC0DIRhJlVzUexoqOIBMYo0AILJEeJlWtFrM4fmm++vIhISCLhkNDt9bG7d59R
         08EZnTv1BCpvgIkrva/r/54hBJGfv4wmnwrZXW03qN754GM9mxOmTa0k7hdbzEEdG1M3
         WtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agcdnOZfTcz01ftPLLH5YMZ3Fbx9lBJzltNoiQrFR+s=;
        b=3FdIXI0smOmPuM8wSLVt9p1qN91h8zyYkEsafPuXMNzPkvPx6LjLS4imxx+pg7WVtt
         NCbh4XBTC90sKxv8impohcUSnhT7VvT6fUTjVJihhD8myYWIhf28qQumW5vux9Lr3BAf
         TB4ip7um1/fD1op7Kawvi5GHeb2VEMWfz1keNZVVIdG6lue7ACdtnuBoJyM7lEPxtV0L
         zv3aymnlucGQAJMO1juVQxhJN/L3jO/xGR/jWL4k69wLzHAXxE94y1VsNPbgw1DgNJzq
         2ZW8LnC1aDN5eJ/hQ92kMlFbCYhQ3Bnx5nujecS5BGqrkG0I+6+bAFxuT7czXCkiTbbZ
         Aopg==
X-Gm-Message-State: ANoB5pnDcREGgWFy6wIVjRTvFdgq3glBg5dsBrkAxyMaByD+NLhrGMKx
        GCscq/lqYI+b2Yay/eMVD6o=
X-Google-Smtp-Source: AA0mqf7UYHn6BfmpFxzltOtoTcchK9jnayi5HlZKBfCxXnfdPKi82ql/WWuz+zmdC/wM54/tLPE1tw==
X-Received: by 2002:a17:906:e244:b0:7c0:f9ec:1dff with SMTP id gq4-20020a170906e24400b007c0f9ec1dffmr4431123ejb.283.1670274506851;
        Mon, 05 Dec 2022 13:08:26 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id u15-20020aa7d0cf000000b0045ce419ecffsm221838edo.58.2022.12.05.13.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 13:08:26 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v4 4/4] soc: sunxi: sram: Only iterate over SRAM children
Date:   Mon, 05 Dec 2022 22:08:25 +0100
Message-ID: <5320657.Sb9uPGUboI@kista>
In-Reply-To: <20221125040112.18160-5-samuel@sholland.org>
References: <20221125040112.18160-1-samuel@sholland.org> <20221125040112.18160-5-samuel@sholland.org>
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

Dne petek, 25. november 2022 ob 05:01:12 CET je Samuel Holland napisal(a):
> Now that a regulators child is accepted by the controller binding, the
> debugfs show routine must be explicitly limited to mmio-sram children.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


