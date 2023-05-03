Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFD36F61B5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 01:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjECXDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 19:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjECXDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 19:03:41 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121345FD9
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 16:03:38 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 9B16A3FAFD;
        Thu,  4 May 2023 01:03:36 +0200 (CEST)
Date:   Thu, 4 May 2023 01:03:35 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] drm/msm/dpu: Add has_data_compress to dpu_caps
Message-ID: <46an5zrsxplqo3h35okjyhfes6sqwmw5kez3nm3x5vrkqyvsn5@lxca65m7ju6n>
References: <20230405-add-dsc-support-v1-0-6bc6f03ae735@quicinc.com>
 <20230405-add-dsc-support-v1-3-6bc6f03ae735@quicinc.com>
 <v5hmqtjwd3syqwo5nqru7xgpt3rv5ubfbzt6pssriyb7cuprkf@7zdvwsil67nc>
 <7117aadb-0289-01ff-6eb9-8bfc358eca63@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7117aadb-0289-01ff-6eb9-8bfc358eca63@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jessica,

On 2023-05-03 12:03:40, Jessica Zhang wrote:
> 
> 
> On 5/3/2023 12:07 AM, Marijn Suijten wrote:
> > On 2023-05-02 18:19:14, Jessica Zhang wrote:
> >> Add data_compress feature to DPU HW catalog.
> >>
> >> In DPU 7.x and later, there is a DATA_COMPRESS register that must be set
> >> within the DPU INTF block for DSC to work.
> >>
> >> As core_rev (and related macros) was removed from the dpu_kms struct, the
> >> most straightforward way to indicate the presence of this register would be
> >> to have a flag in dpu_caps.
> > 
> > This is a very generic name to have in the global dpu_caps for a very
> > specific register on the INTF block since DPU >= 7.0.0, and I doubt any
> > new catalog contributor will know how to fill this field.  After all,
> > DPU < 7.0.0 also has DCE but it is controlled via the PINGPONG block.
> > 
> > Instead, how about having it as a DPU_INTF_DATA_COMPRESS (or similar)
> > feature flag on the INTF block?  We do the same for other (register
> > related) features on the INTF block, and you did the same to disable DSC
> > callbacks on PP in [1].

(Note: I said "you" but meant Kuogee)

> Hi Marijn,
> 
> Sounds good.
> 
> > 
> > In fact it seems that the DSC/DCE (enablement) registers have been moved
> > from PINGPONG to INTF in DPU 7.0.0.  Can you clarify in the patch
> > message for v2 that this is the case, and do the same in the linked
> > PINGPONG patch?  Perhaps these patches should be part of the same series
> > as they do not seem DSI-specific.
> 
> Will make a note of the PP to INTF change in the commit message.

Thanks.

> I would prefer to keep this patch in this series is because it is needed 
> for DSI over command mode to work and the subsequent patch is 
> specifically for command mode.

That is fine, but do mention this in the commit message if it is
relevant here.  Otherwise only mention it as part of patch 4/4.

- Marijn
