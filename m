Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF4572F823
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243757AbjFNIoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243723AbjFNIoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:44:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8261FD5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:43:59 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4E13D6606F14;
        Wed, 14 Jun 2023 09:43:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686732238;
        bh=Ge/Fde+IO5OnVVPpbznrh9tcQY2RO9OzpPAaX7OypS4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kWGhytc9Ew47gZQUjWb4E1/Ihz4y6ScmhBRnOX4EfFS9MPnAL4EALw9NqGe4xkRnu
         L8Fy76Wn5rwmRaXE4iXjeM4nlAOfZ3mIR65vmBhXRYR0fDi4lB96NxPoG4pEMI9CHN
         9+Cjz+SfKBCnJ+1YZ0Iq0xNQzNn0G2oYQXXEmu6lMuJCA/IqBa3iJZXkv8lMn7ZIje
         DCMyaJ2RVz04OHeGqCcdKz+UhAym6MMPea3BrVDQjnDuJI/DrUGo4cNiCyFW+/HNZF
         x5TbzufR6P7X7XvlWaAlxHFNFynvvrQ34mH4uoyqS4PJ/LFon05b2xGWnqk0HCSaK+
         /gk1YqpqYnG6g==
Message-ID: <98809b8a-1d30-a686-0da8-5032bb362560@collabora.com>
Date:   Wed, 14 Jun 2023 10:43:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 4/4] drm/mediatek: Fix dereference before null check
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230613113210.24949-1-jason-jh.lin@mediatek.com>
 <20230613113210.24949-5-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230613113210.24949-5-jason-jh.lin@mediatek.com>
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

Il 13/06/23 13:32, Jason-JH.Lin ha scritto:
> Null-checking state suggests that it may be null, but it has already
> been dereferenced on drm_atomic_get_new_plane_state(state, plane).
> 
> The parameter state will never be NULL currently, so just remove the
> state is NULL flow in this function.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Fixes: 5ddb0bd4ddc3 ("drm/atomic: Pass the full state to planes async atomic check and update")

Fixes before S-o-b...

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


