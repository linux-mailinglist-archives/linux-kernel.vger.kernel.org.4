Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E867617CDD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiKCMml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiKCMmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:42:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFC2F33;
        Thu,  3 Nov 2022 05:42:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9B0AB823C1;
        Thu,  3 Nov 2022 12:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D476DC433C1;
        Thu,  3 Nov 2022 12:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667479356;
        bh=W1nkZxNszhwNsoEA2MBJEvw/bRH0X3776BIDQFXqokQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sFEr2kmPEzXraDtriYkdQG65Oubcpzetp8dV2XdVEv+YxEJXaxDvS65VB5NnqGka0
         x+/dUWCGaXj3OpjOcjaAUJgwClI4YaK4iCg/ND/Ovwsg4DdajyUwz3Se0TKQze4HtT
         3QFxtNQqNFv0QSZ3bBIF6/PeDiyCTE31gGU5ZHgNdAnvhOaziXbwDeFlUZLU1av88D
         Gwxwll5+a23anF0/gFW8vozHlUvcU8CDLezw3KKg1pCQpZiUZsR5O8dlRmLoZpROU/
         0WqeCzC2kY3rFconED+86Dz+5LJNZXbK6WQ0q+nX8jzgiOulY/oX1gRdcaOc7rVzXZ
         EhZK7AWmaAbjw==
Date:   Thu, 3 Nov 2022 18:12:29 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Hemant Kumar <quic_hemantk@quicinc.com>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mhi: pci_generic: add support for sc8280xp-crd SDX55
 variant
Message-ID: <20221103124229.GF8434@thinkpad>
References: <20221031083429.18971-1-johan+linaro@kernel.org>
 <20221101114258.GB54667@thinkpad>
 <Y2Jp/wNPmTrC6sEy@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2Jp/wNPmTrC6sEy@hovoldconsulting.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 02:00:47PM +0100, Johan Hovold wrote:
> On Tue, Nov 01, 2022 at 05:12:58PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Oct 31, 2022 at 09:34:29AM +0100, Johan Hovold wrote:
> > > The SC8280XP Compute Reference Design (CRD) has an on-PCB SDX55 modem
> > > which uses MBIM.
> > > 
> > > The exact channel configuration is not known but the Foxconn SDX55
> > > configuration allows the modem to be used so reuse that one for now.
> > > 
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> > >  drivers/bus/mhi/host/pci_generic.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> > > index caa4ce28cf9e..f9f4345d472d 100644
> > > --- a/drivers/bus/mhi/host/pci_generic.c
> > > +++ b/drivers/bus/mhi/host/pci_generic.c
> > > @@ -542,6 +542,9 @@ static const struct mhi_pci_dev_info mhi_telit_fn990_info = {
> > >  static const struct pci_device_id mhi_pci_id_table[] = {
> > >  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0304),
> > >  		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx24_info },
> > > +	/* SC8280XP-CRD (sdx55) */
> > 
> > Platform device name is not needed.
> 
> Ok, only added it because the other entries had a description.
>  

Those descriptions are for the modems itself, like Telit FN980m. But
SC8280XP-CRD is the platform that makes use of *some* sdx55 based modem. So it
is not required.

> > > +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0306, PCI_VENDOR_ID_QCOM, 0x010c),
> > 
> > Sub ID looks wierd. Did you test with mhi_qcom_sdx55_info? If it didn't
> > work, what was the issue?
> 
> I obviously added the new entry because the default match did not work.
> 
> I haven't had time to look at this since before the summer, but based on
> my notes and a quick test now it seems that the QMI channel is not
> supported and ModemManager takes forever to enumerate with a bunch of
> failed transactions every second:
> 
>   ModemManager[469]: [/dev/wwan0qmi0] Checking version info (45 retries)...
>   ...
>   ModemManager[469]: transaction 0x2 aborted, but message is not abortable
>   ...
>   ModemManager[469]: transaction 0x2e aborted, but message is not abortable
>   ...
>   ModemManager[469]: <warn>  [plugin/generic] could not grab port wwan0qmi0: Cannot add port 'wwan/wwan0qmi0', unhandled port type
> 
> According to my notes I could connect to the provider after the (~45 s)
> timeout, but no data was coming through with the default config which I
> attributed to the differences in the data channel configuration (i.e.
> "IP_HW0" and "IP_HW0_MBIM" are handled by different drivers).
>  

Okay, this makes it clear.

Thanks,
Mani

> > > +		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
> > >  	/* EM919x (sdx55), use the same vid:pid as qcom-sdx55m */
> > >  	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0306, 0x18d7, 0x0200),
> > >  		.driver_data = (kernel_ulong_t) &mhi_sierra_em919x_info },
> > > -- 
> > > 2.37.3
> 
> Johan
> 

-- 
மணிவண்ணன் சதாசிவம்
