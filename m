Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938DE7003E3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240272AbjELJgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjELJgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:36:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C0B5FCD;
        Fri, 12 May 2023 02:36:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEA3864F4E;
        Fri, 12 May 2023 09:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49013C433EF;
        Fri, 12 May 2023 09:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683884210;
        bh=sFzboBVIPgpCAMpaLOZuuYbAaS8obMt0kAlpbkh4Lus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HUoacoqO9ZEu6OVD9XqX296JFFGvcazTM0Qygj9vWVTL9FaBMQyw+mA3/u9inJ68K
         LUNfF8oWxpnEg796GF1QXupnsiEEShj1dZWnC1N+VFJ8kEtpx5U2t4mQYDm4QGPSVO
         VcV231jBkWVigcVZP/Y8yHaBpn8Y6/bkPBQ5vN6IISK5v2kIVyZ5rvtAGgfT4jgWux
         4Jz/OR5Tnc1ss3hD5d0CuV4dP1wPwkulzN6l3UCS4A/2DxhLqmytlY23Lb746pkgFQ
         kHkcKH3zTY4RaCgz79U23o0gS1K+WivTaHbP7ixDnGFzS/v5pdB/97GFKVO8vFQEso
         7hYohFzG67iVg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pxPDB-00039Y-Ad; Fri, 12 May 2023 11:37:18 +0200
Date:   Fri, 12 May 2023 11:37:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v2 6/8] phy: qcom-qmp-combo: Introduce drm_bridge
Message-ID: <ZF4Izb0WHvfSPK9H@hovoldconsulting.com>
References: <20230510031930.1996020-1-quic_bjorande@quicinc.com>
 <20230510031930.1996020-7-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510031930.1996020-7-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 08:19:28PM -0700, Bjorn Andersson wrote:
> The QMP combo PHY sits in an of_graph connected between the DisplayPort
> controller and a USB Type-C connector (or possibly a redriver).
> 
> The TCPM needs to be able to convey the HPD signal to the DisplayPort
> controller, but no directly link is provided by DeviceTree so the signal
> needs to "pass through" the QMP combo phy.
> 
> Handle this by introducing a drm_bridge which upon initialization finds
> the next bridge (i.e. the usb-c-connector) and chain this together. This
> way HPD changes in the connector will propagate to the DisplayPort
> driver.
> 
> The connector bridge is resolved lazily, as the TCPM is expected to be
> able to resolve the typec mux and switch at probe time, so the QMP combo
> phy will probe before the TCPM.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Tested-by: Abel Vesa <abel.vesa@linaro.org>
> Tested-by: Steev Klimaszewski <steev@kali.org>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on HDK8450
> Tested-by: Johan Hovold <johan+linaro@kernel.org>	# X13s
> ---
> 
> Changes since v1:
> - Wrap DRM-related code in CONFIG_DRM guard
> - Inroduce DRM-dependencies in Kconfig
> - Dropped dev_err_probe() usage

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
