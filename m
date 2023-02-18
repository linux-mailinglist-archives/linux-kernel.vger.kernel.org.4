Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B697669BB33
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 18:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjBRRUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 12:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBRRUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 12:20:00 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514301557A
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 09:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676740800; x=1708276800;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qt1RHbN1OsrxFRpfecZ66WOgjqfzrX66OcKRGGC/V6o=;
  b=A3Th6DTe6cXGtOPLDqBUkV4IVgrt4ClhJYs2vurRkwz/YFtSJjnz/eDt
   UPr6CLdZZHIy6MnaTjw2NQASAJ8GVTZg6AdTvnKjEni+3Tn51XJdaAwho
   5dGR9+9BpPCcnbOfkC9iKOa5BeKBEJKkhSDlxfrloYF1RfKdL1HdXowQ6
   2ut/CfnjqKPGcDpXbSz25uzgVGJ99RblJlerMLcj27LcPUNpu1nYg79j4
   ftnZu0zh1nLS8Qc3cXDqs8ujWnToEB8bwn2CsIeOq60eYjzNDFDkm5Pgk
   O8zGIHQhqYrSORzm1b0bYwmyce4pvDUWpcWsgPeIxBzY8LdcNdXoCFh08
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="333547899"
X-IronPort-AV: E=Sophos;i="5.97,307,1669104000"; 
   d="scan'208";a="333547899"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 09:19:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="759751696"
X-IronPort-AV: E=Sophos;i="5.97,307,1669104000"; 
   d="scan'208";a="759751696"
Received: from jmakhij-mobl.gar.corp.intel.com (HELO [10.252.133.10]) ([10.252.133.10])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 09:19:58 -0800
Message-ID: <5c98c586-680c-29de-2bd8-f95a7fc7e432@intel.com>
Date:   Sat, 18 Feb 2023 09:19:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/1] x86/topology: fix erroneous smp_num_siblings on Intel
 Hybrid platform
Content-Language: en-US
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc:     "Brown, Len" <len.brown@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhang.jia@linux.alibaba.com" <zhang.jia@linux.alibaba.com>,
        "x86@kernel.org" <x86@kernel.org>
References: <20230217163724.581513-1-rui.zhang@intel.com>
 <20230217163724.581513-2-rui.zhang@intel.com>
 <fcd46e9d-c6d0-4a01-141b-11173602475e@intel.com>
 <a0242c82631b19f3de7a223d8dd38f21308cd3cc.camel@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <a0242c82631b19f3de7a223d8dd38f21308cd3cc.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/23 08:11, Zhang, Rui wrote:
> yes. I totally agree with this.
> 
> But when showing the (cpu topology info and lscpu) problem below, I
> want to deliver a clear message that
> 1. there are two bugs and *both* of them are required in order to
>    trigger the problem
> 2. this patch just fixes one of the bugs

That's fine, but please deliver that message in the cover letter, not
the patch changelog.

> Do you mean that I don't need to mention the x86_max_cores issue here?

Yes.
