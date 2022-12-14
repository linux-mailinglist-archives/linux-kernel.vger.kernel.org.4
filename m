Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B9664CC89
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238325AbiLNOmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiLNOms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:42:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05F318374;
        Wed, 14 Dec 2022 06:42:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ACED61AE3;
        Wed, 14 Dec 2022 14:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D7AC433EF;
        Wed, 14 Dec 2022 14:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671028967;
        bh=tb2AsELIIZzyGSpjpE700QAuHM3wBVWwcbsHaNbdiQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AsdAE/eiZF+bh9VidavDiRp/P5bLlWFFF5fbv0+4RXMLBD0v2eHcUtPAXujZ6TFEC
         KxrmPCe0HHgMUog8LYj7hXV1fYpAKJXTjDXMqYXiaUuO3Nm5uKZsTH2wENMm31aZkR
         zrsBP1ZAVSGc5+LfjX/6NkVyX9CAhEuDp5iXvBol+tXGNd0JjLA2o118gvMy2toHS+
         nYSBEVW5VlnWpSM8/fhAw0DSRb16ayX4FWeVMNa6CmQ+P2mWvCPDa8cRIwQSraO5Jr
         qnzc/XjJABe1FGjhvJZcQ3dyiObBJDZduu0arQyL9LFI4NvAik78h7mT1gGlw3elvz
         wriBGkgHvhHIA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p5SyY-0001lF-C2; Wed, 14 Dec 2022 15:43:15 +0100
Date:   Wed, 14 Dec 2022 15:43:14 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 0/4] thermal: fix locking regressions in linux-next
Message-ID: <Y5nhAr+kb02kwQHg@hovoldconsulting.com>
References: <20221214131617.2447-1-johan+linaro@kernel.org>
 <CAJZ5v0gY-Lhgf_1Kfg6P5O8s+YMkP4TxggxyS=LU9jVgJikAkg@mail.gmail.com>
 <cc48a248-5dc1-eba8-d91b-ee24300bab52@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc48a248-5dc1-eba8-d91b-ee24300bab52@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 03:37:43PM +0100, Daniel Lezcano wrote:
> On 14/12/2022 15:02, Rafael J. Wysocki wrote:
> > On Wed, Dec 14, 2022 at 2:18 PM Johan Hovold <johan+linaro@kernel.org> wrote:
> >>
> >> This series fixes some of the fallout after the thermal changes that
> >> just landed in linux-next.
> >>
> >> Lockdep reported a lock inversion in one of the Qualcomm drivers and a
> >> closer review revealed that the changes had also broken the sysfs
> >> interface for at least three drivers.

> > It is still present in my bleeding-edge branch, though, so please
> > apply the patches from Johan on top of it and send a new PR to me, so
> > I can add it back to my linux-next branch once 6.2-rc1 appears.
> > 
> > It would be good to check the code again too for any more similar fallout.
> 
> I've been through already, the exynos fix is not necessary.

Right, I failed to notice that tmu_set_trip_temp() was not actually a
thermal_zone_device_ops callback. So that one can be dropped.

Johan
