Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910196C0C18
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjCTIWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjCTIWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:22:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182281C321
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 01:22:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A411161277
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B6EC433D2;
        Mon, 20 Mar 2023 08:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679300543;
        bh=Doe1j/uXAracamn2Mysv5svXt7LOcVO7jSrIu0ukLWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WmMbgKxhrvLdrQUMb3RD/I0nM4GvhQVW1byr/VWg0euMi9rxIqLW3Qycuvn6IZ3UV
         JY52pcJkVJATODOjATOqsFAT20TpQOrsWDw9B/nnRUJkSRTJ0Ce96DZjF3rwTJ9cRY
         tcfYSBRQVR6GMsW5oym8He1ypbx7l0MKYPtvutvATIcmjyRdxZIeOXdVS2sfmP4y9h
         9eX5P22Ti3vmMUEDfHvpHFoPznkdmNZfIrUr7ue1clJfZjNcFsdNCQVxuq7W5PNbA9
         UYjoY/Jzb8k3my7QeCfJG4nZa2LH5IlO32zxH3RsaRKpJ47YXULfXV2LtrjRStQUk4
         rWJhVEGfnk8kw==
Date:   Mon, 20 Mar 2023 08:22:17 +0000
From:   Lee Jones <lee@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 07/37] drm/mediatek/mtk_disp_aal: Remove half completed
 incorrect struct header
Message-ID: <20230320082217.GK9667@google.com>
References: <20230317081718.2650744-1-lee@kernel.org>
 <20230317081718.2650744-8-lee@kernel.org>
 <5dbee8ef-a5eb-b73d-5336-8b5c879a0d2a@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dbee8ef-a5eb-b73d-5336-8b5c879a0d2a@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023, AngeloGioacchino Del Regno wrote:

> Il 17/03/23 09:16, Lee Jones ha scritto:
> > Fixes the following W=1 kernel build warning(s):
> >
> >   drivers/gpu/drm/mediatek/mtk_disp_aal.c:39: warning: Function parameter or member 'clk' not described in 'mtk_disp_aal'
> >   drivers/gpu/drm/mediatek/mtk_disp_aal.c:39: warning: Function parameter or member 'regs' not described in 'mtk_disp_aal'
> >   drivers/gpu/drm/mediatek/mtk_disp_aal.c:39: warning: Function parameter or member 'cmdq_reg' not described in 'mtk_disp_aal'
> >   drivers/gpu/drm/mediatek/mtk_disp_aal.c:39: warning: Function parameter or member 'data' not described in 'mtk_disp_aal'
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
>
> I'd add the missing documentation instead.
>
> Please give some time, either me or someone else will do that ASAP.

Even better.  Thank you.

--
Lee Jones [李琼斯]
