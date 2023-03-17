Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885006BEC86
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjCQPJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjCQPJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:09:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D136F10DE7C;
        Fri, 17 Mar 2023 08:08:40 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8162C66030B9;
        Fri, 17 Mar 2023 15:07:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679065665;
        bh=oDkOpASujwD4omvYh15ZgVx02nJzDslcJUvtWJE8YGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y+3fXThjONEiG2GDz0f94e6hUKgev5us7WM1wv9muoN55JAJ1EkRRiy7/AdAYYnjz
         xu+Cm92GqsrWm/eWOnBuouHfl0ZSju9jqP1SrRpqNYfRstB5dsC8+leTYDz6fPqs0u
         o/tzh3xzeO7eEnI9g036SAR6q/5FHncyeCYHXKN3Jv+NlSp2zHAnkRwCBU6ubBeQaT
         SfOrRKRZfYJ6gAl95bWAaqOQ+xW3lOGroCn8UpskrV1boNQ6YQbqp6jGjmXLIBwyar
         +l7qlVpWRtnYa2XciTvIvz9cpxssH/HhYPAqZcAiwb4QyQPcnMiQ5QBLmHLk+bwWQw
         N0NyKQIgAMceQ==
Date:   Fri, 17 Mar 2023 11:07:39 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v4,1/2] media: mediatek: vcodec: Force capture queue
 format to MM21
Message-ID: <20230317150739.wmrik43dols5ju3a@notapiano>
References: <20230317030833.16836-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230317030833.16836-1-yunfei.dong@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 11:08:32AM +0800, Yunfei Dong wrote:
> While the decoder can produce frames in both MM21 and MT21C formats, only MM21
> is currently supported by userspace tools (like gstreamer and libyuv). In order
> to ensure userspace keeps working after the SCP firmware is updated to support
> both MM21 and MT21C formats, force the MM21 format for the capture queue.
> 
> This is meant as a stopgap solution while dynamic format switching between
> MM21 and MT21C isn't implemented in the driver.
> 
> Fixes: 7501edef6b1f ("media: mediatek: vcodec: Different codec using different capture format")
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>


With this patch and the new firmware [1], I was able to run fluster using the
VP8, VP9 and H.264 codecs on both MT8192 and MT8195:

MT8192:
	        VP8: 59/61
	        VP9: 250/303
		     0/6 (HIGH)
	        H.264: 92/135
		       27/69 (JVT-FR-EXT)

MT8195:
	        VP8: 59/61
	        VP9: 276/303
		     0/6 (HIGH)
	        H.264: 95/135
		       27/69 (JVT-FR-EXT)

[1] https://lore.kernel.org/linux-firmware/a43524a089a783f70adbe89b83eeb01fbd405d04.camel@mediatek.com/T/#mb0591267d7921bbfada7c06ee2bda128db554648

Thanks,
Nícolas
