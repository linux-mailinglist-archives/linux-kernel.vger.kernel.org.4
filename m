Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7288F6BEDD8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjCQQQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCQQQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:16:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BF175849;
        Fri, 17 Mar 2023 09:16:33 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B99A166030BB;
        Fri, 17 Mar 2023 16:16:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679069792;
        bh=49PZcSvk47SlrfLl7/yknVPtoQk4XUEFnqrmnkayK1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jltYPnZPzubr2lTQ/mLSolkU80AW0fOvMP1z7YZd8IoIwIRKndJ2VxpVOxFUy6SpV
         UZD+CfZfOjt3Sffj7yVlyxFJ2k2hHkgnET5izAl6StKCNgZtj1IV0w+lOq8yGgPPoP
         ChC0gCNvnUbxoeYxWSM7kmYzgqlffRJhCKL10QwOtr6JyfzDS4chHNk+o3d5DglyIA
         WGtKoQXzs3VnVe43ID8r35N1EjUVHUBpTwAu36xFqJdUBj0nBFaXjdy2/PulIrPyHo
         zHx6u2eAgGuxKmcPVf2hjbLV/FgKGPfehNIPeRWBWSkNHdrRB8k8OpMUAqEDN9vxEQ
         41U1E37EjGkbg==
Date:   Fri, 17 Mar 2023 12:16:25 -0400
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
Subject: Re: [PATCH v4,2/2] media: mediatek: vcodec: Using MM21 as the
 default capture format
Message-ID: <20230317161625.x6hm6cxr36hnhmcz@notapiano>
References: <20230317030833.16836-1-yunfei.dong@mediatek.com>
 <20230317030833.16836-2-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230317030833.16836-2-yunfei.dong@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunfei,

thanks for the patch.

The commit title should be in imperative, so I suggest:

	media: mediatek: vcodec: Make MM21 the default capture format

On Fri, Mar 17, 2023 at 11:08:33AM +0800, Yunfei Dong wrote:
> For the capture queue only support MM21 format with LibYuv, need to set MM21 as the
> default format.

Again, I think this commit message could be improved a bit. Here's a suggestion:

	Given that only the MM21 capture format is supported by userspace tools (like
	gstreamer and libyuv), make it the default capture format.

	This allows us to force the MM21 format even when a MM21 and MT21C capable
	firmware is available (which is needed while dynamic format switching isn't
	implemented in the driver), without causing the following regressions on
	v4l2-compliance:

				fail: v4l2-test-formats.cpp(478): pixelformat 3132544d (MT21) for buftype 9 not reported by ENUM_FMT
			test VIDIOC_G_FMT: FAIL
				fail: v4l2-test-formats.cpp(478): pixelformat 3132544d (MT21) for buftype 9 not reported by ENUM_FMT
			test VIDIOC_TRY_FMT: FAIL
				fail: v4l2-test-formats.cpp(478): pixelformat 3132544d (MT21) for buftype 9 not reported by ENUM_FMT
			test VIDIOC_S_FMT: FAIL

Also, I think it would be slightly better if this was the first patch in the
series, so that v4l2-compliance doesn't fail in between the patches.

> 
> Fixes: 7501edef6b1f ("media: mediatek: vcodec: Different codec using different capture format")
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

With this change I've confirmed that all v4l2-compliance tests are passing again:

Total for mtk-vcodec-dec device /dev/video2: 46, Succeeded: 46, Failed: 0, Warnings: 0

So, after the above comments are addressed,

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
