Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2F56A877D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 18:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCBRCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 12:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjCBRCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 12:02:17 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B781498A3;
        Thu,  2 Mar 2023 09:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677776536; x=1709312536;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K8UfcyDULSxs+JLejDBokny3OpEjfLTcJdJQurDsg1A=;
  b=cNG2g3sSJ8rm/j6PMX9gaCcshQs7DEsXA454kemqmFsaQTzplmb/rbRP
   5ejqu3m62LSoE83WV1dt9sai4VqTsyyYCdFoaDiw5iIUKreq4V01qV7Tz
   9NspUhSDX2c+5mldNDp1gppDFCdASKXU7Fni8ejLlztHhNxr6vUJwwpj1
   uDSurBzpY5QiKMLlFvA9SXjkOg/zjesLoMv25qpgVdrLhJAx3hvPXEuwh
   pHE3pHzQEy0CFosCXJgp2oP8qtKT/b4IsJ4Awctr6HaRlEHONTTZD/oqU
   tkf0fX7u0ixkVTBPyQlrb4qamH9/MX9b7pQnNyHRpex/iOx8bxS0/IRpo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="318601677"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="318601677"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 09:02:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="1004188522"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="1004188522"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.30.53]) ([10.212.30.53])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 09:02:14 -0800
Message-ID: <e17d59b0-ac81-8c7a-be0b-40eb419193c6@intel.com>
Date:   Thu, 2 Mar 2023 10:02:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] cxl/hdm: Fix hdm decoder init by adding COMMIT field
 check
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Fan Ni <fan.ni@samsung.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20230228224029uscas1p1e2fb92a8a595f80fa2985b452899d785@uscas1p1.samsung.com>
 <20230228224014.1402545-1-fan.ni@samsung.com>
 <346a8225-609e-0188-ec8a-4abe8d271a09@intel.com>
 <20230302062305.GA1444578@bgt-140510-bm03>
 <e10b60ab-f666-8124-eb8f-6a2da6c0f989@intel.com>
 <20230302162838.euflpp5luvkqcc7f@offworld>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230302162838.euflpp5luvkqcc7f@offworld>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/2/23 9:28 AM, Davidlohr Bueso wrote:
> On Thu, 02 Mar 2023, Dave Jiang wrote:
> 
>> It does sound like a bug with QEMU emulation currently.
> 
> Agreed, but still, crashing the kernel is always a no no - like with
> the passthrough decoder situation we had.

I wonder if we are missing a check in cxl_decoder_commit() to exit if 
COMMITTED bit is set in register. The current code just blindly start 
programming the registers.

> 
> Thanks,
> Davidlohr
