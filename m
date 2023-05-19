Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3658708D08
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjESAnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjESAnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:43:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCA3BC;
        Thu, 18 May 2023 17:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684457000; x=1715993000;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8/K+FKtfU5ptt8CUslFmSHuuIq82VJWzkwwU9cWQ8sQ=;
  b=Pm6bQBXebQA3dOr8L8EtO9iHBJhCYl0+gImN/gm1mnYujKuNei1rjVdt
   tmO4/fSUcrYPt/tgmaWIG9JWESDF4v1rXoIxbrGPlOHbbtlXmUHmeMtE+
   GQQpW+pFmzltfVq3n0tl0pOwG6371iReTlwQdYoxXeR1kwW3irdEHDdt4
   CulixJAYQOnghk8TnDh6Im18x2ip6KthK04Fx5EmYvjHDPXk6n66BKXpy
   2GTKWjyq2fFEW2TkeAkR+momBKk8T5cG4JxlDTjfLHlN9efAC/a7GRG/N
   Qfks2+mf/CXvQWhwXImgIKGvDZQ/p7HryqnrgG6b3ZN5iLYGVhtWR3tyv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="380446268"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="380446268"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 17:43:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="792155452"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="792155452"
Received: from mkim1-mobl.amr.corp.intel.com (HELO [10.209.118.171]) ([10.209.118.171])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 17:43:15 -0700
Message-ID: <f2467d69-882b-3439-b082-bcaf591a9892@intel.com>
Date:   Thu, 18 May 2023 17:43:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] x86/numa: Introduce numa_fill_memblks()
Content-Language: en-US
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>, x86@kernel.org,
        linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1684448934.git.alison.schofield@intel.com>
 <e365f4dfa7fa974118eb4e59aebc7cc423cf19a1.1684448934.git.alison.schofield@intel.com>
 <8dc725c8-613a-b51b-6cc1-80d2275ca130@intel.com>
 <ZGbCG4gRGow0VCmQ@aschofie-mobl2>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ZGbCG4gRGow0VCmQ@aschofie-mobl2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/23 17:26, Alison Schofield wrote:
> On Thu, May 18, 2023 at 05:08:16PM -0700, Dave Hansen wrote:
>> On 5/18/23 17:04, alison.schofield@intel.com wrote:
>>> The initial use case is the ACPI driver that needs to extend
>>> SRAT defined proximity domains to an entire CXL CFMWS Window[1].
>>
>> Dumb question time: Why didn't the SRAT just cover this sucker in the
>> first place?  Are we fixing up a BIOS bug or is there a legitimate
>> reason that the SRAT didn't cover it up front?
>>
> There is no requirement that the BIOS describe (in the SRAT) all the
> HPA assigned to a CFMWS Window. The HPA range may not actually map to
> any memory at boot time. It can be persistent capacity or may be there
> to enable hot-plug. IIUC BIOS can pick and choose and define volatile
> regions wherever it pleases.

I understand that it _can_ do this.  I'm trying to get to the reasoning
of why.

Is this essentially so that the physical address space doesn't have to
be *committed* to a single use up front?  For RAM, I guess this wasn't a
problem because there was only a finite amount of RAM that could get
hotplugged into a single node.

But with these fancy schmancy new devices, it's really hard to figure
out how much space will show up and what performance it will have until
you actually start poking at it.  The firmware wasn't _quite_ sure how
it wanted to burn the physical address space at the time the SRAT was
created.  But, now it knows, and this is handling the case where the
firmware only expands an adjacent chunk of physical address space.

Close?
