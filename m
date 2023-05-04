Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA966F67A1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjEDIiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjEDIit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:38:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7B01722;
        Thu,  4 May 2023 01:38:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E2E76326B;
        Thu,  4 May 2023 08:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC04EC433D2;
        Thu,  4 May 2023 08:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683189527;
        bh=lyHDvvruE+QpJiz2b8/hfSd8MdRly286qX04fvZa2mM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ueEtORMx7XS5bd+UDk3Hr/ohERrwMQUCuGtyanSCF/qNjohVAwU4el94X3HosnmfN
         ETP75+9gTknkcKlqcBro8PMcmkQI7ZzOBReJPYQADnyMQRLe/dBXro9plhtEFfRidH
         NyA0Y+AjLTD5OKqjaR+a9yqC0sa3/+ByJf/grmabaGxmiMBkrzfUD8UcI3yEeK3Xdz
         wS/ljmpfls87SrEw+JM6buDTQYapRU9QVBx1bafQxfv7JXiRrp8uxVPWti2GrNhRU6
         4QJTIzdfnCejK4fqWTeTJdDAjl6yleCjTYdtyuzp5dONrJS2aN8hveC3VVMITijJ0g
         tNWkAGSCuPTZw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1puUUJ-0005SO-05; Thu, 04 May 2023 10:38:55 +0200
Date:   Thu, 4 May 2023 10:38:54 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] phy: qcom-qmp-combo: Introduce drm_bridge
Message-ID: <ZFNvHgaYsHUc2Y9L@hovoldconsulting.com>
References: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
 <20230425034010.3789376-6-quic_bjorande@quicinc.com>
 <ZFD8oQETtLuDH2Xg@hovoldconsulting.com>
 <20230504031354.GE870858@hu-bjorande-lv.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504031354.GE870858@hu-bjorande-lv.qualcomm.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 08:13:54PM -0700, Bjorn Andersson wrote:
> On Tue, May 02, 2023 at 02:05:53PM +0200, Johan Hovold wrote:
> > On Mon, Apr 24, 2023 at 08:40:08PM -0700, Bjorn Andersson wrote:
> > > The QMP combo PHY sits in an of_graph connected between the DisplayPort
> > > controller and a USB Type-C connector (or possibly a redriver).
> > > 
> > > The TCPM needs to be able to convey the HPD signal to the DisplayPort
> > > controller, but no directly link is provided by DeviceTree so the signal
> > > needs to "pass through" the QMP combo phy.
> > > 
> > > Handle this by introducing a drm_bridge which upon initialization finds
> > > the next bridge (i.e. the usb-c-connector) and chain this together. This
> > > way HPD changes in the connector will propagate to the DisplayPort
> > > driver.
> > > 
> > > The connector bridge is resolved lazily, as the TCPM is expected to be
> > > able to resolve the typec mux and switch at probe time, so the QMP combo
> > > phy will probe before the TCPM.
> > > 
> > > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > > ---
> > >  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 36 +++++++++++++++++++++++
> > >  1 file changed, 36 insertions(+)
> > > 
> > > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > > index 5d6d6ef3944b..84bc08002537 100644
> > > --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c

> > > @@ -3196,6 +3200,34 @@ static int qmp_combo_register_clocks(struct qmp_combo *qmp, struct device_node *
> > >  	return devm_add_action_or_reset(qmp->dev, phy_clk_release_provider, dp_np);
> > >  }
> > >  
> > > +static int qmp_combo_bridge_attach(struct drm_bridge *bridge,
> > > +				   enum drm_bridge_attach_flags flags)
> > > +{
> > > +	struct qmp_combo *qmp = container_of(bridge, struct qmp_combo, bridge);
> > > +	struct drm_bridge *next_bridge;
> > > +
> > > +	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
> > > +		return -EINVAL;
> > > +
> > > +	next_bridge = devm_drm_of_get_bridge(qmp->dev, qmp->dev->of_node, 0, 0);
> > > +	if (IS_ERR(next_bridge))
> > > +		return dev_err_probe(qmp->dev, PTR_ERR(next_bridge), "failed to acquire drm_bridge\n");
> > 
> > Using dev_err_probe() in an attach callback looks wrong as these
> > functions should not be returning -EPROBE_DEFER (and this is not a probe
> > function).
> 
> The problem is that this might return EPROBE_DEFER, and at least today
> propagates out to returning EPROBE_DEFER from our DP controller's
> bind().

Due to the known issue with the MSM driver panel lookup, or due to some
more fundamental problem with the stack?

At least in the former case, I don't think we should hide the fact that
we have an unresolved issue with the MSM driver this way even if it
means printing an extra error message until it has been resolved (cf.
the panel lookup errors that we've intentionally kept in place).

> This is not optimal, but unfortunately we have a two way dependency
> across the of_graph, so we need to make one of the sides lazy...

But this comments seems to suggest this is a bigger issue than the panel
lookup.

Could you describe the issue in some more detail (e.g. when would you
see -EPROBE_DEFER here)?

Johan
