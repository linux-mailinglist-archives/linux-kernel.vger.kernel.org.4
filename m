Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3333D703153
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242267AbjEOPSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbjEOPSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:18:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C53FDB;
        Mon, 15 May 2023 08:18:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0DF661EF9;
        Mon, 15 May 2023 15:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD54C433EF;
        Mon, 15 May 2023 15:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684163899;
        bh=O3PfqBWgvC8kkGINqTRq9A/j4B9puDgpei0jZpKHjlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TR/ieNdtOS3Aq05DCRzeBZnDpGK4oekHaqZqUfIpl0QVfq8f/t3OjKl/AfRp4A7Jy
         PbCkngvyAqOd+gZCVADseTLDifrg7EBiTi0GklaHhLYq4WD+ArWmpHEbxC6SSH1hNS
         DsEC1UZy87aczsCm118Jo384Dhys8W/nRR1ULzJ80zWu/fEJCchb/MLyDT9pdAYuvr
         Pp6f/iJJ5qP8xLi3xVJbzx1+EeI0T32Wv1wPpkk4sL5zbmTKr4bVucAQfcCmqAZNov
         2A/aMOshbjV4GYL8H8fwh+a1bYUJKkIGM/zB762aMkszOhMX5r+/a6Dy0ZC1j5DxuS
         RCTzI5gIG7/Pw==
Date:   Mon, 15 May 2023 16:18:12 +0100
From:   Lee Jones <lee@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Diederik de Haas <didi.debian@cknow.org>,
        Vincent Legoll <vincent.legoll@gmail.com>
Subject: Re: [PATCH v8 03/14] mfd: rk808: use dev_err_probe
Message-ID: <20230515151812.GO10825@google.com>
References: <20230504173618.142075-1-sebastian.reichel@collabora.com>
 <20230504173618.142075-4-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230504173618.142075-4-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 May 2023, Sebastian Reichel wrote:

> Use dev_err_probe instead of dev_err in probe function,
> which simplifies code a little bit and prints the error
> code.
> 
> Also drop possibly incorrect printing of chip id registers
> while touching the error message.
> 
> Acked-for-MFD-by: Lee Jones <lee@kernel.org>
> Tested-by: Diederik de Haas <didi.debian@cknow.org> # Rock64, Quartz64 Model A + B
> Tested-by: Vincent Legoll <vincent.legoll@gmail.com> # Pine64 QuartzPro64
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/mfd/rk808.c | 48 +++++++++++++++------------------------------
>  1 file changed, 16 insertions(+), 32 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
