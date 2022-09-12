Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9325B5C49
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiILOfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiILOfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:35:05 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388E3167EC;
        Mon, 12 Sep 2022 07:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662993303; x=1694529303;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lTQhPuGOrEhsApa+ZuBWBhTU3YqEpPMJQ+ugZRCuVU0=;
  b=hxBYwAm33bKAz7NeCmAAVr/l60jOdSBlR0Bgk7nqk4hS9VFysIJRQqpb
   7AJUuS3Cd35r5jaWSDT/vu1W499G02lqWBtaRZ0fkA/sriv0yEGaulauj
   AN15XzJIg54Ab6ch8KKsnQJrK/4r6z5BUQ5ykfFz6i1eP/I8wYHxw3XjA
   VNR4Je5rqBaz4exgVTU5TqeN368I0ttBdFM5fSBerkUQp1a1LA89B/yTj
   0QHF+c5/G0VXeymqnIYEVe2f6sDHbgWiPb+1vP4WVWkx44l7lIvD7Dh3+
   DLYf5JG4Eags27wkQyOTRehuHBGmsMGY5u5AUGHk46vaJvldexoupdJQi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="384175166"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="384175166"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 07:34:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="646480527"
Received: from jmwalsh-mobl.amr.corp.intel.com (HELO [10.213.220.208]) ([10.213.220.208])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 07:34:35 -0700
Message-ID: <28d7a4bf-591f-3afa-b9ea-526a14abc587@intel.com>
Date:   Mon, 12 Sep 2022 07:34:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/intel: Clear SGX bit if both SGX driver and KVM SGX
 are not enabled
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kai Huang <kai.huang@intel.com>
Cc:     linux-sgx@vger.kernel.org, dave.hansen@linux.intel.com,
        seanjc@google.com, linux-kernel@vger.kernel.org
References: <20220909080853.547058-1-kai.huang@intel.com>
 <Yx8OTDwhqbgvGp4p@kernel.org>
 <ce358ac4-a473-158c-ccce-c50af813fb6d@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ce358ac4-a473-158c-ccce-c50af813fb6d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/22 07:31, Reinette Chatre wrote:
> 
> On 9/12/2022 3:47 AM, Jarkko Sakkinen wrote:
>> On Fri, Sep 09, 2022 at 08:08:53PM +1200, Kai Huang wrote:
>>> Currently on platform which has SGX enabled, if CONFIG_X86_SGX is not
>>> enabled, the X86_FEATURE_SGX is not cleared, resulting in /proc/cpuinfo
>>> shows "sgx" feature.  This is not desired.
>>>
>>> Clear SGX feature bit if both SGX driver and KVM SGX are not enabled in
>>> init_ia32_feat_ctl().
>>>
>>> Signed-off-by: Kai Huang <kai.huang@intel.com>
>> Is it a pattern that flags are cleared when they are disabled by the
>> kernel? I don't know the answer for this.

There's no good pattern.

But, one guideline is that the X86_FEATURE_*'s are for the *kernel*.
They are *not* for userspace.  The fact that the features are exposed to
userspace in cpuinfo is unfortunate, but it doesn't change our guideline.

So, if this patch is done only for the benefit of userspace, I don't
think we should apply it.
