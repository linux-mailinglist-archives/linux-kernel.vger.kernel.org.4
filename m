Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739F4627A09
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbiKNKHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236977AbiKNKGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:06:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB2A1FCD2;
        Mon, 14 Nov 2022 02:05:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFDB960F9D;
        Mon, 14 Nov 2022 10:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F3EC433D6;
        Mon, 14 Nov 2022 10:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668420351;
        bh=7U/JLGLVqG5uJOPAiWuJklR/LVbjzuDSTvLSKgNm8AA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q6yeJPHIViXWhZoIGEGrkqT0iRrRlHWhfKb0+YXQ1H/5/TEYjouUp+1ZXwO+1YjkQ
         YTdDg5kWSY55YILXkx6jKFznnm0NSnzmQe/YVebaK5UtkQ82xhQFN1nSeXlKuj54IS
         6lqo8MA76aTAUnr/89AHm55PHhgFd939Rp4RC5XdvATvhRwzBLGizC/+7kD5CHnKui
         ULvPZayeqvKrKjOBTkn2Bf40WJlySGqfWMSBb9HYnRU47h3ZzLZodeTyqKYGpumGa6
         vTi70NKErwmJPqZiQflFirKsWNTrYHYCrcDOxHOJiolW+wixyd/RIpSh8fCvVDo8hb
         QG6toxsylzhog==
Date:   Mon, 14 Nov 2022 11:05:44 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com,
        kishon@kernel.org, bhelgaas@google.com
Subject: Re: [PATCH v4 0/5] PCI: endpoint: Rework the EPC to EPF notification
Message-ID: <Y3IS+KIPGmEvcWmT@lpieralisi>
References: <20221025145101.116393-1-manivannan.sadhasivam@linaro.org>
 <20221114073316.GI3869@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221114073316.GI3869@thinkpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 01:03:16PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Oct 25, 2022 at 08:20:56PM +0530, Manivannan Sadhasivam wrote:
> > Hello,
> > 
> > During the review of the patch that fixes DBI access in PCI EP, Rob
> > suggested [1] using a fixed interface for passing the events from EPC to
> > EPF instead of the in-kernel notifiers.
> > 
> > This series introduces a simple callback based mechanism for passing the
> > events from EPC to EPF. This interface is chosen for satisfying the below
> > requirements:
> > 
> > 1. The notification has to reach the EPF drivers without any additional
> > latency.
> > 2. The context of the caller (EPC) needs to be preserved while passing the
> > notifications.
> > 
> > With the existing notifier mechanism, the 1st case can be satisfied since
> > notifiers aren't adding any huge overhead. But the 2nd case is clearly not
> > satisfied, because the current atomic notifiers forces the EPF
> > notification context to be atomic even though the caller (EPC) may not be
> > in atomic context. In the notification function, the EPF drivers are
> > required to call several EPC APIs that might sleep and this triggers a
> > sleeping in atomic bug during runtime.
> > 
> > The above issue could be fixed by using a blocking notifier instead of
> > atomic, but that proposal was not accepted either [2].
> > 
> > So instead of working around the issues within the notifiers, let's get rid
> > of it and use the callback mechanism.
> > 
> > NOTE: DRA7xx and TEGRA194 drivers are only compile tested. Testing this series
> > on the real platforms is greatly appreciated.
> > 
> 
> Lorenzo, can this series be merged for v6.2 since all the patches are reviewed
> now?

Patch (2) isn't (or I missed something) - we should be looking for
review/testing on it.

Thanks,
Lorenzo

> Thanks,
> Mani
> 
> > Thanks,
> > Mani
> > 
> > [1] https://lore.kernel.org/all/20220802072426.GA2494@thinkpad/T/#mfa3a5b3a9694798a562c36b228f595b6a571477d
> > [2] https://lore.kernel.org/all/20220228055240.24774-1-manivannan.sadhasivam@linaro.org
> > 
> > Changes in v4:
> > 
> > * Added check for the presence of event_ops before involing the callbacks (Kishon)
> > * Added return with IRQ_WAKE_THREAD when link_up event is found in the hard irq
> >   handler of tegra194 driver (Vidya)
> > * Collected review tags
> > 
> > Changes in v3:
> > 
> > * As Kishon spotted, fixed the DRA7xx driver and also the TEGRA194 driver to
> >   call the LINK_UP callback in threaded IRQ handler.
> > 
> > Changes in v2:
> > 
> > * Introduced a new "list_lock" for protecting the epc->pci_epf list and
> >   used it in the callback mechanism.
> > 
> > Manivannan Sadhasivam (5):
> >   PCI: dra7xx: Use threaded IRQ handler for "dra7xx-pcie-main" IRQ
> >   PCI: tegra194: Move dw_pcie_ep_linkup() to threaded IRQ handler
> >   PCI: endpoint: Use a separate lock for protecting epc->pci_epf list
> >   PCI: endpoint: Use callback mechanism for passing events from EPC to
> >     EPF
> >   PCI: endpoint: Use link_up() callback in place of LINK_UP notifier
> > 
> >  drivers/pci/controller/dwc/pci-dra7xx.c       |  2 +-
> >  drivers/pci/controller/dwc/pcie-tegra194.c    |  9 ++++-
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 38 ++++++-------------
> >  drivers/pci/endpoint/pci-epc-core.c           | 32 ++++++++++++----
> >  include/linux/pci-epc.h                       | 10 +----
> >  include/linux/pci-epf.h                       | 19 ++++++----
> >  6 files changed, 59 insertions(+), 51 deletions(-)
> > 
> > -- 
> > 2.25.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
