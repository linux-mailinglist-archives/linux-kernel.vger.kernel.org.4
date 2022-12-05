Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9AC642905
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiLENOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiLENN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:13:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DA8E090;
        Mon,  5 Dec 2022 05:13:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43CCCB80F79;
        Mon,  5 Dec 2022 13:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CDAC433D6;
        Mon,  5 Dec 2022 13:13:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VVz/fQ59"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1670246028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B++/OBP5b9tao3rBjJnSn5JP+R13g8uCUXYA4vb8b6I=;
        b=VVz/fQ59+g0ixnAiSLQHtrMWFc7PZbckvhkfuwtWBgpOxGpGhujiGPk2nqgQi5gt/9fYSD
        UhmQy996dpKokjAuMZHYu+29c4sb76Y0UaBo0MgS47OLI0FmvX+prDVEujvVgumTdLYMdJ
        3POrHd2H7ASzOS9M0u6opQ+LoDAaax4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 113cf849 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 5 Dec 2022 13:13:48 +0000 (UTC)
Date:   Mon, 5 Dec 2022 14:13:45 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Aurelien Jarno <aurelien@aurel32.net>
Cc:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lin Jinhan <troy.lin@rock-chips.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] hwrng: add Rockchip SoC hwrng driver
Message-ID: <Y43uiVo41vljLsZM@zx2c4.com>
References: <20221128184718.1963353-1-aurelien@aurel32.net>
 <20221128184718.1963353-3-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221128184718.1963353-3-aurelien@aurel32.net>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 07:47:17PM +0100, Aurelien Jarno wrote:
> The TRNG device does not seem to have a signal conditionner and the FIPS
> 140-2 test returns a lot of failures. They can be reduced by increasing
> RK_RNG_SAMPLE_CNT, in a tradeoff between quality and speed. This value
> has been adjusted to get ~90% of successes and the quality value has
> been set accordingly.

Can't you reduce it even more to get 100%? All we need is 32 bytes every
once in a while.

> +	rk_rng->rng.quality = 900;

If your intention is "90%", this should be 921 or 922, because the
quality knob is out of 1024, not 1000.

Herbert - this seems like a fairly common pitfall I've seen all over the
place. It might be worth making a mental memo to reject or ask questions
about numbers that seem "too round", when you look at these sorts of
patches.

Jason
