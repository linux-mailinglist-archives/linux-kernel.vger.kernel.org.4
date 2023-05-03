Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2CA6F59F8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 16:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjECO1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 10:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjECO1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 10:27:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDB55BB8;
        Wed,  3 May 2023 07:27:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B60CA62DF1;
        Wed,  3 May 2023 14:27:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17874C433D2;
        Wed,  3 May 2023 14:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683124051;
        bh=W2XOHQb6yKkoN3xJSZAY+6+X+L/JcA2LzNHxTQz5qc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ITIgoY6nvKH+KUTYPsEf3pUMUdSpykTJkvu7bUfGyz7B2VLTm49tAqcKuarr/19Yz
         80gzR4nDoDZ24YmfvmtE9sS6LkDbEjHEaYV7NWuS99i+QT5/T0dAiodefrZqMstP1h
         45VhCvQFPNfXeN1wpRdZJBWsMtitxE61gk8/GTComn2b/fdiD7mRxxnOMBtPrtiQDA
         w3Shyh4C1dv0rEdtJlHioEJ+VPuHpCa6BdZMy1FePNycjnk46QsMkJr2HIM8X12Ce+
         agbWH4ZG2xvPMLBGTLLWBd5MerheffmuLpodwSBmifl7ICY79E/Ys1YJa+eYTlLOTk
         io5RIaUQvWoww==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1puDSC-00072Y-J8; Wed, 03 May 2023 16:27:36 +0200
Date:   Wed, 3 May 2023 16:27:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH v7 5/9] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Message-ID: <ZFJvWAgZ1LGloS5N@hovoldconsulting.com>
References: <20230501143445.3851-1-quic_kriskura@quicinc.com>
 <20230501143445.3851-6-quic_kriskura@quicinc.com>
 <ZFJBN2i5tXkY8ARA@hovoldconsulting.com>
 <910de571-caaf-97df-2065-e16efa454bad@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <910de571-caaf-97df-2065-e16efa454bad@quicinc.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 07:50:57PM +0530, Krishna Kurapati PSSNV wrote:
> On 5/3/2023 4:40 PM, Johan Hovold wrote:
> > On Mon, May 01, 2023 at 08:04:41PM +0530, Krishna Kurapati wrote:
> >> Currently the DWC3 driver supports only single port controller
> >> which requires at most one HS and one SS PHY.
> >>
> >> But the DWC3 USB controller can be connected to multiple ports and
> >> each port can have their own PHYs. Each port of the multiport
> >> controller can either be HS+SS capable or HS only capable
> >> Proper quantification of them is required to modify GUSB2PHYCFG
> >> and GUSB3PIPECTL registers appropriately.
> >>
> >> Add support for detecting, obtaining and configuring phy's supported
> >> by a multiport controller and limit the max number of ports
> >> supported to 4.
> >>
> >> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
> >> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> >> ---
> >>   drivers/usb/dwc3/core.c | 262 +++++++++++++++++++++++++++++-----------
> >>   drivers/usb/dwc3/core.h |  12 +-
> >>   drivers/usb/dwc3/drd.c  |  13 +-
> >>   3 files changed, 209 insertions(+), 78 deletions(-)
> > 
> > Note that this patch no longer applies and you need to rebase the series
> > on mainline (e.g. including commit 1d72fab47656 ("USB: dwc3: refactor
> > phy handling").

>    This series is rebased on top of usb-next (on top of the above 
> mentioned patch). Probably that is why its not applying on top of 
> linux-next.

Indeed it is. Sorry about the noise. Let me go double check why it did
not apply here. Perhaps I'm missing something else from usb-next.

Johan
