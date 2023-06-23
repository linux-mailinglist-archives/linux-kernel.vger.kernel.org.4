Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A1973B106
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjFWHCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjFWHCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:02:47 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408E9212F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 00:02:45 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id AE3D53F32D;
        Fri, 23 Jun 2023 09:02:42 +0200 (CEST)
Date:   Fri, 23 Jun 2023 09:02:42 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/msm/dsi: Enable DATABUS_WIDEN for DSI command
 mode
Message-ID: <qgqzbcoy5rbkya4vodicmty3pvhqj5laqb3sb5kcdicwityboq@m4hpqw3tofdz>
References: <20230525-add-widebus-support-v1-0-c7069f2efca1@quicinc.com>
 <20230525-add-widebus-support-v1-3-c7069f2efca1@quicinc.com>
 <3a6cc492-6b54-2c70-402e-995c0b003c01@linaro.org>
 <mfzmioovf54lcuiuzvk4fuz26elag6iw3ohbdhgym7k3qzirhx@dd7vu7ms6azz>
 <e594fed4-fc01-477b-1e7c-d1d58e1a0dda@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e594fed4-fc01-477b-1e7c-d1d58e1a0dda@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-22 16:04:30, Abhinav Kumar wrote:
<snip>
> >> Is widebus applicable only to the CMD mode, or video mode can employ it too?
> > 
> > The patch description states that it was not tested on video-mode yet,
> > so I assume it will.  But this should also be highlighted with a comment
> > (e.g. /* XXX: Allow for video-mode once tested/fixed */), _especially_
> > on the check for MIPI_DSI_MODE_VIDEO above.
> 
> Sure, we can leave a comment.

Thanks!
> 
> > If I understand this correctly DSC is not working for video mode at all
> > on these setups, right?  Or no-one was able to test it?  I'm inclined to
> > request dropping these artifical guards to have as little friction as
> > possible when someone starts enabling and testing this - and less
> > patches removing artificial bounds in the future.
> > 
> 
> Noone was able to test it. Like I have said before, we dont have or have 
> not brought up any DSI DSC panel with video mode. DP will be the first 
> to validate the video mode path for DSC so even that time we cannot test 
> DSI with DSC on video mode.
> 
> I think we should find a panel which supports cmd and video mode ( I 
> believe one of the HDKs does have that ) and bring that one up first to 
> validate this.
> 
> I believe we should keep this checks with the comment you have 
> suggested. If someone tests it and then removes it, I am comfortable 
> with that.
> 
> Till then, I would rather guard that configuration.

Sure.  On the one hand my suggestion to drop it would be to simplify
DSC video-mode "bring-up" and not put up arbitrary barriers, but for
distinct optional features like widebus it makes sense to keep them
guarded so that a developer can enable them one at a time.  I'm just
afraid that them being spread far and wide across the codebase makes it
hard to find all the places where this guard is in place.

Unless it is hopefully one of the current active developers testing
video-mode, because we all know what's where now :)

- Marijn
