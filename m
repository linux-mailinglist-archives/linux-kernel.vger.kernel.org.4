Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC376F082A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243673AbjD0PWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244202AbjD0PWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:22:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4C74495;
        Thu, 27 Apr 2023 08:21:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C488C63DF5;
        Thu, 27 Apr 2023 15:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A84C433EF;
        Thu, 27 Apr 2023 15:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682608918;
        bh=ubzLIiKWk4xS3fSUFL6f4HYwN3pMsyjqGrPI/EsNgjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SIgAkX1LAax4lBVZnNItcQejkgjdWp2jW2n+tccgqr0xHc3DGMMGIIhUheL1+7d4k
         wPyfq1DPU4qV+twUfCgLrfsKbhy8vw1N+3VuSupOV9Ib1zMrZoa8WTZOMWiJZ4Wtcf
         nWCNmBVN2/Pmc+i/onQtJ5FBBA5UBq34y00Fq1bkrlWpINWvuEbcSKqjne3srI0pnd
         WdRK+ck7bl/SNuq0oUQdmXe+vrHc4D643zs6Rqd9I+D9PGcOOqpPtmIkU6/NSj+9tj
         441zkhW5aUj7QM7Q38zGNF1jRoRyoxkUnaBmEBn6TY1WM0MQxWQcOREftn8ilWn64C
         oVQBXP+FRpuRA==
Date:   Thu, 27 Apr 2023 16:21:53 +0100
From:   Lee Jones <lee@kernel.org>
To:     Maarten Zanders <maarten.zanders@mind.be>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] leds: lp55xx: configure internal charge pump
Message-ID: <20230427152153.GY50521@google.com>
References: <20230421075305.37597-1-maarten.zanders@mind.be>
 <20230421075305.37597-3-maarten.zanders@mind.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230421075305.37597-3-maarten.zanders@mind.be>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023, Maarten Zanders wrote:

> The LP55xx range of devices have an internal charge pump which
> can (automatically) increase the output voltage towards the
> LED's, boosting the output voltage to 4.5V.
> 
> Implement this option from the devicetree. When the setting
> is not present it will operate in automatic mode as before.
> 
> Tested on LP55231. Datasheet analysis shows that LP5521, LP5523
> and LP8501 are identical in topology and are modified in the
> same way.
> 
> Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
> ---
> 
> Notes:
>     v1: implement as bool to disable charge pump
>     v2: rewrite to use string configuration, supporting all modes
>     v3: simplification by replacing string from DTS by constant
>     v4: added notes
>     v5: property type to u32
>     v6: cleanup parsing of DT paramter
>     v7: formatting
> 
>  drivers/leds/leds-lp5521.c                | 11 +++++------
>  drivers/leds/leds-lp5523.c                | 14 +++++++++-----
>  drivers/leds/leds-lp55xx-common.c         |  9 +++++++++
>  drivers/leds/leds-lp8501.c                |  8 +++++---
>  include/linux/platform_data/leds-lp55xx.h |  3 +++
>  5 files changed, 31 insertions(+), 14 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
