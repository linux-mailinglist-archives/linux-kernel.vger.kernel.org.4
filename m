Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E546A73DF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCASyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCASyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:54:11 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BE746159;
        Wed,  1 Mar 2023 10:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677696850; x=1709232850;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DoyD1gP9taeJoodWCJ7O6lelSaChC3vuRqFuYZhR8lU=;
  b=K7+rJUcKFjwsICFv0T5IBkrluoBo5M+zmg1qG14VBNoqp3TI9EfnqtgE
   XgevLMUQFjIweWbzB8+Q4LQ6CXrARuhbAkWEdyKlQ7tEjjF6foVpIxFoU
   VUDaCdJ9ZsgXEkd7Cin1Tm8TIEu9CEkchLUSgZnrq0kYhpEcVkPOCO6nr
   IDC6XpdIjxh/QCh1xFrnNhY8ORU8goIwAKrmBRVo4o3uEcOZ+uleEpnv2
   2B3rt1UlGTXKWjeSv2naNxX7Aerlceysgc6JXDVrbp3dyMLT6cBTZeq0W
   oKlfzC42cmudwLq7JudmahIEaybIxxhPtN7GjtLoZkWJnVYmSqq8E7d66
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="318294129"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="318294129"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 10:54:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="738741585"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="738741585"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.71.27]) ([10.212.71.27])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 10:54:09 -0800
Message-ID: <346a8225-609e-0188-ec8a-4abe8d271a09@intel.com>
Date:   Wed, 1 Mar 2023 11:54:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] cxl/hdm: Fix hdm decoder init by adding COMMIT field
 check
Content-Language: en-US
To:     Fan Ni <fan.ni@samsung.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20230228224029uscas1p1e2fb92a8a595f80fa2985b452899d785@uscas1p1.samsung.com>
 <20230228224014.1402545-1-fan.ni@samsung.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230228224014.1402545-1-fan.ni@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/23 3:40 PM, Fan Ni wrote:
> Add COMMIT field check aside with existing COMMITTED field check during
> hdm decoder initialization to avoid a system crash during module removal
> after destroying a region which leaves the COMMIT field being reset while
> the COMMITTED field still being set.

Hi Fan. Are you seeing this issue on qemu emulation or hardware? The 
situation does not make sense to me. If we clear the COMMIT bit, then 
the COMMITTED bit should be cleared by the hardware shortly after right? 
Otherwise, how would one reprogram the decoder if the decoder is 
indicating to be active?

DJ

> 
> In current kernel implementation, when destroying a region (cxl
> destroy-region),the decoders associated to the region will be reset
> as that in cxl_decoder_reset, where the COMMIT field will be reset.
> However, resetting COMMIT field will not automatically reset the
> COMMITTED field, causing a situation where COMMIT is reset (0) while
> COMMITTED is set (1) after the region is destroyed. Later, when
> init_hdm_decoder is called (during modprobe), current code only check
> the COMMITTED to decide whether the decoder is enabled or not. Since
> the COMMITTED will be 1 and the code treats the decoder as enabled,
> which will cause unexpected behaviour.
> 
> Before the fix, a system crash was observed when performing following
> steps:
> 1. modprobe -a cxl_acpi cxl_core cxl_pci cxl_port cxl_mem
> 2. cxl create-region -m -d decoder0.0 -w 1 mem0 -s 256M
> 3. cxl destroy-region region0 -f
> 4. rmmod cxl_acpi cxl_pci cxl_port cxl_mem cxl_pmem cxl_core
> 5. modprobe -a cxl_acpi cxl_core cxl_pci cxl_port cxl_mem (showing
> "no CXL window for range 0x0:0xffffffffffffffff" error message)
> 6. rmmod cxl_acpi cxl_pci cxl_port cxl_mem cxl_pmem cxl_core (kernel
> crash at cxl_dpa_release due to dpa_res has been freed when destroying
> the region).
> 
> The patch fixed the above issue, and is tested based on follow patch series:
> 
> [PATCH 00/18] CXL RAM and the 'Soft Reserved' => 'System RAM' default
> Message-ID: 167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>   drivers/cxl/core/hdm.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 80eccae6ba9e..6cf854c949f0 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -695,6 +695,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   	struct cxl_endpoint_decoder *cxled = NULL;
>   	u64 size, base, skip, dpa_size;
>   	bool committed;
> +	bool should_commit;
>   	u32 remainder;
>   	int i, rc;
>   	u32 ctrl;
> @@ -710,10 +711,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   	base = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
>   	size = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
>   	committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
> +	should_commit = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMIT);
>   	cxld->commit = cxl_decoder_commit;
>   	cxld->reset = cxl_decoder_reset;
>   
> -	if (!committed)
> +	if (!should_commit || !committed)
>   		size = 0;
>   	if (base == U64_MAX || size == U64_MAX) {
>   		dev_warn(&port->dev, "decoder%d.%d: Invalid resource range\n",
> @@ -727,7 +729,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   	};
>   
>   	/* decoders are enabled if committed */
> -	if (committed) {
> +	if (should_commit && committed) {
>   		cxld->flags |= CXL_DECODER_F_ENABLE;
>   		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
>   			cxld->flags |= CXL_DECODER_F_LOCK;
> @@ -772,7 +774,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   		return 0;
>   	}
>   
> -	if (!committed)
> +	if (!should_commit || !committed)
>   		return 0;
>   
>   	dpa_size = div_u64_rem(size, cxld->interleave_ways, &remainder);
