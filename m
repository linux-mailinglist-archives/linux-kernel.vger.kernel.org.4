Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D33733BD0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 00:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjFPWAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 18:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjFPWAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 18:00:06 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE49E2967
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 15:00:05 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id B9B7740F37;
        Sat, 17 Jun 2023 00:00:03 +0200 (CEST)
Date:   Sat, 17 Jun 2023 00:00:02 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/msm/dpu: Add DPU_INTF_DATABUS_WIDEN feature flag
 for DPU >= 5.0
Message-ID: <uvfqlaez2jxiacacl7ndhuj4oqjtuboqz42sacxlavcxd3vqtf@hl7rajyglvc2>
References: <20230525-add-widebus-support-v1-0-c7069f2efca1@quicinc.com>
 <20230525-add-widebus-support-v1-1-c7069f2efca1@quicinc.com>
 <wpjxrnhbcanbc5iatxnff25yrrdfrtmgb24sgwyo457dz2oyjz@e2docpcb6337>
 <f4fb042c-1458-6077-3c49-8cc02638b27c@linaro.org>
 <ycgei43x4kfmjk7g7gbeglehtiiinfbqmrjbdzcy56frxbtd2z@yk2f5kgrkbrt>
 <i5trozzoexkm7taojob4c53sajm2w6tnasj2yfzjy3a77oqvw7@wadk7g7op2kp>
 <3791f18c-89f1-f066-38c4-d8d13a3ab611@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3791f18c-89f1-f066-38c4-d8d13a3ab611@quicinc.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-16 14:06:47, Abhinav Kumar wrote:
> On 6/14/2023 3:49 PM, Marijn Suijten wrote:
> > On 2023-06-14 14:23:38, Marijn Suijten wrote:
> > <snip>
> >> Tested this on SM8350 which actually has DSI 2.5, and it is also
> >> corrupted with this series so something else on this series might be
> >> broken.
> > 
> > Never mind, this was a bad conflict-resolve.  Jessica's original
> > BURST_MODE patch was RMW'ing MDP_CTRL2, but the upstreamed patch was
> > only writing, and the way I conflict-resolved that caused the write of
> > BURST_MODE to overwrite the RMW DATABUS_WIDEN.
> > 
> > If both are moved to dsi_ctrl_config(), we could do a read, add both
> > flags in conditionally, and write.
> > 
> 
> So just to confirm, there is no issue on your 8350 setup with widebus 
> enabled right?

After properly conflict-resolving both series so that they either both
RMW, or combine the two bit-sets (the same you just discussed _not_
doing on the DPU side for DATABUS_WIDEN|COMPRESSION...) before a single
write, it works fine!

- Marijn
