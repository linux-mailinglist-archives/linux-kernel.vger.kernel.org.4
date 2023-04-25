Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EEB6EE50F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbjDYPzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbjDYPzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:55:44 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796A610EF;
        Tue, 25 Apr 2023 08:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682438143; x=1713974143;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SctoAXA82p6ubya8177iIuP6SefhFaRORUGaErkssiQ=;
  b=j1A4Zi1dtQUrrXAGn6g4YxgkSpk7BpXd0QiYWz55kqqe/973hg6FBGxd
   SWVd17tZQZ7wcPTJmRMDgnBdieo7ApFpaF9rGCtOi7E88yPpRIQF6/p0q
   Twb+iLQCr4P65T8sfeOoNa07rFoNNDU7FON8TRRcinj19pdhrWbiSSxbQ
   ISabc7xmQb3+obIFQirU3PJM8nLOqRUqJQjBGtljjTqgcp8p52mUN625a
   o8XO3JaEeoxY3nhTiZEopCHTSFtILhtIeHIz9vYPpel0k2t+drUDhHue2
   FmsbK3oBFEdZUy8OioGVumxGV0wKQE990IfBg4MspTZodeVDG0WloETOW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="409763407"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="409763407"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 08:55:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="1023186397"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="1023186397"
Received: from gbelvis-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.26.247])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 08:55:13 -0700
Message-ID: <2bd0143cf0e638c88f57409f854c0529a1b12b6b.camel@linux.intel.com>
Subject: Re: [PATCH] HID: intel-ish-hid: pci-ish:  Fix use after free bug in
  ish_remove due to race condition
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com, rafael@kernel.org,
        hdegoede@redhat.com, gregkh@linuxfoundation.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Date:   Tue, 25 Apr 2023 08:55:12 -0700
In-Reply-To: <20230412171441.18958-1-zyytlz.wz@163.com>
References: <20230412171441.18958-1-zyytlz.wz@163.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-04-13 at 01:14 +0800, Zheng Wang wrote:
> In ish_probe, it calls ish_dev_init to init the device. In this
> function,
> ishtp_device_init is called and &dev->bh_hbm_work is bound with 
> bh_hbm_work_fn. recv_hbm may be called to start the timer work.
> 
> If we remove the module which will call ish_remove to make cleanup,
> there may be an unfinished work. The possible sequence is as follows:
> 
> Fix it by canceling the work before cleanup in
> ishtp_bus_remove_all_clients
> 
> CPU0                  CPUc1
> 
>                     |bh_hbm_work_fn
> ish_remove      |
> ishtp_bus_remove_all_clients  |
> kfree(ishtp_dev->fw_clients); |
>                     |
>                     |&dev->fw_clients[...]
>                     |   //use
> 
> Fixes: 3703f53b99e4 ("HID: intel_ish-hid: ISH Transport layer")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

It is a extremely rare case, so it is OK to not mark for stable.

> ---
>  drivers/hid/intel-ish-hid/ishtp/bus.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c
> b/drivers/hid/intel-ish-hid/ishtp/bus.c
> index 81385ab37fa9..ada7cd08dbeb 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/bus.c
> +++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
> @@ -744,6 +744,7 @@ void ishtp_bus_remove_all_clients(struct
> ishtp_device *ishtp_dev,
>                  */
>         }
>         spin_unlock_irqrestore(&ishtp_dev->cl_list_lock, flags);
> +       cancel_work_sync(&ishtp_dev->bh_hbm_work);
>  
>         /* Release DMA buffers for client messages */
>         ishtp_cl_free_dma_buf(ishtp_dev);

