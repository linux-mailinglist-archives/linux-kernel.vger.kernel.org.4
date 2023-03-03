Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B846A957A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjCCKnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCCKnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:43:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60A0113D9;
        Fri,  3 Mar 2023 02:43:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E83FB81854;
        Fri,  3 Mar 2023 10:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF302C433D2;
        Fri,  3 Mar 2023 10:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677840222;
        bh=tUVMasFlU6t7eOjsQ/0W5M32YRxx/KOO9ZB7UVG3/ks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r5adkAsucnPwqxukbPfFcYy1aAG3UamVWCxS/zjh5BDpz6dZjx1EyTGhruL+jVK+4
         rkVu3gDTf4LJJ+iNfAmME6Fqoh+99fbBJvgW3kqdBCBwzfH/HysKNkLhiUXqw5ND6Y
         FODREBMBsZLCrWdH4yEWvQ28FBQzwKRK9o9FZlx/jBsXiWpxDETU8owylCkKu5xLGb
         mmiPJos088VOPu574IqyHuj9zd0jqKxf0VHysys3R4QbSIkxEjDocTKYhqj2f9tyYa
         ZxQjDBq5Usv86K+4W2LvQaLkz/F2SLOPQkI53Xiej32Yqh3t+7OasEemqBWwMU321F
         fXA2JdE7OOTJA==
Date:   Fri, 3 Mar 2023 10:43:37 +0000
From:   Lee Jones <lee@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] mfd: qcom-pm8008: Fix swapped mask/unmask in irq
 chip
Message-ID: <20230303104337.GS2303077@google.com>
References: <20230216222214.138671-1-aidanmacdonald.0x0@gmail.com>
 <20230216222214.138671-2-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230216222214.138671-2-aidanmacdonald.0x0@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023, Aidan MacDonald wrote:

> The usual behavior of mask registers is writing a '1' bit to
> disable (mask) an interrupt; similarly, writing a '1' bit to
> an unmask register enables (unmasks) an interrupt.
> 
> Due to a longstanding issue in regmap-irq, mask and unmask
> registers were inverted when both kinds of registers were
> present on the same chip, ie. regmap-irq actually wrote '1's
> to the mask register to enable an IRQ and '1's to the unmask
> register to disable an IRQ.
> 
> This was fixed by commit e8ffb12e7f06 ("regmap-irq: Fix
> inverted handling of unmask registers") but the fix is opt-in
> via mask_unmask_non_inverted = true because it requires manual
> changes for each affected driver. The new behavior will become
> the default once all drivers have been updated.
> 
> The PM8008 appears to rely on the inverted behavior. It has
> separate set & clear registers for a register called INT_EN,
> which presumably enables interrupts by writing '1's. Opt in
> to the new non-inverted behavior & swap mask_base/unmask_base.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/mfd/qcom-pm8008.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
