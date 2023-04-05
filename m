Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564596D7D3F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238138AbjDENCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238116AbjDENCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:02:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E2661BF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 06:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680699701; x=1712235701;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nEsDOT4c3s2sCRVB0meEsVGfQxGhxGRSvgonugKmZ48=;
  b=etjRcuSQ7vPyfDDR/a09yj7998uWgc6GbJrWaRXWO58opMGJsheff18A
   HKCUGnjAb+ejxmbYGPbISRVQz5hqv1ORzhIby6NN15DZiK02hg6Ug2ReW
   EW6czdLUa2hJLwPoFIIs8/UirfBRh9kmm9VaaCHvMaJPWvaQj/mdtu1e+
   jH6+2qR+hikpsVvLb9e6TnExNFT1pf9d0EVKJ0+DCjuRZSesQ4JmQ5UYX
   p+jdIv2YfybioWJ6zv8kZILGdPlnAZe3vaZ3jz4e/+C1lKeD7E4R6BYcm
   1V6mo2jGOwgvg/WcIm3V1s2o5dhGsMu6WHC61eqqdRty03XKFwHajnOMT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="339935782"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="339935782"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 06:00:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="664030958"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="664030958"
Received: from kyunghyu-mobl2.amr.corp.intel.com (HELO [10.209.6.69]) ([10.209.6.69])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 06:00:46 -0700
Message-ID: <e46777d3-adea-90a2-afc4-35f9d7cef50c@intel.com>
Date:   Wed, 5 Apr 2023 06:00:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 6/6] x86/efi: Safely enable unaccepted memory in UEFI
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
 <bc9e6d82-c7c1-47dc-e91f-57d9b4e2bb0a@intel.com>
 <20230404180917.4fsgkzcdhqvph6io@box.shutemov.name>
 <CAMj1kXF0XyEOuSUDqgsLSYK8GSkGN1xK3RQ525+BxhG+7+vnCA@mail.gmail.com>
 <20230404202445.6qkl7hz67qgievqz@box.shutemov.name>
 <CAMj1kXFrm74+zNcSpHJ1kw38PTMOFk1cTx_EAoGFHaG1fYzRTQ@mail.gmail.com>
 <20230404210153.tll2mojlglx4rfsa@box.shutemov.name>
 <CAMj1kXGvcg-E84h1T_vPi7qxPWxEXBpyuB79KOL+ON7v5YAgJg@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAMj1kXGvcg-E84h1T_vPi7qxPWxEXBpyuB79KOL+ON7v5YAgJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/23 00:46, Ard Biesheuvel wrote:
> Once the firmware stops exposing this protocol (and ceases to accept
> memory on the OS's behalf), we can phase it out from the kernel as
> well.

This is a part of the story that I have doubts about.

How and when do you think this phase-out would happen, realistically?

The firmware will need the unaccepted memory protocol support as long as
there are guests around that need it, right?

People like to keep running old kernels for a _long_ time.  Doesn't that
mean _some_ firmware will need to keep doing this dance for a long time?

As long as there is firmware out there in the wild that people want to
run new kernels on, the support needs to stay in mainline.  It can't be
dropped.
