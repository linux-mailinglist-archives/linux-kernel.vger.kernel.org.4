Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27677159AF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjE3JPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjE3JPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:15:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519E0CD;
        Tue, 30 May 2023 02:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685438115; x=1716974115;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ht5FlU3n6y7nFuAmHBrSvsNrWfyhEwrb7dbJw+ZY6no=;
  b=FCmN+a6+E/r6afHE4cYsPSBkwFNFv8gGllmZJZhOOq3ZLW9gaOorYrCk
   9YiiZcEF0jrF2NPNs5nmdw4wJntn5Udx8SVQcl9gjYNt80bwgsssqNCIt
   3biam7ONBZCKKFaUxOFZBzZLZIzYtvYF3wTjEcNII1Bes8FlnaqxhF8uW
   9+dRS5bX3BPaj+RtMnEhHcCAQax6t/yCbOBGqGip/8RJIDa3sOYAsb9ZT
   wwlIE3UE1GL8LtSAAlSBmSKzTyiAAudTHDZf17xcaW8CXsmkV1Q3nlm5n
   KwCGKGDDkJj1jMyDE6nHpII929fYH5HfvKHBCn2uWdX+ro7wjSbC5AkbC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="352361799"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="352361799"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 02:15:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="796199877"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="796199877"
Received: from rajatkha-mobl.gar.corp.intel.com (HELO [10.67.146.41]) ([10.67.146.41])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 02:15:06 -0700
Message-ID: <0367a134-cb04-8a1c-bb46-bb5553df6f8a@linux.intel.com>
Date:   Tue, 30 May 2023 14:45:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5] usb: typec: intel_pmc_mux: Expose IOM port status to
 debugfs
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230524104754.4154013-1-rajat.khandelwal@linux.intel.com>
 <2023052917-juicy-calamity-4b35@gregkh>
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
In-Reply-To: <2023052917-juicy-calamity-4b35@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/29/2023 7:48 PM, Greg KH wrote:
> On Wed, May 24, 2023 at 04:17:54PM +0530, Rajat Khandelwal wrote:
>> IOM status has a crucial role during debugging to check the
>> current state of the type-C port.
>> There are ways to fetch the status, but all those require the
>> IOM port status offset, which could change with platform.
>>
>> Make a debugfs directory for intel_pmc_mux and expose the status
>> under it per port basis.
>>
>> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
>> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Does not apply to my tree :(

I have pushed the patch on top of the Linus's tree.
Had a quick check with the USB Linux tree and seems like its a lot
behind?
Can you please confirm once and come back?

Thanks
Rajat

