Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F1E719701
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjFAJch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjFAJcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:32:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61AFD7;
        Thu,  1 Jun 2023 02:32:34 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 675986606EBB;
        Thu,  1 Jun 2023 10:32:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685611953;
        bh=whFU6RQfTu4aMGzHChOYJW6hVSKs9682QmXsD693FIo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CjJNE85gZL9TSf82fMtJzz4ok6OK9dj9OJTjXF4pabMi0hP8POLwTXSXbf7TlribO
         RV/w50MZnSyOrVz+aT1bUuqDZ39NulSM7Ayle56TSdD/dCECzIo2hu9zAlieXgvsu4
         qV2+91Tfq1EWs8YDEMNLB4mmhED1wlr3gKLzIZ9nDgoYRQAEZix6LHFC6oVp2tJ6c/
         xaBcFEbKhHF16ngSWzcVBti5DROgVubYnUq4AXweCmEyZM0YY8FZkDWIC+YaLw9+zz
         KCwVZPa89v4TZzMlvYFrAhejXcpvK8cH8Xr2q6Mb62E+1ikNvu683cictWmYVitPyk
         QdnN2Cknpn0pA==
Message-ID: <937fb46e-7e52-5689-9c49-efef477211db@collabora.com>
Date:   Thu, 1 Jun 2023 11:32:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 0/8] media: mediatek: vcodec: separate encoder and decoder
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, Nathan Hebert <nhebert@chromium.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230601030256.29875-1-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230601030256.29875-1-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/06/23 05:02, Yunfei Dong ha scritto:
> With the driver more and more complex, encoder and decoder need to add more parameter
> in shared struct 'mtk_vcodec_ctx' and 'mtk_vcodec_dev'. Encoder use about 40% and
> decoder use 60% parameter. Need to allocate extra unused memory when encoder and decoder
> working.
> 
> Separate encoder and decoder in different folder and use independent data struct.
> 

Great cleanup initiative! Love it!

My sugggestion here is to change the new folder names to drop "video-":
this is already in folder vcodec/ which means that it is video codec related.

So, instead of having folders "video-common", "video-decoder", "video-encoder",
we should have "common", "decoder", "encoder" instead.

Cheers,
Angelo

