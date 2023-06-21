Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F83173887A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjFUPJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjFUPJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:09:25 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BCC2975;
        Wed, 21 Jun 2023 08:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687359867; x=1718895867;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UoFFhTqq8EUjbkCCMDbaEV6mCDWIMtiTF+GBEJ5VlN0=;
  b=kiVv/9jX9hEgMUsScVV4wZkLHvepGP/GGN7Iy/AtBNZH7wbyHaoVQ59g
   0vney8kScQlaZaLiLtlrqU0oY4u7KgBuuNRNPL2GfUHfioDUZiXV4Wfqv
   7sDCS4lJpbJE0H2Z6eBDoqLcdSNofy7cNDmApAsA/uB15CifZIvTtBYTi
   QIeC4iv95UFnpk9ijn7U4PFdp9kyZ1X3HUUHEHL57Jnmg82eCVeFXYV0N
   HgytC5tNbb5ep6n6V7MkC6SBrui4ul9muQGxFuIbfJaCLYibRHsz51fT4
   s209pVdidGkElrg+lbty+ocnAGg3cnd1tVJpmzJ2DE33vUgCAFaHo7iJu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="360214176"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="360214176"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 08:02:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="744197820"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="744197820"
Received: from lfrecald-mobl2.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.26.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 08:02:46 -0700
Message-ID: <1540593f20b69aaa1a3fc344fb1a3fcd36fca1cc.camel@linux.intel.com>
Subject: Re: [PATCH 3/7] thermal: int340x: processor_thermal: Use non MSI
 interrupts
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 21 Jun 2023 08:02:46 -0700
In-Reply-To: <b692f9a983d45a50aeae43dce3082551059f6bfe.camel@intel.com>
References: <20230620230150.3068704-1-srinivas.pandruvada@linux.intel.com>
         <20230620230150.3068704-4-srinivas.pandruvada@linux.intel.com>
         <b692f9a983d45a50aeae43dce3082551059f6bfe.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-06-21 at 14:53 +0000, Zhang, Rui wrote:
> On Tue, 2023-06-20 at 16:01 -0700, Srinivas Pandruvada wrote:
> > There are issues in using MSI interrupts for processor thermal
> > device.
> > The support is not consistent, across generations. Even in the same
> > generation, there are issue in getting interrupts via MSI.
> > 
> > Hence always use legacy PCI interrupts by default, instead of MSI.
> > Add a module param to use of MSI, so that MSI can be still used.
> > 
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > ---
> >  .../processor_thermal_device_pci.c            | 33 ++++++++++++---
> > --
> > --
> >  1 file changed, 22 insertions(+), 11 deletions(-)
> > 
> > diff --git
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pc
> > i.
> > c
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pc
> > i.
> > c
> > index 5a2bcfff0a68..057778f7bece 100644
> > ---
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pc
> > i.
> > c
> > +++
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pc
> > i.
> > c
> > @@ -15,6 +15,11 @@
> >  
> >  #define DRV_NAME "proc_thermal_pci"
> >  
> > +static int msi_enabled;
> > +module_param(msi_enabled, int, 0644);
> 
> why not use
> 
> static bool msi_enabled;
> module_params(msi_enabled, bool, 0644);
> 
Sure.

Thanks,
Srinivas

> thanks,
> rui
> 
> > +MODULE_PARM_DESC(msi_enabled,
> > +       "Use PCI MSI based interrupts for processor thermal
> > device.");
> > +
> >  struct proc_thermal_pci {
> >         struct pci_dev *pdev;
> >         struct proc_thermal_device *proc_priv;
> > @@ -219,8 +224,6 @@ static int proc_thermal_pci_probe(struct
> > pci_dev
> > *pdev, const struct pci_device_
> >                 return ret;
> >         }
> >  
> > -       pci_set_master(pdev);
> > -
> >         INIT_DELAYED_WORK(&pci_info->work,
> > proc_thermal_threshold_work_fn);
> >  
> >         ret = proc_thermal_add(&pdev->dev, proc_priv);
> > @@ -248,16 +251,23 @@ static int proc_thermal_pci_probe(struct
> > pci_dev *pdev, const struct pci_device_
> >                 goto err_ret_mmio;
> >         }
> >  
> > -       /* request and enable interrupt */
> > -       ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
> > -       if (ret < 0) {
> > -               dev_err(&pdev->dev, "Failed to allocate
> > vectors!\n");
> > -               goto err_ret_tzone;
> > -       }
> > -       if (!pdev->msi_enabled && !pdev->msix_enabled)
> > +       if (msi_enabled) {
> > +               pci_set_master(pdev);
> > +               /* request and enable interrupt */
> > +               ret = pci_alloc_irq_vectors(pdev, 1, 1,
> > PCI_IRQ_ALL_TYPES);
> > +               if (ret < 0) {
> > +                       dev_err(&pdev->dev, "Failed to allocate
> > vectors!\n");
> > +                       goto err_ret_tzone;
> > +               }
> > +               if (!pdev->msi_enabled && !pdev->msix_enabled)
> > +                       irq_flag = IRQF_SHARED;
> > +
> > +               irq =  pci_irq_vector(pdev, 0);
> > +       } else {
> >                 irq_flag = IRQF_SHARED;
> > +               irq = pdev->irq;
> > +       }
> >  
> > -       irq =  pci_irq_vector(pdev, 0);
> >         ret = devm_request_threaded_irq(&pdev->dev, irq,
> >                                         proc_thermal_irq_handler,
> > NULL,
> >                                         irq_flag, KBUILD_MODNAME,
> > pci_info);
> > @@ -273,7 +283,8 @@ static int proc_thermal_pci_probe(struct
> > pci_dev
> > *pdev, const struct pci_device_
> >         return 0;
> >  
> >  err_free_vectors:
> > -       pci_free_irq_vectors(pdev);
> > +       if (msi_enabled)
> > +               pci_free_irq_vectors(pdev);
> >  err_ret_tzone:
> >         thermal_zone_device_unregister(pci_info->tzone);
> >  err_ret_mmio:
> 

