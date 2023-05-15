Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B36370315C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242302AbjEOPTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242298AbjEOPS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:18:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35174DB;
        Mon, 15 May 2023 08:18:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B51B62619;
        Mon, 15 May 2023 15:18:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A595C433EF;
        Mon, 15 May 2023 15:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684163931;
        bh=TXYgj6/20Uus/rd/MXXhGWJpYIqaRRMVUuQbbVSNwSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ps3JfcQvrrHK/zPEqbOWEy2mt2cKLshPw6KHPs2oF+I15/gX95RGVtYGSsD8d2tDr
         lg/wPCYS5FNqbP8w36Ow/MxAZ5DSIimSIBem/jRrsbZO4Ar30XeSjKmmvsYz+4iFRj
         IW2PEyBOEmqxNy+GC2FAOK79GRTbuKkjO6ZOnreIBexGTBOuQS2dCWayyULYx5ZzFA
         SE92Ug9UqQH92tcl4opY6f+nEbABOiZqueb0TGLO9+A8eJcecShywg1ltszJaD5+/o
         mwZTeiikhwcJDPG5x9YkF6EChnAidavjdBBr5gQ3a5a6h/hDYTvdAKItvldCfnkfnZ
         wHQxYFAGlM1Og==
Date:   Mon, 15 May 2023 16:18:43 +0100
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
Subject: Re: [PATCH v8 04/14] mfd: rk808: replace 'struct i2c_client' with
 'struct device'
Message-ID: <20230515151843.GP10825@google.com>
References: <20230504173618.142075-1-sebastian.reichel@collabora.com>
 <20230504173618.142075-5-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230504173618.142075-5-sebastian.reichel@collabora.com>
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

> Put 'struct device' pointer into the MFD platform_data instead
> of the 'struct i2c_client' pointer. This simplifies the code
> and prepares the MFD for SPI support.
> 
> Acked-for-MFD-by: Lee Jones <lee@kernel.org>
> Tested-by: Diederik de Haas <didi.debian@cknow.org> # Rock64, Quartz64 Model A + B
> Tested-by: Vincent Legoll <vincent.legoll@gmail.com> # Pine64 QuartzPro64
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/mfd/rk808.c       | 6 +++---
>  include/linux/mfd/rk808.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
