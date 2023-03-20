Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121006C0CEC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjCTJQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjCTJPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:15:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D46CC2E;
        Mon, 20 Mar 2023 02:15:52 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 609CE6600362;
        Mon, 20 Mar 2023 09:15:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679303751;
        bh=FVE/VnhCqhKLk/cTAsJE4ygkLkqvPEjjRuwr8ROyMvM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EY7vmn2bfUZM8B6KuVifIfAdWx0h6YzszVdX1HeOUlpZnXV7FdGTyvGUQUaE4jG8d
         uVMFtNtmlPIPZsCEA7jMqrWLLhQMaXFc+oqMH2WsBtq6sJqne0hpapXMzp0rUAtIsg
         igbCOFalXRAYvj74u78n0K6qB3knPpJzE6IHhPj5qhIafol1B3Oo4l1V6E0Li7n+NR
         hWglPl1HXz987icEApndGia57kjVCZknz5OIZwp0vRj4k2cFf/IL9f1VZxQwjIMOMq
         0REeIUWKj4Q/tqr/cPfjiBuBKZXH6ogrhRuHJgL2wUujUe9iZDkXG/7coTKaSGnf4j
         hRsqkL7JrLlfg==
Message-ID: <4af1f582-33c1-9491-0ccc-38cc412b9639@collabora.com>
Date:   Mon, 20 Mar 2023 10:15:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] clk: mediatek: mt81xx: Ensure fhctl code is available
To:     Arnd Bergmann <arnd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230320091353.1918439-1-arnd@kernel.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230320091353.1918439-1-arnd@kernel.org>
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

Il 20/03/23 10:13, Arnd Bergmann ha scritto:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Just like in commit eddc63094855 ("clk: mediatek: Ensure fhctl code is
> available for COMMON_CLK_MT6795"), these three need the shared driver
> code, otherwise they run into link errors such as:
> 
> aarch64-linux/bin/aarch64-linux-ld: drivers/clk/mediatek/clk-mt8192-apmixedsys.o: in function `clk_mt8192_apmixed_probe':
> clk-mt8192-apmixedsys.c:(.text+0x134): undefined reference to `fhctl_parse_dt'
> 
> Fixes: 45a5cbe05d1f ("clk: mediatek: mt8173: Add support for frequency hopping through FHCTL")
> Fixes: 4d586e10c428 ("clk: mediatek: mt8192: Add support for frequency hopping through FHCTL")
> Fixes: da4a82dc67b0 ("clk: mediatek: mt8195: Add support for frequency hopping through FHCTL")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

....and sorry for this big miss.

Regards,
Angelo
