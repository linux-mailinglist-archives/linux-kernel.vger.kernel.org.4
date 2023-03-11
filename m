Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4BB6B5B49
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCKLpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCKLpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:45:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10939222CF;
        Sat, 11 Mar 2023 03:45:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B07B8B824B9;
        Sat, 11 Mar 2023 11:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF883C433EF;
        Sat, 11 Mar 2023 11:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678535110;
        bh=75mbQ2zIUa16Px+XAHlCBKsO8iebtVjeSF8AguylJ8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vKcuArUhUvEGj+8PjRsrv9iWFy3ybcuDWmCSvAgrw3VQcr0KCqVMB3Yd+hSUl/rWD
         LCu8+rzUrXPWC4LCYoUTY2xxqaJI1I1cWg8N8qp1rdNKHSNgDDZgxRZzvPhyoW7LWx
         cWPIh8k/c6WorLch500+1DFN9R9uHtSVtIbxVzVhhl/EGrk80HN4VeTWkdSZg7T2cY
         I/lsX4kNDEE+9FWmE5/oHplFO/6HBF3GGkSUuRHlhxTakn/zWpKqq6pOYoXGeLuKAP
         YqoVWlEGWkGw99B/Rl8mhHUCSuukN6sdHMUKQVz7ZUSBKj+QI18qIPWpeaZMwZ4rSP
         O64zmpd8v+XCw==
Date:   Sat, 11 Mar 2023 12:45:07 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Kamal Dasu <kdasu.kdev@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Heiko Stuebner <heiko@sntech.de>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 07/16] spi: s3c64xx: Drop of_match_ptr for ID table
Message-ID: <20230311114507.axtae3j64fbt64t3@intel.intel>
References: <20230310222857.315629-1-krzysztof.kozlowski@linaro.org>
 <20230310222857.315629-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230310222857.315629-7-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Fri, Mar 10, 2023 at 11:28:48PM +0100, Krzysztof Kozlowski wrote:
> The driver can match only via the DT table (all platforms are OF-only)
> so the table should be always used and the of_match_ptr does not have
> any sense (this also allows ACPI matching via PRP0001, even though it is
> not relevant here).
> 
>   drivers/spi/spi-s3c64xx.c:1496:34: error: ‘s3c64xx_spi_dt_match’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
