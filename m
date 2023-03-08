Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9566B1646
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjCHXLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjCHXLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:11:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6CC6923C;
        Wed,  8 Mar 2023 15:10:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF7856193B;
        Wed,  8 Mar 2023 23:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F94C433EF;
        Wed,  8 Mar 2023 23:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678317031;
        bh=6K5Aos/pHDOzNcZcmESeumuhe0HreLjKYHuJ1XTrzPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k/DseVQbYHn/At0guNyNZP4BN8i6WzjB0uRmhQobxO94ZBF0jJgd1PQlMGc04OpGE
         lIyKOJJTGkFOUXl1nCFzpKhe2MBgIyG30zjvFh8gaq/Ry3OWbr6iw/+DwdTHfdbfT6
         g6tDn+K/sH73TtnH0pXB6xFjCYSDJE5U8ygmaBnmDVCUtS25eS1W9ltWXSYuZK1Lzi
         iDbk9WM5rfiKALXn+gKk6Nwn52Qcpy8GlvtIpdkRhyG0wvRL1waJ4isIaHZAuLd/8b
         zYsmc2akgBrq5ajRhZNYtg8BOomZdsybcO3o7ld6yFFSh3hJ8IslyB0hPBarBpdIEO
         E4LzQ0XBIIc5A==
Date:   Wed, 8 Mar 2023 23:10:29 +0000
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
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/7] soc: qcom: Make the Qualcomm UFS/SDCC ICE a
 dedicated driver
Message-ID: <ZAkV5ZNeK5iHU0Uq@gmail.com>
References: <20230308155838.1094920-1-abel.vesa@linaro.org>
 <20230308155838.1094920-5-abel.vesa@linaro.org>
 <ZAjppY2K0/XPBHxG@sol.localdomain>
 <ZAkBwZNWMTsXlt+p@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAkBwZNWMTsXlt+p@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 11:44:33PM +0200, Abel Vesa wrote:
> On 23-03-08 12:01:41, Eric Biggers wrote:
> > On Wed, Mar 08, 2023 at 05:58:35PM +0200, Abel Vesa wrote:
> > >  * Switched QCOM_INLINE_CRYPTO_ENGINE to tristate and made it built-in
> > >    if any of the UFS or the SDHC drivers are built-in. This is to allow
> > >    the API to be available even if the built-in driver doesn't have
> > >    crypto enabled.
> > [...]
> > > diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> > > index a8f283086a21..c584369e9810 100644
> > > --- a/drivers/soc/qcom/Kconfig
> > > +++ b/drivers/soc/qcom/Kconfig
> > > @@ -275,4 +275,10 @@ config QCOM_ICC_BWMON
> > >  	  the fixed bandwidth votes from cpufreq (CPU nodes) thus achieve high
> > >  	  memory throughput even with lower CPU frequencies.
> > >  
> > > +config QCOM_INLINE_CRYPTO_ENGINE
> > > +	tristate
> > > +	depends on SCSI_UFS_CRYPTO || MMC_CRYPTO
> > > +	default y if SCSI_UFS_QCOM=y || MMC_SDHCI_MSM=y
> > > +	select QCOM_SCM
> > 
> > What are the "depends on" and "default y" lines above for?
> > 
> > You're already selecting this from SCSI_UFS_QCOM and MSM_SDHCI_MSM, as I had
> > suggested.  Isn't that enough?
> 
> We have the following:
> (SCSI_UFS_QCOM && SCSI_UFS_CRYPTO) || (MMC_SDHCI_MSM && MMC_CRYPTO)
> 
> So lets take as example the scenario: (m && y) || (y && n).
> 
> The QCOM_INLINE_CRYPTO_ENGINE will be set to 'm' and the sdhci driver
> will not be able to link properly since the ICE API is part of a module.
> 
> Therefore, if just one of SCSI_UFS_QCOM and MMC_SDHCI_MSM is built-in
> and at least one of the crypto options are enabled, set the
> QCOM_INLINE_CRYPTO_ENGINE to 'y' by default in order to make the
> built-in one linkage will not fail.
> 

That does not make sense.  If MMC_CRYPTO is disabled, then the sdhci-msm driver
should not call any of the ICE APIs.  Likewise for ufs-qcom and SCSI_UFS_CRYPTO.

- Eric
