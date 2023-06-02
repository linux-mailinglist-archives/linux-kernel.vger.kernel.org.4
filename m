Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9051D720888
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 19:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbjFBRmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 13:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbjFBRmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:42:35 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD502133;
        Fri,  2 Jun 2023 10:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685727754; x=1717263754;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pKlkspNOzWL1+VLdgFmqTg/cLWhdIZxOrJGpOZ10YD0=;
  b=hWUr5qDOkbD3nEl3i/8qitoQI4jdHYAOqZv4dx2hYsFNZ4VDBgULKYUx
   sCIFk6Y0R1ZHvOOgqnUYXL9BcVMNIV7YEfgLSfjw0Hx6Lkn5inbB1fsK5
   HMOYovmlQt5PkifP8zBZPVGAOtELkPNrA7c0UACa+65l+eWeI/R77EdPb
   NnRVjyyymylz1oPhoV3gYeRpfowEE+H4cd6QCrqtwbUj8qw9zc8mlLKXR
   NONxT8kA68TCTnEKOpLdOFeHk5D5HntUgJqmCayuNTIbxXOjlo2DTZOYC
   DzCDM4aPaFvaj+DAvUPA15O+poF5TMkOgFIuG18H418zAn/7L+KzGmj6I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="336289400"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="336289400"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 10:42:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="702030729"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="702030729"
Received: from pingshi-mobl.amr.corp.intel.com (HELO [10.251.23.169]) ([10.251.23.169])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 10:42:34 -0700
Message-ID: <d73d41cc-0578-7bf3-46a2-b47eea44bdd0@intel.com>
Date:   Fri, 2 Jun 2023 10:42:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv2 2/3] x86/tdx: Fix race between set_memory_encrypted()
 and load_unaligned_zeropad()
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, Dexuan Cui <decui@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20230526120225.31936-1-kirill.shutemov@linux.intel.com>
 <20230526120225.31936-3-kirill.shutemov@linux.intel.com>
 <19d9977f-bf07-2948-1b45-456af9c09e2f@linux.intel.com>
 <20230530005736.ndwza2i5n7wrki5h@box.shutemov.name>
 <9d679d3f-8db9-80ef-292a-9ca5b860579b@amd.com>
 <2d8ae093-dd9e-ea49-d6f9-3fdb2fb84e4d@linux.intel.com>
 <BYAPR21MB1688EF2A57E90FCE02B82F84D748A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <9fbc3760-7239-2323-ed90-210a0de9e286@amd.com>
 <BYAPR21MB168826D6C870542E5BD3372BD74EA@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <BYAPR21MB168826D6C870542E5BD3372BD74EA@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/23 09:11, Michael Kelley (LINUX) wrote:
> Tom -- Does the above sequence *depend* on the hypervisor doing anything
> to make it work?  I'm not clear on why KVM would automatically change the
> page over to private.  If there's a dependency on the hypervisor doing
> something, then it seems like we'll need to standardize that "something"
> across hypervisors, lest we end up with per-hypervisor code in Linux to handle
> this scenario.  And running SEV-SNP with multiple VMPLs probably makes it
> even more complicated.
> 
> Kirill -- Same question about TDX.  Does making load_unaligned_zeropad()
> work in a TDX VM depend on the hypervisor doing anything?  Or is the
> behavior seen by the guest dependent only on architected behavior of
> the TDX processor?

No, there's no active help from the hypervisor here.

Also, fwiw, the "architected behavior" here is really just the TDX
module policy and _arguably_ the hardware Secure-EPT controlled by the
TDX module.
