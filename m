Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083CB683991
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjAaWsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjAaWsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:48:09 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E262A274BC;
        Tue, 31 Jan 2023 14:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675205287; x=1706741287;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s/SDjQxQzEEm/Q6iuxlrqRAomix1+H5xLpivUae6uhw=;
  b=nCLLLK8h+PD8hLgJX/vLeDoJg3a3Gzums6w+f3K+n8O9o9GALorvkzS8
   ZYQH3nAHghfu5zyymcEaJxFql/OqheII1mcrT8iG66KQWvchxSiwwD56w
   TMmJcqP7EPjKRJe8stR0yyPLN2FgBHVzJ3F0PtNaR6SUjbTLe35jQEpui
   xehbKCx2e3e83O7UcPLif3mMkiv6Uf5ADEoITV0GOzLhIaxs0e+3ooNSk
   BqqvoKN38bwFzlTWpwXH5CLLfIlyy/DIoRRIpuEB8KwKtDrk8ZXlBOkMa
   aCuhp+swpMAp331EiXlYy35NhFnQvaZulgRSoB1o8SjpsSh/ZuJH5pG9S
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="390349000"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="390349000"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 14:48:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="773175008"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="773175008"
Received: from bdoolin-mobl1.amr.corp.intel.com (HELO [10.209.125.63]) ([10.209.125.63])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 14:48:06 -0800
Message-ID: <16e3217b-1561-51ea-7514-014e27240402@intel.com>
Date:   Tue, 31 Jan 2023 14:48:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] x86: enable Data Operand Independent Timing Mode
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Roxana Bradescu <roxabee@chromium.org>,
        Adam Langley <agl@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
References: <20230125012801.362496-1-ebiggers@kernel.org>
 <14506678-918f-81e1-2c26-2b347ff50701@intel.com>
 <CAG48ez1NaWarARJj5SBdKKTYFO2MbX7xO75Rk0Q2iK8LX4BwFA@mail.gmail.com>
 <394c92e2-a9aa-37e1-7a34-d7569ac844fd@intel.com>
 <CAG48ez0ZK3pMqkto4DTZPNyddYcv8jPHQDNhYoFEPvSRLf80fQ@mail.gmail.com>
 <e37a17c4-8611-6d1d-85ad-fcd04ff285e1@intel.com> <Y9MAvhQYlOe4l2BM@gmail.com>
 <8b2771ce-9cfa-54cc-de6b-e80ce7af0a93@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <8b2771ce-9cfa-54cc-de6b-e80ce7af0a93@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've been talking about this inside Intel.  Suffice to say that DOITM
was not designed to be turned on all the time.  If software turns it on
all the time, it won't accomplish what it was designed to do.

The _most_ likely thing that's going to happen is that DOITM gets
redefined to be much more limited in scope.  The current DOITM
architecture is very broad, but the implementations have much more
limited effects.  This means that the architecture can probably be
constrained and still match the hardware that's out there today.  That's
pure speculation (ha!) on my part.

I think we should hold off on merging any DOITM patches until the dust
settles.  As far as I know, there is no pressing practical reason to
apply something urgently.

Any objections?
