Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5B864C057
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbiLMXRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbiLMXRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:17:04 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015C7654B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670973424; x=1702509424;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h+DzqhlFrgg17qtACPb6XXF/U+neyYFLDo+kd4/I+o8=;
  b=dbODmfnHf1jSaYXeGJH142u3T7dUj3O6+6khzRLGSO3Lefgx0NKPVkpJ
   r/7bT3Rux/iSvukdHbFT4EtpYTQJj9Dy+0tdynZGywkJF9UPYbLAsnS0u
   cFJ07IRJWFRiK2cbWaUTApX0XoMNU1vbnZgUIlOZHFShRCOfH1Z+OvaqG
   NMzlww3FIBUl0lyP1ra6BXBpW2CE/uDiFdSi8jrofj0xjJzbjEBLnKDVQ
   0DU8tzrLCDM9jkJPkiOP7DqeSl9VwNS3i3fyG0Q8A9sl5sSD2Egmz5zcA
   kmkxUHPN8VPg4++wCMkyqZDKICIU3EnRmgcF869mON9PfGis6O6oKaO+x
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="316962534"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="316962534"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 15:17:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="773124263"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="773124263"
Received: from snjones-mobl1.amr.corp.intel.com (HELO [10.212.218.27]) ([10.212.218.27])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 15:17:03 -0800
Message-ID: <6eed73b1-adee-caf7-e02f-4d2b08f1aefe@intel.com>
Date:   Tue, 13 Dec 2022 15:17:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/4] x86/tdx: Disable NOTIFY_ENABLES
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221209132524.20200-1-kirill.shutemov@linux.intel.com>
 <20221209132524.20200-5-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221209132524.20200-5-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/22 05:25, Kirill A. Shutemov wrote:
> == Background ==
> 
> There is a class of side-channel attacks against SGX enclaves called
> "SGX Step"[1]. These attacks create lots of exceptions inside of
> enclaves. Basically, run an in-enclave instruction, cause an exception.
> Over and over.
> 
> There is a concern that a VMM could attack a TDX guest in the same way
> by causing lots of #VE's. The TDX architecture includes new
> countermeasures for these attacks. It basically counts the number of
> exceptions and can send another *special* exception once the number of
> VMM-induced #VE's hits a critical threshold[2].
> 
> == Problem ==
> 
> But, these special exceptions are independent of any action that the
> guest takes. They can occur anywhere that the guest executes. This
> includes sensitive areas like the entry code. The (non-paranoid) #VE
> handler is incapable of handling exceptions in these areas.
> 
> == Solution ==
> 
> Fortunately, the special exceptions can be disabled by the guest via
> write to NOTIFY_ENABLES TDCS field. NOTIFY_ENABLES is disabled by
> default, but might be enabled by a bootloader, firmware or an earlier
> kernel before the current kernel runs.
> 
> Disable NOTIFY_ENABLES feature explicitly and unconditionally. Any
> NOTIFY_ENABLES-based #VE's that occur before this point will end up
> in the early #VE exception handler and die due to unexpected exit
> reason.
> 
> [1] https://github.com/jovanbulck/sgx-step
> [2] https://intel.github.io/ccc-linux-guest-hardening-docs/security-spec.html#safety-against-ve-in-kernel-code
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Dave Hansen <dave.hansen@intel.com>
