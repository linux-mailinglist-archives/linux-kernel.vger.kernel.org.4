Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3820D6BECC0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjCQPRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjCQPRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:17:49 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB2F2A9B0;
        Fri, 17 Mar 2023 08:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679066256; x=1710602256;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/yif/JaC6+wmaldStjTz5ro1dksBj0JAbToG9uiLr9c=;
  b=BVV+EYj6ExuREnllZa0c5gbcl2zhEtr0p9YZU6LbqhN3ufJ9yxsWi/PE
   yw1lOYTnly4tpS29CuonAkEcNm4TwIpyrcmXnTRdDWQUErfoFQOZ+Gmwt
   s90Nm0+jZSOz87kfbOhsRcJGYkIVqBJKqaAy+8bYzc60X4zaDI9mYppM5
   n5ofwVvfGKZv3fukr09h4oTdPBPs12WFmzcqM1pvCfy8V+pJJoO1AA2pZ
   vrlDilRwKFvndPc68XzlawTzAnlq6QpKYZQyon2sNO2twofwV6uyQcruy
   pifGFJltfKq6iOpNjo1g4gCi3UygN3+CKLT8NI9aGOEpgNrp96j6CGeug
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="400859586"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="400859586"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 08:17:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="749284659"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="749284659"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga004.fm.intel.com with ESMTP; 17 Mar 2023 08:17:34 -0700
Message-ID: <d6be3f68-b61d-c830-5d0d-631fb05bb00e@linux.intel.com>
Date:   Fri, 17 Mar 2023 17:18:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH RESEND] xhci: also avoid the XHCI_ZERO_64B_REGS quirk with
 a passthrough iommu
To:     Marc Zyngier <maz@kernel.org>,
        D Scott Phillips <scott@os.amperecomputing.com>
Cc:     linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20230315181440.1478259-1-scott@os.amperecomputing.com>
 <86bkktxdpy.wl-maz@kernel.org>
Content-Language: en-US
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <86bkktxdpy.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.3.2023 11.11, Marc Zyngier wrote:
> On Wed, 15 Mar 2023 18:14:40 +0000,
> D Scott Phillips <scott@os.amperecomputing.com> wrote:
>>
>> Previously the quirk was skipped when no iommu was present. The same
>> rationale for skipping the quirk also applies in the iommu.passthrough=1
>> case.
>>
>> Skip applying the XHCI_ZERO_64B_REGS quirk if the device's iommu domain is
>> passthrough.
>>
>> Fixes: 12de0a35c996 ("xhci: Add quirk to zero 64bit registers on Renesas PCIe controllers")
>> Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> 
> 	M.

Thanks, adding to queue

-Mathias
  

