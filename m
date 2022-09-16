Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CAF5BA9DF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 12:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiIPKCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 06:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiIPKCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:02:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8BE501B0;
        Fri, 16 Sep 2022 03:02:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF2ABB824F9;
        Fri, 16 Sep 2022 10:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A61AC433D6;
        Fri, 16 Sep 2022 10:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663322547;
        bh=dRPEjw9QsUBzaKuoW8W8ZQwQfff1/Q8c7DTD0nfC71A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CtzMwcHuF0Zc4G9d61SsS08dA96Ql8Dvo0Sl2jMyGnOMoFkAlecmOGL3YHj1U9ixR
         Ce5eqTV3AmHGnRHf5bu2FcF8iit9iybMnOppgZ81JX0c6wRja3EFgxL+IZa2aUelrB
         ZbgrisVxs8WFBt4Mqr4JGi3q6ID0TFKDMrOCA357c5ySroUMvSSsIrxxN2B3Wgv0jI
         y31Y9hO4LBA6cun+tuEVtwOG5+bPnEHlMhvc/6c7ECsbeeGBsXBecfVYhivoRzKP8R
         c6C1UrrswrWQ/hR6tQ42ex0DdHnswED8Rh0r9n3SzjnDL44ECqwpV7nPjD5iwd7cct
         3pV+7/kLmacoQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oZ8B6-0006Ty-Cf; Fri, 16 Sep 2022 12:02:32 +0200
Date:   Fri, 16 Sep 2022 12:02:32 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] phy: qcom-qmp: more fixes and cleanups
Message-ID: <YyRJuCnuUE+bF7RP@hovoldconsulting.com>
References: <20220914162545.6289-1-johan+linaro@kernel.org>
 <YyM3o6aSwt0zM0t4@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyM3o6aSwt0zM0t4@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 04:33:08PM +0200, Johan Hovold wrote:
> On Wed, Sep 14, 2022 at 06:25:34PM +0200, Johan Hovold wrote:
> > Here's the next set of QMP PHY cleanups including some non-critical
> > fixes of tiny memory leaks on probe deferral (I didn't add a stable tag
> > for any of them on purpose).
> 
> > Johan Hovold (11):
> >   phy: qcom-qmp-pcie: add pcs_misc sanity check
> >   phy: qcom-qmp-pcie: fix memleak on probe deferral
> >   phy: qcom-qmp-pcie-msm8996: fix memleak on probe deferral
> >   phy: qcom-qmp-combo: fix memleak on probe deferral
> >   phy: qcom-qmp-ufs: fix memleak on probe deferral
> >   phy: qcom-qmp-usb: fix memleak on probe deferral
> >   phy: qcom-qmp-pcie-msm8996: drop unused pcs_misc handling
> >   phy: qcom-qmp-pcie: drop unused legacy DT workaround
> >   phy: qcom-qmp-combo: drop unused legacy DT workaround
> >   phy: qcom-qmp-ufs: drop legacy DT workaround
> >   phy: qcom-qmp-usb: drop legacy DT workaround
> 
> Please hold off with applying this series. I realised that we have a
> couple devicetrees in mainline with overlapping register regions for
> which the drivers would fail to bind if we start checking checking for
> that.
> 
> I'll see to fixing those up and look into how to handle backward
> compatibility first.

So we had four devicetrees (one is new in 6.0) with incorrect serdes
region sizes that included the adjacent regions. I've sent fixes for
those now, and I don't think we need to add workarounds for booting
older malformed dtbs in this case, at least not until someone complains.

We do however have two USB PHY bindings that currently rely on
overlapping regions which would require some more work to be fixed up.

Specifically, the USB PHY driver uses two separate PCS regions but the
binding treats them as one and the driver ends up mapping everything in
between. This sort of works on all platforms but two where the TX and RX
regions lie in between.

The binding and driver should probably be fixed up to define this
PCS_USB region explicitly, but that work is left for another day.

Meanwhile, I've implemented a workaround that fall back to using
non-exclusive mappings for these platforms. I'll send a v2 with this.

Finally, note that new sc8280xp USB4/USB3/DP binding is also broken,
but that's really a separate issue and we're working on fixing that up.

Johan
