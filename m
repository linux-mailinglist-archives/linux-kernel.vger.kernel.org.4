Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08776D6AFF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbjDDR55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjDDR5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:57:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBFB173E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680631074; x=1712167074;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yb17VqhY2itSWHQvleEg2FshNonzyB9h186iH0BpvkU=;
  b=H97t9Pe4c2iQ8v6N46DLo4fALRvBVos8E4AIO84XHona6ghVpxJx+1XV
   D186Rpf8iff0mBC2SXl/SC1pc6TflpCZBXLfSkA2UW0PfUgUSam4aAHjR
   JLFM0XdyIewI80sNUMkhWR4uaGE6Bf94WZDLzTNcpLuC6ayN69+hqkuPN
   gw6ooSgafPAQnwq6lifqIMk6tsOEPxOyevK6alno+YgnXoHkkW1ZYEt1I
   iEVuwBVb0AIlKfBb/79zWR1xDNcXzoZ2zS7747+Gpb2xsVYl/YQ9n3HEG
   aGp2xivs6QwZXkWAUaVmKYtB/i04A3pRIJD2nW2RugMXhfZEM+ktKDDTa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="344832446"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="344832446"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 10:57:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="719030804"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="719030804"
Received: from jshresth-mobl1.amr.corp.intel.com (HELO [10.209.62.86]) ([10.209.62.86])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 10:57:53 -0700
Message-ID: <bc9e6d82-c7c1-47dc-e91f-57d9b4e2bb0a@intel.com>
Date:   Tue, 4 Apr 2023 10:57:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 6/6] x86/efi: Safely enable unaccepted memory in UEFI
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biescheuvel <ardb@kernel.org>,
        "Min M. Xu" <min.m.xu@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jiewen Yao <jiewen.yao@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
 <cover.1680628986.git.thomas.lendacky@amd.com>
 <1d38d28c2731075d66ac65b56b813a138900f638.1680628986.git.thomas.lendacky@amd.com>
 <20230404174506.pjdikxvk2fsyy4au@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230404174506.pjdikxvk2fsyy4au@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/23 10:45, Kirill A. Shutemov wrote:
> I still think it is a bad idea.
> 
> As I asked before, please include my
> 
> Nacked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> into the patch.

I was pretty opposed to this when I first saw it too.  But, Tom and
company have worn down my opposition a bit.

The fact is that we have upstream kernels out there with SEV-SNP support
that don't know anything about unaccepted memory.  They're either
relegated to using the pre-accepted memory (4GB??) or _some_ entity
needs to accept the memory.  That entity obviously can't be the kernel
unless we backport unaccepted memory support.

This both lets the BIOS be the page-accepting entity _and_ allows the
entity to delegate that to the kernel when it needs to.

As much as I want to nak this and pretend that that those existing
kernel's don't exist, my powers of self-delusion do have their limits.

If our AMD friends don't do this, what is their alternative?
