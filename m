Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7D365BF6B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbjACLxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236962AbjACLxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:53:09 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E33B658E;
        Tue,  3 Jan 2023 03:53:08 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9A7D86602CF2;
        Tue,  3 Jan 2023 11:53:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672746787;
        bh=Z0T/Uxfv2PUmyYHU5vEIFVIY7agrm3NioSoW9V9Fw0g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ATChoxL+c6VgV5SfbeR45O+w+BinEb/7fl+vigcjsoKvbii7L0S3VDj9PtRwSvHBC
         dI0OIt4UkMxMUHiTFExvMtXX/Q0ud0lKgg+i8SRFVEUADe92Gjy+LFd00wJRiLr+rQ
         9tcJ8+ORjH/EveEYr0ZFYfHqLwh4Zc1rIdCPD8QxMSwsUocUHe49VGgVrzVKU1MTzj
         vW4kh0ErmLnOUoFKXgBiOQkUPDxARFV46/QHxgj8t10cqxpbEIF7/S928FY1+zPJG3
         uNDb7CIwrNEFCV38YB/RzQRP7lXAnXekq89G5UEkEC6YMJckjvuIU13Cc9TfzHYrlK
         p6fB5bIT90s/g==
Message-ID: <d2a3e440-9755-b603-9c19-a47f68f3c780@collabora.com>
Date:   Tue, 3 Jan 2023 12:53:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] clk: core: Honor CLK_OPS_PARENT_ENABLE in
 clk_core_is_enabled
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230103092330.494102-1-wenst@chromium.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230103092330.494102-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/01/23 10:23, Chen-Yu Tsai ha scritto:
> In the previous commits that added CLK_OPS_PARENT_ENABLE, support for
> this flag was only added to rate change operations (rate setting and
> reparent) and disabling unused subtree. It was not added to the
> clock gate related operations. Any hardware driver that needs it for
> these operations will either see bogus results, or worse, hang.
> 
> This has been seen on MT8192 and MT8195, where the imp_ii2_* clk
> drivers set this, but dumping debugfs clk_summary would cause it
> to hang.
> 
> Prepare parent on prepare and enable parent on enable dependencies are
> already handled automatically by the core as part of its sequencing.
> Whether the case for "enable parent on prepare" should be supported by
> this flag or not is not clear, and thus ignored for now.
> 
> This change solely fixes the handling of clk_core_is_enabled, i.e.
> enabling the parent clock when reading the hardware state. Unfortunately
> clk_core_is_enabled is called in a variety of places, sometimes with
> the enable clock already held. To avoid deadlocking, the core will
> ignore readouts and just return false if CLK_OPS_PARENT_ENABLE is set
> but the parent isn't currently enabled.
> 
> Fixes: fc8726a2c021 ("clk: core: support clocks which requires parents enable (part 2)")
> Fixes: a4b3518d146f ("clk: core: support clocks which requires parents enable (part 1)")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Moreover, for MT6795 Xperia M5, MT8173 Elm, MT8192 Asurada, MT8195 Tomato:

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

