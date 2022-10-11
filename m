Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9A75FB314
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiJKNQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiJKNPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:15:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C75F178A8;
        Tue, 11 Oct 2022 06:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665494102; x=1697030102;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UlEFJL5s7mZfjhc9gzE63zr6TUlk0oFMXJYz8eY7RIc=;
  b=j/OGgobca2VqR+vQNtVWNoTtWYmcMb5EDQCFrJrENadqbDhuIg2N/d57
   DnMsOPaGTL/e/o4Foq7EhylPJ/SmK8r5fUFER3sPPQQzBzEP9kMCOC1j9
   Qxu4fSoLN3fMKgDBBbXTIsGpE1Ybxe6eJiMUA5d+tQzk+ovG3eyO+TmJi
   9v3ghyGSLxJon1AwuoWkqcETJRBnkRALJiOvDr41aRzbDpLjIEgyheKe8
   BORpQp4RQrGYXgcHc/WwASlFGWpxs4mqdDantdcbn46xlmN939Stda7bx
   TZtAKJXBODDBL+eMgBlf+HSY8gr6C9k3RKh8yaA1qJWeDhP+zkxiUL/o4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="291814749"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="291814749"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 06:15:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="689230414"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="689230414"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga008.fm.intel.com with ESMTP; 11 Oct 2022 06:14:58 -0700
Message-ID: <7c08c4c8-562d-553f-e513-c925080300a7@linux.intel.com>
Date:   Tue, 11 Oct 2022 16:16:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3] xhci-pci: Set runtime PM as default policy on all xHC
 1.2 or later devices
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221010160022.647-1-mario.limonciello@amd.com>
 <Y0T68lC6bUY7dg7D@black.fi.intel.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <Y0T68lC6bUY7dg7D@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.2022 8.11, Mika Westerberg wrote:
> On Mon, Oct 10, 2022 at 11:00:21AM -0500, Mario Limonciello wrote:
>> For optimal power consumption of USB4 routers the XHCI PCIe endpoint
>> used for tunneling must be in D3.  Historically this is accomplished
>> by a long list of PCIe IDs that correspond to these endpoints because
>> the xhci_hcd driver will not default to allowing runtime PM for all
>> devices.
>>
>> As both AMD and Intel have released new products with new XHCI controllers
>> this list continues to grow. In reviewing the XHCI specification v1.2 on
>> page 607 there is already a requirement that the PCI power management
>> states D3hot and D3cold must be supported.
>>
>> In the quirk list, use this to indicate that runtime PM should be allowed
>> on XHCI controllers. The following controllers are known to be xHC 1.2 and
>> dropped explicitly:
>> * AMD Yellow Carp
>> * Intel Alder Lake
>> * Intel Meteor Lake
>> * Intel Raptor Lake
>>
>> Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>> Link: https://www.intel.com/content/dam/www/public/us/en/documents/technical-specifications/extensible-host-controler-interface-usb-xhci.pdf
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks, added to queue

-Mathias
