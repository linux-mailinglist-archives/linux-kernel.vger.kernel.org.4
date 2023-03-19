Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B766C069D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 00:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCSXdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 19:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCSXdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 19:33:51 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F667E3A4;
        Sun, 19 Mar 2023 16:33:48 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 261C41373;
        Mon, 20 Mar 2023 00:33:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1679268826;
        bh=rfehHzT0nNC1C/6Q8HysuOgzvRnx3AnZ/cu68zcvIDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AbjSS6ayXnuqLhNWp/mlyDEibEroimNo5524LDllyl+5l8OTzNL+N19fuRaa8JOkQ
         /hMzNTpPDQoaW3ugi1qphNNqEpCX2hp2/Y5dXcqu1UBXKiQrXaiUGLpXnhZwk/4asE
         cZfZf5l6VdSz+htrDT2WABZRId7PHRBwC2VQMVbw=
Date:   Mon, 20 Mar 2023 01:33:52 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        ming.qian@nxp.com, shijie.qin@nxp.com, eagle.zhou@nxp.com,
        bin.liu@mediatek.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, tiffany.lin@mediatek.com,
        andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        daniel.almeida@collabora.com, hverkuil-cisco@xs4all.nl,
        jerbel@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [RFC 2/4] media: videobuf2: Replace bufs array by a list
Message-ID: <20230319233352.GC20234@pendragon.ideasonboard.com>
References: <20230313135916.862852-1-benjamin.gaignard@collabora.com>
 <20230313135916.862852-3-benjamin.gaignard@collabora.com>
 <20230313181155.GC22646@pendragon.ideasonboard.com>
 <bdade438cd93230daa47ee48eafab60f65cd4224.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdade438cd93230daa47ee48eafab60f65cd4224.camel@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 09:57:51AM -0400, Nicolas Dufresne wrote:
> Le lundi 13 mars 2023 à 20:11 +0200, Laurent Pinchart a écrit :
> > > -	/* Ensure that q->num_buffers+num_buffers is below VB2_MAX_FRAME */
> > > -	num_buffers = min_t(unsigned int, num_buffers,
> > > -			    VB2_MAX_FRAME - q->num_buffers);
> > > -
> > 
> > We can indeed drop this check now, but shouldn't we introduce some kind
> > of resource accounting and limitation ? Otherwise any unpriviledged
> > userspace will be able to starve system memory. This could be
> > implemented on top, as the problem largely exists today already, but I'd
> > like to at least record this in a TODO comment.
> 
> The current limit already isn't work for resource accounting and limitation for
> m2m drivers. You can open a device, allocate 32 buffers, and close that device
> keeping the memory around. And redo this process as many times as you want.

I know, that's why I mentioned that the problem largely exists today
already.

> A TODO is most appropriate, but I would prefer to see this done at a memory
> layer level (rather then v4l2 specific), so that limits and accounting works
> with containers and other sandboxes.

I haven't thought about how this could be implemented, all I know is
that it's about time to tackle this issue, so I would like to at least
record it.

> > I also wonder if we should still limit the number of allocated buffers.
> > The limit could be large, for instance 1024 buffers, and it would be an
> > in-kernel limit that could be increased later if needed. I'm concerned
> > that dropping the limit completely will allow userspace to request
> > UINT_MAX buffers, which may cause integer overflows somewhere. Limiting
> > the number of buffers would avoid extensive review of all the code that
> > deals with counting buffers.
> 

-- 
Regards,

Laurent Pinchart
