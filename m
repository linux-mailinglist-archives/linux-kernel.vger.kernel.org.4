Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803FA5F0A92
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiI3LdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiI3Lcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:32:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E772D1DA53;
        Fri, 30 Sep 2022 04:25:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5DADB82815;
        Fri, 30 Sep 2022 11:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EFCC433D6;
        Fri, 30 Sep 2022 11:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664537129;
        bh=EtTfFT95kJOlidZdVTvfFENPF4UX2MmvkhuMlNo/5/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fxkXsVbJTnaqNg90wrGGaKbu5cDEYBRIK3HdYvLdz8bNGTDmaC+f0PitO10wCHvEQ
         VCrHYTpLIt/NtBwjyh9Ub8KVU4GCdx8w0RNFyzy3UQUulF8alvQ09EowF2EwF2TX68
         Jpql8OVFsie8fCWVhzLnIslIJ+t94sucOJ74pxwUnPafyQXNrDS/8qIkLA6jAOKYiD
         Fg7CoKcr9IRgbsS9lZayoksFlTI/eTMzjrulnpxN23xm+HFabMH9CDWN1AzaXoqwuH
         EdTfBibGznid03MlMKY4hl35DM0ykGgni+x5PtKiFfjMvHcPlAfALnUXtsJjnD2Nwu
         7p9tEdLcvT4qQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oeE9A-000157-M8; Fri, 30 Sep 2022 13:25:36 +0200
Date:   Fri, 30 Sep 2022 13:25:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/11] phy: qcom-qmp-pcie: drop bogus register update
Message-ID: <YzbSMAOqaP5vFF6o@hovoldconsulting.com>
References: <20220929092916.23068-1-johan+linaro@kernel.org>
 <20220929092916.23068-12-johan+linaro@kernel.org>
 <d82b0c09-194d-9357-a887-f0c8f81fb6ab@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d82b0c09-194d-9357-a887-f0c8f81fb6ab@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 01:57:46PM +0300, Dmitry Baryshkov wrote:
> On 29/09/2022 12:29, Johan Hovold wrote:
> > Since commit 0d58280cf1e6 ("phy: Update PHY power control sequence") the
> > PHY is powered on before configuring the registers and only the MSM8996
> > PCIe PHY, which includes the POWER_DOWN_CONTROL register in its PCS
> > initialisation table, may possibly require a second update afterwards.
> > 
> > To make things worse, the POWER_DOWN_CONTROL register lies at a
> > different offset on more recent SoCs so that the second update, which
> > still used a hard-coded offset, would write to an unrelated register
> > (e.g. a revision-id register on SC8280XP).
> > 
> > As the MSM8996 PCIe PHY is now handled by a separate driver, simply drop
> > the bogus register update.
> > 
> > Fixes: e4d8b05ad5f9 ("phy: qcom-qmp: Use proper PWRDOWN offset for sm8150 USB") added support
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> #RB3

Thanks for confirming.

Johan
