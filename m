Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303EF602E9E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiJROfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiJROfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:35:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECE784E55;
        Tue, 18 Oct 2022 07:35:09 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 140966602363;
        Tue, 18 Oct 2022 15:35:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666103707;
        bh=yj4no1hmXPxcFVYFNGkQ5Rv31q7Byllln3UwaWTWbOk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QJStN3kg4CTlqoA7Cfp8KPYl6RqtnBMvM6R8jZqmpWiBD4brOY6gX3gNlI76+iR3q
         Wz7rFKFubT2Nus8145TroKz2vANtuALBjEppZyF5oFwkrFRlmUSWgzgypnn3DWAbpV
         yI/1WJJfohlwNOffPWPS1D9vHRlsayyrlPITDKwN7w2RCzrxmr3g8fxC1vS5M6GiGH
         i3rndgmNLpR9OePeUG2Lq94twYfazYIxefAHSOIddxhi0X9tVP1ZzOrHzv/dqypefM
         Og/fb9O/5BH4ejNbP54CbHS1nXZeo1xIyeOZzwYDc4XO1YZh1N0GaKf5VPkc57kEtR
         wCM1CjdRxJm+g==
Message-ID: <c196afc4-46e8-a61a-b0fe-c92f26614a8f@collabora.com>
Date:   Tue, 18 Oct 2022 16:35:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/4] clk: Remove WARN_ON NULL parent in
 clk_core_init_rate_req()
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20221018-clk-range-checks-fixes-v1-0-f3ef80518140@cerno.tech>
 <20221018-clk-range-checks-fixes-v1-1-f3ef80518140@cerno.tech>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221018-clk-range-checks-fixes-v1-1-f3ef80518140@cerno.tech>
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
> If a clock has CLK_SET_RATE_PARENT, but core->parent is NULL (most
> likely because it's orphan), callers of clk_core_init_rate_req() will
> blindly call this function leading to a very verbose warning.
> 
> Since it's a fairly common situation, let's just remove the WARN_ON but
> keep the check that prevents us from dereferencing the pointer.
> 
> Interestingly, it fixes a regression on the Mediatek MT8195 where the
> GPU would stall during a clk_set_rate for its main clock. We couldn't
> come up with a proper explanation since the condition is essentially the
> same.
> 
> It was then assumed that it could be timing related since printing the
> warning stacktrace takes a while, but we couldn't replicate the failure
> by using fairly large (10ms) mdelays.
> 
> Fixes: 262ca38f4b6e ("clk: Stop forwarding clk_rate_requests to the parent")
> Reported-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


