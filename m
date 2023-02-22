Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F7E69F21F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjBVJsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjBVJr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:47:56 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227CC3A0BC;
        Wed, 22 Feb 2023 01:46:06 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EC70766021A4;
        Wed, 22 Feb 2023 09:31:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677058315;
        bh=z1nbc9uu0vOOIzAQoEiB9OWmVSYp4DkRy59rM1/bgZM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eIQroP8mU2qOY/sCGOZpM1hWWFpg6TPZE8qebzrIl5+KS7KhafIXe6H4csJN8wt3t
         p82KITsZAWCBkbW4SJkuwaO06GJuY8nePV/2nJgVaA2SCFoPLo9kh/sOpTYgmsZj6Q
         JCxJuKmerXN9mWiC8bEn0rh9eCSvuN5wR+/BJZ5XIAyfqU2WReleKLbzSLIno/z9G/
         1QwqyKQoTlCAEG+ZN2eB2MCc0jrVZhlwMw5zrqwmEBPe4E1ov1IbcSBhf6r9N21Wmv
         u9J6Bh9IVxgsIG0t4uvGUWVrrqFGc/b8kXCMq0kaF2qxVssIlUjcX4lSCx24XI6jIx
         Y+OmtGXpXC/YA==
Message-ID: <94b131f7-9a66-7e26-4f8f-9d84e2c90fbf@collabora.com>
Date:   Wed, 22 Feb 2023 10:31:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 06/16] thermal: Don't use 'device' internal thermal
 zone structure field
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balsam CHIHI <bchihi@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:TI BANDGAP AND THERMAL DRIVER" 
        <linux-omap@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
 <20230221180710.2781027-7-daniel.lezcano@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230221180710.2781027-7-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/02/23 19:07, Daniel Lezcano ha scritto:
> Some drivers are directly using the thermal zone's 'device' structure
> field.
> 
> Use the driver device pointer instead of the thermal zone device when
> it is available.
> 
> Remove the traces when they are duplicate with the traces in the core
> code.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Balsam CHIHI <bchihi@baylibre.com> #Mediatek LVTS

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> 
#MediaTek LVTS


