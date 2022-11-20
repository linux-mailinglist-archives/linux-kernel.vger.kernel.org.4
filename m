Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06D263159B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 18:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiKTRva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 12:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiKTRv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 12:51:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38BC2409A;
        Sun, 20 Nov 2022 09:51:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EB2AB80ACB;
        Sun, 20 Nov 2022 17:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF86C433C1;
        Sun, 20 Nov 2022 17:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668966684;
        bh=79AEpTRKQTWAHAOHI8JWsnFg+OvIT75uE0KkDyA7TBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VYJtJIqCGToiTZSAcm3HB63P+y+LabQen90VlfxF9pvHQbbrS//M3+uKXs5PXp64Q
         FTILDxaIAThcKYLlmFzTdf2nbS5EPWYo5x+Hg460Mvu5nAFOZLfpXXBab8CcbD3eUp
         647cTkmnfvK1GHRnHqjLHnVICdeYdvaPGHzxaTJGhCe8ZUqSouR4BouRThVaEeeCjX
         jX/U8rUY9zPz5veeKvH2rt9H0cr3VB9aixE/MWjoTw70uiBop36wp/eY2/tkS43ak/
         +2WH6GQfTnaYA9tOZCnF+rWETLQa1yQU3n8NYRHEzMrtX7irEMJ4geKyHZcuybyrs3
         3u4VAA9imcbhw==
Date:   Sun, 20 Nov 2022 17:51:19 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 5/7] riscv: dts: bouffalolab: add the bl808 SoC base
 device tree
Message-ID: <Y3ppF88SuYAPOjbU@spud>
References: <20221120082114.3030-1-jszhang@kernel.org>
 <20221120082114.3030-6-jszhang@kernel.org>
 <CAJM55Z_f=zp3Z=wno_yr7csAUMQ472RiZXD19CrDTTxmGAmU4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJM55Z_f=zp3Z=wno_yr7csAUMQ472RiZXD19CrDTTxmGAmU4w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 03:57:17PM +0100, Emil Renner Berthing wrote:
> On Sun, 20 Nov 2022 at 09:32, Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > Add a baisc dtsi for the bouffalolab bl808 SoC.

> > +       xtal: xtal-clk {
> > +               compatible = "fixed-clock";
> > +               clock-frequency = <40000000>;
> 
> This was discussed many times before, but I think the conclusion was
> that the frequency is a property of the crystal on the board, so this
> should be 0 in the SoC dtsi, and then overwritten in the board device
> tree.

Or set nothing in soc.dtsi so that dtbs_check can be used to see if
someone forgot to set a clock for their board?

> > +               clock-output-names = "xtal";
> > +               #clock-cells = <0>;
> > +       };

