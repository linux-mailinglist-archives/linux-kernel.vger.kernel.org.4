Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EFA68DC99
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjBGPLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjBGPK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:10:59 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1D63019E;
        Tue,  7 Feb 2023 07:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675782643; x=1707318643;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=iOjXe6t9xdIUb4Mn8IpomUUQcUBir+akgY7gJjeXLQ8=;
  b=dMIqRmA8UTah/oKW2Uay8Et08Hiu5JxHvW67TDcZpvT1GFfc9hnHvuXd
   eZ9qRyTVwnBWTCx0BNZB3BmskySemgOVL4Ur4nPoibALpzGNDCBwPhmPQ
   7nQ4viAhkvDT6zlUAPvVilq+O3kEnFeJQZHP5/lN+jtm/LKvu5CZUSEEE
   3LJv7Hb2ljOIWHDBo6g2fR99oaqMp1fEKk0oOnvfpEPmf5JTxQEGsHx8U
   Ky2eIpRt4qEnokwk1UZmZdWjbF1P4VHjL0i9OAWwSpVXSLOIs2Kbm/nQS
   dyCKyWz9Nu3QeHHdDaLvDKZ1Awenpm2/fSrLbD4rZQcBjawuV/X66reqV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="415746836"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="415746836"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 07:10:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="699281764"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="699281764"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga001.jf.intel.com with ESMTP; 07 Feb 2023 07:10:02 -0800
Message-ID: <31a4cfbe-2c23-cda2-2d92-9d15a5d4bcb3@linux.intel.com>
Date:   Tue, 7 Feb 2023 17:11:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230206161049.13972-1-andriy.shevchenko@linux.intel.com>
 <20230206161049.13972-3-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v1 2/7] xhci: mem: Use __GFP_ZERO instead of explicit
 memset() call
In-Reply-To: <20230206161049.13972-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.2.2023 18.10, Andy Shevchenko wrote:
> Use __GFP_ZERO instead of explicit memset() call in
> xhci_alloc_stream_ctx().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/usb/host/xhci-mem.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index c385513ad00b..768adcb544a7 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -571,6 +571,8 @@ static struct xhci_stream_ctx *xhci_alloc_stream_ctx(struct xhci_hcd *xhci,
>   	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
>   	size_t size = size_mul(sizeof(struct xhci_stream_ctx), num_stream_ctxs);
>   
> +	mem_flags |= __GFP_ZERO;
> +

How about calling dma_pool_zalloc() instead of setting __GFP_ZERO flag?
Memory returned by dma_alloc_coherent() should already be zeroed if I remember correctly

-Mathias


