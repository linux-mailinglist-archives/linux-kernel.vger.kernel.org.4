Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B25B65254F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 18:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbiLTRME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 12:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbiLTRLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 12:11:24 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1C8DF41;
        Tue, 20 Dec 2022 09:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671556267; x=1703092267;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UArxLVUf4dXhZTAq10N5OIewA40pAGd9cB0Plmqz5lQ=;
  b=nvLJjbSFIwIRuH0+XhK+YCrYh0rdAD6ToMJssmqBPo6BIpQzCJAAVilN
   +B/ipGgHhA6IeMFxFZXpa1HgQEQHKcTEUAiFsDECMwJAro7y1tAJ6KmkM
   Sr4zu1bBqSJc16pfZ/67OkBCXxgir7Et4id6fyQa13Sm+p8mhhcvgpJ9g
   DPIOMtX9Fodk6jttuCFNxe4hVoWR4debbIg2uOfQunPP5SD9I5BIOw+15
   p56tUWppxDuGLbQyEj+QNmVimR0LuZQpOw9JnGfmLeOcUYWw3QEzSKRGD
   ODsbLNX/p3uqd3tsvQnlcus4Xm/ODitCBkH0wabcWh1shu3zOlwcnlO/7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="405906779"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="405906779"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 09:08:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="644525709"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="644525709"
Received: from kjayadev-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.251.27.109])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 09:08:04 -0800
Message-ID: <c8e7fdb0e29b975537551ed6331f91b76e426246.camel@linux.intel.com>
Subject: Re: [PATCH] HID: intel_ish-hid: Add check for ishtp_dma_tx_map
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, Even Xu <even.xu@intel.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 20 Dec 2022 09:08:03 -0800
In-Reply-To: <20221122134823.540-1-jiasheng@iscas.ac.cn>
References: <20221122134823.540-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-11-22 at 21:48 +0800, Jiasheng Jiang wrote:
> As the kcalloc may return NULL pointer,
> it should be better to check the ishtp_dma_tx_map
> before use in order to avoid NULL pointer dereference.
> 
> Fixes: 3703f53b99e4 ("HID: intel_ish-hid: ISH Transport layer")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
+Even Xu, We should do during alloc. Please try to submit a change for
that for later kernel rev as it will require error processing during
hbm dispatch.

>  drivers/hid/intel-ish-hid/ishtp/dma-if.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/hid/intel-ish-hid/ishtp/dma-if.c
> b/drivers/hid/intel-ish-hid/ishtp/dma-if.c
> index 40554c8daca0..00046cbfd4ed 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/dma-if.c
> +++ b/drivers/hid/intel-ish-hid/ishtp/dma-if.c
> @@ -104,6 +104,11 @@ void *ishtp_cl_get_dma_send_buf(struct
> ishtp_device *dev,
>         int required_slots = (size / DMA_SLOT_SIZE)
>                 + 1 * (size % DMA_SLOT_SIZE != 0);
>  
> +       if (!dev->ishtp_dma_tx_map) {
> +               dev_err(dev->devc, "Fail to allocate Tx map\n");
> +               return NULL;
> +       }
> +
>         spin_lock_irqsave(&dev->ishtp_dma_tx_lock, flags);
>         for (i = 0; i <= (dev->ishtp_dma_num_slots - required_slots);
> i++) {
>                 free = 1;
> @@ -150,6 +155,11 @@ void ishtp_cl_release_dma_acked_mem(struct
> ishtp_device *dev,
>                 return;
>         }
>  
> +       if (!dev->ishtp_dma_tx_map) {
> +               dev_err(dev->devc, "Fail to allocate Tx map\n");
> +               return;
> +       }
> +
>         i = (msg_addr - dev->ishtp_host_dma_tx_buf) / DMA_SLOT_SIZE;
>         spin_lock_irqsave(&dev->ishtp_dma_tx_lock, flags);
>         for (j = 0; j < acked_slots; j++) {

