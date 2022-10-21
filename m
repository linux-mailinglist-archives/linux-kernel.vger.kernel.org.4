Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D02B607C11
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiJUQVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJUQVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:21:33 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0F3285989
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666369290; x=1697905290;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dK40dK+lY5TVBGw0yofnjsJSl6P3SbdlFMTcnDB5Fbs=;
  b=MgDKJWC54eCXpcLHnlJFRXEPnfDJdiKt/sVqGdQxsAyL2UHdjbXLYAlJ
   8uDviWk9Uj4vWZn62pVadxyGZO2rAQGV0S2o6yORzKIqKzKNhW6xiTbCo
   8Z9u63Co0uRVt/GuyGaFFNk8Q9YIEnDIEFRcBXya9Eo9EfeS+56EQ00uO
   2xiYB7TBa/az1p7AbsTdVUZAsPyWXg4AOPZ7N/B767tKz8WG+otemm7jC
   1IVcE0dhBii6XoPrVHS+zwdl42wTi09tb5vIhFp/0npTk8577gHSOWosz
   +ZSepwmHBm23SgCDLGQmlp945tAVvigOiai8+8mngBN1ce3at27sYELEI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="369088707"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="369088707"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 09:21:03 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="581654411"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="581654411"
Received: from thnguy1-mobl2.amr.corp.intel.com (HELO [10.209.91.210]) ([10.209.91.210])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 09:21:02 -0700
Message-ID: <63dca468-c94d-844a-5b19-09c03cf84911@intel.com>
Date:   Fri, 21 Oct 2022 09:21:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v1 1/2] x86/tsc: use logical_package as a better
 estimation of socket numbers
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tim.c.chen@intel.com, Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        liaoyu15@huawei.com
References: <20221021062131.1826810-1-feng.tang@intel.com>
 <f27e4b3f858890c657df9a7d6f34dc2d60b89757.camel@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <f27e4b3f858890c657df9a7d6f34dc2d60b89757.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 08:00, Zhang Rui wrote:
> I checked the history of '__max_logical_packages', and realized that
> 
> 1. for topology_max_packages()/'__max_logical_packages', the divisor
>    'ncpus' uses cpu_data(0).booted_cores, which is based on the
>    *online* CPUs. So when using kernel cmdlines like maxcpus=/nr_cpus=,
>    '__max_logical_packages' can get over-estimated.
> 
> 2. for 'logical_packages', it equals the number of different physical
>    Package IDs for all *online* CPUs. So with kernel cmdlines like
>    nr_cpus=/maxcpus=, it can gets under-estimated.
> 
> BTW, I also checked CPUID.B/1F, which can tell a fixed number of CPUs
> within a package. But we don't have a fixed number of total CPUs from
> hardware.
> On my Dell laptop, BIOS allows me to disable/enable one or several
> cores. When this happens, the 'total_cpus' changes, but CPUID.B/1F does
> not change. So I don't think CPUID.B/1F can be used to optimize the '__
> max_logical_packages' calculation.
> 
> I'm not sure if we have a perfect solution here.

Are the implementations fixable?  Or, at least tolerable?

For instance, I can live with the implementation being a bit goofy when
kernel commandlines are in play.  We can pr_info() about those cases.
