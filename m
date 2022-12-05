Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9FB64357B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbiLEUUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiLEUUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:20:02 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A778B23EB5;
        Mon,  5 Dec 2022 12:20:01 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id bj12so1173717ejb.13;
        Mon, 05 Dec 2022 12:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TV3EVJDFpv4jOhLs+2U0Y+CL7NCFB0EHmk1Lgv928eY=;
        b=BSQJhsS3OA+Ovo0B4IA5Je8a9KnMZOgilgB96Hqy83RmfZIu8I/3bF8NuJD4Bees1s
         LZ56j4nj5Z3SUuvqOJ+MuopONKJCBSwTalZH2rU8+JNhYeJ5QoyCTotj47BN/86AIyny
         mK69ky+rSmdHF5AWDgv12DToeZ+qqiDOEilVD3ULnKBahQzA8VfmEnEo4SMAGS25VIR9
         S/KW6AExvmAGyNWusrzTVOsdaviAT2WIG7SidYuCvZDCPuEVfqIw7ZjtB2JTvsfqWgOm
         6yh6cZ5ewu4GraN+COcaZVrYgTsdfedbiPMdz7yXok3Ood+meGLxZle6rUNQBwdooxmV
         1PjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TV3EVJDFpv4jOhLs+2U0Y+CL7NCFB0EHmk1Lgv928eY=;
        b=Kvg/bwnXwyxPwSzRE9cz9cfHpoO6HWqAm8O4jvKSFywyGEhTH+es0iA5Mc4OLrh+DX
         dPUsjvxDVmZgCA2gDvBoO5+YNI7dYj2V4qQqr98y7VXh/vq2DnzJ92z0Pa2uGCpnchCm
         m62KIKul3bXN4lMHiWUWfm+jUWtfSZ5PPIfjyt8ctp/+e4BAFhgpmnBvFEDrcPz91fGy
         Npd9nQN19UGkhR1Q6EaAWJE3xycdNgXrfCO7nk7a6J4NbwKEUylYAfYd2NN2Wg7NJuoo
         kdVX8H4lPIO/04I3hCtqlWdAbi6kpbCVcaSrTaFCRh1ENkNjoN0zlqht81T4OR/AhFX1
         f05w==
X-Gm-Message-State: ANoB5plfuaVdzPR4cEs/f3LPZK9Bp4ErxBDeKOjYUBS192MTVUloNFL5
        lO4PmKwekYWW3qTip5EDSPNSt4FWIim3Uw==
X-Google-Smtp-Source: AA0mqf4ItSWy6T3/K9bcouoUMH6PqWFkMCl6j7AE3eINXvaqYbYe9sBm4iEB2h+5BCwvs63xemtfOQ==
X-Received: by 2002:a17:906:99cb:b0:7bb:7dda:7d3c with SMTP id s11-20020a17090699cb00b007bb7dda7d3cmr22532235ejn.182.1670271600173;
        Mon, 05 Dec 2022 12:20:00 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906768300b007c099174a12sm6718941ejm.178.2022.12.05.12.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 12:19:59 -0800 (PST)
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
Subject: Re: [PATCH 1/5] clk: sunxi-ng: Remove duplicate ARCH_SUNXI dependencies
Date:   Mon, 05 Dec 2022 21:19:58 +0100
Message-ID: <13153056.uLZWGnKmhe@kista>
In-Reply-To: <20221126191319.6404-2-samuel@sholland.org>
References: <20221126191319.6404-1-samuel@sholland.org> <20221126191319.6404-2-samuel@sholland.org>
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

Dne sobota, 26. november 2022 ob 20:13:15 CET je Samuel Holland napisal(a):
> SUNXI_CCU already depends on ARCH_SUNXI, so adding the dependency to
> individual SoC drivers is redundant.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


