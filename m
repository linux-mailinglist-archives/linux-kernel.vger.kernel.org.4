Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC69973A2E0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjFVOSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjFVOSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:18:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2141510F6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687443515; x=1718979515;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UKEe/b4TDo1CLNfS/S1pNSMwV3IdLaBKSn31vLe1Eyc=;
  b=j3HirR68KZz0xD0774+L91QzkgbXm8VZrjFg9PStud5dMby7j8Y7z7zV
   hBSMcNZsrAu3c20LGN0/ycNjbaiiRIl0TtJLS480wTmdOS6ZFB85ns8qx
   l/K5uFK0JL+XbR2qmz1qZJNsg9y83nlQps5eYr5ZNHga6uLF4Hltptrza
   gSNfTZuMI++5GyCkg09tE4zWMwWgxuIJ5oyaMoyScFrLrCPAzbnd3xU2s
   efZe8inxOzXlqJt80mde7N2kKIi6AZpl2sFpZIvzHYLdFEsUL3F2SUUun
   hIqB8apd9s5f/93qpdbO2C/+rThajBkU8heczhwHbAzWqnivZnkexjY9Q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="426464612"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="426464612"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 06:42:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="839060881"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="839060881"
Received: from pajgaonk-mobl1.amr.corp.intel.com (HELO [10.212.235.136]) ([10.212.235.136])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 06:42:15 -0700
Message-ID: <bd4ce33f-9877-4256-483d-0bbc72b1580f@intel.com>
Date:   Thu, 22 Jun 2023 06:42:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] x86/bugs: Break down mitigations configurations
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Breno Leitao <leitao@debian.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, leit@fb.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20230616164851.2559415-1-leitao@debian.org>
 <20230621001327.qdyebewnx7r5aiy3@desk> <ZJMdKUr98H8zPSAl@gmail.com>
 <20230621173135.wiprtgzslhw5z5or@desk> <ZJNDRSUZuZ2L+pwo@gmail.com>
 <20230621194101.bmwesljror2yqjxx@desk>
 <d9bc78ed-1f05-47db-e916-d4d8bc76634e@intel.com> <ZJN/SGwvOBZmChJw@gmail.com>
 <0c908258-2b03-ebb3-bc7d-af5ea66479d4@intel.com>
 <20230622124238.GAZJRBvrJdWloWzy0D@fat_crate.local>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230622124238.GAZJRBvrJdWloWzy0D@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/23 05:42, Borislav Petkov wrote:
> On Wed, Jun 21, 2023 at 03:58:10PM -0700, Dave Hansen wrote:
>> Do you like the direction this is going?  Maybe I'm missing something.
> Yeah, see
> 
> f43b9876e857 ("x86/retbleed: Add fine grained Kconfig knobs")
> 
> AFAIR, Linus wanted those this way so the only logical next step is to
> add the Kconfig knobs for the missing ones...

Makes sense.  Thanks.
