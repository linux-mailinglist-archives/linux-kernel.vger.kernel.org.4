Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37E173918A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjFUVbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFUVb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:31:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4041E1BC;
        Wed, 21 Jun 2023 14:31:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0E78616D8;
        Wed, 21 Jun 2023 21:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7DDC433C0;
        Wed, 21 Jun 2023 21:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687383087;
        bh=HY2/KPCQv+TNb8BEUoFS/75P2bkM0JsT+gXSpFBNCJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=inJljWazMcccbQVlONx/s92wacqeR1e65s1uXDfzP8ddik+z5pUlpBQKE5kSFyfME
         VAkZAODssc039oYcAHlCKCTi7j5WiJy6YESntQDym3N5YRUSPeuy5YL94ZdxMxeQXY
         I7VWEg9/4cM2agT4V2XhXpmeGxdg3TP/ZxnQBvntnfC4J8xFGdJd0exvsJgIfFpIus
         EKy2GZ5bK/cvf4Ghg3/KblBZTk3EclqnYSzKcKxBTHU0px6Hh+9emJD9cCxfwT1E5Y
         UvEEE8BNXEncBVjoeaw0CDY9o7wB13lrmROFp0Mowsyxs2LbLrqR35UnHU4/pCCslh
         BOXqTkjIVAM1A==
Date:   Wed, 21 Jun 2023 21:31:24 +0000
From:   Nathan Chancellor <nathan@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     pavel@ucw.cz, lee@kernel.org, sean.wang@mediatek.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, llvm@lists.linux.dev
Subject: Re: [PATCH v3 8/8] leds: leds-mt6323: Add support for WLEDs and
 MT6332
Message-ID: <20230621213124.GA2689001@dev-arch.thelio-3990X>
References: <20230601110813.2373764-1-angelogioacchino.delregno@collabora.com>
 <20230601110813.2373764-9-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601110813.2373764-9-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On Thu, Jun 01, 2023 at 01:08:13PM +0200, AngeloGioacchino Del Regno wrote:
> Add basic code to turn on and off WLEDs and wire up MT6332 support
> to take advantage of it.
> This is a simple approach due to the aforementioned PMIC supporting
> only on/off status so, at the time of writing, it is impossible for me
> to validate more advanced functionality due to lack of hardware.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

After this patch as commit 9bb0a9e0626c ("leds: leds-mt6323: Add support
for WLEDs and MT6332") in -next, I see the following warnings from
clang, which are basically flagging potential kernel Control Flow
Integrity [1] violations that will be visible at runtime (this warning
is not enabled for the kernel yet but we would like it to be):

  drivers/leds/leds-mt6323.c:598:49: error: incompatible function pointer types assigning to 'int (*)(struct led_classdev *, enum led_brightness)' from 'int (struct led_classdev *, unsigned int)' [-Werror,-Wincompatible-function-pointer-types-strict]
    598 |                         leds->led[reg]->cdev.brightness_set_blocking =
        |                                                                      ^
    599 |                                                 mt6323_wled_set_brightness;
        |                                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/leds/leds-mt6323.c:600:40: error: incompatible function pointer types assigning to 'enum led_brightness (*)(struct led_classdev *)' from 'unsigned int (struct led_classdev *)' [-Werror,-Wincompatible-function-pointer-types-strict]
    600 |                         leds->led[reg]->cdev.brightness_get =
        |                                                             ^
    601 |                                                 mt6323_get_wled_brightness;
        |                                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~
  2 errors generated.

From what I can tell/understand, 'enum led_brightness' is obsolete and
the value that is passed via ->brightness_set_blocking() is an 'unsigned
int' as well but it seems 'enum led_brightness' is used as the parameter
in a lot of different callback implementations, so the prototype cannot
be easily updated without a lot of extra work. Is there any reason not
to just do something like this to avoid this issue?

[1]: https://lwn.net/Articles/898040/

Cheers,
Nathan

diff --git a/drivers/leds/leds-mt6323.c b/drivers/leds/leds-mt6323.c
index e8fecfc2e90a..24f35bdb55fb 100644
--- a/drivers/leds/leds-mt6323.c
+++ b/drivers/leds/leds-mt6323.c
@@ -76,7 +76,7 @@ struct mt6323_led {
 	int			id;
 	struct mt6323_leds	*parent;
 	struct led_classdev	cdev;
-	unsigned int		current_brightness;
+	enum led_brightness	current_brightness;
 };
 
 /**
@@ -451,7 +451,7 @@ static int mtk_wled_hw_off(struct led_classdev *cdev)
 	return 0;
 }
 
-static unsigned int mt6323_get_wled_brightness(struct led_classdev *cdev)
+static enum led_brightness mt6323_get_wled_brightness(struct led_classdev *cdev)
 {
 	struct mt6323_led *led = container_of(cdev, struct mt6323_led, cdev);
 	struct mt6323_leds *leds = led->parent;
@@ -471,7 +471,7 @@ static unsigned int mt6323_get_wled_brightness(struct led_classdev *cdev)
 }
 
 static int mt6323_wled_set_brightness(struct led_classdev *cdev,
-				      unsigned int brightness)
+				      enum led_brightness brightness)
 {
 	struct mt6323_led *led = container_of(cdev, struct mt6323_led, cdev);
 	struct mt6323_leds *leds = led->parent;
