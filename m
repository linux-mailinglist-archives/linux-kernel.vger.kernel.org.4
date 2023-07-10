Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24F774CF70
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjGJIHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjGJIHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:07:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6ABE1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 01:07:02 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0327A66057B8;
        Mon, 10 Jul 2023 09:07:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688976421;
        bh=4MaltMVO+iQy6EpByYoeAcXeuF+ABj89+MZxBYJFHKg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=addcJBtOMke09j+T2MFJ5b5YVqiJA8dBuzMlpUWHxRWbF7exr5O9ywRw4xwFxyZdv
         22k+KVecQZIG0Rmt9tBcCPHqUyxIZaPHySPgJC8fjqckey56wrJYQ+LIwBfFZWtwWI
         Q3Ek46u64q8lnquI2kj8o0u1gcCMo394umGWpHrYKt0OU2lAk3PN3H5EHx/dKqYLIg
         dH5Fu86DCBBs/qHx/iYA3x9Alj8/NubIPQPwBfaZcehKN/K95ffQwvEJWj9db7vD+W
         Hx9brc0DBNm+uZLfWFKBdlIWb37uqpSZKYr3jaSWRAffcj7LnqL8daiyvDGQQ81lhb
         M1txsLeyxlN1Q==
Message-ID: <44a4270b-72d5-10ca-c706-c3a1fc7bd4dc@collabora.com>
Date:   Mon, 10 Jul 2023 10:06:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/2] drm/mediatek: Fix iommu fault by swapping FBs
 after updating plane state
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230709162641.6405-1-jason-jh.lin@mediatek.com>
 <20230709162641.6405-2-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230709162641.6405-2-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/07/23 18:26, Jason-JH.Lin ha scritto:
> According to the comment in drm_atomic_helper_async_commit(),
> we should make sure FBs have been swapped, so that cleanups in the
> new_state performs a cleanup in the old FB.
> 
> So we should move swapping FBs after calling mtk_plane_update_new_state(),
> to avoid using the old FB which could be freed.
> 
> Fixes: 1a64a7aff8da ("drm/mediatek: Fix cursor plane no update")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


