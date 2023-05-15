Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1113703140
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242072AbjEOPO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjEOPOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:14:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCE4139;
        Mon, 15 May 2023 08:14:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4217561AA3;
        Mon, 15 May 2023 15:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B330C433EF;
        Mon, 15 May 2023 15:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684163663;
        bh=dE9YnPR26TNYmLFla4WyHsacrUjsXOOYKfAvHIZPxD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Muf2RtzLigRmySKrBo1rC1ATbp4a9sHIS7us2BeTmWNFtyFUafw+ZWb6YgvT5hPWE
         NZdAx7ZwkdGW11Oaa1/vH4DrVqohKppNleAyNpG7Mu6DRwk+O50eoZFc9Dgoxc611U
         sshpGPLrcYGA7hO+3nLctgQ4oTw1du64yxbC+WyOxRG7Gg3F0k3WSGB7uHxpi8dYmh
         jLQqtUH6XgYXW+PzQpQlEbYeaaE2JQTOdbMnXMoNWDDsnoX9CnjuOFdhSrooJd/pg8
         0W35R7ECcxRueaMpbysJSiXRZgB9fzArYgVzPGZVWtz4R6F6Ns1rDpstGkcPvh0oJY
         eu3yoJdUSkK4g==
Date:   Mon, 15 May 2023 16:14:16 +0100
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
Subject: Re: [PATCH v8 01/14] clk: RK808: reduce 'struct rk808' usage
Message-ID: <20230515151416.GM10825@google.com>
References: <20230504173618.142075-1-sebastian.reichel@collabora.com>
 <20230504173618.142075-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230504173618.142075-2-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 May 2023, Sebastian Reichel wrote:

> Reduce usage of 'struct rk808' (driver data of the parent MFD), so
> that only the chip variant field is still being accessed directly.
> This allows restructuring the MFD driver to support SPI based
> PMICs.
> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Tested-by: Diederik de Haas <didi.debian@cknow.org> # Rock64, Quartz64 Model A + B
> Tested-by: Vincent Legoll <vincent.legoll@gmail.com> # Pine64 QuartzPro64
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/clk/clk-rk808.c | 34 ++++++++++++++++------------------
>  1 file changed, 16 insertions(+), 18 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
