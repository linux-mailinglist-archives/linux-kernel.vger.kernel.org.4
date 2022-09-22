Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7065E630D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiIVNAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiIVNAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:00:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72197B2B7;
        Thu, 22 Sep 2022 06:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663851637; x=1695387637;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=5QBetHFsi1eFZ6sWcQbYQYznjr0Mg44JGGwnlV+QUQw=;
  b=Ihefzx6FPMeSpBBUjF09/pqMOaeZ6Zf9Ndf68WgawZBcBUD4gbDVg4+s
   j+0FNdepKSTsoUDhp9KXm+kFpJKBB3vYlD8T/TBKSkUwquy6oExrSXwDs
   x/I/hMat3fzY9/Rafhd4qD9M3mq1RCSPmWkQ2kgTzebcvU9PNEd/4xUB9
   7xl2Yy6BLnx9GVUhM3s0NcK8+TcrDUtLlJCDoUl9AnSiFNGz6adD6Qyg1
   Q7xREfqxmqpTkPxBQFgSLQRDn1n6sB50neKY2GUiUI3PscEVanlDVUxH/
   UfBxqf1mbeqIzMMo4Jf0Wt7iq96iPAH4GZ0zkiExgGUmEu0JfY2pPus5x
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="301134951"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="301134951"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 06:00:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="762173737"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 22 Sep 2022 06:00:35 -0700
Message-ID: <6b5a45f1-caf3-4259-77da-e36788f5b8a9@linux.intel.com>
Date:   Thu, 22 Sep 2022 16:01:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Content-Language: en-US
To:     Longfang Liu <liulongfang@huawei.com>, gregkh@linuxfoundation.org,
        mathias.nyman@intel.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        yisen.zhuang@huawei.com
References: <20220915011134.58400-1-liulongfang@huawei.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] xhci: print warning when HCE was set
In-Reply-To: <20220915011134.58400-1-liulongfang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 15.9.2022 4.11, Longfang Liu wrote:
> When HCE(Host Controller Error) is set, it means that the xhci hardware
> controller has an error at this time, but the current xhci driver
> software does not log this event.
> 
> By adding an HCE event detection in the xhci interrupt processing
> interface, a warning log is output to the system, which is convenient
> for system device status tracking.
> 

xHC should cease all activity when it sets HCE, and is probably not
generating interrupts anymore.

Would probably be more useful to check for HCE at timeouts than in the
interrupt handler.

If this is something seen on actual hardware then it makes sense to add it.

Thanks
-Mathias
