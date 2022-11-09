Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EF0622630
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiKIJE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiKIJES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:04:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9DE19C2D;
        Wed,  9 Nov 2022 01:04:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2607B81D46;
        Wed,  9 Nov 2022 09:04:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B212C433D7;
        Wed,  9 Nov 2022 09:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667984655;
        bh=dH7Ry1CIVTZgyI9KDAD7GwQOyjSCd95V0RbPoon0Nc4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aX27582WOVXNU1jj0FQfgLz8r3Yp9vvPY4KtxtEXh+a/GDU3sWTVgpeZfpqnW4tdk
         KOrP4RnySArPB0V2V28mCiKe+K55D28CiZTS89Ip0pGDJRWR9wrJrJ4I1GPclPgmZa
         JUjxjOPw+yA06lGWQcbEnstdabNQB3x0VKGsKa6wgtYWtx0EmSCeky7MKrUoHXdKq7
         am7b1p9AnemOG9o/u96or6eQEu2BWfDnD1g3Opk8Dg+TEINLXc93XQBLBJkYVZmouO
         CPOvHn0hi9wsPA+cd2/k3DsmbcqiDDOLRF54HAoHUjLzM1y+NzizH7lVpGV0ZvKotI
         AgZW7YTKiy3QA==
Message-ID: <5758c2af-c2c5-dfbe-c7d8-036bbdaf71c7@kernel.org>
Date:   Wed, 9 Nov 2022 10:04:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 5/7] dt-bindings: watchdog: mediatek: Convert mtk-wdt
 to json-schema
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     nfraprado@collabora.com, angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20221108033209.22751-1-allen-kh.cheng@mediatek.com>
 <20221108033209.22751-6-allen-kh.cheng@mediatek.com>
 <585a9cbb-4df4-1c06-ecfa-3b9442f1a5e2@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <585a9cbb-4df4-1c06-ecfa-3b9442f1a5e2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2022 11:50, Matthias Brugger wrote:
> 
> 
> On 08/11/2022 04:32, Allen-KH Cheng wrote:
>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>
>> Convert the MediaTek watchdog bindings to schema.
>>
>> The original binding only had 4 without a fallback but there is a reset
>> controller on the "mediatek,mt7986-wdt", "mediatek,mt8186-wdt",
>> "mediatek,mt8188-wdt" and "mediatek,mt8195-wdt" Since there is no reset
>> controller for the mt6589, we remove "mediatek,mt6589-wdt" as a
>> fallback.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Co-developed-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
>> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> As I'm put as the maintainer:
> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
> 
> Shall I take that through my tree or shall it go through the watchdog tree?
> 

In general, bindings should go via subsystem trees (so watchdog), just
like drivers. However this got Guenter's review tag, so usually it means
also an ack... Dunno... :)

Best regards,
Krzysztof

