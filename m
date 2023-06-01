Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573BE719F4C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbjFAOLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjFAOLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:11:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD9E1A1;
        Thu,  1 Jun 2023 07:11:37 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QX7Kx5QNGz683fS;
        Thu,  1 Jun 2023 22:09:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 1 Jun
 2023 15:11:35 +0100
Date:   Thu, 1 Jun 2023 15:11:34 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Robert Richter <rrichter@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
Subject: Re: [PATCH v4 23/23] PCI/AER: Unmask RCEC internal errors to enable
 RCH downstream port error handling
Message-ID: <20230601151134.00006281@Huawei.com>
In-Reply-To: <ZHEXOlxfCCApI+NE@bhelgaas>
References: <ZG/cYUaZerXNqqJl@rric.localdomain>
        <ZHEXOlxfCCApI+NE@bhelgaas>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > @@ -1432,6 +1495,7 @@ static int aer_probe(struct pcie_device *dev)
> > > >  		return status;
> > > >  	}
> > > >  
> > > > +	cxl_rch_enable_rcec(port);  
> > > 
> > > Could this be done by the driver that claims the CXL RCiEP?  There's
> > > no point in unmasking the errors before there's a driver with
> > > pci_error_handlers that can do something with them anyway.  
> > 
> > This sounds reasonable at the first glance. The problem is there could
> > be many devices associated with the RCEC. Not all of them will be
> > bound to a driver and handler at the same time. We would need to
> > refcount it or maintain a list of enabled devices. But there is
> > already something similar by checking dev->driver. But right, AER
> > errors could be seen and handled then at least on PCI level. I tent to
> > permanently enable RCEC AER, but that could cause side-effects. What
> > do you think?  
> 
> IIUC, this really just affects CXL devices, so I think the choice is
> (1) always unmask internal errors for RCECs where those CXL devices
> report errors (as this patch does), or (2) unmask when first CXL
> driver that can handle the errors is loaded and restore previous state
> when last one is unloaded.
> 
> If the RCEC *only* handles errors for CXL devices, i.e., not for a mix
> of vanilla PCIe RCiEPs and CXL RCiEPs, I think I'm OK with (1).  I
> think you said only the CXL driver knows how to collect and interpret
> the error data.  Is it OK that when no such driver is loaded, we field
> error interrupts silently, without even mentioning that an error
> occurred?  I guess without the driver, the device is probably not in
> use.

It might be in use.  Firmware may well have set up the CXL device and
even have put the kernel image in that memory for example. OS first RAS
handling won't be up until the driver loads though.  Would be a bit
odd to mix OS first handling with firmware setup. I'd expect firmware
first handling in that case, but I don't think anything stops the two
being mixed.

Jonathan

