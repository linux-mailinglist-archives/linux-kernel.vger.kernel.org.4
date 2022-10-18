Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F898602E9D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiJROfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiJROfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:35:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19058A2226;
        Tue, 18 Oct 2022 07:35:07 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8BC526602330;
        Tue, 18 Oct 2022 15:35:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666103705;
        bh=O2XZNqKJSjQR7Nr1ZVhrijE/E4rZvErYqWg4oq5rW7w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=G/BobmwEdNml++71NSiQGfTrjSqYtx+NOpUHisyoM/+nmPpi1BKunyc3s8UuzKU7a
         FLpohEqDc4H2CQRewPz/BVrFji4ScLYlncJwoTxqVgbFCTXjS6xndh/GyCc0nwtH+3
         vu9xgOTunTObzZG1UxeJFqkBGPCmOXEsiq9wayzv1y3T07lv6Ayip+ZrEnlQwHPCTx
         UI0Yy/ZhNZjeunjJH9sgSzKfotLyHeVfyVhDbtGoeGW8ZGYG6HIw6Cx9JIM9VYJ5Ii
         QzX1kmLDu38eotKM8+wUk4913LYNi3dXdBx1LtNYeEfaPR141gTzTvXXkb0hnXrJ5n
         LH3Jnpm5NnOYw==
Message-ID: <9abc0a59-d2f3-f95f-5537-6234817b15ce@collabora.com>
Date:   Tue, 18 Oct 2022 16:35:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 2/4] clk: Initialize the clk_rate_request even if clk_core
 is NULL
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20221018-clk-range-checks-fixes-v1-0-f3ef80518140@cerno.tech>
 <20221018-clk-range-checks-fixes-v1-2-f3ef80518140@cerno.tech>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221018-clk-range-checks-fixes-v1-2-f3ef80518140@cerno.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/10/22 15:52, Maxime Ripard ha scritto:
> Since commit c35e84b09776 ("clk: Introduce clk_hw_init_rate_request()"),
> users that used to initialize their clk_rate_request by initializing
> their local structure now rely on clk_hw_init_rate_request().
> 
> This function is backed by clk_core_init_rate_req(), which will skip the
> initialization if either the pointer to struct clk_core or to struct
> clk_rate_request are NULL.
> 
> However, the core->parent pointer might be NULL because the clock is
> orphan, and we will thus end up with our local struct clk_rate_request
> left untouched.
> 
> And since clk_hw_init_rate_request() doesn't return an error, we will
> then call a determine_rate variant with that unitialized structure.
> 
> In order to avoid this, let's clear our clk_rate_request if the pointer
> to it is valid but the pointer to struct clk_core isn't.
> 
> Fixes: c35e84b09776 ("clk: Introduce clk_hw_init_rate_request()")
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


