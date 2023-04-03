Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0216D505A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjDCSaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjDCS36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:29:58 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94E430C1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680546597; x=1712082597;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JHYBbxcGddX0wTVZ59Y7TiSvMqk9yfeulh/16f0QVm8=;
  b=TUw3GIgdkzkavJgwpYUjjXFdHGFXBQwiteVX1ekZ5uPFV5kniEXm/fs3
   1u6gc03OMHltzADuWo5/DRPGHLKNq5+ynXOYYQ13+frljY1tbq64M7Kqu
   bfQtNBEjiXYsoCEHqCl7zOhH8Lvf0iud0BVFdMQia+cWOQx/EFCrDuOln
   bFC2dNDb5BQGhfQpCIRE6fFw6VEcGInTC8qrZPWzgFlOwr5dz8gW+wiXx
   0w593i3W/AUK3EVUiXOGqjOO8uoF0fVW0rWSUDIw26/EYrpGvy8MYv5FT
   c3Lk06elqSPeC+NQajOjsNtA7Xo/84JX4n4eJ7Nj+mRC2PBLcpfWZc0c7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="325994860"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="325994860"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 11:29:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="750580306"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="750580306"
Received: from akleen-mobl3.amr.corp.intel.com (HELO [10.209.21.167]) ([10.209.21.167])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 11:29:56 -0700
Message-ID: <96d44033-3bfd-840b-15d7-80dd3a1a5313@linux.intel.com>
Date:   Mon, 3 Apr 2023 11:29:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] x86: profiling: Using generic unwinding in profile_pc
To:     Chen Zhongjin <chenzhongjin@huawei.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>
References: <20230224021858.120078-1-chenzhongjin@huawei.com>
 <dc0625d2-edaf-22fe-5eea-3088e95a2998@huawei.com>
Content-Language: en-US
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <dc0625d2-edaf-22fe-5eea-3088e95a2998@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/2/2023 6:24 PM, Chen Zhongjin wrote:
> Just ping... Or has profile code already been obsoleted?


I think it would be reasonable to remove the locked functions hack since 
lock profiling can be handled with much better other tools these days.

I wouldn't make it depend on the generic unwinder since such a low level 
facility is likely better off without complex dependencies that could break.

-Andi


