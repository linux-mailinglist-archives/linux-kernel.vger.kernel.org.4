Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B716F5AA6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 17:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjECPIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 11:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjECPIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 11:08:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3834ED2;
        Wed,  3 May 2023 08:08:41 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 86AEC660309E;
        Wed,  3 May 2023 16:08:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683126519;
        bh=RwTGWOhkT7pHlQLK7lBAvP67WOlpNIgQtMBeQOTu5GQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TsfBtP/r5DB06esjjVFlv1laNtIZfYOWcaJSjKiK/vBGHoYjiFdeIa33f0Frtk+4L
         FUOXQETj1YxZhTvk8Uz2iLdvcFRnG/bmQbl2rWVB1DE3dYAG3r3bMjv7dLtUm8LoPX
         YY+R0XBOaaFdkKUU3aAx58sz4tmpSTnWKlmYLhWkYl+MXlIWNY9Y+QZBPq9+4BJFJu
         0PpCVJbt46yoxg7GdS2G7OPKqFPh5A+udbnNKP2yoZq7lgIBU4n1quPJ4bzwVnM7+c
         L03/4EmwU0SXjcwgPA5LwzTrWdQEs0M6tiGvbIMikeeonyPlx8/hEPVl/L+IlFrSCl
         V8LxOwUKef5nw==
Message-ID: <449d21bf-c91c-f8dc-38c4-1206a5463fdd@collabora.com>
Date:   Wed, 3 May 2023 17:08:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/3] thermal/drivers/mediatek/lvts_thermal: Handle IRQ on
 all controllers
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
 <20230428195347.3832687-2-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230428195347.3832687-2-nfraprado@collabora.com>
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
> There is a single IRQ handler for each LVTS thermal domain, and it is
> supposed to check each of its underlying controllers for the origin of
> the interrupt and clear its status. However due to a typo, only the
> first controller was ever being handled, which resulted in the interrupt
> never being cleared when it happened on the other controllers. Add the
> missing index so interrupts are handled for all controllers.
> 
> Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


