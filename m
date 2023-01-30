Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7176806B1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 08:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbjA3HpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 02:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjA3HpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 02:45:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33294166D8;
        Sun, 29 Jan 2023 23:45:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDA6CB80DEA;
        Mon, 30 Jan 2023 07:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF81C433EF;
        Mon, 30 Jan 2023 07:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675064711;
        bh=pYwcsUsVtDE+CD0pM+qfd07SzUAWDxtCJQsikCIFxWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hYTf8T6Tu/8quBK6k1D0bjtKcSK1Ic4d+mRNxLFth6vYO+0k1nFQJ7FEYd1pQERXm
         4P1tHR+LgRaSMVOykg3z5DuUczSPk8uolVjlqvRP6tOFqAPqTY/zEj5Dc0ad8GWKlz
         uwThHKAZPdYrjsYHA/yoW/8fNMUwKG7RJPRkmgaP2Mv3jIR5etGp9wXdaJQvQMbp44
         dsbg6m16D9WCumWufDXFsAw8J+OVhwMKkYu8VX39GAFYxsrm0hS1uz9nxb5GWm6NGJ
         j8KQ0SlnjPiWBAHBACmRkCH36FWw/yYxRHO3q1xtV4fpB9j4VxsoswB2ffN/pR1FyZ
         C6+gP0RZb3c9A==
Date:   Mon, 30 Jan 2023 13:15:00 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Can Guo <quic_cang@quicinc.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: qcom: fix platform_msi_domain_free_irqs()
 reference
Message-ID: <20230130074500.GA12687@thinkpad>
References: <20230126211831.2274211-1-arnd@kernel.org>
 <20230127060221.GB7809@thinkpad>
 <9ff005f0-0cef-65d6-6f69-8394f1ba3e3c@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ff005f0-0cef-65d6-6f69-8394f1ba3e3c@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 12:03:45PM +0800, Can Guo wrote:
> Hi Mani and Arnd,
> 
> On 1/27/2023 2:02 PM, Manivannan Sadhasivam wrote:
> > On Thu, Jan 26, 2023 at 10:17:31PM +0100, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > The newly added MSI support is mostly hidden inside of an #ifdef,
> > > except for one line that now causes a build failure when MSI
> > > is disabled:
> > > 
> > > drivers/ufs/host/ufs-qcom.c: In function 'ufs_qcom_remove':
> > > drivers/ufs/host/ufs-qcom.c:1698:9: error: implicit declaration of function 'platform_msi_domain_free_irqs' [-Werror=i]
> > >   1698 |         platform_msi_domain_free_irqs(hba->dev);
> > >        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > 
> > > Above that, the symbol that guards the other call was recently
> > > removed, so that is all dead code at the moment.
> > > 
> > > Remove the incorrect #ifdef and instead of a Kconfig dependency
> > > to only allow building the driver when CONFIG_GENERIC_MSI_IRQ
> > > is enabled. This symbol is always present when PCI_MSI
> > > or ARM_GIC_V3_ITS are enabled, both of which should be present
> > > on kernels that can run on Qualcomm SoCs.
> > > 
> > > The 'select RESET_CONTROLLER' in combination with this dependency
> > > unfortunately causes a dependency loop and this is a user-visible
> > > symbol, so it's better to change both to 'depends on'.
> > > 
> > > Fixes: 519b6274a777 ("scsi: ufs: qcom: Add MCQ ESI config vendor specific ops")
> > > Fixes: 13e7accb81d6 ("genirq: Get rid of GENERIC_MSI_IRQ_DOMAIN")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > 
> > > ---
> > > Not sure if this is the best solution, both the GENERIC_MSI_IRQ
> > > dependencies and the RESET_CONTROLLER dependencies are a bit
> > > inconsistent already. Feel free to pick another approach that
> > > addresses both of the bugs I found.
> > I think your proposed solution works best at the moment.
> > 
> > Thanks,
> > Mani
> > 
> > > ---
> > >   drivers/ufs/host/Kconfig    | 3 ++-
> > >   drivers/ufs/host/ufs-qcom.c | 8 --------
> > >   2 files changed, 2 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/ufs/host/Kconfig b/drivers/ufs/host/Kconfig
> > > index 139064e70a34..663881437921 100644
> > > --- a/drivers/ufs/host/Kconfig
> > > +++ b/drivers/ufs/host/Kconfig
> > > @@ -57,8 +57,9 @@ config SCSI_UFS_DWC_TC_PLATFORM
> > >   config SCSI_UFS_QCOM
> > >   	tristate "QCOM specific hooks to UFS controller platform driver"
> > >   	depends on SCSI_UFSHCD_PLATFORM && ARCH_QCOM
> > > +	depends on GENERIC_MSI_IRQ
> > > +	depends on RESET_CONTROLLER
> > >   	select QCOM_SCM if SCSI_UFS_CRYPTO
> > > -	select RESET_CONTROLLER
> > >   	help
> > >   	  This selects the QCOM specific additions to UFSHCD platform driver.
> > >   	  UFS host on QCOM needs some vendor specific configuration before
> > > diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> > > index 681da3ea7154..eb66b5f6cf19 100644
> > > --- a/drivers/ufs/host/ufs-qcom.c
> > > +++ b/drivers/ufs/host/ufs-qcom.c
> > > @@ -1538,7 +1538,6 @@ static int ufs_qcom_get_outstanding_cqs(struct ufs_hba *hba,
> > >   	return 0;
> > >   }
> > > -#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
> > >   static void ufs_qcom_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> > >   {
> > >   	struct device *dev = msi_desc_to_dev(desc);
> > > @@ -1626,13 +1625,6 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
> > >   	return ret;
> > >   }
> > > -#else
> > > -static int ufs_qcom_config_esi(struct ufs_hba *hba)
> > > -{
> > > -	return -EOPNOTSUPP;
> > > -}
> > > -#endif
> > > -
> > >   /*
> > >    * struct ufs_hba_qcom_vops - UFS QCOM specific variant operations
> > >    *
> > > -- 
> > > 2.39.0
> > > 
> 
> Thank you for pointing to 13e7accb81d6 ("genirq: Get rid of
> GENERIC_MSI_IRQ_DOMAIN"),
> 
> which I was not aware of. I am thinking about fixing it just like how
> 
> 13e7accb81d6 ("genirq: Get rid of GENERIC_MSI_IRQ_DOMAIN") is fixing
> drivers/dma/qcom/hidma.c -
> 
> In ufs-qcom.c, use CONFIG_GENERIC_MSI_IRQ instead of
> CONFIG_GENERIC_MSI_IRQ_DOMAIN,
> 
> and meanwhile add #ifdef check before calling
> platform_msi_domain_free_irqs().
> 
> Please let me know your idea.
> 

No. Let's get rid of the ifdef's please... I like Arnd's patch as it models the
dependency nicely in Kconfig. And most (all?) of the qcom platforms require
GENERIC_MSI_IRQ and RESET_CONTROLLER one way or the other anyway.

Thanks,
Mani

> 
> Thanks.
> Regards,
> Can Guo
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
