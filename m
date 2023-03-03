Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580916AA119
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 22:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjCCVZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 16:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjCCVZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 16:25:15 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96186230C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 13:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677878706; x=1709414706;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YMZDRR+PM05c4rv4SQCyz2WYSDg/ciTluk55719hYjc=;
  b=BgooRcUc/yyIkM+WljK8BQDfiidm8Pb3WASNpgWLdjj3O/iO4M5iRqL3
   WXccUUrNaWK8pGztnKRqJflC5Am5oFMygfBjUANEDymoLFHymML3N0FaJ
   3f1vxkr6JoOBm4BClije3m6vVCxpsAJCDJLgzy9ZenjCpU35sNV5AOBt5
   MeFktKW0ffxuH05FL4CqYAxxx0xgAhfKHGNtH3z+lFY/Cb7H2NOcPY7vL
   DtRi4oXLCrtP7AqnGNcMXm6Sy4/eprNGNi3DYQ/xGtqDQwTS0u6xg9v1+
   jVSZL2if95Udqm4aOtfmELqXipEUyog/pUHlR3N8ph9XBtX13cN/t96fN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="362759554"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="362759554"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 13:24:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="785429320"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="785429320"
Received: from ctretbar-mobl.amr.corp.intel.com (HELO [10.212.170.209]) ([10.212.170.209])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 13:24:54 -0800
Message-ID: <addc0715-7b75-59d3-fe82-dcfd6a7ef81a@intel.com>
Date:   Fri, 3 Mar 2023 13:24:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] x86/mm: Do not shuffle CPU entry areas without KASLR
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230303160645.3594-1-mkoutny@suse.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230303160645.3594-1-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/23 08:06, Michal Koutný wrote:
> @@ -29,6 +30,12 @@ static __init void init_cea_offsets(void)
>  	unsigned int max_cea;
>  	unsigned int i, j;
>  
> +	if (!kaslr_memory_enabled()) {
> +		for_each_possible_cpu(i)
> +			per_cpu(_cea_offset, i) = i;
> +		return;
> +	}

Should this be kaslr_memory_enabled() or kaslr_enabled()?

The delta seems to be CONFIG_KASAN, and the cpu entry area randomization
works just fine with KASAN after some recent fixes.  I _think_ that
makes cpu entry area randomization more like module randomization which
would point toward kaslr_enabled().

