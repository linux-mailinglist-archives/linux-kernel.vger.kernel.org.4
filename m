Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A74B74ACCA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjGGIWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjGGIWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:22:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344EE210B;
        Fri,  7 Jul 2023 01:22:09 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4AB9C6606FCA;
        Fri,  7 Jul 2023 09:22:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688718128;
        bh=KlqmsemJjqgs8TN2Gg23NtEfSBp5PE0Ob4EPcUQRJuw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dTdK+JOhlS1RgWLnLTo3YBkJSNT581LvyIa23ZL6eicmvkcLaVeZ2g9u18dMNXOtW
         Tkg1Aq4nQlff4bBZ1dqbJGm9dWMsjhuQwVWbcWHECFBoh1cTZuPbwzJEvY78QPckSL
         7eka9gMKpUNEg71Ki37FrhwC9A4KGP43lfwQmmpa0tuqv+po5EARjMa5kUpl4EFDgk
         k0MsmvVaVgxDATr5bRtjL2v37taVHc/z/Qkc00kmGPoqxe4mnx1WiKXKqOVjZGG1yv
         nFLJEiPw9v261ho8uS3+/h33OHfo7A+TllTaehD8q7Qw7HQrWOYWx/0uJIS5sM8nZ3
         bKyqCZpet8aPQ==
Message-ID: <7d7db84b-e6be-2d45-fbc6-e891718b757a@collabora.com>
Date:   Fri, 7 Jul 2023 10:22:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 5/6] thermal/drivers/mediatek/lvts_thermal: Don't leave
 threshold zeroed
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
 <20230706153823.201943-6-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230706153823.201943-6-nfraprado@collabora.com>
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
> The thermal framework might leave the low threshold unset if there
> aren't any lower trip points. This leaves the register zeroed, which
> translates to a very high temperature for the low threshold. The
> interrupt for this threshold is then immediately triggered, and the
> state machine gets stuck, preventing any other temperature monitoring
> interrupts to ever trigger.
> 
> (The same happens by not setting the Cold or Hot to Normal thresholds
> when using those)
> 
> Set the unused threshold to a valid low value. This value was chosen so
> that for any valid golden temperature read from the efuse, when the
> value is converted to raw and back again to milliCelsius, the result
> doesn't underflow.
> 
> Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


