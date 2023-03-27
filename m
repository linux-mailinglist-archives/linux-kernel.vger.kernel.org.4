Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A5D6CA618
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjC0Ni0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjC0NiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:38:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7397C359C;
        Mon, 27 Mar 2023 06:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679924303; x=1711460303;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e61Ql3VETaVOEl2l5DbC+OWMMqje4lKbAtYCoJPiXI4=;
  b=laeJ6sobr6LA1xWnJmrLe/Aa0eQQ9IZi4GW9qkltvEkMXw7uHQnccuDK
   rnm4Yj50wQ0X0M67OP4qSbRvMokq1Z/6qaBlJkYUdlwyx/KM+3rl6rg6N
   xxmp9mK6LSUNFtmZNgZQNS6xCg/47pxG/zeFh283f80oURyQdA1enLMDO
   ZJ08B5cplXxhkW1c/EmfdxYNxiUYiydrphVDZn+vN89lztTNSanP+LeJt
   s71prNqyNFRTvSDHIsaHINzE7RCVwU0mYdM/MDr39cCeQc2Mo5Mi8ogR9
   zMfEwim5M24GnfXx7AZZolC6da7wNqpotVun7jsOw+DSRSOLUVjeuLvK5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="338984948"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="338984948"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 06:38:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="683478432"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="683478432"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga002.jf.intel.com with ESMTP; 27 Mar 2023 06:38:21 -0700
Message-ID: <70fff502-3dab-9c81-d16a-e2aa8d001434@linux.intel.com>
Date:   Mon, 27 Mar 2023 16:39:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH] xhci: only define xhci_msix_sync_irqs() when CONFIG_PM is
 set
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     sfr@canb.auug.org.au, josue.d.hernandez.gutierrez@intel.com,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
References: <ZCFHsSkxXAahISuK@kroah.com>
 <20230327103103.1060696-1-mathias.nyman@linux.intel.com>
 <ZCGF0Q_tt5zA6DbS@kroah.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <ZCGF0Q_tt5zA6DbS@kroah.com>
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

On 27.3.2023 15.02, Greg KH wrote:
> On Mon, Mar 27, 2023 at 01:31:03PM +0300, Mathias Nyman wrote:
>> xhci_msic_sync_irqs() function is only called during suspend, when
>> CONFIG_PM is set, so don't define it unconditionally.
>>
>> Fixes: 9abe15d55dcc ("xhci: Move xhci MSI sync function to to xhci-pci")
>> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>> ---
>>   drivers/usb/host/xhci-pci.c | 27 ++++++++++++++-------------
>>   1 file changed, 14 insertions(+), 13 deletions(-)
> 
> No linux-usb?
> 

Oh, right, linux-usb was missing.
Now sent there separately as well

Thanks
Mathias
