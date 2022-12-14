Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E05A64D195
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 22:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiLNVFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 16:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLNVFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 16:05:20 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06F02C661
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:05:19 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 983FE3F790;
        Wed, 14 Dec 2022 22:05:17 +0100 (CET)
Date:   Wed, 14 Dec 2022 22:05:16 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Kalyan Thota <kalyant@qti.qualcomm.com>
Cc:     "Kalyan Thota (QUIC)" <quic_kalyant@quicinc.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robdclark@chromium.org" <robdclark@chromium.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "Vinod Polimera (QUIC)" <quic_vpolimer@quicinc.com>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>
Subject: Re: [v10] drm/msm/disp/dpu1: add support for dspp sub block flush in
 sc7280
Message-ID: <20221214210516.u7drmdhc74a7rxvk@SoMainline.org>
References: <1670417963-19426-1-git-send-email-quic_kalyant@quicinc.com>
 <20221207140832.6r2kznoulfek7yye@SoMainline.org>
 <BN0PR02MB81425C5E341E0FF1C374A3A496E29@BN0PR02MB8142.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN0PR02MB81425C5E341E0FF1C374A3A496E29@BN0PR02MB8142.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-12 11:35:15, Kalyan Thota wrote:
> [..]
> >> +             if (ctx->pending_dspp_flush_mask[dspp - DSPP_0])
> >> +                     DPU_REG_WRITE(&ctx->hw, CTL_DSPP_n_FLUSH(dspp - DSPP_0),
> >> +                             ctx->pending_dspp_flush_mask[dspp -
> >> + DSPP_0]);
> >
> >Shouldn't this loop as a whole check if _any_ DSPP flush is requested via
> >`pending_flush_mask & BIT(29)`?  The other flushes don't check the per-block
> >mask value either (and could write zero that way) but only base this check on the
> >presence of a global flush mask for that block.
> >
> BIT(29) enables dspp flush only from DPU rev 7.x.x where hierarchal flush is introduced. For other targets that supports CTL_ACTIVE, it's a NOP.

The only way this patch ever writes pending_dspp_flush_mask is followed
by unconditionally setting BIT(29) in pending_flush_mask.  I was under
the assumption that pending_dspp_flush_mask should be considered invalid
or irrelevant unless BIT(29) is set.

> With the check "pending_flush_mask & BIT(29)", unintended DSPP registers for that CTL path will be programmed to "0" which is not correct IMO.

You can also keep the second `if` to guard against that; as said the
code above does exactly this though, but I think we could assume that
if a pending sub-block flush is set, pending_dspp_flush_mask is nonzero?

> Secondly "pending_flush_mask & BIT(29)" although will not be true for DPU 6.x.x versions but can be confusing w.r.t code readability.
> Let me know your thoughts.

Ack, it is /super/ confusing that BIT(29) is used for DSPP (sub-block)
flush, but also to flash INTF_2??

In fact there are many overlapping flush bits used for different
components.  Only few are clarified via a #define.  Can you confirm
whether this is correct?  And whether these should all be pulled out
into numerically-sorted defines to improve readability and document
intentional overlap?

- Marijn
