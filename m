Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D1F731475
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241788AbjFOJu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245741AbjFOJtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:49:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002F92963;
        Thu, 15 Jun 2023 02:49:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72E4360C28;
        Thu, 15 Jun 2023 09:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C09BC433C8;
        Thu, 15 Jun 2023 09:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686822576;
        bh=OhJC7fJUT8U6Rp9IUkfeZynOBy6WMQvDT/VICc9QVow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wPkL+Ivq0riNfFQCc+KJLuM8Hntwj2JivKRD4W4hBess1xxRK3OLiYdMFfvdJmNQF
         916uUdsTeJuKgwUmSSUGJtZCL3HmPM2Yrde2mY+FgpXXEiZrrBs8vy22NKdGi5xyDO
         FqpaFIeQZxxBlFk4AULBoR5uKu5kwbVMSv+byISs=
Date:   Thu, 15 Jun 2023 11:49:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     wangxiaolei <xiaolei.wang@windriver.com>
Cc:     peter.chen@kernel.org, pawell@cadence.com, rogerq@kernel.org,
        a-govindraju@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: cdns3: Put the cdns set active part outside the
 spin lock
Message-ID: <2023061507-mummy-salvation-c45a@gregkh>
References: <20230504131602.3273835-1-xiaolei.wang@windriver.com>
 <2023050503-handful-shore-ae11@gregkh>
 <3a9c2750-1c80-506a-69ec-a92250dfeaa8@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a9c2750-1c80-506a-69ec-a92250dfeaa8@windriver.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 11:16:05AM +0800, wangxiaolei wrote:
> 
> On 5/5/23 6:33 PM, Greg KH wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender and know the content is safe.
> > 
> > On Thu, May 04, 2023 at 09:16:02PM +0800, Xiaolei Wang wrote:
> > > The device may be scheduled during the resume process,
> > > so this cannot appear in atomic operations. Since
> > > pm_runtime_set_active will resume suppliers, put set
> > > active outside the spin lock, which is only used to
> > > protect the struct cdns data structure, otherwise the
> > > kernel will report the following warning:
> > > 
> > >    BUG: sleeping function called from invalid context at drivers/base/power/runtime.c:1163
> > >    in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 651, name: sh
> > >    preempt_count: 1, expected: 0
> > >    RCU nest depth: 0, expected: 0
> > >    CPU: 0 PID: 651 Comm: sh Tainted: G        WC         6.1.20 #1
> > >    Hardware name: Freescale i.MX8QM MEK (DT)
> > >    Call trace:
> > >      dump_backtrace.part.0+0xe0/0xf0
> > >      show_stack+0x18/0x30
> > >      dump_stack_lvl+0x64/0x80
> > >      dump_stack+0x1c/0x38
> > >      __might_resched+0x1fc/0x240
> > >      __might_sleep+0x68/0xc0
> > >      __pm_runtime_resume+0x9c/0xe0
> > >      rpm_get_suppliers+0x68/0x1b0
> > >      __pm_runtime_set_status+0x298/0x560
> > >      cdns_resume+0xb0/0x1c0
> > >      cdns3_controller_resume.isra.0+0x1e0/0x250
> > >      cdns3_plat_resume+0x28/0x40
> > > 
> > > Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> > > ---
> > >   drivers/usb/cdns3/cdns3-plat.c |  3 ++-
> > >   drivers/usb/cdns3/cdnsp-pci.c  |  3 ++-
> > >   drivers/usb/cdns3/core.c       | 14 +++++++++++---
> > >   drivers/usb/cdns3/core.h       |  3 ++-
> > >   4 files changed, 17 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
> > > index 2bc5d094548b..726b2e4f67e4 100644
> > > --- a/drivers/usb/cdns3/cdns3-plat.c
> > > +++ b/drivers/usb/cdns3/cdns3-plat.c
> > > @@ -256,9 +256,10 @@ static int cdns3_controller_resume(struct device *dev, pm_message_t msg)
> > >        cdns3_set_platform_suspend(cdns->dev, false, false);
> > > 
> > >        spin_lock_irqsave(&cdns->lock, flags);
> > > -     cdns_resume(cdns, !PMSG_IS_AUTO(msg));
> > > +     cdns_resume(cdns);
> > >        cdns->in_lpm = false;
> > >        spin_unlock_irqrestore(&cdns->lock, flags);
> > > +     cdns_set_active(cdns, !PMSG_IS_AUTO(msg));
> > >        if (cdns->wakeup_pending) {
> > >                cdns->wakeup_pending = false;
> > >                enable_irq(cdns->wakeup_irq);
> > > diff --git a/drivers/usb/cdns3/cdnsp-pci.c b/drivers/usb/cdns3/cdnsp-pci.c
> > > index 7b151f5af3cc..0725668ffea4 100644
> > > --- a/drivers/usb/cdns3/cdnsp-pci.c
> > > +++ b/drivers/usb/cdns3/cdnsp-pci.c
> > > @@ -208,8 +208,9 @@ static int __maybe_unused cdnsp_pci_resume(struct device *dev)
> > >        int ret;
> > > 
> > >        spin_lock_irqsave(&cdns->lock, flags);
> > > -     ret = cdns_resume(cdns, 1);
> > > +     ret = cdns_resume(cdns);
> > >        spin_unlock_irqrestore(&cdns->lock, flags);
> > > +     cdns_set_active(cdns, 1);
> > > 
> > >        return ret;
> > >   }
> > > diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> > > index dbcdf3b24b47..661d5597fb68 100644
> > > --- a/drivers/usb/cdns3/core.c
> > > +++ b/drivers/usb/cdns3/core.c
> > > @@ -522,7 +522,7 @@ int cdns_suspend(struct cdns *cdns)
> > >   }
> > >   EXPORT_SYMBOL_GPL(cdns_suspend);
> > > 
> > > -int cdns_resume(struct cdns *cdns, u8 set_active)
> > > +int cdns_resume(struct cdns *cdns)
> > >   {
> > >        struct device *dev = cdns->dev;
> > >        enum usb_role real_role;
> > > @@ -556,15 +556,23 @@ int cdns_resume(struct cdns *cdns, u8 set_active)
> > >        if (cdns->roles[cdns->role]->resume)
> > >                cdns->roles[cdns->role]->resume(cdns, cdns_power_is_lost(cdns));
> > > 
> > > +     return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(cdns_resume);
> > > +
> > > +void cdns_set_active(struct cdns *cdns, u8 set_active)
> > > +{
> > > +     struct device *dev = cdns->dev;
> > > +
> > >        if (set_active) {
> > >                pm_runtime_disable(dev);
> > >                pm_runtime_set_active(dev);
> > >                pm_runtime_enable(dev);
> > >        }
> > > 
> > > -     return 0;
> > > +     return;
> > >   }
> > > -EXPORT_SYMBOL_GPL(cdns_resume);
> > > +EXPORT_SYMBOL_GPL(cdns_set_active);
> > >   #endif /* CONFIG_PM_SLEEP */
> > > 
> > >   MODULE_AUTHOR("Peter Chen <peter.chen@nxp.com>");
> > > diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
> > > index 2d332a788871..0f429042f997 100644
> > > --- a/drivers/usb/cdns3/core.h
> > > +++ b/drivers/usb/cdns3/core.h
> > > @@ -125,8 +125,9 @@ int cdns_init(struct cdns *cdns);
> > >   int cdns_remove(struct cdns *cdns);
> > > 
> > >   #ifdef CONFIG_PM_SLEEP
> > > -int cdns_resume(struct cdns *cdns, u8 set_active);
> > > +int cdns_resume(struct cdns *cdns);
> > >   int cdns_suspend(struct cdns *cdns);
> > > +void cdns_set_active(struct cdns *cdns, u8 set_active);
> > >   #else /* CONFIG_PM_SLEEP */
> > >   static inline int cdns_resume(struct cdns *cdns, u8 set_active)
> > >   { return 0; }
> > > --
> > > 2.25.1
> > > 
> > 
> > Hi,
> > 
> > This is the friendly semi-automated patch-bot of Greg Kroah-Hartman.
> > You have sent him a patch that has triggered this response.
> > 
> > Right now, the development tree you have sent a patch for is "closed"
> > due to the timing of the merge window.  Don't worry, the patch(es) you
> > have sent are not lost, and will be looked at after the merge window is
> > over (after the -rc1 kernel is released by Linus).
> > 
> > So thank you for your patience and your patches will be reviewed at this
> > later time, you do not have to do anything further, this is just a short
> > note to let you know the patch status and so you don't worry they didn't
> > make it through.
> 
> Can someone help review this patch?

It breaks the build:

drivers/usb/cdns3/core.c: In function ‘cdns_resume’:
drivers/usb/cdns3/core.c:527:24: error: unused variable ‘dev’ [-Werror=unused-variable]
  527 |         struct device *dev = cdns->dev;
      |                        ^~~


How did you test it?

thanks,

greg k-h
