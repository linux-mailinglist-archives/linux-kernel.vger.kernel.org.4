Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC916616B0E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiKBRkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiKBRk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:40:29 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF1025EA6;
        Wed,  2 Nov 2022 10:40:12 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0983A240004;
        Wed,  2 Nov 2022 17:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667410811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gGuazh88qunSG4Zit4G5LhacSw9tqlTZP/9FORmH9Ck=;
        b=kceZ2KlQxyxh5tkb5b2vNF2IvtuBMbJiLmQu1w5P8ripvP5mDZPv2OFB33LqbJfAlEOw1O
        0HA9Agc8yKZclSDcB/grN0/IUGYoU6IZh0wtBmtQ2ILsUK0jWH88N64br4PpvF0lISdWqZ
        k9WtkpTuv00460sOYFPBdJT4B3DudcHrFUlqPiMqCXDa+yrddqHK/GHVuf8sQ0iE+UxQ/G
        C444R8PXeWuRYf+gwMCUA9/VCXKWoYklz8Hj+DwJHq/WLU9uQrzoclBWE9+Vx3LdVZRJ97
        kPZEigrQmt/Cyff+a0o7qe1ElzgJFyumI2neBSaWRMDFTWZDYhyll+lenH7ZHA==
Date:   Wed, 2 Nov 2022 18:40:08 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        od@opendingux.net
Subject: Re: [PATCH v2 0/4] rtc: ingenic: various updates
Message-ID: <Y2KreBRUnSVxHfZF@mail.local>
References: <20221028225519.89210-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028225519.89210-1-paul@crapouillou.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2022 23:55:15+0100, Paul Cercueil wrote:
> Hi Alessandro / Alexandre,
> 
> Here's the V2 of a previous patchset I sent back in April.
> 
> Patch [1/4] was updated with Krzysztof's feedback.
> 
> Patches 2-4 are unmodified from V1 as they didn't receive any feedback.
> Patch 4 is RFC; I *think* it works, but I don't know how to test it.
> 

You should simply adjust the RTC and see whether the drift changes. The
best is to simply use chrony as this will actually tell you how much the
RTC drifts. This actually gives you the exact value to put in offset to
remove the drift.

> V1 had a 5th patch which would reset the scratchpad register on power
> loss, but was dropped following upstream feedback.
> 
> Cheers,
> - Paul
> 
> Paul Cercueil (4):
>   dt-bindings: rtc: ingenic: Rework compatible strings and add #clock-cells
>   rtc: jz4740: Use readl_poll_timeout
>   rtc: jz4740: Register clock provider for the CLK32K pin
>   rtc: jz4740: Support for fine-tuning the RTC clock
> 
>  .../devicetree/bindings/rtc/ingenic,rtc.yaml  |  32 ++++-
>  drivers/rtc/rtc-jz4740.c                      | 113 +++++++++++++++---
>  2 files changed, 129 insertions(+), 16 deletions(-)
> 
> -- 
> 2.35.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
