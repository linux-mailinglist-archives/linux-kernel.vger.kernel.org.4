Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FAA64296D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbiLENa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbiLENaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:30:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44331CB10;
        Mon,  5 Dec 2022 05:30:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3058961087;
        Mon,  5 Dec 2022 13:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A809C433C1;
        Mon,  5 Dec 2022 13:30:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZHV2azxK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1670247018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=77miVuUVU22opWZzTtZsOCj5BnnAupU555MsmQ4hl2o=;
        b=ZHV2azxKBleZixdMsY3L6P7O6rjWGg/LZL3gSZLqZGPG5YIwdQKHZWN7dR36amXBb5CEHm
        Vt0EYxfpl8P+3ki5UFRU3RBGw0U7lNkkhW7xbBznehCiIVl/Lh8eTsGiW/u07+ZiLTqUIF
        zv3kThwvJt/l/BZyuHsKPi3OhdKVJ5g=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5dae6f5e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 5 Dec 2022 13:30:18 +0000 (UTC)
Date:   Mon, 5 Dec 2022 14:30:17 +0100
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
Message-ID: <Y43yaS1ybCCG6szm@zx2c4.com>
References: <20221128184718.1963353-1-aurelien@aurel32.net>
 <20221128184718.1963353-3-aurelien@aurel32.net>
 <Y43uiVo41vljLsZM@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y43uiVo41vljLsZM@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 02:13:45PM +0100, Jason A. Donenfeld wrote:
> If your intention is "90%", this should be 921 or 922, because the
> quality knob is out of 1024, not 1000.
> 
> Herbert - this seems like a fairly common pitfall I've seen all over the
> place. It might be worth making a mental memo to reject or ask questions
> about numbers that seem "too round", when you look at these sorts of
> patches.

Or alternatively we could introduce a cheesy macro like:

   #define HWRNG_PERCENTAGE(p) ((p) * 1024 / 100)

and then enforce that everyone use that. But that's a bit wacky too, in
the sense of - why is anybody using a non-obvious percentage in the first
place. Like if you see "512" (or better, "1024 / 2"), okay fine, it's a
device that guarantees 50%, which seems like a common enough physical
thing. But if we see "HWRNG_PERCENTAGE(90)", the first question is why?
What causes that?  Seems very weird. And it's probably wrong.

But if it *is* right, that deserves a big comment with explanation,
where the calculation for that "921" literal can be explained in full,
or, better, evaluated as a constant expression in terms of hardware
constants -- something like
HW_CLOCKRATE/FROBNICATOR_INTENSITY*1024/TURBOENCABULATION_MODE_WEIGHT,
and then it all makes sense.

So maybe rather than a macro or accepting barebones "921" values, if the
value isn't 1024 (0), then it needs a comment + an expression computing
the value.

Seem reasonable?

Jason
