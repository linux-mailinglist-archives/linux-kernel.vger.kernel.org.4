Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41366EEA53
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 00:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbjDYWfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 18:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbjDYWfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 18:35:52 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A93314468
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 15:35:51 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 2EC3A3F094;
        Wed, 26 Apr 2023 00:35:49 +0200 (CEST)
Date:   Wed, 26 Apr 2023 00:35:47 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno@lists.freedesktop.org,
        Jami Kettunen <jami.kettunen@somainline.org>,
        David Airlie <airlied@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Sean Paul <sean@poorly.run>
Subject: Re: [Freedreno] [PATCH v2 3/3] drm/msm/dpu: Pass catalog pointers
 directly from RM instead of IDs
Message-ID: <ecopixnagol7yd5znvmjanknqbv7vi4ayy36vchaeyyhuavu4w@rkdfllrd4uzb>
References: <ymq4kstme55dm3j5kr6trevnwdelhjq7e7m4yky6zcbnf7auid@66l7inxz4oq2>
 <CAA8EJprYQUFER6x1+ucHX_Ze2uqWc6xoEaYDdJ1s0jgZjPJ0QQ@mail.gmail.com>
 <c809476f-74bc-0399-08f9-1bf26e7170fa@quicinc.com>
 <r2tndjr5jbjtrwwti6l3ag7562e53nqx2uk6vz6fx43yc7sncl@eypc37r2ey3j>
 <31f116f6-a6b7-1241-83bc-96c31e718f3f@linaro.org>
 <m5z5mv5hbdgpjbfo3mqo5s3egshnlu77nla4b7txddlsbk5fvi@jitwvapbr7wr>
 <CAA8EJpoCeCkucvb=a+1ken_yR=8FvcECrvajOk5MxgO-j2nD6A@mail.gmail.com>
 <2c3ef118-d7b1-83bd-f789-3e5c5212a6e5@quicinc.com>
 <CAA8EJpq8i4YxRc4yM-BGyV0uM4WyDOoFAgsU8bOoZL963wRMkQ@mail.gmail.com>
 <fc3089b6-5511-7046-9c70-f0535d8f4ba3@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc3089b6-5511-7046-9c70-f0535d8f4ba3@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-25 14:32:51, Abhinav Kumar wrote:
<snip>
> >>>>> We can return NULL from dpu_hw_foo_init(), which would mean that the
> >>>>> block was skipped or is not present.
> >>>>
> >>>> An then replace the `if INTF_NONE continue` logic in dpu_rm_init with a
> >>>> check for NULL that skips, and a check for IS_ERR` that goes to `fail`?
> >>>
> >>> You can just drop the INTF_NONE in dpu_rm. If dpu_hw_intf_init()
> >>> returns NULL, the rest of the code in dpu_rm will work correctly.

Sure, I'll keep the check exclusively in dpu_hw_intf_init().  Should I
also move the pingpong==PINGPONG_MAX check into dpu_hw_lm_init()?

> >> The only thing lost will be that the loop in the RM will break at the
> >> first instance of NULL so if the loop has valid intf blocks later, those
> >> will also not get initialized.
> >
> > No, it won't. There is the IS_ERR check, not the IS_ERR_OR_NULL()

Only DSC currently uses IS_ERR_OR_NULL... We should fix that as
rc=PTR_ERR(hw) on the next should be 0 (actually, the intent is for it
to be undefined I think) for that...

> Ack, but isnt that an issue since rm->hw_intf[intf->id - INTF_0] can be 
> assigned to a NULL hw.

Yes, that is exactly the intent here.

> >> That wont happen today because catalog doesnt have such entries but just
> >> wanted to note what gets lost with this change.

It does, we have a few SoCs with type=INTF_NONE.  Quoting myself from
above:

    As per the first patch of this series SM6115/QCM2290 only have a DSI
    interface which always sits at ID 1, and ID 0 has its TYPE set to
    INTF_NONE and is skipped.

- Marijn
