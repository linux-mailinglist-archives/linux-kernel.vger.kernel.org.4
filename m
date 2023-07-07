Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567E274ACCD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjGGIXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbjGGIW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:22:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614AC2109;
        Fri,  7 Jul 2023 01:22:44 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6E8056606FCA;
        Fri,  7 Jul 2023 09:22:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688718163;
        bh=C7CMkxmZPAlHvOPFwq2S9P/9xy5K1sw18FMOfrzXvRs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DvqZkfgqgUMrr+u89G0Qog44SqNJzD2utg2faRY9pl8nXtOZORJywbcWcb01Mh9Mb
         9s4d0sCaaD+ZUnS0VafaPJjmCMK14DnM25sDcVuswmSA9GSQhfIIRC52kc4AYW1/9K
         +TWstsAk3LrBkXhw1mm5WVGQEthuqx/ZHFZ3qVNAycSNV+iFXF99USK+blOhEVVg8M
         assnECXSq4tIvwZK2XgsrpY7U+u/fVTi0O9wyllf1pPmbWRNctpZ1UB2NaCqby0+zl
         Ps7wpuPWcV8QI8mB4aocMhj9X6CQY2QrWPlOWsE0XBwWiW0IkoCSjaFOll4k0bPgV0
         w/v1Op4BHVtOA==
Message-ID: <16c4d5a9-4eeb-6a92-e97e-6e15eaeb913a@collabora.com>
Date:   Fri, 7 Jul 2023 10:22:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 6/6] thermal/drivers/mediatek/lvts_thermal: Manage
 threshold between sensors
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
 <20230706153823.201943-7-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230706153823.201943-7-nfraprado@collabora.com>
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
> Each LVTS thermal controller can have up to four sensors, each capable
> of triggering its own interrupt when its measured temperature crosses
> the configured threshold. The threshold for each sensor is handled
> separately by the thermal framework, since each one is registered with
> its own thermal zone and trips. However, the temperature thresholds are
> configured on the controller, and therefore are shared between all
> sensors on that controller.
> 
> When the temperature measured by the sensors is different enough to
> cause the thermal framework to configure different thresholds for each
> one, interrupts start triggering on sensors outside the last threshold
> configured.
> 
> To address the issue, track the thresholds required by each sensor and
> only actually set the highest one in the hardware, and disable
> interrupts for all sensors outside the current configured range.
> 
> Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

