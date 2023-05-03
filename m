Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9D46F5ABA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 17:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjECPMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 11:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjECPMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 11:12:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2004ED2;
        Wed,  3 May 2023 08:12:18 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 10AF4660309E;
        Wed,  3 May 2023 16:12:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683126736;
        bh=Pi/CSe8nv/Bn/w1ZOAaw3WYXTtUFhF9Hq3jb//Y3+2U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FE71iUqcb1QFWFNA3otCiAMTpY/p5HvHJZrIf1+KOPqWzSPysuJcEN/+3wOP6ZXBQ
         hvFf/rkkglQMiiyriKdGxXdMVay7nx/w/N9KfAIMNP0/dPqy8uLa3xULtj7FKNOK7l
         cjkBSoUog29I+Xt6nN4OXr4I3rkww6T5sRJUd2TWLikIQmW/idr0ACHqHStKr6bIFT
         8xatKmjYGMwaQKwNetILI36FgRXr79+8dLdTbuhk6exLPzrkQU+JrO2C99WCE09x7m
         Hq0W8m8IvfqXd8NST9C1NXegeNQqxTCdcjkD3MaYi5B6HopXdX+dD0oJ53+yBgaAfH
         ziUv1iE+pN5mA==
Message-ID: <43be865c-c870-f61a-9837-e189d6e4ae00@collabora.com>
Date:   Wed, 3 May 2023 17:12:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/3] thermal/drivers/mediatek/lvts_thermal: Disable
 undesired interrupts
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Alexandre Bailon <abailon@baylibre.com>, kernel@collabora.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20230428195347.3832687-1-nfraprado@collabora.com>
 <20230428195347.3832687-4-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230428195347.3832687-4-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/04/23 21:53, Nícolas F. R. A. Prado ha scritto:
> Out of the many interrupts supported by the hardware, the only ones of
> interest to the driver currently are:
> * The temperature went over the hot threshold, for any of the sensors
> * The temperature went over the hot to normal threshold, for any of the
>    sensors
> * The temperature went over the stage3 threshold
> 
> These are the only thresholds configured by the driver through the
> HTHRE, H2NTHRE, and PROTTC registers, respectively.
> 
> The current interrupt mask in LVTS_MONINT_CONF, enables many more
> interrupts, including offset detection and data ready on sensors for
> both filtered and immediate mode. These are not only not handled by the
> driver, but they are also triggered too often, causing unneeded
> overhead. Disable these unnecessary interrupts.
> 
> The meaning of each bit can be seen in the comment describing
> LVTS_MONINTST in the IRQ handler.
> 
> Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


