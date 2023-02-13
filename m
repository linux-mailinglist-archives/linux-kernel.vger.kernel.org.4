Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DCF6949EE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjBMPDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjBMPDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:03:10 -0500
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93C98A76
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:02:51 -0800 (PST)
Received: from SoMainline.org (D57D4C6E.static.ziggozakelijk.nl [213.125.76.110])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id D91E01F55E;
        Mon, 13 Feb 2023 16:02:27 +0100 (CET)
Date:   Mon, 13 Feb 2023 16:02:26 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Robert Foss <rfoss@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] drm/msm/dpu: Allow variable SSPP/INTF_BLK size
Message-ID: <20230213150226.du27ocydnyrkvuin@SoMainline.org>
References: <20230211122656.1479141-1-konrad.dybcio@linaro.org>
 <20230211122656.1479141-6-konrad.dybcio@linaro.org>
 <20230213111220.ietr4aro6xu4emtu@SoMainline.org>
 <e6653ceb-bce1-9552-019d-278f455ba8a5@linaro.org>
 <20230213143148.qvyagudd3qm5jgwd@SoMainline.org>
 <e3c1a048-a9e1-53fa-5a19-cba62e8b1580@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3c1a048-a9e1-53fa-5a19-cba62e8b1580@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-13 16:40:56, Dmitry Baryshkov wrote:
> On 13/02/2023 16:31, Marijn Suijten wrote:
> > On 2023-02-13 13:38:33, Dmitry Baryshkov wrote:
> >> On 13/02/2023 13:12, Marijn Suijten wrote:
> >>> On 2023-02-11 13:26:51, Konrad Dybcio wrote:
> >>>> These blocks are of variable length on different SoCs. Set the
> >>>> correct values where I was able to retrieve it from downstream
> >>>> DTs and leave the old defaults (0x1c8 for sspp and 0x280 for
> >>>> intf) otherwise.
> >>>>
> >>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>>> ---
> >>>>    .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 242 +++++++++---------
> >>>>    1 file changed, 121 insertions(+), 121 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> >>>> index 802050118345..d9ef1e133c1e 100644
> >>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> >>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> >>> [..]
> >>>> @@ -1848,10 +1848,10 @@ static struct dpu_dsc_cfg sm8150_dsc[] = {
> >>>>    /*************************************************************
> >>>>     * INTF sub blocks config
> >>>>     *************************************************************/
> >>>> -#define INTF_BLK(_name, _id, _base, _type, _ctrl_id, _progfetch, _features, _reg, _underrun_bit, _vsync_bit) \
> >>>> +#define INTF_BLK(_name, _id, _base, _len, _type, _ctrl_id, _progfetch, _features, _reg, _underrun_bit, _vsync_bit) \
> >>>
> >>> Dmitry and I discussed in #freedreno to instead add the INTF_BLK_DSI_TE
> >>> macro that accounts for the INTF TE registers using this higher register
> >>> area, as well as an extended signature to configure extra interrupts.
> >>
> >> Yes, that's still the plan. It's slightly painful that we are touching
> >> this are simultaneously.
> > 
> > Should we (Konrad) then drop this patch as there's no need to add these
> > (mostly RAZ/WI) registers to the dump until my INTF TE series starts
> > using them?  That'll make rebasing easier on everyone too.
> 
> RAZ/WI is for not present registers (read-as-zero/write-ignore). I think 
> that the growing register space is getting populated with registers 
> (which we have been ignoring up to now).

They are, but not until my INTF TE series lands; hence again the request
to drop this patch until that happens?

- Marijn
