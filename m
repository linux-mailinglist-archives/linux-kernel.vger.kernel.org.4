Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259D263EE7C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiLAKzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLAKzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:55:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2892E1DDC2;
        Thu,  1 Dec 2022 02:55:43 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669892141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Td6NWg37tgKK/R89b3W+x5buNn+OHKbKyja18wB8IEw=;
        b=CyhDIS73ej6zlgPH/gJ31NA05md2tb69sFvcCindU4QGN0yYsm4sHIQYGpIS26mQ6a+M1U
        TE8D71NZ15F/T6BljSA+rEaIuWvHtJKIpZVy4RL4d5BfelhmesD7nlYduE4tX+j+3KtEvh
        lTLkIzUyFV4ub69ITeJfIE//MonhrbADsAwVc9BaQwrxOpX+Cwh3at84oNIwpA6f9AeNCN
        NxfSqK0uoiP5zJcwiK82sBuzak1DjUqUcZRXVCEfIYZqTYl6lGbLZP9lRiWEo/xPOU8EDL
        4nURnwUmsXnCOMLQb2KINb0t1JEW1cXpLRaftBp6QMGGyrE9rWyFh0lmBZviZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669892141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Td6NWg37tgKK/R89b3W+x5buNn+OHKbKyja18wB8IEw=;
        b=k5JrKXi2jMVZQKJq9g5O8uCX1UslB1noSmC1Ls05iRD/1JTvZlnuDFxeyfsBTI9HltIQ9m
        CGoUUjgjF4CMBRCg==
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource/drivers/sh_cmt: access registers according
 to spec
In-Reply-To: <20221130210609.7718-1-wsa+renesas@sang-engineering.com>
References: <20221130210609.7718-1-wsa+renesas@sang-engineering.com>
Date:   Thu, 01 Dec 2022 11:55:40 +0100
Message-ID: <87pmd3s89f.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfram!

On Wed, Nov 30 2022 at 22:06, Wolfram Sang wrote:
> Documentation for most CMTs say that we need to wait two input clocks
> before changes propagate to the timer. This is especially relevant when
> we stop the timer to change further settings. Implement the delays
> according to the spec. To avoid unnecessary delays in atomic mode, we
> also check if the to-be-written value actually differs. CMCNT is a bit
> special because testing showed that we need to wait 3 cycles instead.
> AFAIU, this is also true for all CMTs. Also, the WRFLAG needs to be
> checked before writing. This fixes "cannot clear CMCNT" messages which
> occur often on R-Car Gen4 SoCs, but only very rarely on older SoCs for
> some reason.

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog

I fixed it up for you this time...

> Fixes: 81b3b2711072 ("clocksource: sh_cmt: Add support for multiple channels per device")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Changes since RFC v2:
> * use DIV_ROUND_UP also for caluclating cmcnt_delay
> * remove a FIXME comment
>
> There were no further comments, so I dropped the RFC status and send
> this as a regular patch. Here again the introduction from RFC v1:

Instead of quoting, it would have been helpful to have the lore links
for RFC v1/v2....

Thanks,

        tglx
