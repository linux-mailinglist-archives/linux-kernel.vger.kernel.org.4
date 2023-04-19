Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2CA6E72AB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 07:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjDSFpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 01:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDSFpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 01:45:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB7B2118
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 22:45:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A30D63B0F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0E0C433EF;
        Wed, 19 Apr 2023 05:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681883120;
        bh=rHIVwcWlnAi6I7EkL3r3k1a15viUoZ98G0Ds8/Yst4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H/BGdcSYEk2ZQ32pQ/0W1uRry9lv83+rgnE4uGpjyOtQqRFDNUni+12kavXJZm2No
         NRSeFPNyOaiol6RH221aAeH0iJ7QLpGF282uUoj1w6ZESa0iGmg61OKWt37WA6h2/P
         3uAY8LG6/vzl6VbVkSGZTHmZkTIsOffKc3D4w/e9jysM530tYnCBj/EMyo4p1rc2Kx
         eCpBKX7SsQ+yDJE3ON1iwcBGWo30qaD7n1lfrZPW85hzpGUH7meWLVGjQH2KdlOdF3
         /UiVSEa2frokvmHdbWV+y0PTiQ89/vjtpefaqFOl+dxdb7BIrFF4QqPynZlk3oHO0u
         iP8KnCri24PZA==
Date:   Wed, 19 Apr 2023 07:45:16 +0200
From:   Simon Horman <horms@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH] soc: ti: pruss: Avoid cast to incompatible function type
Message-ID: <ZD9/7Oed8Rujjj/0@kernel.org>
References: <20230418-pruss-clk-cb-v1-1-549a7e7febe4@kernel.org>
 <CAKwvOdnj7rNeh0YeX2NPcbkoJBnRwXb9Dt0SF9mHaMKYVLjCjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdnj7rNeh0YeX2NPcbkoJBnRwXb9Dt0SF9mHaMKYVLjCjw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 11:44:28AM -0700, Nick Desaulniers wrote:
> On Tue, Apr 18, 2023 at 4:41 AM Simon Horman <horms@kernel.org> wrote:
> >
> > Rather than casting clk_unregister_mux to an incompatible function
> > type provide a trivial wrapper with the correct signature for the
> > use-case.
> >
> > Reported by clang-16 with W=1:
> >
> >  drivers/soc/ti/pruss.c:158:38: error: cast from 'void (*)(struct clk *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
> >          ret = devm_add_action_or_reset(dev, (void(*)(void *))clk_unregister_mux,
> >
> > No functional change intended.
> > Compile tested only.
> 
> Thanks for the patch!
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> Here's some more suspects to look at, if you have cycles:
> drivers/base/devres.c:734:int __devm_add_action(struct device *dev,
> void (*action)(void *), void *data, const char *name)
> drivers/i2c/busses/i2c-mchp-pci1xxxx.c:1159: ret =
> devm_add_action(dev, (void (*)(void *))pci1xxxx_i2c_shutdown, i2c);
> drivers/soc/ti/pruss.c:96: ret = devm_add_action_or_reset(dev,
> (void(*)(void *))clk_unregister_mux,
> drivers/mmc/host/meson-mx-sdhc-mmc.c:791: ret =
> devm_add_action_or_reset(dev, (void(*)(void *))mmc_free_host,
> drivers/pci/controller/pcie-microchip-host.c:866:
> devm_add_action_or_reset(dev, (void (*) (void
> *))clk_disable_unprepare,

Thanks, I will take a look as a background task.
Let me know if there is any urgency on your side.

...
