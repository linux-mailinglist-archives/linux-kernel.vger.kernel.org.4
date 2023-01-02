Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C4765AFA6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjABKim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjABKij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:38:39 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0A9EBF
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 02:38:38 -0800 (PST)
Received: from SoMainline.org (D57D4C6E.static.ziggozakelijk.nl [213.125.76.110])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 3B1ED3EE8C;
        Mon,  2 Jan 2023 11:38:36 +0100 (CET)
Date:   Mon, 2 Jan 2023 11:38:34 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     phone-devel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 5/7] drm/msm/dpu: Document and enable TEAR interrupts
 on DSI interfaces
Message-ID: <20230102103834.v37rv7i72sysruko@SoMainline.org>
References: <20221231215006.211860-1-marijn.suijten@somainline.org>
 <20221231215006.211860-6-marijn.suijten@somainline.org>
 <ccd35acf-15b5-91c7-606a-b327229cb255@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccd35acf-15b5-91c7-606a-b327229cb255@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-01 15:12:35, Dmitry Baryshkov wrote:
> On 31/12/2022 23:50, Marijn Suijten wrote:
> > <snip>
> > -#define INTF_BLK(_name, _id, _base, _type, _ctrl_id, _progfetch, _features, _reg, _underrun_bit, _vsync_bit) \
> > +#define INTF_BLK(_name, _id, _base, _len, _type, _ctrl_id, _progfetch, _features, _reg, _underrun_bit, _vsync_bit, _tear_reg, _tear_rd_ptr_bit) \
> >   	{\
> >   	.name = _name, .id = _id, \
> > -	.base = _base, .len = 0x280, \
> > +	.base = _base, .len = _len, \
> 
> Please move .len setting to a separate patch, it is not direclty related 
> to tear interrupt addition.

It is directly related in that the TE registers reside in the extra
space beyond 0x280, but I can surely make that explicit in a separate
patch.

> >   	.features = _features, \
> >   	.type = _type, \
> >   	.controller_id = _ctrl_id, \
> >   	.prog_fetch_lines_worst_case = _progfetch, \
> >   	.intr_underrun = DPU_IRQ_IDX(_reg, _underrun_bit), \
> >   	.intr_vsync = DPU_IRQ_IDX(_reg, _vsync_bit), \
> > +	.intr_tear_rd_ptr = DPU_IRQ_IDX(_tear_reg, _tear_rd_ptr_bit), \
> 
> Initially I added separate _reg and _bit settings because reg was common 
> to both interrupts. However now as tear interrups use different reg it 
> might be better to first move DPU_IRQ_IDX out of this macro () and then 
> to add your tear_rd_ptr_intr as a single intr_idx.

I assumed as much; then we do get the duplication of _reg but I guess
it's not too bad if the lines are nicely wrapped like in _pp[].  I'll do
so in a separate patch.

- Marijn

<snip>
