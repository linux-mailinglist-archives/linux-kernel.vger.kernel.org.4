Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B016D836A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjDEQQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjDEQQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:16:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AF66187
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 09:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680711322; x=1712247322;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nmRCAz1HCRY9TC9EnRfgOrfkIWg8/5cMsJF1iYZbSGI=;
  b=JA9uOR9feTqLInqzX0f5AsqJ50BR3nnEJt88wHfp+BZLUT0FUSWQhKeF
   0+iiJgOsC6Dz0YUgEGoeJaMYsGTtl4Ot5XMSuOprh6o3wN+BIDcYdx+ff
   2Bq6cbH/+aCDNaa0sEtgYnKORMsxy4MX/Wkkfg0ACoKaA09YpnYOssx/E
   QqAZAMQK5iZzOP9rcqp5EjmqDtbbEthNUnC7CE36D/FRUfP4/wLqjFj4g
   ZBH4YbPMG13FW8bkI/zu0C5PeqG42tdLE7VXcUseqQ20M9yRfvhTDfs92
   EqY9xX9FUWOqyGlHbnKeh/3jBkWmTbrLfvMBRTTk2PC6QSRhiO5eymCyo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="331101857"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="331101857"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 09:15:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="1016531293"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="1016531293"
Received: from kyunghyu-mobl2.amr.corp.intel.com (HELO [10.209.6.69]) ([10.209.6.69])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 09:15:15 -0700
Message-ID: <969a3d2a-52e7-e60e-5de6-c550c548730d@intel.com>
Date:   Wed, 5 Apr 2023 09:15:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 6/6] x86/efi: Safely enable unaccepted memory in UEFI
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Tom Lendacky <thomas.lendacky@amd.com>,
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
 <e46777d3-adea-90a2-afc4-35f9d7cef50c@intel.com>
 <CAMj1kXEDYa5YcRj7t9JJmQ21+ierue2q6ADOXUOMjoOGndGRug@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAMj1kXEDYa5YcRj7t9JJmQ21+ierue2q6ADOXUOMjoOGndGRug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/23 06:44, Ard Biesheuvel wrote:
> Given that the intent here is to retain compatibility with
> unenlightened workloads (i.e., which do not upgrade their kernels), I
> think it is perfectly reasonable to drop this from mainline at some
> point.

OK, so there are three firmware types that matter:

1. Today's SEV-SNP deployed firmware.
2. Near future SEV-SNP firmware that exposes the new ExitBootServices()
   protocol that allows guests that speak the protocol to boot faster
   by participating in the unaccepted memory dance.
3. Far future firmware that doesn't have the ExitBootServices() protocol

There are also three kernel types:
1. Old kernels with zero unaccepted memory support: no
   ExitBootServices() protocol support and no hypercalls to accept pages
2. Kernels that can accept pages and twiddle the ExitBootServices() flag
3. Future kernels that can accept pages, but have had ExitBootServices()
   support removed.

That leads to nine possible mix-and-match firmware/kernel combos.  I'm
personally assuming that folks are going to *try* to run with all of
these combos and will send us kernel folks bug reports if they see
regressions.  Let's just enumerate all of them and their implications
before we go consult our crystal balls about what folks will actually do
in the future.

So, here we go:

              |                   Kernel                   |
              |                                            |
              | Unenlightened | Enlightened | Dropped UEFI |
Firmware      |     ~5.19??   |    ~6.4??   | protocol     |
              |---------------+-------------+--------------|
Deployed      |   Slow boot   |  Slow boot  |  Slow boot   |
Near future   |   Slow boot   |  Fast boot  |  Slow boot   |
Far future    |   Crashes??   |  Fast Boot  |  Fast boot   |

I hope I got that all right.

The thing that worries me is the "Near future firmware" where someone
runs a ~6.4 kernel and has a fast boot experience.  They upgrade to a
newer, "dropped protocol" kernel and their boot gets slower.

I'm also a little fuzzy about what an ancient enlightened kernel would
do on a "far future" firmware that requires unaccepted memory support.
I _think_ those kernels would hit some unaccepted memory, and
#VC/#VE/#whatever and die.  Is that right, or is there some fallback there?
