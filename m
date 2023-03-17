Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7366BE244
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 08:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjCQHyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 03:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjCQHyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 03:54:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1E7C6414;
        Fri, 17 Mar 2023 00:53:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B03EB8247B;
        Fri, 17 Mar 2023 07:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5E9C433EF;
        Fri, 17 Mar 2023 07:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679039613;
        bh=FHqeoUzoVZtRqyxQJUT/4e1BNJn6xtdz6lPXXgD9+QU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vj1ByAAC/ZRd2EHSGZHX0kRv5PTnfDa6eJPKaJ3uRVm4e9ye0AdQngEC1EoNQXbZM
         hI6/uUPPS3nLTIgu2WNwAyYWplTI1WuagQxQ5I+ERvldOyt6/rK37eHIkbOFLPCSjV
         yroVnV+uMQJHJSqhEZOx2LquTRtov+j86ySViL0a3PawzrXRMcpkIftj20ZPvn5fxj
         2QL6eAz/lClygp5T9Hjs9yZ72iMi7aQBsSH8Q2p1qUAmIJn9NjFglQ/DX2b+lCGReh
         pr8ObugbtbXKMP/+RUPiBTIWZNX43Snzm0j0Y0JjS4lx2x59oBn2RKz/a0gSxxKk8s
         bKsCzQLPNrXhA==
Date:   Fri, 17 Mar 2023 07:53:27 +0000
From:   Lee Jones <lee@kernel.org>
To:     ChiaEn Wu <chiaen_wu@richtek.com>
Cc:     corbet@lwn.net, pavel@ucw.cz, matthias.bgg@gmail.com,
        andriy.shevchenko@linux.intel.com, jacek.anaszewski@gmail.com,
        angelogioacchino.delregno@collabora.com, linux-doc@vger.kernel.org,
        peterwu.pub@gmail.com, cy_huang@richtek.com,
        linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        szunichen@gmail.com, Alice Chen <alice_chen@richtek.com>
Subject: Re: [PATCH v18 1/3] leds: rgb: mt6370: Add MediaTek MT6370 current
 sink type LED Indicator support
Message-ID: <20230317075327.GA9667@google.com>
References: <cover.1678430444.git.chiaen_wu@richtek.com>
 <1df93a583c3f508a7158b83b95857e9bce235e1b.1678430444.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1df93a583c3f508a7158b83b95857e9bce235e1b.1678430444.git.chiaen_wu@richtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023, ChiaEn Wu wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
>
> The MediaTek MT6370 is a highly-integrated smart power management IC,
> which includes a single cell Li-Ion/Li-Polymer switching battery
> charger, a USB Type-C & Power Delivery (PD) controller, dual
> Flash LED current sources, a RGB LED driver, a backlight WLED driver,
> a display bias driver and a general LDO for portable devices.
>
> Add support for the MediaTek MT6370 Current Sink Type LED Indicator
> driver. It can control four channels current-sink RGB LEDs with 3 modes:
> constant current, PWM, and breath mode.
>
> Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Co-developed-by: Alice Chen <alice_chen@richtek.com>
> Signed-off-by: Alice Chen <alice_chen@richtek.com>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---
> v18:
> - Rename 'MT6370_VENID_MASK' to more human readable
>   'MT6370_VENDOR_ID_MASK'
> - Define the const number vid.
> - Unwrap each line by 100 chars limit.
> - Remove the redudant space in 'mt6370_gen_breath_pattern()' comment for
>   patterh data allocation.
> - Define a sub function 'mt6370_assign_multicolor_info()' to tidy up
>   'mt6370_init_led_properties()' for multicolor case.
> - Define a sub function 'mt6370_multicolor_led_register' to tidy up
>   'mt6370_led_register()' for multicolor case.
> - Refine 'fwnode_handle_put' in probe function with 'goto'.
> ---
>  drivers/leds/rgb/Kconfig           |   13 +
>  drivers/leds/rgb/Makefile          |    1 +
>  drivers/leds/rgb/leds-mt6370-rgb.c | 1010 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 1024 insertions(+)
>  create mode 100644 drivers/leds/rgb/leds-mt6370-rgb.c

Applied, thanks

--
Lee Jones [李琼斯]
