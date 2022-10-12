Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842445FCEA8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiJLW65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiJLW60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:58:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C55125028;
        Wed, 12 Oct 2022 15:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665615470; x=1697151470;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5mkM7oTyO2MRfpvf1l/u8o+k5OX3BWVwOK+EAoeg1yE=;
  b=m3t5az/gKhyQIjmllk/NnsdOVZbNLjFI8f+loy3OlGYZSm/232SebTxi
   2HQ/xGHEnnmjNUk7exZmEfNuUaEv4q3vwqB4QSZwWdw468S1srTue7QVD
   FjJYRlP8r7p9duBhAmIN2o1G2bkGy9uAW9vz809xWVZGyUaR9M1H2bMmu
   ylF/X4hyPy0QNby+5C3NUbNmVyJSZ6CPfV24yHeaLC8aWsexOF8eZ83p8
   0Xx+2jX8IopHMpQjW1dcGMOzqEJYJu5tPEei3aCBOIKuX1DUeqNR2Ba2y
   DDWD8cl8HlH6h9d2rEPkoOmQXB7Ll2FWpG8J05ZcmqstnICJZ1ptjEJwM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="331425448"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="331425448"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 15:57:50 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="604733048"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="604733048"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.71.30]) ([10.212.71.30])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 15:57:48 -0700
Message-ID: <b155c6df-adb6-6136-c3b4-4a2c66110ecf@intel.com>
Date:   Wed, 12 Oct 2022 15:57:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.1
Subject: Re: [PATCH] cxl: Add generic MSI/MSI-X interrupt support
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc:     ira.weiny@intel.com, Jonathan.Cameron@huawei.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        bwidawsk@kernel.org, a.manzanares@samsung.com,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20221012180432.473373-1-dave@stgolabs.net>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221012180432.473373-1-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/12/2022 11:04 AM, Davidlohr Bueso wrote:
> Introduce a generic irq table for CXL components/features that can have
> standard irq support - DOE requires dynamic vector sizing and is not
> considered here.
>
> Create an infrastructure to query the max vectors required for the CXL
> device.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

LGTM. Although it would be nice to see the other half of the picture. 
i.e. having the mailbox consuming the vector via request_irq() as an 
example.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>   drivers/cxl/pci.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 63 insertions(+)
>
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index faeb5d9d7a7a..467f2d568e3e 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -428,6 +428,66 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
>   	}
>   }
>   
> +/**
> + * struct cxl_irq_cap - CXL feature that is capable of receiving MSI/MSI-X irqs.
> + *
> + * @name: Name of the device generating this interrupt.
> + * @get_max_msgnum: Get the feature's largest interrupt message number.  If the
> + *		    feature does not have the Interrupt Supported bit set, then
> + *		    return -1.
> + */
> +struct cxl_irq_cap {
> +	const char *name;
> +	int (*get_max_msgnum)(struct cxl_dev_state *cxlds);
> +};
> +
> +static const struct cxl_irq_cap cxl_irq_cap_table[] = {
> +	{ "isolation", NULL },
> +	{ "pmu_overflow", NULL },
> +	{ "mailbox", NULL },
> +	{ "event", NULL },
> +};
> +
> +static void cxl_pci_free_irq_vectors(void *data)
> +{
> +	pci_free_irq_vectors(data);
> +}
> +
> +static int cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> +{
> +	struct device *dev = cxlds->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int rc, i, vectors = -1;
> +
> +	for (i = 0; i < ARRAY_SIZE(cxl_irq_cap_table); i++) {
> +		int irq;
> +
> +		if (!cxl_irq_cap_table[i].get_max_msgnum)
> +			continue;
> +
> +		irq = cxl_irq_cap_table[i].get_max_msgnum(cxlds);
> +		vectors = max_t(int, irq, vectors);
> +	}
> +
> +	if (vectors == -1)
> +		return -EINVAL; /* no irq support whatsoever */
> +
> +	vectors++;
> +	rc = pci_alloc_irq_vectors(pdev, vectors, vectors,
> +				   PCI_IRQ_MSIX | PCI_IRQ_MSI);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (rc != vectors) {
> +		dev_err(dev, "Not enough interrupts; use polling where supported\n");
> +		/* Some got allocated; clean them up */
> +		cxl_pci_free_irq_vectors(pdev);
> +		return -ENOSPC;
> +	}
> +
> +	return devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
> +}
> +
>   static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   {
>   	struct cxl_register_map map;
> @@ -498,6 +558,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (IS_ERR(cxlmd))
>   		return PTR_ERR(cxlmd);
>   
> +	/* TODO: When there are users, this return value must be checked */
> +	cxl_pci_alloc_irq_vectors(cxlds);
> +
>   	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
>   		rc = devm_cxl_add_nvdimm(&pdev->dev, cxlmd);
>   
