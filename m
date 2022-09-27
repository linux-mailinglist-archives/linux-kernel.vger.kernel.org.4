Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7E95EBFEE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiI0Kjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiI0Kjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:39:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DAC76765;
        Tue, 27 Sep 2022 03:39:45 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3A8096602265;
        Tue, 27 Sep 2022 11:39:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664275184;
        bh=1Dj0DOUe9P54HMVaAc5tPkN254QBec4iUGXzuL+bCxg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Biuo7sl+wBZmjb1oyqzxOCK0C0Pk2ynpF3tFZPWRFJ3WmQ1n2HNwjr5yKu+m4QGD1
         VgAwD0tZtvJTjRxmzYdAairbmcEhV/NpXoJqHsHKOz5+Az2Guk7a/G0K/b18PFH0HA
         w+z3EETj9qhXmsW5B9TO6NrgJGMDLJndPkFS7sq0/ftIl/8eYcb/2fazWunMqy4Sj7
         r4WINcjClC9N8/LkiSLjKm416vGNIXWvwy8dhNY9xJPWuU1ReL7lI5hkKi+RJTBRJ5
         t5nAnsq/TS86xYvFoBnddk0+L+TSgo8d69R1tyIZOagXQ2Xyu+ikiVYP1VKJ2LcskG
         NRaDJWVnjVcNw==
Message-ID: <0a1618c4-b808-56bd-e89f-560b0423191d@collabora.com>
Date:   Tue, 27 Sep 2022 12:39:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 3/6] clk: mediatek: mt8192: Do not re-register
 top_early_divs in probe function
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220926102523.2367530-1-wenst@chromium.org>
 <20220926102523.2367530-4-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220926102523.2367530-4-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/09/22 12:25, Chen-Yu Tsai ha scritto:
> top_early_divs are registered in the CLK_OF_DECLARE_DRIVER() half of the
> topckgen clk driver. Don't try to register it again in the actual probe
> function. This gets rid of the "Trying to register duplicate clock ..."
> warning.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Can't we simply remove the CLK_OF_DECLARE_DRIVER() and top_init_early entirely,
and transfer TOP_CSW_F26M_D2 to top_divs[] instead?
I get that systimer concern and we have something similar in MT8195, where the
TOP_CLK26M_D2 is registered "late".

Getting back to MT8192, TOP_CSW_F26M_D2 seems to be used only for:
1. systimer
2. SPMI MST (registered "late").

Being it a fixed factor clock, parented to another fixed clock, it doesn't
even have any ON/OFF switch, so I think it would be actually possible to go
for the proposed removal... which would further improve this cleanup.

Regards,
Angelo


