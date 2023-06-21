Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135C0738874
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjFUPJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjFUPJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:09:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D68297A;
        Wed, 21 Jun 2023 08:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687359837; x=1718895837;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=42x+6nPgmci9QC5DOooRQad/IVtZd9ZVHG3OKuMCydc=;
  b=DcHj+4OnH5D2nLUrcfH2Sz5j9k8Y76R+JTHolh3RnGVuDXAKNV2cNFR+
   h3zm6lCoyXxZOwvwsfW4k58b8zgqYRZNF9Ouk1JZ49u9V3X/9CCiNQPvt
   I8rWOp7NIBBtkrOMGc7m5c/gr2Q+3KFC8bDQoNomTUOhSoR+tbU/O28CD
   T23Yjv9ohOQDmKs3cjt5EZibIPyTn34SJVcqq6nZYA++vVVeSkYx4vcjq
   l2V9MxA5an7vrbZ0w2zmwDTkMYh4CvWjlt/H7ekokMYKf+JUh2f+JKMtJ
   ouJOUZ2eqtAGvhhfPcJFPzo1WI1eVaoI7+mh6TDBP1jDkF4isoORZks1S
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="360213722"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="360213722"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 08:02:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="744197772"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="744197772"
Received: from lfrecald-mobl2.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.26.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 08:02:02 -0700
Message-ID: <d0966d1f53dccd6ce5a6c26f6cef7bb7d961d09a.camel@linux.intel.com>
Subject: Re: [PATCH 2/7] thermal: int340x: processor_thermal: Add interrupt
 configuration
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 21 Jun 2023 08:02:03 -0700
In-Reply-To: <2bdbba78c1e3162bd7e385ed48715fd949133253.camel@intel.com>
References: <20230620230150.3068704-1-srinivas.pandruvada@linux.intel.com>
         <20230620230150.3068704-3-srinivas.pandruvada@linux.intel.com>
         <2bdbba78c1e3162bd7e385ed48715fd949133253.camel@intel.com>
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

On Wed, 2023-06-21 at 14:50 +0000, Zhang, Rui wrote:
> On Tue, 2023-06-20 at 16:01 -0700, Srinivas Pandruvada wrote:
> > Some features on this PCI devices require interrupt support. Here
> > interrupts are enabled/disabled via sending mailbox commands. The
> > mailbox command ID is 0x1E for read and 0x1F for write.
> > 
> > The interrupt configuration will require mutex protection as it
> > involved read-modify-write operation. Since mutex are already used
> > in the mailbox read/write functions: send_mbox_write_cmd() and
> > send_mbox_read_cmd(), there will be double locking. But, this can
> > be avoided by moving mutexes from mailbox read/write processing
> > functions to the calling (exported) functions.
> > 
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > ---
> >  .../processor_thermal_device.h                |  2 +
> >  .../int340x_thermal/processor_thermal_mbox.c  | 85 ++++++++++++++-
> > --
> > --
> >  2 files changed, 68 insertions(+), 19 deletions(-)
> > 
> > diff --git
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> > index 7cdeca2edc21..defc919cb020 100644
> > ---
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> > +++
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> > @@ -91,6 +91,8 @@ void proc_thermal_wlt_req_remove(struct pci_dev
> > *pdev);
> >  
> >  int processor_thermal_send_mbox_read_cmd(struct pci_dev *pdev, u16
> > id, u64 *resp);
> >  int processor_thermal_send_mbox_write_cmd(struct pci_dev *pdev,
> > u16
> > id, u32 data);
> > +int processor_thermal_mbox_interrupt_config(struct pci_dev *pdev,
> > bool enable, int enable_bit,
> > +                                           int time_window);
> >  int proc_thermal_add(struct device *dev, struct
> > proc_thermal_device
> > *priv);
> >  void proc_thermal_remove(struct proc_thermal_device *proc_priv);
> >  int proc_thermal_suspend(struct device *dev);
> > diff --git
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
> > index ec766c5615b7..7ef0af3f5bef 100644
> > ---
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
> > +++
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
> > @@ -45,23 +45,16 @@ static int send_mbox_write_cmd(struct pci_dev
> > *pdev, u16 id, u32 data)
> >         int ret;
> >  
> >         proc_priv = pci_get_drvdata(pdev);
> > -
> > -       mutex_lock(&mbox_lock);
> > -
> >         ret = wait_for_mbox_ready(proc_priv);
> >         if (ret)
> > -               goto unlock_mbox;
> > +               return ret;
> >  
> >         writel(data, (proc_priv->mmio_base + MBOX_OFFSET_DATA));
> >         /* Write command register */
> >         reg_data = BIT_ULL(MBOX_BUSY_BIT) | id;
> >         writel(reg_data, (proc_priv->mmio_base +
> > MBOX_OFFSET_INTERFACE));
> >  
> > -       ret = wait_for_mbox_ready(proc_priv);
> > -
> > -unlock_mbox:
> > -       mutex_unlock(&mbox_lock);
> > -       return ret;
> > +       return wait_for_mbox_ready(proc_priv);
> >  }
> >  
> >  static int send_mbox_read_cmd(struct pci_dev *pdev, u16 id, u64
> > *resp)
> > @@ -71,12 +64,9 @@ static int send_mbox_read_cmd(struct pci_dev
> > *pdev, u16 id, u64 *resp)
> >         int ret;
> >  
> >         proc_priv = pci_get_drvdata(pdev);
> > -
> > -       mutex_lock(&mbox_lock);
> > -
> >         ret = wait_for_mbox_ready(proc_priv);
> >         if (ret)
> > -               goto unlock_mbox;
> > +               return ret;
> >  
> >         /* Write command register */
> >         reg_data = BIT_ULL(MBOX_BUSY_BIT) | id;
> > @@ -84,28 +74,85 @@ static int send_mbox_read_cmd(struct pci_dev
> > *pdev, u16 id, u64 *resp)
> >  
> >         ret = wait_for_mbox_ready(proc_priv);
> >         if (ret)
> > -               goto unlock_mbox;
> > +               return ret;
> >  
> >         if (id == MBOX_CMD_WORKLOAD_TYPE_READ)
> >                 *resp = readl(proc_priv->mmio_base +
> > MBOX_OFFSET_DATA);
> >         else
> >                 *resp = readq(proc_priv->mmio_base +
> > MBOX_OFFSET_DATA);
> >  
> > -unlock_mbox:
> > -       mutex_unlock(&mbox_lock);
> > -       return ret;
> > +       return 0;
> >  }
> >  
> >  int processor_thermal_send_mbox_read_cmd(struct pci_dev *pdev, u16
> > id, u64 *resp)
> >  {
> > -       return send_mbox_read_cmd(pdev, id, resp);
> > +       int ret;
> > +
> > +       mutex_lock(&mbox_lock);
> > +       ret = send_mbox_read_cmd(pdev, id, resp);
> > +       mutex_unlock(&mbox_lock);
> > +
> > +       return ret;
> >  }
> >  EXPORT_SYMBOL_NS_GPL(processor_thermal_send_mbox_read_cmd,
> > INT340X_THERMAL);
> >  
> >  int processor_thermal_send_mbox_write_cmd(struct pci_dev *pdev,
> > u16
> > id, u32 data)
> >  {
> > -       return send_mbox_write_cmd(pdev, id, data);
> > +       int ret;
> > +
> > +       mutex_lock(&mbox_lock);
> > +       ret = send_mbox_write_cmd(pdev, id, data);
> > +       mutex_unlock(&mbox_lock);
> > +
> > +       return ret;
> >  }
> >  EXPORT_SYMBOL_NS_GPL(processor_thermal_send_mbox_write_cmd,
> > INT340X_THERMAL);
> >  
> > +#define MBOX_CAMARILLO_RD_INTR_CONFIG  0x1E
> > +#define MBOX_CAMARILLO_WR_INTR_CONFIG  0x1F
> > +#define WLT_TW_MASK                    GENMASK_ULL(30, 24)
> > +#define SOC_PREDICTION_TW_SHIFT                24
> > +
> > +int processor_thermal_mbox_interrupt_config(struct pci_dev *pdev,
> > bool enable,
> > +                                           int enable_bit, int
> > time_window)
> 
> All the callers of this API in this patch series uses
> SOC_WLT_PREDICTION_INT_ENABLE_BIT as the enable_bit, so this
> parameter
> is redundant?
> or do we expect a different enable_bit on other/future platforms?
> 
I will submit another patch for enabling interrupt for "power floor",
that is another bit.

Thanks,
Srinivas

> thanks,
> rui
> 
> > +{
> > +       u64 data;
> > +       int ret;
> > +
> > +       if (!pdev)
> > +               return -ENODEV;
> > +
> > +       mutex_lock(&mbox_lock);
> > +
> > +       /* Do read modify write for MBOX_CAMARILLO_RD_INTR_CONFIG
> > */
> > +
> > +       ret = send_mbox_read_cmd(pdev,
> > MBOX_CAMARILLO_RD_INTR_CONFIG,  &data);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "MBOX_CAMARILLO_RD_INTR_CONFIG
> > failed\n");
> > +               goto unlock;
> > +       }
> > +
> > +       if (time_window >= 0) {
> > +               data &= ~WLT_TW_MASK;
> > +
> > +               /* Program notification delay */
> > +               data |= (time_window << SOC_PREDICTION_TW_SHIFT);
> > +       }
> > +
> > +       if (enable)
> > +               data |= BIT(enable_bit);
> > +       else
> > +               data &= ~BIT(enable_bit);
> > +
> > +       ret = send_mbox_write_cmd(pdev,
> > MBOX_CAMARILLO_WR_INTR_CONFIG, data);
> > +       if (ret)
> > +               dev_err(&pdev->dev, "MBOX_CAMARILLO_WR_INTR_CONFIG
> > failed\n");
> > +
> > +unlock:
> > +       mutex_unlock(&mbox_lock);
> > +
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(processor_thermal_mbox_interrupt_config,
> > INT340X_THERMAL);
> > +
> >  MODULE_LICENSE("GPL v2");
> 

