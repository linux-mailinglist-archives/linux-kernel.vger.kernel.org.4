Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4052656092
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 07:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiLZG4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 01:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiLZG4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 01:56:05 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E842D61
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 22:56:04 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id k4so5569158vsc.4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 22:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nKoRBsCZk8t5IRW6q7FXOzmG70vM+tRWxxCkDHcgI5s=;
        b=Gh5L7i4lMdFGdpQcVXbyK2egNp5Z1yUnv6IBSCJIVgNBy8xEcu7FXNb0L5gzT9eP8z
         C+nRl2MuAO3DcFB2eY31UCof7isEZbIuENKeIinzKjIcHW2xZR/p0Qt8ht2DLvLrlMdA
         NtcVKDhvzKfjPGz17B1xY5nsAyPsyGGHsbTwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nKoRBsCZk8t5IRW6q7FXOzmG70vM+tRWxxCkDHcgI5s=;
        b=U1/cQTed08vyJd00VEQWqt33eoq4OhqHADQCflO6ttgVKbCJKE4DOtw+/0eYf6MJZA
         zA6/1bW6WuJU3WGiNAwaWN4iWHIpL3J0stFvhURk36Wzy85xc3j5/RYNiqpM3ojEZ5e5
         NFSQMIY4xy58ylqt01k8v1ujKVbrwP5x+izCkfCQoqg6V4t0g+Q/f9MCk6IciihYIZsF
         V0oogJntTtqKuWsknfRZLqTHydJbPMJ2piL/gr8PeY8znpB0yWicOl977fgtMO9wtL0c
         9hNiHIhklMw01V6baMDxjcTdY8p5EvOxCruZyu2kRy8FWnT2PNNxn6rSQrj3MbXfWqy+
         W1+A==
X-Gm-Message-State: AFqh2kq6H24uTcIzLMQvy9P0o1eKngnhr5XAodhbSd1QHXPhJ+2gwBnL
        bd1hIXxI2MjlkpAeOsFcBJsW5drut1bFHHipHiVPYg==
X-Google-Smtp-Source: AMrXdXtihqlxHKqphDrGOCSc3OcIsPQPPIjiFqufrI1F9HDNZwbnCYgvr87cVSS4ITP2veDTDo3oR+pGal+18iKFQm8=
X-Received: by 2002:a05:6102:4427:b0:3b0:6da7:39ba with SMTP id
 df39-20020a056102442700b003b06da739bamr2383130vsb.26.1672037763548; Sun, 25
 Dec 2022 22:56:03 -0800 (PST)
MIME-Version: 1.0
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com> <20221223094259.87373-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221223094259.87373-2-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 26 Dec 2022 14:55:52 +0800
Message-ID: <CAGXv+5EQDzgT+1VL7MDNGzHXCa4WheemP6Ysn5=3sF6Gft=V0A@mail.gmail.com>
Subject: Re: [PATCH v2 01/23] clk: mediatek: mt8192: Correctly unregister and
 free clocks on failure
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        fparent@baylibre.com, chun-jie.chen@mediatek.com,
        sam.shih@mediatek.com, y.oudjana@protonmail.com,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        ryder.lee@kernel.org, daniel@makrotopia.org,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        pablo.sun@mediatek.com, msp@baylibre.com, weiyi.lu@mediatek.com,
        ikjn@chromium.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 5:43 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> If anything fails during probe of the clock controller(s), unregister
> (and kfree!) whatever we have previously registered to leave with a
> clean state and prevent leaks.
>
> Fixes: 710573dee31b ("clk: mediatek: Add MT8192 basic clocks support")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
