Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D09D60274D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiJRImv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiJRImt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:42:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2589D3D591
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:42:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id k2so30507685ejr.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iTyZoAG1Msmk9uodk66u2eG085RCcOEtYKv2XNmOQG8=;
        b=MlC5tIQYknk7saPUItJ2DOuP94f1ZNnZVhQWVtB7n+Kd/Nrm6dfkKJuOKHhHNX7XvH
         BMXOrBw09ho8M7zMKedLCocv6dzZ0T3Qi9S2canTfhydIYettVdBmRBrwYB92V+8WB+A
         in9Kh2mh+2rfOW3pkjH4TxzWPIy/TfcIWaJQsCmTnMhDfpZp8tSrJIzGR1xeRzY0JXke
         k3ZbhSCVZbnjPpUQ91ptQJKPof3ICLYScffpZzxiLbGWqdDDbe5sX0EsWV8dl9GsQhMy
         bfmaC1aZK3I78SMGxT5CDF9oW5OUlALe61hFdW1/o92t6phVbH5faz1j+mwewEhfxv8+
         l9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iTyZoAG1Msmk9uodk66u2eG085RCcOEtYKv2XNmOQG8=;
        b=l5JQGQ5n1Jweyn3wM2uNVogjH7sSbTF6Evb6nh512iD3OTxkkFbCm2GrcYGHD487XA
         8EZT/r7jww7r7r8G+IF9iMZx/ttVQZ+Y5z7XAr+Y7qFDNCnsfdByFibnXTZspGZXYufa
         weR1OEyhzedriNKD5H8XqLeMKBhoHmozf5ZRP4ibtWTLezW8BNHlv/IHP063UdGSBFCw
         497wlYYYBGaHKkBDdhuP7SKDejnzYkbnmXi8nUnDQLcVaN0wwmS9ipZ6KZvQ7unCIbBU
         RGeDBe9Eji4Y6zDCEYhb8fWCLlHHA4v3pOL1H3qki99dE5+kxZ1WXf1A8EJPVOLtByA6
         CPgA==
X-Gm-Message-State: ACrzQf38mLvDXt43ZYGug6t0KK0Rwuy0gpRv+OYuOMOFNoI4thKzRVAZ
        Yc9v90MvaKRB2K6c/T8ATxqRjzEuG3tw55N1UIvUTw==
X-Google-Smtp-Source: AMsMyM6eNyhJxObx3NMuafA47nbI/HO2ux80D3ao6jX7hXNxj8sZmF3gpmbTjs8h2VIYXe2WXLts9a8Yo27/FXsiALw=
X-Received: by 2002:a17:906:5d04:b0:77f:ca9f:33d1 with SMTP id
 g4-20020a1709065d0400b0077fca9f33d1mr1492290ejt.526.1666082566712; Tue, 18
 Oct 2022 01:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221018070959.1322606-1-horatiu.vultur@microchip.com>
In-Reply-To: <20221018070959.1322606-1-horatiu.vultur@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Oct 2022 10:42:35 +0200
Message-ID: <CACRpkdbP=x_PZfxF+J6RRqEg2jHOrP+KfmrWe=oNvpxqM9zw-Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ocelot: Fix incorrect trigger of the interrupt.
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com, michael@walle.cc,
        UNGLinuxDriver@microchip.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 9:05 AM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:

> The interrupt controller can detect only link changes. So in case an
> external device generated a level based interrupt, then the interrupt
> controller detected correctly the first edge. But the problem was that
> the interrupt controller was detecting also the edge when the interrupt
> was cleared. So it would generate another interrupt.
> The fix for this is to clear the second interrupt but still check the
> interrupt line status.
>
> Fixes: c297561bc98a ("pinctrl: ocelot: Fix interrupt controller")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Patch applied for fixes!

Yours,
Linus Walleij
