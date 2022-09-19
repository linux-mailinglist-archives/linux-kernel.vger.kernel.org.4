Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413A95BD64E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 23:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiISVW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 17:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiISVWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 17:22:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC914D174;
        Mon, 19 Sep 2022 14:22:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04869B820F3;
        Mon, 19 Sep 2022 21:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4394C433D6;
        Mon, 19 Sep 2022 21:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663622541;
        bh=IvWPxgYC8Y7/jKbvrMgvoSlVhNU4G8aj4azB6VTN5qk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LDukC2laWLeAS1hTstk3+uI80cx9+0pZ+wPFhhsMNlRE1bu16hMatnmZ1crpFbqt1
         k3tuAb9cL3igaJ1hDw7pjHvCDdVDLLmsBbe8qF07lur0B2xwaCdMINQtpmSO8vGW4c
         Wm8sgUtgNwKfKIY2ok3U8REzvC4BSqFPOn0IFdSj7Nw4tvVH2ISkeHNNXtB698XHbA
         uzxcqMJLg0T1xmOP/eHgGvkLgQDLvJAfLjdQ/w6afxgTGGwuF5TtgJcCpyRafNtP2a
         qbELnhcSynvFccTFurRKvvc8gGi6OMcf1cAYn2a79rBiiIey0Kb9Xl0WsTfpXmYe+Z
         /sx7/IpnsHzsw==
Date:   Mon, 19 Sep 2022 16:22:18 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] drm/msm/dp: Implement hpd_notify()
Message-ID: <20220919212218.chyeo7uga2sitwk7@builder.lan>
References: <20220916200028.25009-1-quic_bjorande@quicinc.com>
 <20220916200028.25009-6-quic_bjorande@quicinc.com>
 <07b39c97-30be-4e82-044e-51b0d98a5197@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07b39c97-30be-4e82-044e-51b0d98a5197@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 02:17:30PM -0700, Jeff Johnson wrote:
> On 9/16/2022 1:00 PM, Bjorn Andersson wrote:
> > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > 
> > The DisplayPort controller's hot-plug mechanism is based on pinmuxing a
> > physical signal no a GPIO pin into the controller. This is not always
> 
> nit: s/ no / on /?
> 

Correct, thank you Jeff.

> > possible, either because there aren't dedicated GPIOs available or
> > because the hot-plug signal is a virtual notification, in cases such as
> > USB Type-C.
> 
