Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3EF6DFDF5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjDLSvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjDLSvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:51:07 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C60459D3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:50:55 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id BFAD320251;
        Wed, 12 Apr 2023 20:50:53 +0200 (CEST)
Date:   Wed, 12 Apr 2023 20:50:51 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        freedreno@lists.freedesktop.org, quic_sbillaka@quicinc.com,
        airlied@gmail.com, andersson@kernel.org, robdclark@gmail.com,
        dri-devel@lists.freedesktop.org, dianders@chromium.org,
        vkoul@kernel.org, agross@kernel.org, daniel@ffwll.ch,
        linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
        sean@poorly.run, linux-kernel@vger.kernel.org
Subject: Re: [Freedreno] [PATCH] drm/msm/dpu: add DSC range checking during
 resource reservation
Message-ID: <szwu75yxcfxeyvfvrsyuoc3jeoaylydwtlzm3cevmpr3zpmfpo@wrdgbf3w3de2>
References: <1681247380-1607-1-git-send-email-quic_khsieh@quicinc.com>
 <qvgbm3wimai3jytnikbcixipvwqn2uywqpg4mn6mjh5atergfx@wa4edsrp7y22>
 <96416911-bca3-b007-b036-1c4463e83aaa@quicinc.com>
 <24c5aa23-9b3c-787c-10aa-e9d5ad91512b@linaro.org>
 <49479b93-b364-d882-7a77-08223a94ed36@quicinc.com>
 <tczt5alqbadkodgorqm4pljpqkn5bc4efpxiy3em7bgu7gqaka@3cdszu4k6rhk>
 <8310d7ce-7ac0-05a6-b95a-c18a498f7644@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8310d7ce-7ac0-05a6-b95a-c18a498f7644@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-12 10:48:18, Abhinav Kumar wrote:
[..]
> > The only way to trigger this newly introduced range check is by omitting
> > the DSC_x constants and manually writing e.g. an out-of-range value 10
> > here, or setting DSC_NONE.  This is only allowed for interfaces.
> > 
> 
> Correct, its just working on an implicit understanding that the indices 
> in the catalog

.. this sentence appears to be incomplete: what did you want to say? ..

> which might still be right stick to the RM limits.
> 
> Thats why this is not bad to have.

What do you mean by "RM limits"?  We have constants in the kernel that
both define the maximum number of blocks in these arrays and a
predefined set of ids that block can have.  These are all used in
constant structs in the catalog, so there's nothing "software" or
SoC-specific limiting about this (except what is available in the
arrays).

[..]
> I think kuogee just added this to keep it consistent with other checks 
> present in the RM. So I didnt see any harm with that.

Yep, that's the only reason

> If he did see an issue, i will let him report that here.

If so an out-of-bounds constant was hardcoded in dpu_hw_catalog.c.

> Otherwise, I dont want to spend more time discussing this bounds check 
> when other blocks already have it.

I'll whip up a patch to clear out the extraneous lookup (assuming there
is no other reason/dependency for it to be there...) and can follow that
up with removing these range checks of known-good values in `const
struct` fields.

- Marijn
