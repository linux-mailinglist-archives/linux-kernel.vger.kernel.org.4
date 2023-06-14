Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED58D72F7B0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243372AbjFNIWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjFNIWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:22:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904D0A1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:22:06 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 375E4660217A;
        Wed, 14 Jun 2023 09:22:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686730925;
        bh=yHxKJIOTkMxsr4VfXZbhFYwmx/86Jp5vCpgw7y5SUx4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DOIgvONy8f6tb1k5x3t2TOXugfkYXng8zMlcYSsUTo865xRjHbr8SqgyqbAmIpUhM
         WfutGJmOiZjRSIqsopLIMNjUrMntH6F4tTZITpNMEIQCVsteQAAObp6soUXw1Z/eJC
         aI1+PVajbKixuQD28rLVwtkspvdzYoBtpcKP9qbYe9bhBvmT4+DQmrZ6/BOhH+k7Rb
         UzNXM+tqt0giyWYcg1cz7mf5AoIGbO5WUSvnVccdT1xTKGrYyzJkjNq3RhQFyeTKZi
         hRQPtdVOfAVDLYClWF7+utsr2FNOCJsioWVD1+fN4PkNjSUYrPy4LfdLetDgm09vcv
         XIp/l/uTRTaXQ==
Message-ID: <86ad3ffb-fbe2-9bed-751d-684994b71e9d@collabora.com>
Date:   Wed, 14 Jun 2023 10:22:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] drm/bridge: ps8640: Drop the ability of ps8640 to fetch
 the EDID
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org
Cc:     Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pin-yen Lin <treapking@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <uwu@icenowy.me>,
        linux-mediatek@lists.infradead.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230612163256.1.I7b8f60b3fbfda068f9bf452d584dc934494bfbfa@changeid>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230612163256.1.I7b8f60b3fbfda068f9bf452d584dc934494bfbfa@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/06/23 01:32, Douglas Anderson ha scritto:
> In order to read the EDID from an eDP panel, you not only need to
> power on the bridge chip itself but also the panel. In the ps8640
> driver, this was made to work by having the bridge chip manually power
> the panel on by calling pre_enable() on everything connectorward on
> the bridge chain. This worked OK, but...
> 
> ...when trying to do the same thing on ti-sn65dsi86, feedback was that
> this wasn't a great idea. As a result, we designed the "DP AUX"
> bus. With the design we ended up with the panel driver itself was in
> charge of reading the EDID. The panel driver could power itself on and
> the bridge chip was able to power itself on because it implemented the
> DP AUX bus.
> 
> Despite the fact that we came up with a new scheme, implemented in on
> ti-sn65dsi86, and even implemented it on parade-ps8640, we still kept
> the old code around. This was because the new scheme required a DT
> change. Previously the panel was a simple "platform_device" and in DT
> at the top level. With the new design the panel needs to be listed in
> DT under the DP controller node. The old code allowed us to properly
> fetch EDIDs with ps8640 with the old DTs.
> 
> Unfortunately, the old code stopped working as of commit 102e80d1fa2c
> ("drm/bridge: ps8640: Use atomic variants of drm_bridge_funcs"). There
> are cases at bootup where connector->state->state is NULL and the
> kernel crashed at:
> * drm_atomic_bridge_chain_pre_enable
> * drm_atomic_get_old_bridge_state
> * drm_atomic_get_old_private_obj_state
> 
> A bit of digging was done to see if there was an easy fix but there
> was nothing obvious. Instead, the only device using ps8640 the "old"
> way had its DT updated so that the panel was no longer a simple
> "platform_deice". See commit c2d94f72140a ("arm64: dts: mediatek:
> mt8173-elm: Move display to ps8640 auxiliary bus") and commit
> 113b5cc06f44 ("arm64: dts: mediatek: mt8173-elm: remove panel model
> number in DT").
> 
> Let's delete the old, crashing code so nobody gets tempted to copy it
> or figure out how it works (since it doesn't).
> 
> NOTE: from a device tree "purist" point of view, we're supposed to
> keep old device trees working and this patch is technically "against
> policy". Reasons I'm still proposing it anyway:
> 1. Officially, old mt8173-elm device trees worked via the "little
>     white lie" approach. The DT would list an arbitrary/representative
>     panel that would be used for power sequencing. The mode information
>     in the panel driver would then be ignored / overridden by the EDID
>     reading code in ps8640. I don't feel too terrible breaking DTs that
>     contained the wrong "compatible" string to begin with. NOTE that
>     any old device trees that _didn't_ lie about their compatible will
>     still work because the mode information will come from the
>     hardcoded panels in panel-edp.
> 2. The only users of the old code were Chromebooks and Chromebooks
>     don't bake their DTs into the BIOS (they are bundled with the
>     kernel). Thus we don't need to worry about breaking someone using
>     an old DT with a new kernel.
> 3. The old code was crashing anyway. If someone wants to fix the old
>     code instead of deleting it then they have my blessing, but without
>     a proper fix the old code isn't useful.
> 
> I'll list this as "Fixing" the code that made the old code start
> failing. There's not lots of reason to bring this back any further
> than that.

Hoping to see removal of non-aux EDID reading code from all drivers that can
support aux-bus is exactly why I moved Elm to the proper... aux-bus.. so...

Yes! Let's go!

> 
> Fixes: 102e80d1fa2c ("drm/bridge: ps8640: Use atomic variants of drm_bridge_funcs")

...but this Fixes tag will cause this commit to be backported to kernel versions
before my commit moving Elm to aux-bus, and break display on those.

I would suggest to either find a different Fixes tag, or don't add any, since
technically this is a deprecation commit. We could imply that the old technique
is deprecated since kernel version X.Y and get away with it.

Otherwise, if you want it backported *anyway*, the safest way would be to Cc it
to stable and explicitly say which versions should it be backported to.

I really want to give my R-b tag to this one.

Cheers!
Angelo


