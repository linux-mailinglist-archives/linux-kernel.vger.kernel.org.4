Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DB7722341
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjFEKSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjFEKSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:18:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD6099;
        Mon,  5 Jun 2023 03:18:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED41C6122F;
        Mon,  5 Jun 2023 10:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5688EC433D2;
        Mon,  5 Jun 2023 10:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685960316;
        bh=Hq8WndsreVnOiOjWNynVMw7xnDT/MtLrF7deKaysJyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fQLZ2VOLsMuWSk++nBuN3rvjtATWL1sX0YGhAbM+V5HxQYe1amB08X1j9iqJxe7dr
         Y9pTagR5YP1J3TRQd+RTL3sfcoD64Tvi0yftaUlrEIzIuKHAhdcjWFl1xacDxw28w4
         auoGQnW9QZZzfQyrEiGgRKNRCpbpk/fy2mJ6y1dcQd0JD+UdIa2u2P3LsmTZMNZ5Kd
         QMF0fMMQiLnYF/i/MD1ytI/U0IgVOgU6VSbThlwv9Ag/30ezJZpu8L/qDUkHUj7MH9
         aBXAxCwBvotTh1AUffkttQmmAAmBRa8IHgPeGYQJDTPmDHj3esC37gMv0hoCsVGHfv
         uyp1cE8FRS6KA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q67Ia-0005sI-Uo; Mon, 05 Jun 2023 12:18:53 +0200
Date:   Mon, 5 Jun 2023 12:18:52 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        regressions@lists.linux.dev
Subject: Re: [PATCH] Revert "drm/msm/dp: set self refresh aware based on PSR
 support"
Message-ID: <ZH22jMTq6fi8iBpe@hovoldconsulting.com>
References: <20230523151646.28366-1-johan+linaro@kernel.org>
 <ZH2ys6dVeL02JLCU@hovoldconsulting.com>
 <CAA8EJprBNzw4o4m0sn2OoOqnwioQWNcTPcKoKGqxLWGc_8xjWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJprBNzw4o4m0sn2OoOqnwioQWNcTPcKoKGqxLWGc_8xjWA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 01:05:36PM +0300, Dmitry Baryshkov wrote:
> On Mon, 5 Jun 2023 at 13:02, Johan Hovold <johan@kernel.org> wrote:

> > Virtual terminals are still broken with 6.4-rc5 on the Lenovo ThinkPad
> > X13s two weeks after I reported this, and there has been no indication
> > of any progress in the other related thread:
> >
> >         https://lore.kernel.org/lkml/ZHYPHnWoDbXB-fqe@hovoldconsulting.com
> >
> > Seems like it is time to merge this revert to get this sorted.
> >
> > Rob, Abhinav, Dmitry, can either of you merge this one and get it into
> > 6.4-rc6?
> 
> Rob sent the pull request few hours ago, see
> https://lore.kernel.org/dri-devel/CAF6AEGuHujkFjRa6ys36Uyh0KUr4Hd16u1EMqJo8tOZ3ifVubQ@mail.gmail.com/

Ok, so you guys went with the module parameter hack. Whatever. As long
as the regression is finally fixed.

Next time, some visibility into your process would be appreciated to
avoid unnecessary work.

Johan
