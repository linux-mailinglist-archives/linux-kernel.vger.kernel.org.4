Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BC573A194
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjFVNNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVNNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:13:00 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4D51BD7;
        Thu, 22 Jun 2023 06:12:58 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qn1212SWGz67k9Y;
        Thu, 22 Jun 2023 21:10:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Jun
 2023 14:12:56 +0100
Date:   Thu, 22 Jun 2023 14:12:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v6 25/27] cxl/pci: Disable root port interrupts in RCH
 mode
Message-ID: <20230622141255.00006d13@Huawei.com>
In-Reply-To: <20230622035126.4130151-26-terry.bowman@amd.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
        <20230622035126.4130151-26-terry.bowman@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 22:51:24 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The RCH root port contains root command AER registers that should not be
> enabled.[1] Disable these to prevent root port interrupts.

I'm a little dubious about a 'because the spec says' so argument.
If we can describe the path by which spurious interrupts turn up then
great - if not then fair enough.

One trivial spelling thing inline. With that fixed.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> [1] CXL 3.0 - 12.2.1.1 RCH Downstream Port-detected Errors
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/core.h |  6 ++++++
>  drivers/cxl/core/pci.c  | 29 +++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c |  3 +++
>  3 files changed, 38 insertions(+)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 87467c633123..880bac9db376 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -86,4 +86,10 @@ enum cxl_poison_trace_type {
>  	CXL_POISON_TRACE_CLEAR,
>  };
>  
> +#ifdef CONFIG_PCIEAER_CXL
> +void cxl_disable_rch_root_ints(struct cxl_dport *dport);
> +#else
> +static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { };
> +#endif
> +
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9e0eba5ccfc4..39a2f9f4f115 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -838,6 +838,35 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>  		cxl_handle_rdport_ras(cxlds, dport);
>  }
>  
> +void cxl_disable_rch_root_ints(struct cxl_dport *dport)
> +{
> +	void __iomem *aer_base = dport->regs.dport_aer;
> +	struct pci_host_bridge *bridge;
> +	u32 aer_cmd_mask, aer_cmd;
> +
> +	if (!aer_base)
> +		return;
> +
> +	bridge = to_pci_host_bridge(dport->dport_dev);
> +
> +	/*
> +	 * Disable RCH root port command interrupts.
> +	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
> +	 *
> +	 * This sequnce may not be necessary. CXL spec states disabling

Spell check. (I often forget as well :(


> +	 * the root cmd register's interrupts is required. But, PCI spec
> +	 * shows these are disabled by default on reset.
> +	 */
> +	if (bridge->native_cxl_error) {
> +		aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
> +				PCI_ERR_ROOT_CMD_NONFATAL_EN |
> +				PCI_ERR_ROOT_CMD_FATAL_EN);
> +		aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
> +		aer_cmd &= ~aer_cmd_mask;
> +		writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
> +	}
> +}
> +
>  #else
>  static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
>  #endif
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 87a12e69aa8e..2d812bbaf05f 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1035,6 +1035,9 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  
>  	cxl_dport_map_regs(dport);
>  
> +	if (dport->rch)
> +		cxl_disable_rch_root_ints(dport);
> +
>  	cond_cxl_root_lock(port);
>  	rc = add_dport(port, dport);
>  	cond_cxl_root_unlock(port);

