Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AFD632BAC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 19:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiKUSBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 13:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiKUSBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 13:01:09 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2112014095;
        Mon, 21 Nov 2022 10:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669053665; x=1700589665;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k6/eLSPB+iMLB76eCgiF5UKnnzVZJqpZbnIt3RtAOrc=;
  b=FbaRj4W8Nr4XZagcwIqxFS/sZrKHnPEN54YCPGWtvm3EzUla1sF6i/Iq
   ctJZS/Mq+VHcmZhVF35aJwS2mZz1nY5DUr7Npe/9WrzFXOOf4IICGQiWv
   1HIvru0B6Xe1NEW7vkgi88/Wsur7mEFlcY2sFH7ctQJ1CTsXBGYg62SJX
   I6CrxWygetwOFXt23agRVf6apN6g72i+mRj8DOjTfyvMVPZEd3b9FXduj
   rUElSCEDexiRk5505kE+0v2pJ451wWnhBB/eJRQCPQ/jlPrqPKUNML80V
   cnr+BIjlM4a8x8TJqdh7/SH4AbreTkOvfySAiCRqJCcHRkpDbbS3lCCTl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="312324683"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="312324683"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 10:01:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="709900214"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="709900214"
Received: from gkammela-mobl.amr.corp.intel.com (HELO [10.212.164.188]) ([10.212.164.188])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 10:01:02 -0800
Message-ID: <1e08361f-74f8-15a6-e22b-9215d61ec6bd@linux.intel.com>
Date:   Mon, 21 Nov 2022 10:00:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v1 0/8] Redesign the pmc core driver
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     irenic.rajneesh@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        sukumar.ghorai@intel.com, xi.pardee@intel.com,
        rajvi.jingar@intel.com,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        David E Box <david.e.box@linux.intel.com>
References: <20221114183257.2067662-1-gayatri.kammela@linux.intel.com>
 <2a3f8cc5-4c6e-7bb9-5a09-1dc20929271e@redhat.com>
Content-Language: en-US
From:   "Kammela, Gayatri" <gayatri.kammela@linux.intel.com>
In-Reply-To: <2a3f8cc5-4c6e-7bb9-5a09-1dc20929271e@redhat.com>
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

On 11/21/2022 1:44 AM, Hans de Goede wrote:

> Hi,
>
> On 11/14/22 19:32, Gayatri Kammela wrote:
>> This patch series focuses on redesigning the PMC core driver for
>> maintainability and readability. Moving PCH specific structures and
>> functions to separate c files, simplifies core.c file and makes it
>> easier to add new platforms in future. The series includes two
>> preparatory patches that lays the ground work for the redesign. The
>> patch series also adds legacy support for Meteor Lake.
>>
>> This redesign adds following c files to support different PCHs. There
>> are no functional changes involved for the already supported platforms.
>>
>> spt.c: Sunrise Point PCH supports: Sky Lake, Sky Lake L, Kaby Lake,
>> Kaby Lake L
>> cnp.c: Cannon Lake Point PCH supports: Cannon Lake L, Comet Lake,
>> Comet Lake L
>> icl.c: Ice Lake PCH supports: Ice Lake L, Ice Lake NNPI, Jasper Lake
>> tgl.c: Tiger Lake PCH supports: Tiger Lake, Tiger Lake L, Alder Lake L,
>> Alder Lake N, Rocket Lake, Raptor Lake P, Elkhart Lake
>> adl.c: Alder Lake PCH supports: Alder Lake, Raptor Lake, Raptor Lake S
>> mtl.c: Meteor Lake PCH supports: Meteor Lake
>>
>> Patch 1: platform/x86: intel/pmc: Replace all the reg_map with init
>> functions
>> Patch 2: platform/x86: intel/pmc: Move variable declarations and
>> definitions to header and core.c
>> Patch 3: platform/x86: intel/pmc: Relocate Sunrise Point PCH support
>> Patch 4: platform/x86: intel/pmc: Relocate Cannon Lake Point PCH
>> support
>> Patch 5: platform/x86: intel/pmc: Relocate Ice Lake PCH support
>> Patch 6: platform/x86: intel/pmc: Relocate Tiger Lake PCH support
>> Patch 7: platform/x86: intel/pmc: Relocate Alder Lake PCH support
>> Patch 8: platform/x86: intel/pmc: Add Meteor Lake support to pmc core
>> driver
> Thank you for your patch-series, I've applied the series to my
> review-hans branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
>
> Note it will show up in my review-hans branch once I've pushed my
> local branch there, which might take a while.
>
> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.
>
> Regards,
>
> Hans
Thank you Hans!
>
>
>
>
>
>> Gayatri Kammela (4):
>>    platform/x86: intel/pmc: Replace all the reg_map with init functions
>>    platform/x86: intel/pmc: Relocate Tiger Lake PCH support
>>    platform/x86: intel/pmc: Relocate Alder Lake PCH support
>>    platform/x86: intel/pmc/core: Add Meteor Lake support to pmc core
>>      driver
>>
>> Rajvi Jingar (1):
>>    platform/x86: intel/pmc: Relocate Sunrise Point PCH support
>>
>> Xi Pardee (3):
>>    platform/x86: intel/pmc: Move variable declarations and definitions to
>>      header and core.c
>>    platform/x86: intel/pmc: Relocate Cannon Lake Point PCH support
>>    platform/x86: intel/pmc: Relocate Ice Lake PCH support
>>
>>   drivers/platform/x86/intel/pmc/Makefile |   3 +-
>>   drivers/platform/x86/intel/pmc/adl.c    | 325 ++++++++
>>   drivers/platform/x86/intel/pmc/cnp.c    | 210 +++++
>>   drivers/platform/x86/intel/pmc/core.c   | 994 ++----------------------
>>   drivers/platform/x86/intel/pmc/core.h   |  89 ++-
>>   drivers/platform/x86/intel/pmc/icl.c    |  56 ++
>>   drivers/platform/x86/intel/pmc/mtl.c    |  52 ++
>>   drivers/platform/x86/intel/pmc/spt.c    | 140 ++++
>>   drivers/platform/x86/intel/pmc/tgl.c    | 269 +++++++
>>   9 files changed, 1183 insertions(+), 955 deletions(-)
>>   create mode 100644 drivers/platform/x86/intel/pmc/adl.c
>>   create mode 100644 drivers/platform/x86/intel/pmc/cnp.c
>>   create mode 100644 drivers/platform/x86/intel/pmc/icl.c
>>   create mode 100644 drivers/platform/x86/intel/pmc/mtl.c
>>   create mode 100644 drivers/platform/x86/intel/pmc/spt.c
>>   create mode 100644 drivers/platform/x86/intel/pmc/tgl.c
>>
>>
>> base-commit: 309e0a6ed6e3fdb4febacc3e91aeb268500b90c6
>>
>> Cc: Xi Pardee <xi.pardee@intel.com>
>> Cc: Rajvi Jingar <rajvi.jingar@linux.intel.com>
>> Cc: David E Box <david.e.box@linux.intel.com>
