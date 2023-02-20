Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528AC69C862
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjBTKQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBTKQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:16:07 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C6E16311
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:16:03 -0800 (PST)
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B269F3F71D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 10:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676888161;
        bh=fKd9fxybT9+hFfyTDDr2Mtw7ZX+21Hd2dT0jDnkibYM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=tRLcIaWxDCXwruIFB/pF04r4bvV/4oy8w/TsPsD9Ijd2oJTnkKEwyoKst2TayaiDr
         KQXCkpLvVl15Z3b+Yuu8XYA7S0ETBth6ZxrXSpbiC7ugTjElm8bH2g41d7xqdfnrb3
         mYt0LotLWDCwKv365VpewV1YCVbFnT8NsYloMEO723uAwvgOCGsIsmzMAbijeDcWld
         7EEFfs4MUM4xt855p8ojj9Kl4RqM3FuWtaJOF6o2YrqfNlt5NYa1vb21NfOg7zOAVS
         QZcERLcpISKslJUVCSQ0VborlhchrYRBPL4dgqASfO5iYzn0J/ed2y+KsFa0sXpXru
         EjwVnKRq5o83A==
Received: by mail-qv1-f70.google.com with SMTP id pm5-20020ad446c5000000b0056eb3830243so207173qvb.16
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:16:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKd9fxybT9+hFfyTDDr2Mtw7ZX+21Hd2dT0jDnkibYM=;
        b=YCYSLHRh338ymTPYoCeO5w423VSW7lZNtHap6oM3N6mtv8k75B37a5P5OY00576/Z9
         tGOGQUF/2jfk4ta0EVK6KozOa3ADgc6MAOSPtNs/tTE08S4M2lWgUjWl3XnxH6f6qDqt
         gSgldE2PQAOZmsvZWzg/2hgcWpVtGcs0JWmAdA8Y7KENMTUqaJpu3uObnHLtJgiuKtKj
         dRD2ktyLgMMoyfiz6PHXwYkQ1al4l0LMpVgpfY7EaR1mk34zeXTZIJuLox44TqmAOltl
         cJcEoGx6ayV+lNbQSFH7Bwu3gaa2XEFgcDhK7i86mDYekmHLNWQ+xr0BOolAt3Mo1WA4
         p62A==
X-Gm-Message-State: AO0yUKWJLOxR42fJbImxi6PtAx0rRngfZxkLzbYUC8ifeAvU0/sUN01c
        sn8TP9CV+PNZBS2FLpzY/GEWbv1GFoTpT9wDyMqSbgdSXRNDnYgzkXENBsT/LS4TSjLlZpMu+uH
        uEjWJuHXgAoz9QfdPD5pxPrmhVIsYXUjLhKBaC9fZJqVHBPR1kZ/PXAcrfQ==
X-Received: by 2002:a0c:d990:0:b0:570:fc87:4f2c with SMTP id y16-20020a0cd990000000b00570fc874f2cmr203800qvj.83.1676888160751;
        Mon, 20 Feb 2023 02:16:00 -0800 (PST)
X-Google-Smtp-Source: AK7set/YEwtnCc0MdoLEDmbY+Jh+bhbVGYGL0//BwQFePHm998lWNjLRhslfWc3fYUt397bZwhY8xJy7wcjRn5Bnl4Y=
X-Received: by 2002:a0c:d990:0:b0:570:fc87:4f2c with SMTP id
 y16-20020a0cd990000000b00570fc874f2cmr203789qvj.83.1676888160500; Mon, 20 Feb
 2023 02:16:00 -0800 (PST)
MIME-Version: 1.0
References: <20230209143702.44408-1-hal.feng@starfivetech.com>
 <CACRpkdbao9M5dMHFO_QE8z4_E6DZLZsMUW1OnUNjKSfQc59=ew@mail.gmail.com> <4211d93d-702c-6759-6f25-f86160c0be5d@starfivetech.com>
In-Reply-To: <4211d93d-702c-6759-6f25-f86160c0be5d@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Mon, 20 Feb 2023 11:15:44 +0100
Message-ID: <CAJM55Z-+Cxdebcn4MLXfQdOVhx4c2SQ+zMH8cjn-Yq35xO8g0A@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Basic pinctrl support for StarFive JH7110 RISC-V SoC
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Andreas Schwab <schwab@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Feb 2023 at 09:25, Hal Feng <hal.feng@starfivetech.com> wrote:
> On Fri, 10 Feb 2023 23:45:05 +0100, Linus Walleij wrote:
> > On Thu, Feb 9, 2023 at 3:37 PM Hal Feng <hal.feng@starfivetech.com> wrote:
> >
> > > This patch series adds basic pinctrl support for StarFive JH7110 SoC.
> >
> > This v4 version applied, the driver is in good shape and all bindings ACKed,
> > nice work on this driver!
>
> v4? Is this a typo? This series is v5.
> Anyway, thank you so much!

Hi Hal and Linus

I'm curious if there is a plan to address Icenowy's concerns here:
https://lore.kernel.org/linux-gpio/52dcbe48dbf5f2561713a9642943353216fef15a.camel@icenowy.me/

The problem is that input from "GPIO" pins is configured a little
differently on the StarFive SoCs. Instead of having a register pr.
pin(grroup) there is a register pr. control line to the peripherals,
and into these you write the pin number + 2 of the pin you want the
peripheral to react to. Why +2? That's because 0 is a special "always
low" signal and similarly 1 is a special "always high" signal.

With the current bindings one hacky way to solve this is to treat
those two special values as kind of "virtual pins" that will always be
high or low. So that would be something like

pinmux = <GPIOMUX(GPIO_ALWAYS_LOW, GPOUT_IGNORED, GPOEN_DISABLE,
GPI_SYS_USB_OVERCURRENT)>;

..but this means we might need to mux these two virtual pins to
multiple peripherals. I'm not sure the pinmux framework is prepared
for that.

/Emil

> Best regards,
> Hal
