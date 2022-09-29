Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2055EF02F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbiI2ISb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbiI2ISY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:18:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA2BDF043;
        Thu, 29 Sep 2022 01:18:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 526DEB8239B;
        Thu, 29 Sep 2022 08:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA7DC433D6;
        Thu, 29 Sep 2022 08:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664439501;
        bh=THp3JIOFU8Wk1YX5KobyWkuIqKiPW79C9J3yzbH8LG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ki05WK2TbxZXcDYu5kb7IZCzEjAIEtdUhFQgvDWdExO6gTDlSsRLQO4mBq+3vwtLq
         6yZv9vHMbwvTPcAvgUmzs6i83YKnBSC57fUysqSdAZC4SKiD3jnKSt4T4EIrGxNAC5
         4y5kKg+j5zWOwygAN2/1HtJjZBxFlQxsbDFJlKRGJkaCIKSMOrLXoLobRONIc0oxzs
         Q0AvBxUU+MR1BhtYIA8MndLefbkIRknk0oljHEVm1BMqhIWZ5nyyFUJqm004yPnx/J
         FJQEjdrSxKivlt/AjKsKUYXh/px8Ow0sqSLJ6k5aUu8bpiQlSr13a8JvtCkJL18Xjq
         evvqMALb1Zyrg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1odokU-0006ro-Hc; Thu, 29 Sep 2022 10:18:27 +0200
Date:   Thu, 29 Sep 2022 10:18:26 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] phy: qcom-qmp-pcie: drop bogus register update
Message-ID: <YzVU0gC4gT9FwBL+@hovoldconsulting.com>
References: <20220928152822.30687-1-johan+linaro@kernel.org>
 <20220928152822.30687-7-johan+linaro@kernel.org>
 <2bc50ea4-ec29-cacc-216b-1c21d2d2f0bc@linaro.org>
 <f9d0fb60-3e62-8f55-015e-88ca2e209323@linaro.org>
 <YzVFQikkJmTDlg4U@hovoldconsulting.com>
 <e516bd2e-baf8-7ecd-cc59-9e7c2af64918@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e516bd2e-baf8-7ecd-cc59-9e7c2af64918@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 10:56:11AM +0300, Dmitry Baryshkov wrote:
> On 29/09/2022 10:12, Johan Hovold wrote:
> > On Wed, Sep 28, 2022 at 10:48:40PM +0300, Dmitry Baryshkov wrote:
> >> On 28/09/2022 22:10, Dmitry Baryshkov wrote:

> >> The programmings starts with <0x804 0x1 0x0>, writing 1 to
> >> PCS_POWER_DOWN_CONTROL (which if I'm not mistaken we do not do at this
> >> moment). Then after writing all the serdes/tx/rx/pcs/pcs_misc tables
> >> comes the write <0x804 0x3 0x0> (which you are trying to remove here).
> > 
> > The PHY would already have been powered on with the mainline driver, that
> > write has already happened.
> > 
> > Whether or not PCIe support for SDM845 has been broken since it was
> > first mainlined almost three years ago is a separate issue. I assume
> > Bjorn tested it before sending it upstream.
> > 
> > 	421c9a0e9731 ("phy: qcom: qmp: Add SDM845 PCIe QMP PHY support")
> 
> On SDM845 PCIe0 is used for the WiFi, e.g. on the RB3 (dragonboard845) 
> device. The PHY definitely works with the upstream kernels.

Ok, good.

> >> Same sequence applies to the PCIe PHY on msm8998.
> >>
> >> Most newer PHYs have the expected sequence (of writing 0x3 to
> >> PCS_POWER_DOWN_CONTROL) before writing all registers.
> >>
> >> As a short summary: unless we get any additional information that 8998
> >> and sdm845 tables are incorrect, I'd suggest adding a conditional here
> >> (ugh) and using it here and in qmp_pcie_init() call.
> > 
> > I see little point in doing that unless you dig out an SDM845, confirm
> > that it has never worked with upstream, and update the init sequence
> > first.
> 
> Digging out an sdm845 is not a problem per se. It works, but it also has 
> an additional regwrite that this patch tries to remove. I will try 
> checking whether it works with this register write being removed or not.

Right, but as I already mentioned that register already holds the same
value (0x3) when the second redundant write happens. So this should be a
no-op on sdm845 currently.

(Only MSM8996 had an intermediate update of that register in its PCS
table and therefore needs this second update.)

> >> Vinod, Bjorn, do you have any additional info?
> > 
> > An explanation of the split POWER_DOWN_CONTROL updates on MSM8996 would
> > be good to have either way

Johan
