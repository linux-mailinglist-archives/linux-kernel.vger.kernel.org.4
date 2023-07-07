Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2526B74ACC5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjGGIWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjGGIWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:22:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCD02121;
        Fri,  7 Jul 2023 01:21:42 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 560766606FCA;
        Fri,  7 Jul 2023 09:21:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688718092;
        bh=37R8WytlElX/g9LasuDma5fEgNGMk0IZTGnuoKn6N4Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=h2kDENk50rWu1SysrlTafzH1+VuYVHOvKAlvGaTaf4J3/TURNCv6Nh4/5oMsW/bwT
         7D4klldr1l+6QRtXlAH3L3vpKMo0cs/crDBPwbGFAXsx2lHHOIBh8aQF36MRAHfy6N
         M6otPz7A06N/tprFPJtXvw3oa302/9B5GVLc/aMrrQ5rnAvHDXRWwsIf3QI0/bjSaX
         mvTi8wMX8tWu3iN86twZupPWrZBF4noD+d376cHaI5eTC9HYnMZzsDjYhKtaRiZ2yy
         O2MXc9ugiub0CmVw6AYy/X78kmgi7Ji28umZXg+A9VJ6RRofP9ibetQH4Zb9PelTbE
         wMsugYwL7E80Q==
Message-ID: <0361bfac-95b4-3acc-583a-e8665800fe4d@collabora.com>
Date:   Fri, 7 Jul 2023 10:21:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/6] thermal/drivers/mediatek/lvts_thermal: Use offset
 threshold for IRQ
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        kernel@collabora.com, Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20230706153823.201943-1-nfraprado@collabora.com>
 <20230706153823.201943-4-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230706153823.201943-4-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/07/23 17:37, Nícolas F. R. A. Prado ha scritto:
> There are two kinds of temperature monitoring interrupts available:
> * High Offset, Low Offset
> * Hot, Hot to normal, Cold
> 
> The code currently uses the hot/h2n/cold interrupts, however in a way
> that doesn't work: the cold threshold is left uninitialized, which
> prevents the other thresholds from ever triggering, and the h2n
> interrupt is used as the lower threshold, which prevents the hot
> interrupt from triggering again after the thresholds are updated by the
> thermal framework, since a hot interrupt can only trigger again after
> the hot to normal interrupt has been triggered.
> 
> But better yet than addressing those issues, is to use the high/low
> offset interrupts instead. This way only two thresholds need to be
> managed, which have a simpler state machine, making them a better match
> to the thermal framework's high and low thresholds.
> 
> Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

