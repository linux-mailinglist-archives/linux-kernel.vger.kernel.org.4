Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F6162C7A2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbiKPS3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239173AbiKPS3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:29:36 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000684731C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:29:34 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v1so31294681wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERYyKyRjwjlGO/N6ix60VXwlsLrg64yLVcy7mpteO90=;
        b=hqPr7d/V3fZKLMeVbutYZ0JtcE7oK+judWUHu7EAXUO33J8x+TOr/PUNxRipOtTso4
         F2rCXw0i26gd8r+25CAvMKuBjYFjhl3CgWoz95kuftIAs0xqMZSfYPO64SvuGkgmePU7
         6fKMCvTkNPGWf8iZK32rKZDTMLr2LwS7b4w909q+2QOb2wxbiv25z2kYlo5OsIsZm8id
         bDzPJtNdu/WpfuccOio6k2CrwCDyfsKgWwWmwq1aK5gwQN4gUJO9wandBFHKDpp05IOD
         +dgtjZGb/s8K1DM9zsT06gEXghL883cViavEMLLi301W7PLES17yxgM8OAT8Krf7g0Ow
         vm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERYyKyRjwjlGO/N6ix60VXwlsLrg64yLVcy7mpteO90=;
        b=i7jdla1XUHroSLqIVLqP92oLehgzuuGxGI9njEjIQ7ZmGsiqIycSCa74vFVbsmcp+n
         fO77Wc+ZsEnmEM92VHlYFYKlA8nzKUsnOq3aSDbFBNazFrnXeIc8uVWTeWRRoUWvi0xE
         hc51NRDcZiKvnTEBX0zypo8K7Ypxn5y+Dq4jiBc8hm8ACnOHGjiLQXyTq2w6JNXWFC8+
         QvN9tN8PoFpCRJoC5Y54qF11jRBQqVyogtwlSBEuoqWpyFYxNXi0QeM66Z8NtJz9E+xw
         Yy/WvLN+LMGp1pAkmrdvVGTw45YNzNHEEZdX2cG/fxjYu5W/MbBgl4umMArvgMALcG1H
         KFLg==
X-Gm-Message-State: ANoB5pn+2v+xlQzSmYs5r4mqYTeQXp5ylurTjWGbS7y3aQihUUyO+xzw
        /WPJPpvODILNTOmVhxReJMw=
X-Google-Smtp-Source: AA0mqf5cEs0Y3RtVt9snW109hI+LcRC0mRYfN9+j0PcJpB67W+6JFrMr4YfiTFsC7TYDDbq30EmHQg==
X-Received: by 2002:a5d:4562:0:b0:241:8103:769e with SMTP id a2-20020a5d4562000000b002418103769emr11599566wrc.240.1668623373384;
        Wed, 16 Nov 2022 10:29:33 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id co19-20020a0560000a1300b0022e66749437sm15843182wrb.93.2022.11.16.10.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 10:29:33 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 0/3] bus: sunxi-rsb: Fix poweroff issues
Date:   Wed, 16 Nov 2022 19:29:32 +0100
Message-ID: <2654128.mvXUDI8C0e@kista>
In-Reply-To: <20221114015749.28490-1-samuel@sholland.org>
References: <20221114015749.28490-1-samuel@sholland.org>
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

Dne ponedeljek, 14. november 2022 ob 02:57:46 CET je Samuel Holland 
napisal(a):
> This series fixes a couple of issues that occur when powering off a
> board using a PMIC attached to the RSB bus.
> 
> These issues only affected 32-bit platforms, because 64-bit platforms
> use PSCI for pm_power_off(), and the PSCI firmware reinitializes the
> RSB controller.
> 
> Changes in v3:
>  - Adjust patch 1 commit message
>  - Clear the interrupt status register after polling
>  - Add a patch refactoring how the status bits are cleared
> 
> Changes in v2:
>  - Add Fixes tag to patch 2
>  - Only check for specific status bits when polling
> 
> Samuel Holland (3):
>   bus: sunxi-rsb: Remove the shutdown callback
>   bus: sunxi-rsb: Support atomic transfers
>   bus: sunxi-rsb: Clear interrupt status before each transfer

Applied patches 1 and 2.

Best regards,
Jernej

> 
>  drivers/bus/sunxi-rsb.c | 56 ++++++++++++++++++-----------------------
>  1 file changed, 25 insertions(+), 31 deletions(-)
> 
> --
> 2.37.3


