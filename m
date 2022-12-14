Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D7164C6F4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 11:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237543AbiLNKTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 05:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237536AbiLNKS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 05:18:56 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AEE13E35;
        Wed, 14 Dec 2022 02:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671013132; x=1702549132;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=On71BZpK9q1l2+c1xKWnMY3lgFjb7Dio1wCnc04xUG8=;
  b=GCHE1GQNkHQznviMz8mmTOhVagkwCsJ45b3jboYdLSnqvagg/DRpOmAw
   8A3tNY0v1k/gbnzYME6xedGCtz1P39m7mWRuNVfCoFaR/JhbhANRmyGIx
   QMrT3ZbCfsLGz93NaUWT5Mc3gNF6dyy646/XS98VeDa1sQo0idHkjqV/B
   3ok0vrWSR01sCBmzRWYf6m/ReBvCjCGka0O0ElJSv/7EMHp561drRvM8X
   zXE86O2+1Xq9JUttaiBymU7k2w+26xFK1PLt83MwQ5smSGsdxwvyzudue
   iMv1kOkUmRZYUHjGJogqs8pRGNz7k9IHDfpCP4qebSFlkgEEIXQndxM5e
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="317066785"
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; 
   d="scan'208";a="317066785"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 02:18:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="791257203"
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; 
   d="scan'208";a="791257203"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 14 Dec 2022 02:18:50 -0800
Message-ID: <1fe8f8a7-c88f-0c91-e74f-4d3f2f885c89@linux.intel.com>
Date:   Wed, 14 Dec 2022 12:20:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Content-Language: en-US
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221213-xhci-max_seg_size-v1-0-608f716a3792@chromium.org>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] xhci-pci: set the dma max_seg_size
In-Reply-To: <20221213-xhci-max_seg_size-v1-0-608f716a3792@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.12.2022 17.08, Ricardo Ribalda wrote:
> Allow devices to have dma operations beyond 64K, and avoid warnings such
> as:
> 
> xhci_hcd 0000:00:14.0: mapping sg segment longer than device claims to support [len=98304] [max=65536]
> 
> Cc: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> To: Mathias Nyman <mathias.nyman@intel.com>
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   drivers/usb/host/xhci-pci.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 7bccbe50bab1..116a2f328772 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -453,6 +453,8 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>   	if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
>   		pm_runtime_allow(&dev->dev);
>   
> +	dma_set_max_seg_size(&dev->dev, UINT_MAX);
> +

Thanks, this should be ok.

Preferred max segment size of sg list would be 64k as xHC hardware has 64k TRB payload size
limit, but xhci driver will take care of larger segments, splitting them into 64k chunks.

-Mathias

