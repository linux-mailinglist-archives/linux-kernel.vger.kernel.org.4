Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E86602E9C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiJROfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiJROfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:35:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B477084E55;
        Tue, 18 Oct 2022 07:35:05 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7BF8C66022FA;
        Tue, 18 Oct 2022 15:35:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666103702;
        bh=qYYJybovclLEDHkvXdzXj0IFVUkJPyhf7OhToldsM1w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gBfIoyOI5boTpSvODNJfBIKMGJjhKBWxN5LMjXARJ39K1x7xrXAG3CeiXRiMjewhs
         YbcyIc42MPtS42QaPG6zFy0zkoyKC6iJBXI5X1I9MzmTF3JNM4s3UKo3a7QjMNvp/k
         HVO1bcG6quLrMVVAooDZDox38GstNLwwEEKxhackb5bI5RZV4kwWYXRs6/ps95IhNo
         G+5v0Rpvqyc6diE5jwJ13LzljDO7gOtB6U+S+7JIPeCxxWB71yiaIDgaVDthmaYfpi
         8Lq+cUObGb8zBZHtl/BNzNeWAIW/Q84peuVk48dSs7Dv++dLbX8t74CF5MbalACgaB
         gqoQpoS6MCJXg==
Message-ID: <206b8841-5626-c32f-37df-ccc4a87313d0@collabora.com>
Date:   Tue, 18 Oct 2022 16:34:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 4/4] clk: Warn if we register a mux without determine_rate
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20221018-clk-range-checks-fixes-v1-0-f3ef80518140@cerno.tech>
 <20221018-clk-range-checks-fixes-v1-4-f3ef80518140@cerno.tech>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221018-clk-range-checks-fixes-v1-4-f3ef80518140@cerno.tech>
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
> The determine_rate hook allows to select the proper parent and its rate
> for a given clock configuration. On another hand, set_parent is there to
> change the parent of a mux.
> 
> Some clocks provide a set_parent hook but don't implement
> determine_rate. In such a case, set_parent is pretty much useless since
> the clock framework will always assume the current parent is to be used,
> and we will thus never change it.
> 
> This situation can be solved in two ways:
>    - either we don't need to change the parent, and we thus shouldn't
>      implement set_parent;
>    - or we don't want to change the parent, in this case we should set
>      CLK_SET_RATE_NO_REPARENT;
>    - or we're missing a determine_rate implementation.
> 
> The latter is probably just an oversight from the driver's author, and
> we should thus raise their awareness about the fact that the current
> state of the driver is confusing.
> 
> It's not clear at this point how many drivers are affected though, so
> let's make it a warning instead of an error for now.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

That solves my concerns :-) :-)

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


