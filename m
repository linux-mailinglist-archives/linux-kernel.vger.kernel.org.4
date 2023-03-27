Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9616CB240
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 01:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjC0XWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 19:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjC0XWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:22:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A1B90;
        Mon, 27 Mar 2023 16:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679959329; x=1711495329;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zyWjD2PkXDSkIYfuAz0Bzc4b4FSaXT17Kn1U6xHbVx0=;
  b=CBrpeggYy/FT1UJXPZOVEYbrWQHdEJIwaS8VqaBq+aZKtP2XMYpo8t5g
   qiEj2bOJfBc+1YSOWRiC94FS/5sSRCkAsgkZ8IY0275Noo6PPKvpyUeLB
   hVppsxecgIPUbjl4TPxnYuF9bSYcgW8BuUSzNpNBscojFMqrlHIbq9Ljw
   0LA8yCOulr1kK2b7W+or4OEW/EpUHXOl761PuNL4d3UhdKCrDcR2qDA89
   uZRVBenDfbLVs6WrKGiZCuPR8kKOr6p655RcnT/eY+2zet8Xt2ttsuf/E
   00N+izaESn7NBGmN8RBRecch3sGJFhtwkDVPReMn3dMaT2v/7w3INyzt2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="340442312"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="340442312"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 16:21:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="752898707"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="752898707"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.91.66]) ([10.212.91.66])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 16:21:48 -0700
Message-ID: <175c0dcf-5170-0e9a-792c-2fc1cccd52fe@intel.com>
Date:   Mon, 27 Mar 2023 16:21:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v2 5/5] cxl/pci: Add RCH downstream port error logging
To:     Terry Bowman <terry.bowman@amd.com>, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        linux-cxl@vger.kernel.org, rrichter@amd.com
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230323213808.398039-1-terry.bowman@amd.com>
 <20230323213808.398039-6-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230323213808.398039-6-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/23/23 2:38 PM, Terry Bowman wrote:
> RCH downstream port error logging is missing in the current CXL driver. The
> missing AER and RAS error logging is needed for communicating driver error
> details to userspace. Update the driver to include PCIe AER and CXL RAS
> error logging.
> 
> Add RCH downstream port error handling into the existing RCiEP handler.
> The downstream port error handler is added to the RCiEP error handler
> because the downstream port is implemented in a RCRB, is not PCI
> enumerable, and as a result is not directly accessible to the PCI AER
> root port driver. The AER root port driver calls the RCiEP handler for
> handling RCD errors and RCH downstream port protocol errors.
> 
> Update the cxl_mem driver to map the RCH RAS and AER register discovered
> earlier. The RAS and AER registers will be used in the RCH error handlers.
> 
> Disable RCH downstream port's root port cmd interrupts. Enable RCEC AER
> CIE/UIE reporting because they are disabled by default.[1]
> 
> Update existing RCiEP correctable and uncorrectable handlers to also call
> the RCH handler. The RCH handler will read the downstream port AER
> registers, check for error severity, and if an error exists will log
> using an existing kernel AER trace routine. The RCH handler will also
> reuse the existing RAS logging routine to log downstream port RAS
> errors if they exist.
> 
> [1] CXL 3.0 Spec, 12.2.1.1 - RCH Downstream Port Detected Errors
> 
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>   drivers/cxl/core/pci.c  | 126 +++++++++++++++++++++++++++++++++----
>   drivers/cxl/core/regs.c |   1 +
>   drivers/cxl/cxl.h       |  13 ++++
>   drivers/cxl/mem.c       | 134 ++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 262 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 7328a2552411..6e36471969ba 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -5,6 +5,7 @@
>   #include <linux/delay.h>
>   #include <linux/pci.h>
>   #include <linux/pci-doe.h>
> +#include <linux/aer.h>
>   #include <cxlpci.h>
>   #include <cxlmem.h>
>   #include <cxl.h>
> @@ -605,32 +606,88 @@ void read_cdat_data(struct cxl_port *port)
>   }
>   EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
>   
> -void cxl_cor_error_detected(struct pci_dev *pdev)
> +/* Get AER severity. Return false if there is no error. */
> +static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
> +				     int *severity)
> +{
> +	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
> +		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
> +			*severity = AER_FATAL;
> +		else
> +			*severity = AER_NONFATAL;
> +		return true;
> +	}
> +
> +	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
> +		*severity = AER_CORRECTABLE;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +/*
> + * Copy the AER capability registers to a buffer. This is necessary
> + * because RCRB AER capability is MMIO mapped. Clear the status
> + * after copying.
> + *
> + * @aer_base: base address of AER capability block in RCRB
> + * @aer_regs: destination for copying AER capability
> + */
> +static bool cxl_rch_get_aer_info(void __iomem *aer_base,
> +				 struct aer_capability_regs *aer_regs)
> +{
> +	int read_cnt = PCI_AER_CAPABILITY_LENGTH / sizeof(u32);
> +	u32 *aer_regs_buf = (u32 *)aer_regs;
> +	int n;
> +
> +	if (!aer_base)
> +		return false;
> +
> +	for (n = 0; n < read_cnt; n++)
> +		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
> +
> +	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
> +	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
> +
> +	return true;
> +}
> +
> +static void __cxl_log_correctable_ras(struct cxl_dev_state *cxlds,
> +				      void __iomem *ras_base)
>   {
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>   	void __iomem *addr;
>   	u32 status;
>   
> -	if (!cxlds->regs.ras)
> +	if (!ras_base)
>   		return;
>   
> -	addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
> +	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>   	status = readl(addr);
>   	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>   		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>   		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
>   	}
>   }
> -EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, CXL);
> +
> +static void cxl_log_correctable_ras_endpoint(struct cxl_dev_state *cxlds)
> +{
> +	return __cxl_log_correctable_ras(cxlds, cxlds->regs.ras);
> +}
> +
> +static void cxl_log_correctable_ras_dport(struct cxl_dev_state *cxlds)
> +{
> +	return __cxl_log_correctable_ras(cxlds, cxlds->regs.dport_ras);
> +}
>   
>   /* CXL spec rev3.0 8.2.4.16.1 */
> -static void header_log_copy(struct cxl_dev_state *cxlds, u32 *log)
> +static void header_log_copy(void __iomem *ras_base, u32 *log)
>   {
>   	void __iomem *addr;
>   	u32 *log_addr;
>   	int i, log_u32_size = CXL_HEADERLOG_SIZE / sizeof(u32);
>   
> -	addr = cxlds->regs.ras + CXL_RAS_HEADER_LOG_OFFSET;
> +	addr = ras_base + CXL_RAS_HEADER_LOG_OFFSET;
>   	log_addr = log;
>   
>   	for (i = 0; i < log_u32_size; i++) {
> @@ -644,17 +701,18 @@ static void header_log_copy(struct cxl_dev_state *cxlds, u32 *log)
>    * Log the state of the RAS status registers and prepare them to log the
>    * next error status. Return 1 if reset needed.
>    */
> -static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
> +static bool __cxl_report_and_clear(struct cxl_dev_state *cxlds,
> +				  void __iomem *ras_base)
>   {
>   	u32 hl[CXL_HEADERLOG_SIZE_U32];
>   	void __iomem *addr;
>   	u32 status;
>   	u32 fe;
>   
> -	if (!cxlds->regs.ras)
> +	if (!ras_base)
>   		return false;
>   
> -	addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
> +	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
>   	status = readl(addr);
>   	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
>   		return false;
> @@ -662,7 +720,7 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>   	/* If multiple errors, log header points to first error from ctrl reg */
>   	if (hweight32(status) > 1) {
>   		void __iomem *rcc_addr =
> -			cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET;
> +			ras_base + CXL_RAS_CAP_CONTROL_OFFSET;
>   
>   		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
>   				   readl(rcc_addr)));
> @@ -670,13 +728,54 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>   		fe = status;
>   	}
>   
> -	header_log_copy(cxlds, hl);
> +	header_log_copy(ras_base, hl);
>   	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
>   	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>   
>   	return true;
>   }
>   
> +static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
> +{
> +	return __cxl_report_and_clear(cxlds, cxlds->regs.ras);
> +}
> +
> +static bool cxl_report_and_clear_dport(struct cxl_dev_state *cxlds)
> +{
> +	return __cxl_report_and_clear(cxlds, cxlds->regs.dport_ras);
> +}
> +
> +static void cxl_rch_log_error(struct cxl_dev_state *cxlds)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	struct aer_capability_regs aer_regs;
> +	int severity;
> +
> +	if (!cxl_rch_get_aer_info(cxlds->regs.aer, &aer_regs))
> +		return;
> +
> +	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
> +		return;
> +
> +	cper_print_aer(pdev, severity, &aer_regs);
> +
> +	if (severity == AER_CORRECTABLE)
> +		cxl_log_correctable_ras_dport(cxlds);
> +	else
> +		cxl_report_and_clear_dport(cxlds);
> +}
> +
> +void cxl_cor_error_detected(struct pci_dev *pdev)
> +{
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +
> +	if (cxlds->rcd)
> +		cxl_rch_log_error(cxlds);
> +
> +	cxl_log_correctable_ras_endpoint(cxlds);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, CXL);
> +
>   pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>   				    pci_channel_state_t state)
>   {
> @@ -685,6 +784,9 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>   	struct device *dev = &cxlmd->dev;
>   	bool ue;
>   
> +	if (cxlds->rcd)
> +		cxl_rch_log_error(cxlds);
> +
>   	/*
>   	 * A frozen channel indicates an impending reset which is fatal to
>   	 * CXL.mem operation, and will likely crash the system. On the off
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 108a349d8101..7130f35891da 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -198,6 +198,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>   
>   	return ret_val;
>   }
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, CXL);
>   
>   int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
>   			   struct cxl_register_map *map, unsigned long map_mask)
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9fd7df48ce99..7036e34354bc 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -66,6 +66,8 @@
>   #define CXL_DECODER_MIN_GRANULARITY 256
>   #define CXL_DECODER_MAX_ENCODED_IG 6
>   
> +#define PCI_AER_CAPABILITY_LENGTH 56
> +
>   static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>   {
>   	int val = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
> @@ -209,6 +211,15 @@ struct cxl_regs {
>   	struct_group_tagged(cxl_device_regs, device_regs,
>   		void __iomem *status, *mbox, *memdev;
>   	);
> +
> +	/*
> +	 * Pointer to RCH cxl_dport AER. (only for RCH/RCD mode)
> +	 * @dport_aer: CXL 2.0 12.2.11 RCH Downstream Port-detected Errors
> +	 */
> +	struct_group_tagged(cxl_rch_regs, rch_regs,
> +		void __iomem *aer;
> +		void __iomem *dport_ras;
> +	);
>   };
>   
>   struct cxl_reg_map {
> @@ -249,6 +260,8 @@ struct cxl_register_map {
>   	};
>   };
>   
> +void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
> +				   resource_size_t length);
>   void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>   			      struct cxl_component_reg_map *map);
>   void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 12e8e8ebaac0..e217c44ed749 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -4,6 +4,7 @@
>   #include <linux/device.h>
>   #include <linux/module.h>
>   #include <linux/pci.h>
> +#include <linux/aer.h>
>   
>   #include "cxlmem.h"
>   #include "cxlpci.h"
> @@ -45,6 +46,132 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
>   	return 0;
>   }
>   
> +static int rcec_enable_aer_ints(struct pci_dev *pdev)
> +{
> +	struct pci_dev *rcec = pdev->rcec;
> +	int aer, rc;
> +	u32 mask;
> +
> +	if (!rcec)
> +		return -ENODEV;
> +
> +	/*
> +	 * Internal errors are masked by default, unmask RCEC's here
> +	 * PCI6.0 7.8.4.3 Uncorrectable Error Mask Register (Offset 08h)
> +	 * PCI6.0 7.8.4.6 Correctable Error Mask Register (Offset 14h)
> +	 */
> +	aer = rcec->aer_cap;
> +	rc = pci_read_config_dword(rcec, aer + PCI_ERR_UNCOR_MASK, &mask);
> +	if (rc)
> +		return rc;
> +	mask &= ~PCI_ERR_UNC_INTN;
> +	rc = pci_write_config_dword(rcec, aer + PCI_ERR_UNCOR_MASK, mask);
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_read_config_dword(rcec, aer + PCI_ERR_COR_MASK, &mask);
> +	if (rc)
> +		return rc;
> +	mask &= ~PCI_ERR_COR_INTERNAL;
> +	rc = pci_write_config_dword(rcec, aer + PCI_ERR_COR_MASK, mask);
> +
> +	return rc;
> +}
> +
> +static void disable_aer(void *_pdev)
> +{
> +	struct pci_dev *pdev = (struct pci_dev *)_pdev;
> +
> +	pci_disable_pcie_error_reporting(pdev);
> +
> +	/*
> +	 * Keep the RCEC's internal AER enabled. There
> +	 * could be other RCiEPs using this RCEC.
> +	 */
> +}
> +
> +static void rch_disable_root_ints(void __iomem *aer_base)
> +{
> +	u32 aer_cmd_mask, aer_cmd;
> +
> +	/*
> +	 * Disable RCH root port command interrupts.
> +	 * CXL3.0 12.2.1.1 - RCH Downstream Port-detected Errors
> +	 */
> +	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
> +			PCI_ERR_ROOT_CMD_NONFATAL_EN |
> +			PCI_ERR_ROOT_CMD_FATAL_EN);
> +	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
> +	aer_cmd &= ~aer_cmd_mask;
> +	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
> +}
> +
> +static int cxl_ras_setup_interrupts(struct cxl_dev_state *cxlds)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	int rc;
> +
> +	if (cxlds->rcd) {
> +		rch_disable_root_ints(cxlds->regs.aer);
> +
> +		rc = rcec_enable_aer_ints(pdev);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	rc = pci_enable_pcie_error_reporting(pdev);

Hi Terry, not sure if you saw this thread [1], but with the new changes 
upstream [2] to the PCIe subsystem, Bjorn says we no longer need to call 
pci_enable_pcie_error_report() by the driver.

[1]: 
https://lore.kernel.org/linux-cxl/c2e244bd-a94b-8de2-e43c-7ff8a756cbc7@intel.com/T/#mef401fb0580ebb4c4bc2a164f87e12b60cf76693
[2]: commit f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is 
native")

DJ

> +	if (rc)
> +		return rc;
> +
> +	return devm_add_action_or_reset(&pdev->dev, disable_aer, pdev);
> +}
> +
> +static int cxl_rch_map_ras(struct cxl_dev_state *cxlds,
> +			   struct cxl_dport *parent_dport)
> +{
> +	struct device *dev = parent_dport->dport;
> +	resource_size_t aer_phys, ras_phys;
> +	void __iomem *aer, *dport_ras;
> +
> +	if (!parent_dport->rch)
> +		return 0;
> +
> +	if (!parent_dport->aer_cap || !parent_dport->ras_cap ||
> +	    parent_dport->component_reg_phys == CXL_RESOURCE_NONE)
> +		return -ENODEV;
> +
> +	aer_phys = parent_dport->aer_cap + parent_dport->rcrb;
> +	aer = devm_cxl_iomap_block(dev, aer_phys,
> +				   PCI_AER_CAPABILITY_LENGTH);
> +
> +	if (!aer)
> +		return -ENOMEM;
> +
> +	ras_phys = parent_dport->ras_cap + parent_dport->component_reg_phys;
> +	dport_ras = devm_cxl_iomap_block(dev, ras_phys,
> +					 CXL_RAS_CAPABILITY_LENGTH);
> +
> +	if (!dport_ras)
> +		return -ENOMEM;
> +
> +	cxlds->regs.aer = aer;
> +	cxlds->regs.dport_ras = dport_ras;
> +
> +	return 0;
> +}
> +
> +static int cxl_setup_ras(struct cxl_dev_state *cxlds,
> +			 struct cxl_dport *parent_dport)
> +{
> +	int rc;
> +
> +	rc = cxl_rch_map_ras(cxlds, parent_dport);
> +	if (rc)
> +		return rc;
> +
> +	return cxl_ras_setup_interrupts(cxlds);
> +}
> +
>   static void cxl_rcrb_setup(struct cxl_dev_state *cxlds,
>   			   struct cxl_dport *parent_dport)
>   {
> @@ -93,6 +220,13 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>   
>   	cxl_rcrb_setup(cxlds, parent_dport);
>   
> +	rc = cxl_setup_ras(cxlds, parent_dport);
> +	/* Continue with RAS setup errors */
> +	if (rc)
> +		dev_warn(&cxlmd->dev, "CXL RAS setup failed: %d\n", rc);
> +	else
> +		dev_info(&cxlmd->dev, "CXL error handling enabled\n");
> +
>   	endpoint = devm_cxl_add_port(host, &cxlmd->dev, cxlds->component_reg_phys,
>   				     parent_dport);
>   	if (IS_ERR(endpoint))
