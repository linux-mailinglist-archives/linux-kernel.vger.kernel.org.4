Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5BA6F5AA7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 17:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjECPIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 11:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjECPIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 11:08:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EA14EEC;
        Wed,  3 May 2023 08:08:42 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B948366056CF;
        Wed,  3 May 2023 16:08:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683126520;
        bh=D9N6mr2rUKOdTtGJmgSLqH/jJ7q57NmzT7mbNyHBx5Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YWOXPhsrCKmDs7wUubclBOLGm5POV+Mrha43jUNH7ppJmnrU6B2UmyPdz6W1BQTHu
         nLk7Jfb1BvZSKqTvV+CHrtrSYiOT3JROU5yMESQYCVUST1rnTNFuBdDP77eVcggkDM
         IZqllyebtNtV/KBw5cQfMmnkHuGJQ+w9guOKyK3q68sGdGoIQK+b0a3xvV1j0IKx9F
         gG5uv3+ojTkNQrEcVWAqrvdoh/ze7sV4CgLwP0OXVDFhHArd7roYMb4RE4D7LJZR5V
         AlSCJL1501UzqimPnwi4hNAT38u73VmNLmXXpClFEFpNnrH/bGYGBnSRs6mW2Qp5Kr
         OsYp8/xZDWrCw==
Message-ID: <584879fa-1541-17d0-81dd-453333230b48@collabora.com>
Date:   Wed, 3 May 2023 17:08:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/3] thermal/drivers/mediatek/lvts_thermal: Honor sensors
 in immediate mode
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
 <20230428195347.3832687-3-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230428195347.3832687-3-nfraprado@collabora.com>
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
> Each controller can be configured to operate on immediate or filtered
> mode. On filtered mode, the sensors are enabled by setting the
> corresponding bits in MONCTL0, while on immediate mode, by setting
> MSRCTL1.
> 
> Previously, the code would set MSRCTL1 for all four sensors when
> configured to immediate mode, but given that the controller might not
> have all four sensors connected, this would cause interrupts to trigger
> for non-existent sensors. Fix this by handling the MSRCTL1 register
> analogously to the MONCTL0: only enable the sensors that were declared.
> 
> Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Awesome!!!!!

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


