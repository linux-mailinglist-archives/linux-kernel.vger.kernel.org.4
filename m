Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C582693E8B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 07:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjBMG5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 01:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBMG5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 01:57:31 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA12BDCD
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 22:57:27 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id bt4-20020a17090af00400b002341621377cso82087pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 22:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DOhe4T6w8dNDK7j63ly9h/4o/NSXGrsIHCB7WK/Dgqs=;
        b=ZSORfHIjzUeClE5dNxMGVY2sDvaTMulqYxNkN+N+18JgEjjEVRL8ImNaRmX8M9juwL
         BjIGC6ruAho9tM/AQr/sPCMZ0lU3Dg15CkTmc2HEIlmGtS7RBVxEHyTSY0bKVMsBBZce
         8Ch50nvg0X9UuTUegHoLYKnpSft3XgSRGb2hOS62Sb7B6L8AqrgM8w63oeL1WAftUmOh
         WyFu6/PaThgs4gA0hani+Tvqagb0DcA1Z0253WNM/7A503IXtmvfQQetjQlE0RSC70qF
         SZDaEw16okYnFfleFOsUrnclrM2m5KZPWca23OGqufXS6grvUDLLWvWZfm9MswXq8rkH
         l8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DOhe4T6w8dNDK7j63ly9h/4o/NSXGrsIHCB7WK/Dgqs=;
        b=0zjk3eM3CRAhbURiZwBkcHuobxM8iuaTD6Dip8kYB4p6DuksG5fbz3GGgsr99JIuKd
         aEFGLwWYIwa6j6jJHLEjtf1U77/dUySdw6dPQVFIMCKfm0YfM9uacn0bM2cxuJheUZt5
         f0XoKHR0+XINTIp/P28gxCcfJNqyAhIz4szo+WozZjMsMSI8iyn6swGYSFGtBvaBH9T7
         I5Ot/+M0q2Vn55bHvvZCBE3eoh/1XGAEVhuxn0YchxXW4wkX+10VA18naifYEiVQ9Xxt
         Zjbel9gF7OrVSf27px4X2Dffe5URpLz5tdRSV8XYa/vnP9A4adCKmZpUn/IfTe+IvLz9
         oO5g==
X-Gm-Message-State: AO0yUKVDgUs5AG/68jr56osFKK/GUTGxmM4GF1yjl8MQGfNfn6o0pfLC
        4k/ltvkMc2pGnbsaX2j9Huq1JNY1xdIAPrA=
X-Google-Smtp-Source: AK7set/157rq5u8moF9Gp9oYiWWl/nAxXqNUBJ0081x6aR73hp5KWdgtklXZlmSCx8dV7kijYKGL3Q==
X-Received: by 2002:a05:6a21:30c3:b0:be:cbee:eda4 with SMTP id yf3-20020a056a2130c300b000becbeeeda4mr19869415pzb.11.1676271446672;
        Sun, 12 Feb 2023 22:57:26 -0800 (PST)
Received: from thinkpad ([117.217.185.240])
        by smtp.gmail.com with ESMTPSA id x9-20020a63b349000000b004f1e87530cesm6460199pgt.91.2023.02.12.22.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 22:57:26 -0800 (PST)
Date:   Mon, 13 Feb 2023 12:27:18 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kw@linux.com
Cc:     linux-pci@vger.kernel.org, kishon@kernel.org,
        lpieralisi@kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, kw@linux.com, robh@kernel.org,
        vidyas@nvidia.com, vigneshr@ti.com
Subject: Re: [PATCH v5 0/5] PCI: endpoint: Rework the EPC to EPF notification
Message-ID: <20230213065718.GA4375@thinkpad>
References: <20230124071158.5503-1-manivannan.sadhasivam@linaro.org>
 <20230124071602.GB4947@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230124071602.GB4947@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 12:46:11PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Jan 24, 2023 at 12:41:53PM +0530, Manivannan Sadhasivam wrote:
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
> Lorenzo, all patches in this series got review tags. Can you please merge now?
> 

Krzysztof, any update on this series?

Thanks,
Mani

> Thanks,
> Mani
> 
> > Thanks,
> > Mani
> > 
> > [1] https://lore.kernel.org/all/20220802072426.GA2494@thinkpad/T/#mfa3a5b3a9694798a562c36b228f595b6a571477d
> > [2] https://lore.kernel.org/all/20220228055240.24774-1-manivannan.sadhasivam@linaro.org
> > 
> > Changes in v5:
> > 
> > * Collected review tag from Vidya
> > * Fixed the issue reported by Kbot regarding missing declaration
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

-- 
மணிவண்ணன் சதாசிவம்
