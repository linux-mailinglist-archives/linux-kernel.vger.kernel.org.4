Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A61602630
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiJRHvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiJRHvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:51:25 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5728831F9C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:51:23 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t16so34626edd.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nx4cJDlCKZ9fU1HAj805dfsVKCPNxoVsjTzwe56667E=;
        b=xLsyuuLUYCg+D40GpLmV+wGnd9NUl9GyPGOO/imPfZMlKB0iDVh2PM7B7xKKNKLKkc
         3n9llVb0UyT/JKAfl2w1HcghTSnq/VAuQEZJZhm7lZ87/RoHj9e/ecw6xmQnYP6oPjdW
         QfOxY8e/4jM7hFJSk9LCaD0OWgasTXKoBwslX75QqzjvO8/w/GKhmEl01eTK23g9VS/r
         k9LVI8k3eQKQb2OBtLx6HSrmf6v6E60LXifZJtGMB5dd/mkpmIb51gMvFNIypMK0xsJw
         V/D4SICRJFo/ACkbfsyeG2DX5XQCMcatHTpm3BJlZ8AVrQOJC2Lb32MHcpHFg1wwaFT2
         AUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nx4cJDlCKZ9fU1HAj805dfsVKCPNxoVsjTzwe56667E=;
        b=es0gWT63610X8DfQDlH2qIUUueYJl0INMMveYE9/BnbUyt9X0O55NS2rS5U4Hxr+6Q
         uc6arats45BSOUrKiaF3xStCgBbsPb3ymc7jabsgb+7NK9KsSttCqLBT1SYKA4LBond5
         K7NscvHvWzEFcuojAeDtzjTkeIn/5qn96tMmpYzTJtLtdYYpJc086CR075CwZLKllbe1
         I3V6FiU3KvMZdYlKwXNEKMmiSYvG3Aol+RPfC7voXpgH1VlCugV1pl5HNfzr7C1QPaMn
         twtrMMV10yabHj1cKJztrKLFluFpSTHTAtQvTzqLTSKNc0cYDbJY5r8ZmJplA0Llr9xp
         sLkw==
X-Gm-Message-State: ACrzQf3ZL2KX92M6EnzPr06v9OkyeCyGcEU9u3mOmm6XFiXrAgvHFRI7
        Ssl6ktEM9ekCMGYQYyuUCPjgfokO4QlBQNw5JdW53w==
X-Google-Smtp-Source: AMsMyM604N7NwfiJE52AGqgGfOvE09PuWjXnLOWzzJRQX1fQtc0uH2fKcV0YGuRX5XKkil/Gf0sbEs+8WxVgO0N5hps=
X-Received: by 2002:a05:6402:d0b:b0:458:a244:4e99 with SMTP id
 eb11-20020a0564020d0b00b00458a2444e99mr1489708edb.46.1666079481948; Tue, 18
 Oct 2022 00:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221017130303.21746-1-sai.krishna.potthuri@amd.com>
In-Reply-To: <20221017130303.21746-1-sai.krishna.potthuri@amd.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Oct 2022 09:51:10 +0200
Message-ID: <CACRpkdYYvznEKQ0huj5XwNwghMP-FRw5e54Di9FLVdXdsFP3-A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] pinctrl: pinctrl-zynqmp: Revert output-enable and
 bias-high-impedance support
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        saikrishna12468@gmail.com, git@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 3:03 PM Sai Krishna Potthuri
<sai.krishna.potthuri@amd.com> wrote:

> Having support for output-enable and bias-high-impedance properties
> causing system hang with older Xilinx ZynqMP Platform Management Firmware
> because there is missing autodetection feature.
> When this feature is implemented, support for these two properties should
> bring back.
>
> changes in v2:
> -> Added stable tree tag in 1/2 and 2/2 patches.

Patches applied for fixes!

Thanks for dealing with this, I hope you find a proper way to make
it work with all firmwares.

Yours,
Linus Walleij
