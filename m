Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E656DB19B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjDGR2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDGR2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:28:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678A8A5FA;
        Fri,  7 Apr 2023 10:28:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04B4365230;
        Fri,  7 Apr 2023 17:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA1BC433D2;
        Fri,  7 Apr 2023 17:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680888511;
        bh=idDlc8ZJaRbDwkcyJQzHCf0qlNbEXgjDa3puNQw4N9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mtBo5tg3cXKg1cI2/vhx9WamdcOwjH8ylXUHOfZVQsAdN5yBfGzf1oiHOC5v+ZWAK
         OdyC9vP3M+bOKFJpA/p4IA8YWTmzSewUlKlVulK3AQGjjBs/eME276YiXn47k/uyzP
         ZDhxRPgiqhH8QVUO1MMKbp1rUk7ZIw8CaDgYYCVriHLS4gtWMBuMFvszA1JKiygBJY
         g6QYxVv84iIQr5Wy+S9O4UFRpKPyuWp351KbwQikrVkS+ajyF9nQ28WVIiDKnvSVyp
         iqS7g3X4sJmdfdP7rWwRwJSK+VZuBPOO/JMlP2JMBVeiUahrwpirsJ4DJF4jmakBnp
         B6fqfgaLfbbmw==
Date:   Fri, 7 Apr 2023 17:28:29 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v5 4/6] scsi: ufs: ufs-qcom: Switch to the new ICE API
Message-ID: <ZDBSvVIIq6cMTf1Y@gmail.com>
References: <20230403200530.2103099-1-abel.vesa@linaro.org>
 <20230403200530.2103099-5-abel.vesa@linaro.org>
 <20230406201634.GA20288@sol.localdomain>
 <ZC/ADOlol2XO7ACL@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC/ADOlol2XO7ACL@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 10:02:36AM +0300, Abel Vesa wrote:
> On 23-04-06 13:16:34, Eric Biggers wrote:
> > Hi Abel,
> > 
> > On Mon, Apr 03, 2023 at 11:05:28PM +0300, Abel Vesa wrote:
> > > Now that there is a new dedicated ICE driver, drop the ufs-qcom-ice and
> > > use the new ICE api provided by the Qualcomm soc driver ice. The platforms
> > > that already have ICE support will use the API as library since there will
> > > not be a devicetree node, but instead they have reg range. In this case,
> > > the of_qcom_ice_get will return an ICE instance created for the consumer's
> > > device. But if there are platforms that do not have ice reg in the
> > > consumer devicetree node and instead provide a dedicated ICE devicetree
> > > node, the of_qcom_ice_get will look up the device based on qcom,ice
> > > property and will get the ICE instance registered by the probe function
> > > of the ice driver.
> > > 
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > 
> > This is still silent about how the ICE clock behavior is being changed.
> 
> Right, I'll add the some more info into the commit message about the
> clock being handled by the ICE driver.
> 
> > 
> > I'm still trying to understand all this myself, so please bear with me, but my
> > understanding is that the UFS clocks can be disabled even while the host
> > controller is runtime-resumed.  This is called "clock gating" in the code.
> 
> The ICE clock is now being controlled by the new driver.
> > 
> > Before, the ICE clock was just listed as one of the UFS clocks.  So, it was just
> > managed like the other UFS clocks.
> > 
> > Now, it appears that the ICE clock is always enabled while the host controller
> > is runtime-resumed.  So, this patch removes support for gating of the ICE clock.
> 
> I just tested this and it works as expected, which is:
> 
> ICE clock gets enable on qcom_ice_create (via *clk_get*_enabled) and
> then, on the runtime suspend of the UFS, the qcom_ice_suspend is called
> which will disable the clock. Then, every time UFS runtime
> resumes/suspends the clock gets enabled/disabled.
> 
> Hope that makes sense.
> 
> Let me know if you think I'm missing something here.
> 

Well, it's better than v4 and earlier of this patchset, where the clock was
never turned off.

But, this patchset still seems to be a regression from the status quo, since it
makes the ICE clock no longer be disabled when "UFS clock gating" disables the
other UFS clocks.  Instead, it will only be disabled on runtime-suspend.

Now, I don't know whether anyone ever confirmed that the current behavior is
actually optimal and works as intended.  So, it *might* actually be fine to
change it!  But I was hoping that you at least had some thoughts about this,
whereas currently this patchset just ignores the issue entirely.

- Eric
