Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2B5673280
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjASHd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjASHdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:33:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2032E2715;
        Wed, 18 Jan 2023 23:32:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67D5361B97;
        Thu, 19 Jan 2023 07:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C354FC433D2;
        Thu, 19 Jan 2023 07:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674113573;
        bh=av70+XFyUMKLFckzEazY0cMVIDLx9U2jl72bjsU7uj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HQMveQ8n5d7V3zRDfdXLFHFSm/LOMBKMpP9nJ8KQHRxyC/1t7uuZQtYWkSdp0YHBS
         HY/ZFi8tDu6SNADQlV+7t0yjiYCUnhD4kYUwmki3VjWzRb6AnJ0MdMOL1pbzQOikli
         G+yLempXCW83H/f+91DMvBeHhMs4v+ewVM6UPasFKfwLR8cbwpuYeyO2aVznWAdoY8
         Xc6m9Ko1pR1UYfhnJtml475nHdQEwcmBmXK8sN8TrkPy8a2Fd4qTvMGepPnO8HTtRi
         gyuV7Sb/tuvzEu4GCvsl44BcvpL/ntyG3cUnuBDNwLLxhFHcYEExcx94yTiX2vkLrM
         5DznYq/UDsN8w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pIPQG-0004w5-RH; Thu, 19 Jan 2023 08:33:20 +0100
Date:   Thu, 19 Jan 2023 08:33:20 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, abel.vesa@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 0/2] arm64: dts: qcom: sm8550: Add PCIe HC and PHY
 support
Message-ID: <Y8jyQAR7fF1NRmwu@hovoldconsulting.com>
References: <20230118230526.1499328-1-abel.vesa@linaro.org>
 <167408614065.2989059.2950818972854332656.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167408614065.2989059.2950818972854332656.b4-ty@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 05:55:31PM -0600, Bjorn Andersson wrote:
> On Thu, 19 Jan 2023 01:05:24 +0200, Abel Vesa wrote:
> > This patchset adds PCIe controllers and PHYs support to SM8550 platform
> > and enables them on the MTP board.
> > 
> > The v1 was here:
> > https://lore.kernel.org/all/20221116130430.2812173-1-abel.vesa@linaro.org/
> > 
> > Changes since v1:
> >  * ordered pcie related nodes alphabetically in MTP dts
> >  * dropped the pipe_mux, phy_pipe and ref clocks from the pcie nodes
> >  * dropped the child node from the phy nodes, like Johan suggested,
> >    and updated to use the sc8280xp binding scheme
> >  * changed "pcie_1_nocsr_com_phy_reset" 2nd reset name of pcie1_phy
> >    to "nocsr"
> >  * reordered all pcie nodes properties to look similar to the ones
> >    from sc8280xp
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/2] arm64: dts: qcom: sm8550: Add PCIe PHYs and controllers nodes
>       commit: 7d1158c984d37e79ab8bb55ab152a0b35566cb89
> [2/2] arm64: dts: qcom: sm8550-mtp: Add PCIe PHYs and controllers nodes
>       commit: 1eeef306b5d80494cdb149f058013c3ab43984b4

I believe there were still some changes needed to the controller
and PHY bindings so this should not have been merged.

	https://lore.kernel.org/all/Y8fuUI4xaNkADkWl@hovoldconsulting.com/
	https://lore.kernel.org/lkml/Y8giHJMtPu4wTlmA@hovoldconsulting.com/

Perhaps in the future you can send the dts changes along with the (PHY)
driver changes so that they can be kept in lock-step and avoid this.

Johan
