Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1867346FA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 18:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjFRQZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 12:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjFRQZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 12:25:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043D7E54;
        Sun, 18 Jun 2023 09:25:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B1CD60C56;
        Sun, 18 Jun 2023 16:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8408C433C8;
        Sun, 18 Jun 2023 16:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687105524;
        bh=cj0lc42efzA9zyJIt7r/5DSLfw+aWNTYfV86CgQQ2v8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HlnolcDypmBwuyNMPmDah4a2HQ6fJ6MyiTNeeOCIZurbSPM3kut6AwAOct9kR48uS
         w2BBHnFoD6k/qjI4HJtOkCOaIoE7s5inV8PA7bm1TBwKHpC0SSNT59GPpz5eCgP2eM
         xFcrbMh1V3HJWXlP8JYh69X6sLH+XPgKJT8tFf2wKK4gg7uJNtgdT75FiF4O8CPMFD
         3LOzZRFqW7rHsU/p8hFlfiJeb0S2h4gKj3hXjPcSeLVPBXA+/XjjO8Vtx34/EiYaBM
         MXDZxzZiNUJDS4WVj9ykOmWWPIhmlzr5PhHoZIesQuoaBas4F6ENuyJQQ0xtYeP7EA
         0NZIG2aT/G4Kg==
Date:   Mon, 19 Jun 2023 00:14:01 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/8] Add Sipeed Lichee Pi 4A RISC-V board support
Message-ID: <ZI8tSYgpz85gYJqW@xhacker>
References: <20230617161529.2092-1-jszhang@kernel.org>
 <20230617-preppy-eggbeater-a256e963bcc6@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230617-preppy-eggbeater-a256e963bcc6@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 06:02:20PM +0100, Conor Dooley wrote:
> Hey Jisheng,

Hi Conor,

> 
> On Sun, Jun 18, 2023 at 12:15:21AM +0800, Jisheng Zhang wrote:
> > Sipeed's Lichee Pi 4A development board uses Lichee Module 4A core
> > module which is powered by T-HEAD's TH1520 SoC. Add minimal device
> > tree files for the core module and the development board.
> > 
> > Support basic uart/gpio/dmac drivers, so supports booting to a basic
> > shell.
> > 
> > NOTE: the thead cpu reset dt-binding and DT node are removed in v3. This
> > makes secondary CPUs unable to be online.
> 
> The kernel doesn't do anything with that node though, so if you were to
> load a fitImage in U-Boot containing this DT, having booted with
> whatever the factory provided OpenSBI has, that limitation doesn't
> apply, right?

The cpu reset DT node is for opensbi, linux kernel doesn't need it.
So you are right: if the u-boot contains the DT node(no matter how
the DT node is added, statically added or dynamically added with
uboot cmd), the limitation doesn't apply.

> 
> > However, minimal th1520
> > support is better than nothing. And the community has been working on
> > and will work on the cpu reset dt-binding, for example, Conor, Guo and
> > Jessica are discussing about it, I have seen valuable comments and
> > inputs from them. I believe we can add back cpu reset in next
> > development window.
> 
> I'll go take a look through this, if it's good I'll apply it and send it
> on to Arnd for 6.5? Although I assume it is fine since v2 was nearly

Thank you for helping to send out this Pull request!

> fine!
> 
> Cheers,
> Conor.


