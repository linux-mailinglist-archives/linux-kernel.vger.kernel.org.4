Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0DD72C30F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjFLLin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbjFLLiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:38:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290777EC3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:23:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B57F5621CD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A54C433EF;
        Mon, 12 Jun 2023 11:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686569032;
        bh=2pWJ7akrV/IBQIUQGqo/m2AjA44ebmjYSJmPmlQ+/BI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oeatR2Zf7LxcWnEC/5pHJEKc9Qu2yvyHbHpLOt/J8N3D1brNAMTLIlCUa9bTrwEjP
         0GkpMA8rtcW8zeYdb9n/0Kqq4zVq+Y34X/7a7lBRSjs9t+eBUERUzxwOkqAESjtclZ
         dh6MOTdZ1+ThGN9z766sK47NVSG5794NFS/f8AYZW610wqhGfjTnBT+kMpOAbGvnDL
         5Ex4lD1pi/dPzj8+JCrJnQJ8hy58b894PjT7nIWwu49pCB0f6VIBbslDG9g6Je0u3R
         3BTGyggRSu+6DVJZBxd29pPv/QzbwxagUPhnQ1rhnaKeCVE7eLdA4K+mQ5UPhGUCZi
         yJpmLgL8q24hQ==
Date:   Mon, 12 Jun 2023 12:23:46 +0100
From:   Lee Jones <lee@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND 05/15] drm/mediatek/mtk_disp_ccorr: Remove half
 completed incorrect struct header
Message-ID: <20230612112346.GN3635807@google.com>
References: <20230609081732.3842341-1-lee@kernel.org>
 <20230609081732.3842341-6-lee@kernel.org>
 <eed12356-4bc8-29a3-6105-b2bc65d74029@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eed12356-4bc8-29a3-6105-b2bc65d74029@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jun 2023, Matthias Brugger wrote:

> 
> 
> On 09/06/2023 10:17, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >   drivers/gpu/drm/mediatek/mtk_disp_ccorr.c:47: warning: Function parameter or member 'clk' not described in 'mtk_disp_ccorr'
> >   drivers/gpu/drm/mediatek/mtk_disp_ccorr.c:47: warning: Function parameter or member 'regs' not described in 'mtk_disp_ccorr'
> >   drivers/gpu/drm/mediatek/mtk_disp_ccorr.c:47: warning: Function parameter or member 'cmdq_reg' not described in 'mtk_disp_ccorr'
> >   drivers/gpu/drm/mediatek/mtk_disp_ccorr.c:47: warning: Function parameter or member 'data' not described in 'mtk_disp_ccorr'
> > 
> > Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-mediatek@lists.infradead.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >   drivers/gpu/drm/mediatek/mtk_disp_ccorr.c | 5 -----
> >   1 file changed, 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
> > index 1773379b24398..720f3c7ef7b4f 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
> > @@ -34,11 +34,6 @@ struct mtk_disp_ccorr_data {
> >   	u32 matrix_bits;
> >   };
> > -/**
> > - * struct mtk_disp_ccorr - DISP_CCORR driver structure
> > - * @ddp_comp - structure containing type enum and hardware resources
> > - * @crtc - associated crtc to report irq events to
> > - */
> 
> That surely suppress the warning but I think the correct to do here is to
> fix the documentation instead of deleting it.

If someone wants to take responsibility for it and author correct
documentation, I'm all for it.  That is the perfect resolution.  If
that's not going to happen immediately, I suggest we remove it in the
first instance.

-- 
Lee Jones [李琼斯]
