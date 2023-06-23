Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BA373B116
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjFWHKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjFWHKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:10:06 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C622133
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 00:10:03 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 68D083F64E;
        Fri, 23 Jun 2023 09:10:01 +0200 (CEST)
Date:   Fri, 23 Jun 2023 09:10:00 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Ryan McCann <quic_rmccann@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        quic_jesszhan@quicinc.com
Subject: Re: [PATCH 0/6] Add support to print sub block registers in dpu hw
 catalog
Message-ID: <nywovdd4op22ylnrntqx2f6x2plmfrxsgsirq6vmqu2eemulzq@z5sc2kmypl74>
References: <20230622-devcoredump_patch-v1-0-3b2cdcc6a576@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622-devcoredump_patch-v1-0-3b2cdcc6a576@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is nice if cover letters also include the subsystem:

drm/msm: Add support to print DPU sub-block registers

On 2023-06-22 16:48:52, Ryan McCann wrote:
> The purpose of this patch series is to add support to print the registers
> of sub blocks in the dpu hardware catalog and fix the order in which all

Global nit: I think we previously settled on "sblk" or "sub-block(s)",
not "sub blocks".

And capitalize DPU.

> hardware blocks are dumped for a device core dump. This involves:
> 
> 1. Changing data structure from stack to queue to fix the printing order
> of the device core dump.
> 
> 2. Removing redundant suffix of sub block names.
> 
> 3. Removing redundant prefix of sub block names.
> 
> 4. Eliminating unused variable from relevant macros.

Dmitry has been doing that in one of his DPU catalog reworks.

> 5. Defining names for sub blocks that have not yet been defined.

Let's see what this means, because the code logic should already be able
to figure this out (and in some places we can perhaps delete the name
entirely).

> 6. Implementing wrapper function that prints the registers of sub blocks
> when there is a need.

Thought this could be rather automated, but let me see what it means in
the patches.

> Sample Output of the sspp_0 block and its sub blocks for devcore dump:
> ======sspp_0======
> ...registers
> ...
> ====sspp_0_scaler====

My suggestion would be to put less emphasis on this header with:

    ----sspp_0_scaler----

So that it becomes obvious that this is a sblk of the ====sspp_0====
above.

> ...
> ...
> ====sspp_0_csc====
> ...
> ...
> ====next_block====
> ...
> 
> Signed-off-by: Ryan McCann <quic_rmccann@quicinc.com>

No need for sign-off in cover letters.

- Marijn

> ---
> Ryan McCann (6):
>       drm/msm: Update dev core dump to not print backwards
>       drm/msm/dpu: Drop unused num argument from relevant macros
>       drm/msm/dpu: Define names for unnamed sblks
>       drm/msm/dpu: Remove redundant suffix in name of sub blocks
>       drm/msm/disp: Remove redundant prefix in name of sub blocks
>       drm/msm/dpu: Update dev core dump to dump registers of sub blocks
> 
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    |  90 +++++-----
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c           | 194 +++++++++++++++++++---
>  drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c |   2 +-
>  3 files changed, 214 insertions(+), 72 deletions(-)
> ---
> base-commit: 710025fdedb3767655823c3a12d27d404d209f75
> change-id: 20230622-devcoredump_patch-df7e8f6fd632
> 
> Best regards,
> -- 
> Ryan McCann <quic_rmccann@quicinc.com>
> 
