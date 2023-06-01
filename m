Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC487195BB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjFAIgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjFAIgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:36:00 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675011BF;
        Thu,  1 Jun 2023 01:34:44 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126205251136.34.openmobile.ne.jp [126.205.251.136])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 14E272B6;
        Thu,  1 Jun 2023 10:34:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685608460;
        bh=gjjeif7oGjHL6hoGkZVclWwy0gG6mXm12g9c6do6TMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JUUnACbDpEB6bOR3h2O5ln8qOzpTqf9VBhkZ21myMqir6gqWJBUH2lhbgPljo3AUr
         ZLmbW7sTAYzT5ej8JCl0YnN2x2g7F+RvAmu0lgbeX4QT61LRIobNk04EA1PyP66ClH
         YW/Xq3c4rgNzXp9p+1Ol32sfvdB3/t8nHUJEqQMg=
Date:   Thu, 1 Jun 2023 11:34:38 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>, tfiga@chromium.org,
        m.szyprowski@samsung.com, mchehab@kernel.org, ming.qian@nxp.com,
        shijie.qin@nxp.com, eagle.zhou@nxp.com, bin.liu@mediatek.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        tiffany.lin@mediatek.com, andrew-ct.chen@mediatek.com,
        yunfei.dong@mediatek.com, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, daniel.almeida@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 3/8] media: videobuf2: Add a module param to limit vb2
 queue buffer storage
Message-ID: <20230601083438.GE22609@pendragon.ideasonboard.com>
References: <20230321102855.346732-1-benjamin.gaignard@collabora.com>
 <20230321102855.346732-4-benjamin.gaignard@collabora.com>
 <6c4658fd-3a64-b3f8-67cd-17ed2d7d3567@xs4all.nl>
 <20230531080331.GB6496@pendragon.ideasonboard.com>
 <608ae7d6-3f3b-137d-08d2-d41a240be2c4@xs4all.nl>
 <20230531123945.GF27043@pendragon.ideasonboard.com>
 <6f53b5f6-6649-f194-1808-5f5757b449f4@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f53b5f6-6649-f194-1808-5f5757b449f4@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Thu, Jun 01, 2023 at 10:03:39AM +0200, Benjamin Gaignard wrote:
> Le 31/05/2023 à 14:39, Laurent Pinchart a écrit :
> > On Wed, May 31, 2023 at 10:30:36AM +0200, Hans Verkuil wrote:
> >> On 5/31/23 10:03, Laurent Pinchart wrote:
> >>> On Wed, May 31, 2023 at 08:36:59AM +0200, Hans Verkuil wrote:
> >>>> On 21/03/2023 11:28, Benjamin Gaignard wrote:
> >>>>> Add module parameter "max_vb_buffer_per_queue" to be able to limit
> >>>>> the number of vb2 buffers store in queue.
> >>>>>
> >>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> >>>>> ---
> >>>>>   drivers/media/common/videobuf2/videobuf2-core.c | 15 +++------------
> >>>>>   include/media/videobuf2-core.h                  | 11 +++++++++--
> >>>>>   2 files changed, 12 insertions(+), 14 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> >>>>> index ae9d72f4d181..f4da917ccf3f 100644
> >>>>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> >>>>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> >>>>> @@ -34,6 +34,8 @@
> >>>>>   static int debug;
> >>>>>   module_param(debug, int, 0644);
> >>>>>   
> >>>>> +module_param(max_vb_buffer_per_queue, ulong, 0644);
> >>>> There is no MODULE_PARM_DESC here? Please add. I see it is not there for
> >>>> the debug param either, it should be added for that as well.
> >>> Would this be the right time to consider resource accounting in V4L2 for
> >>> buffers ? Having a module parameter doesn't sound very useful, an
> >>> application could easily allocate more buffers by using buffer orphaning
> >>> (allocating buffers, exporting them as dmabuf objects, and freeing them,
> >>> which leaves the memory allocated). Repeating allocation cycles up to
> >>> max_vb_buffer_per_queue will allow allocating an unbounded number of
> >>> buffers, using all the available system memory. I'd rather not add a
> >>> module argument that only gives the impression of some kind of safety
> >>> without actually providing any value.
> >> Does dmabuf itself provide some accounting mechanism? Just wondering.
> >>
> >> More specific to V4L2: I'm not so sure about this module parameter either.
> >> It makes sense to have a check somewhere against ridiculous values (i.e.
> >> allocating MAXINT buffers), but that can be a define as well. But otherwise
> >> I am fine with allowing applications to allocate buffers until the memory
> >> is full.
> >>
> >> The question is really: what is this parameter supposed to do? The only
> >> thing it does is to sanitize unlikely inputs (e.g. allocating MAXINT buffers).
> >>
> >> I prefer that as a define, to be honest.
> >>
> >> I think it is perfectly fine for users to try to request more buffers than
> >> memory allows. It will just fail in that case, not a problem.
> >>
> >> And if an application is doing silly things like buffer orphaning, then so
> >> what? Is that any different than allocating memory and not freeing it?
> >> Eventually it will run out of memory and crash, which is normal.
> >
> > Linux provides APIs to account for and limit usage of resources,
> > including memory. A system administrator can prevent rogue processes
> > from starving system resources. The memory consumed by vb2 buffer isn't
> > taken into account, making V4L2 essentially unsafe for untrusted
> > processes.
> >
> > Now, to be fair, there are many reasons why allowing access to v4L2
> > devices to untrusted applications is a bad idea, and memory consumption
> > is likely not even the worst one. Still, is this something we want to
> > fix, or do we want to consider V4L2 to be priviledged API only ? Right
> > now we can't do so, but with many Linux systems moving towards pipewire,
> > we could possibly have a system daemon isolating untrusted applications
> > from the rest of the system. We may thus not need to fix this in the
> > V4L2 API.
> 
> I'm working in v3 where I'm using Xarray API.
> 
> Just to be sure to understand you well:
> I can just remove VB2_MAX_FRAME limit without adding a new one ?

As long as the code is protected against overflows (e.g. if it uses
num_buffers + 1 in some calculations and allows num_buffers to be
UINT_MAX, you'll have an issue), it should be fine for the vb2 and V4L2
core. Limiting the number of buffers doesn't really protect against
much.

-- 
Regards,

Laurent Pinchart
