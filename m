Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C046B70A8E3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 17:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjETPlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 11:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjETPlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 11:41:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C888E102;
        Sat, 20 May 2023 08:41:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54B5D60ADC;
        Sat, 20 May 2023 15:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CF6C433D2;
        Sat, 20 May 2023 15:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684597259;
        bh=9Ps1xvHyEdQpdoqJaEeCbsAna43Ebewm5CkBpwanu2U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oA1jURKODqVIMIR07QZUqj8P0EAwJYmfUC43ursKlC6SK3C3hlntNXzXTsh7MoDLE
         S4v38CrFsXmdYUg7WmsQFI+Mj11qBUdxNH3voE0X9zGRE+dA4k17WewdGBofvBOfjy
         FJjuHnp/WR6zIj/8XX/qNEsfSdGNVmQOewgZ/dEcaWI46Bj7mFXhksYykFVDObxS3A
         f/cdIdfOeA2AfTdliPQq+RzX0AIpsaQ1laI/45Ny8Lbh2STxYzUxyGHN+QwYKUGbnS
         06ehIM6DmkW4aqDYhZ+4XZSkKMpdWLNT2Iq6bGg6kWSk1YhucU+WPEW9bvPWpJCLk4
         cSMi10hTLRyrg==
Date:   Sat, 20 May 2023 16:57:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     lars@metafoo.de, heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sebastian.reichel@collabora.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        serge.broslavsky@collabora.com, Simon Xue <xxm@rock-chips.com>
Subject: Re: [PATCH 1/7] iio: adc: rockchip_saradc: Add support for RK3588
Message-ID: <20230520165707.695de520@jic23-huawei>
In-Reply-To: <20230516230051.14846-2-shreeya.patel@collabora.com>
References: <20230516230051.14846-1-shreeya.patel@collabora.com>
        <20230516230051.14846-2-shreeya.patel@collabora.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 04:30:45 +0530
Shreeya Patel <shreeya.patel@collabora.com> wrote:

> Refactor conversion operation to support rk3588 saradc and
> add separate start, read, powerdown in respective hooks.
> 
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
Hi Shreeya,

This particular chain of tags has unclear authorship.
If Simon wrote the driver, then the author (from address) of the
patch should be Simon's.  If it is a codeveloped situation look
at how to use the co-developed-by tag


Generally the nicest way to add new callbacks is to do them in their
own patch.  Then introduce new devices with different callbacks in a follow
on patch.  That means the first one can be reviewed to ensure there
is no functional change separate from the new code in the following patch.



> +static const struct rockchip_saradc_data rk3588_saradc_data = {
> +	.channels = rockchip_rk3588_saradc_iio_channels,
> +	.num_channels = ARRAY_SIZE(rockchip_rk3588_saradc_iio_channels),
> +	.clk_rate = 1000000,
> +	.start = rockchip_saradc_start_v2,

As mentioned above, I'd like to see the changes for old devices done in patch
1 and the support for new device in a new patch.

> +	.read = rockchip_saradc_read_v2,
>  };


