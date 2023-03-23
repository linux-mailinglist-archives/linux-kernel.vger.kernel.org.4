Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713B96C68D3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjCWMub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjCWMu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:50:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0183326C32;
        Thu, 23 Mar 2023 05:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679575828; x=1711111828;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=fDt3zvniKGii4PtPU48PaQrpCagZeMYbyS0cNnHtbTI=;
  b=Ud0iNK5aZ3eiGWaz9t/JiYK9w3nebzJSwVQrs/XZUtM60TPfrJ4nntnL
   oJdzgE5FyFboB2q+EIGOwl6OnWSGU134O5A+vttRa2KNnuRJm58hPVx4f
   mQeJF/BpkbJNOYADd7UxbdJPnz5s9lOsARKdRHdPZPbQueqHWZZ1OEzEA
   ere1Bfd+Wbcv3GBlfQ9Dvs7k1NjL6+aUkKbhBVnOch/3P1gwQt619Ls7P
   4LzpQD5XJThaJAa9kHboxYiuAwaMh9vBPyPgal5ni5utHNSMPk+H9qPLI
   TAjvvbVqvWh3npwC45Fo3TeESApmjrJ+651P55TRwmDKKHjmcEfLwRunw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="319864716"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="319864716"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 05:50:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="856470942"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="856470942"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2023 05:50:18 -0700
Message-ID: <80f92044-6f3d-cdd8-a7d4-8793927a648b@linux.intel.com>
Date:   Thu, 23 Mar 2023 14:51:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Content-Language: en-US
To:     Jia-Ju Bai <baijiaju@buaa.edu.cn>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, p.zabel@pengutronix.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230323081329.366459-1-baijiaju@buaa.edu.cn>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] usb: host: xhci: Add a NULL check of hcd in
 xhci_plat_remove()
In-Reply-To: <20230323081329.366459-1-baijiaju@buaa.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.3.2023 10.13, Jia-Ju Bai wrote:
> In a previous commit d7de14d74d65 ("usb: xhci_plat_remove: avoid NULL
> dereference"), hcd can be NULL in usb_remove_hcd(), and thus it should
> be checked before being used.

hcd shouldn't be null in usb_remove_hcd()
That was a bug which was properly fixed shortly after in:

4a593a62a9e3 xhci: Fix null pointer dereference in remove if xHC has only one roothub

I guess commit d7de14d74d65 ("usb: xhci_plat_remove: avoid NULL dereference") Isn't really
needed either anymore, but no harm in keeping it.

> 
> However, in the call stack of this commit, hci is also used to get xhci:
> > xhci_plat_remove()
>    xhci = hcd_to_xhci(hcd)
>      usb_hcd_is_primary_hcd(hcd)
>        if (!hcd->primary_hcd) -> No check for hcd
>      primary_hcd = hcd->primary_hcd; -> No check for hcd
>    usb_remove_hcd(hcd)
>      if (!hcd) -> Add a check by the previous commit

These hcd checks shouldn't be needed.

Thanks
Mathias
