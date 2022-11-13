Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABE1627296
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 21:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbiKMUlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 15:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKMUlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 15:41:01 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE2413CFA
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 12:40:59 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5so6102858wmo.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 12:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:to:from:user-agent
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=smMBG8cth6Wetp8FRPQwBWABZlQNfxVO31AeOc5lUC8=;
        b=JEVEeqze3UWXQn+koWcOG/UYGjm8nnam7/ZT1kq93GITnzz0svZPjyJjIbeGkrMhKY
         f+wWDphZaY5X0RS6HDGXS098J6iKV3q5d4XFJkWcg5PhvCj17J+ajy4dZGFaEdM689ND
         QppIbT6JM0Rq0184K0CBNc6QSBRlRiUv8N5C3M8C3nsqvJq5BYnl7dqvdVPwo5farIcH
         uuYDpi7Eywn0wACmBjB5/XuilV++BSUH4cytjAAiRKsN34CigB2mEw91IM3mHWCsbsv3
         3+uAe5prI0fFbgVE/T+Ree/+K70r1oRnx3/Ftv898mpo5twBX3cuJ4Nu0qDwc9VNX7NS
         mTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:to:from:user-agent
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=smMBG8cth6Wetp8FRPQwBWABZlQNfxVO31AeOc5lUC8=;
        b=myepTE2+xEtNjqzWazUQ0pOmBksyUi+fQRVkPf72SvP2EPgYydD7f+LcjVsqKIxwjP
         RxF4+/nWsWzIyIwfSIVRM8AzIvrVOtjeOiRyMxnh0E8T9f8Bsr0un9uCww/jxwMBSZFl
         Vx90GFX2/zok76reivg6p3P//76n5QVQp5jqpWVQBGKXdC0GlYx7EAZ6KrZpMWfDzc7v
         wlGa6ta6p5iqiR9j4BypVyFss3k37HYXbfXi0lkCT3S0zdtAgcH0WnIUpgp1ZoC4LJYD
         /iXi0hhrdCbSX3NS5hYzSxXFFaJ3gzHTGIezYM+IsourmWozbYAa/trd5GqfxmmP8dYW
         vrSg==
X-Gm-Message-State: ANoB5pnLj8lroi8lOMTrHUUukWe69VxZj2tfHEkwIoPyi0eK6utaVo+T
        UbmT2syWs7JgO0d1BOWBQsG5Zg==
X-Google-Smtp-Source: AA0mqf6DKEqamvPE5yKKuqNWJTOSNf6Z6IDCyJRkxZBFiXxsNuUILEzLvjWteuvVbXn5OMMxZPkt0g==
X-Received: by 2002:a7b:c00b:0:b0:3cf:a985:7692 with SMTP id c11-20020a7bc00b000000b003cfa9857692mr6261764wmb.104.1668372057473;
        Sun, 13 Nov 2022 12:40:57 -0800 (PST)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003c6f8d30e40sm17246093wmq.31.2022.11.13.12.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 12:40:56 -0800 (PST)
References: <20221110150035.2824580-1-adeep@lexina.in>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Vyacheslav Bocharov <adeep@lexina.in>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] arm64: amlogic: mmc: meson-gx: Add core, tx, rx
Date:   Sun, 13 Nov 2022 21:06:44 +0100
In-reply-to: <20221110150035.2824580-1-adeep@lexina.in>
Message-ID: <1jk03y37vs.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 10 Nov 2022 at 18:00, Vyacheslav Bocharov <adeep@lexina.in> wrote:

> The mmc driver use the same phase values (core - 180, tx/rx - 0) for all
> meson64 platforms. However, some platforms (and even some boards) require
> different values

Where does it stops ? Trying to solve the instabilities of this
IP/driver by tweaking the phase has proven to be dead-end.

Soon, you'll end up tweaking these settings depending on the on
particular version of the device because it ships with a different eMMC
manufacturer. Then comes multi sourcing, sdio modules, sdcards ...

> (axg for example use 270 degree for core clock).

Where ? Upstream linux does not

u-boot does something of the sort for sm1 and I'm not entirely sure this
appropriate either.

IMO, this setting has more to do with the mode the mmc device is
operating at - not the platform or board.

We had some discussions with the HW designers at AML and they recommended
to keep a phase shift of 180 between the Core and Tx. They also
recommended to leave Rx alone (actually, starting from the v3, the Rx
field has no effect. It is not even wired to actual HW)

Funnily, that is not what the vendor driver does. It also does A LOT of
extremely complex and 'debatable' things, which mostly mask how much the
driver is unstable.

With the upstream drivers, modes up to SDR50 and HS200 have been stable
lately. SDR104 and DDR modes (DDR52 or HS400) remains problematic.

Changing the settings further would require more discussion with AML.
Blindly poking these value until you get something stablish for 1
particular use case is a recipe for disaster.

> This patch
> transfers the values from the code to the variables in the device-tree files.
> If not set in dts, use old default values.

I think going that way is opening a big can of worms. 
I don't think this should be applied

>
> Vyacheslav Bocharov (4):
>   arm64: amlogic: mmc: meson-gx: Add core, tx, rx eMMC/SD/SDIO phase
>     clock settings from devicetree data
>   arm64: amlogic: mmc: meson-gx: Add dts binding include for core, tx,
>     rx eMMC/SD/SDIO phase clock settings from devicetree data
>   arm64: amlogic: dts: meson: update meson-axg device-tree for new core,
>     tx, rx phase clock settings.
>   arm64: dts: docs: Update mmc meson-gx documentation for new config
>     option amlogic,mmc-phase
>
>  .../bindings/mmc/amlogic,meson-gx.txt         |  7 ++++
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |  3 ++
>  drivers/mmc/host/meson-gx-mmc.c               | 18 +++++++---
>  include/dt-bindings/mmc/meson-gx-mmc.h        | 35 +++++++++++++++++++
>  4 files changed, 58 insertions(+), 5 deletions(-)
>  create mode 100644 include/dt-bindings/mmc/meson-gx-mmc.h

