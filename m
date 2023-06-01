Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD5C719F5B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbjFAONy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbjFAONw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:13:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF07180;
        Thu,  1 Jun 2023 07:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685628830; x=1717164830;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=Nq286GKnh90xOwApeBUtq++zLOYj3gW5k7/CVSmWRB0=;
  b=Vd7po3qG8HWyCVwhR1b3nmzO4reEH0g6jqPZVO3dcm5NCiGUqCFp3GzO
   zdI8B5aNI9vlult+sDa4G1vSlRi+C1A8MiZ7y+lApZjtzpnyx7LOTJ5eB
   ueAFJ7w4WuyZVmV7D19ngGikkPxb9i3+GalyIo3GTsQL4GgDHL2ihtzkn
   uGykKFZBbAV38cWE1TSZry8wRu9txcRprqyTjZwPmJf6K6NgxBEBcuCLO
   V9N3JbBDeMgt/rYxVszw6W+U9yqKpkLq+3USEDFFSXOerpsnlyPcaE6Qi
   c+uUycxDDWiEs8kf2vCGlRakJGEuqvZP8zNEoB8I1vqBooC0QWYapt1GJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="421365624"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="421365624"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:43:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="851698880"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="851698880"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 01 Jun 2023 06:43:40 -0700
Message-ID: <14d94fa1-1499-de1f-c924-9b823a606580@linux.intel.com>
Date:   Thu, 1 Jun 2023 16:45:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Content-Language: en-US
To:     Ricardo Ribalda Delgado <ribalda@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
References: <20230531-xhci-deadlock-v1-1-57780bff5124@chromium.org>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] xhci: Do not create endpoint debugfs while holding the
 bandwidth mutex
In-Reply-To: <20230531-xhci-deadlock-v1-1-57780bff5124@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.5.2023 15.40, Ricardo Ribalda Delgado wrote:
> xhci_debugfs_create_endpoint needs to take the mm->mmap_sem, which is
> not serialized with the hcd->bandwidth_mutex across the codebase.
> 
> Without this patch a deadlock has been observed with the uvc driver at
> the functions v4l2_mmap() and usb_set_interface().
> 
> Cc: Stephen Boyd <swboyd@chromium.org
> Fixes: 167657a1bb5f ("xhci: don't create endpoint debugfs entry before ring buffer is set.")
> Signed-off-by: Ricardo Ribalda Delgado <ribalda@chromium.org>
> ---
> I do not have a proper reproducer for this and I am not used to this
> subsystem, so please take a careful look at this patch :).
> 
> Thanks!

Do you still have the lockdep output showing the deadlock?

I'm not sure how calling xhci_debugfs_create_endpoint() from
xhci_add_endpoint() instead of xhci_check_bandwidth() helps.

Both are called with hcd->bandwidth_mutex held:

usb_set_interface()
	mutex_lock(hcd->bandwidth_mutex);
	usb_hcd_alloc_bandwidth()
		hcd->driver->add_endpoint()    -> xhci_add_endpoint()
		hcd->driver->check_bandwidth() -> xhci_check_bandwidth()
	mutex_unlock(hcd->bandwidth_mutex);

Thanks
Mathias

