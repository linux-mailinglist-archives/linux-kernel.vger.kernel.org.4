Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7078602A02
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 13:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiJRLRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 07:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiJRLRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:17:44 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BAC1EA;
        Tue, 18 Oct 2022 04:17:42 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MsBBv2lfJz67Pmj;
        Tue, 18 Oct 2022 19:16:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 13:17:40 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 12:17:40 +0100
Date:   Tue, 18 Oct 2022 12:17:39 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <bwidawsk@kernel.org>, <vishal.l.verma@intel.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <20221018121739.0000491e@huawei.com>
In-Reply-To: <20221018030010.20913-2-dave@stgolabs.net>
References: <20221018030010.20913-1-dave@stgolabs.net>
        <20221018030010.20913-2-dave@stgolabs.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2022 20:00:09 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Introduce a generic irq table for CXL components/features that can have
> standard irq support - DOE requires dynamic vector sizing and is not
> considered here. For now the table is empty.
> 
> Create an infrastructure to query the max vectors required for the CXL
> device. Upon successful allocation, users can plug in their respective isr
> at any point thereafter, which is supported by a new cxlds->has_irq flag,
> for example, if the irq setup is not done in the PCI driver, such as
> the case of the CXL-PMU.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

> +	vectors++;
> +	rc = pci_alloc_irq_vectors(pdev, vectors, vectors,
> +				   PCI_IRQ_MSIX | PCI_IRQ_MSI);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (rc != vectors) {

Just catching up with David Jiang's review of the CPMU driver.
He correctly points out that we won't hit this condition because
we provide minvec to the pci_alloc_irq_vectors() call:

> I don't think you'll hit here since you passed in vectors for min and 
> max. You'll get -ENOSPC and return from the earlier check.
> 
> https://elixir.bootlin.com/linux/v6.0-rc3/source/drivers/pci/msi/msi.c#L1005
> 
> DJ


> +		dev_dbg(dev, "Not enough interrupts; use polling instead.\n");
> +		/* some got allocated, clean them up */
> +		cxl_pci_free_irq_vectors(pdev);
> +		return -ENOSPC;
> +	}
> +
> +	return devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
> +}
