Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8C17146A5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 10:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjE2IvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 04:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjE2IvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 04:51:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93546C2;
        Mon, 29 May 2023 01:50:55 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 86F9E6605961;
        Mon, 29 May 2023 09:50:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685350254;
        bh=jtQ3UzAAL9SWJIafGv8zGAcWl+Tvfd/waNo7frdU8ns=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NDptBfeV6vql8MIEM5QwYBfSorO2E/aNOk11MUi0WgNVihvFcC30yxaXBK2BG6Cwf
         hWfuHgtyQGUzqQ2NGpY0Zo8wXEqN477MTTdR2yd+d5GK9S1HKWyU22vEqw2Z6t8gMz
         yk35QRpPw+/sH5iuq0l597lv95EnufaqrWvHLAEhGixyO3vstzyOKdLNBgLB4nxgj1
         D0oLsol8kV2xoELZPp4PXPX2hfqTa07UiKpScpWN492iHieI6FhMAe2BIS5rcDuaDU
         sLZEMFVjbst1wn1scDKbu4/24md9DeKrS7nzB7HM3/UXrCBpS7bvg1nbX8qj37Dhp3
         2Vxbem/RuvvlQ==
Message-ID: <89b3e3bb-d725-1f92-7a0d-b5bc1109dafc@collabora.com>
Date:   Mon, 29 May 2023 10:50:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/2] clk: composite: Fix handling of high clock rates
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christopher Obbard <chris.obbard@collabora.com>,
        David Laight <David.Laight@ACULAB.COM>, kernel@collabora.com,
        stable@vger.kernel.org
References: <20230526171057.66876-1-sebastian.reichel@collabora.com>
 <20230526171057.66876-2-sebastian.reichel@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230526171057.66876-2-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/05/23 19:10, Sebastian Reichel ha scritto:
> ULONG_MAX is used by a few drivers to figure out the highest available
> clock rate via clk_round_rate(clk, ULONG_MAX). Since abs() takes a
> signed value as input, the current logic effectively calculates with
> ULONG_MAX = -1, which results in the worst parent clock being chosen
> instead of the best one.
> 
> For example on Rockchip RK3588 the eMMC driver tries to figure out
> the highest available clock rate. There are three parent clocks
> available resulting in the following rate diffs with the existing
> logic:
> 
> GPLL:   abs(18446744073709551615 - 1188000000) = 1188000001
> CPLL:   abs(18446744073709551615 - 1500000000) = 1500000001
> XIN24M: abs(18446744073709551615 -   24000000) =   24000001
> 
> As a result the clock framework will promote a maximum supported
> clock rate of 24 MHz, even though 1.5GHz are possible. With the
> updated logic any casting between signed and unsigned is avoided
> and the numbers look like this instead:
> 
> GPLL:   18446744073709551615 - 1188000000 = 18446744072521551615
> CPLL:   18446744073709551615 - 1500000000 = 18446744072209551615
> XIN24M: 18446744073709551615 -   24000000 = 18446744073685551615
> 
> As a result the parent with the highest acceptable rate is chosen
> instead of the parent clock with the lowest one.
> 
> Cc: stable@vger.kernel.org
> Fixes: 49502408007b ("mmc: sdhci-of-dwcmshc: properly determine max clock on Rockchip")
> Tested-by: Christopher Obbard <chris.obbard@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

