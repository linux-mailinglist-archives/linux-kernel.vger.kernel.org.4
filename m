Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40845F151F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 23:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiI3Vno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 17:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiI3Vnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 17:43:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F1A1830D7;
        Fri, 30 Sep 2022 14:43:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 423AD6250C;
        Fri, 30 Sep 2022 21:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE98C433C1;
        Fri, 30 Sep 2022 21:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664574220;
        bh=cCxNQIjIu1jNntjn2xhR5wc6ij2taNke8th6cN78c5E=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=rFY9wr8CYLbDOcXptxhlvN4KgrZInkSPQNB/j1WLDoiemQ6ji2nZbmFWV68JnjEj7
         6/cLcwHXqpQFiaUgwExT+ZRiYOvry++b349qmIp8MFSiHr+Fh0nXI3JJAe4Ny6WI6E
         Q700N4khg7H/6bwqzXDkz1FZbgVHxVF4ZjFiNk3XIqd9E9mOL5FQi09SN8eTRN2pyf
         u8DSrgUwFPf3DF0BviD2PXaxbuduG1AXvnLrQz3NI/k/OLNbTHBZmH7VF52sH6GvCQ
         ENI5DqKiq3CTNsiCRHr9wkuBJxpN6Ge+DhchdfzKOrMkewbhtgki9q6exoK9vgQKXB
         yr84tiuUhpNGQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220929175459.19884-1-hal.feng@linux.starfivetech.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com> <20220929175459.19884-1-hal.feng@linux.starfivetech.com>
Subject: Re: [PATCH v1 14/30] clk: starfive: Factor out common clock driver code
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-kernel@vger.kernel.org
To:     Hal Feng <hal.feng@linux.starfivetech.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org
Date:   Fri, 30 Sep 2022 14:43:37 -0700
User-Agent: alot/0.10
Message-Id: <20220930214340.8FE98C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hal Feng (2022-09-29 10:54:59)
> From: Emil Renner Berthing <kernel@esmil.dk>
>=20
> The clock control registers on the StarFive SoCs work identically,
> so factor out the code then drivers for different SoCs can share
> it without depending on each other. No functional change.

Sounds great! No functional change! But to verify that it is pretty
hard.  Can you generate the patch with `git format-patch -M -C` and not
rename anything initially? I hope that will allow us to see that really
nothing has changed except code is moved from one file to another. Then
the next patch can be the sed command to rename to starfive.

As the patch is right now, I'm not particularly interested in going
through 700 lines to make sure nothing really changed.
