Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5883B6D897B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbjDEVXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbjDEVXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:23:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A908D728A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 14:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680729789; x=1712265789;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QO+4velRrMLTzwYigIPtwrKM9hLrQDLjrmFglXzlDw8=;
  b=fdNJ2fMAvpq/EunQLpxSUcBTD5jvscGfQD6w7AlfSekwmkiiXV/P5ZPE
   wFJMhN/z9Q22plCjHyJbOALnwYduahACrjfgAsRe0NcKPonkk8Btkpp9E
   GUFWbcb5sA7Dke0x3Baf8vVTiX7yhmuoeiOAS3OMNp217Jqzo6cdX+mji
   owdT1MNOPp5Wyqb+SEMRTEP4dS8NsFMLpC1FWwP7TYCHmZNwPCgLtkuXE
   K7rQ3raRD0JvOgxXs+KRT2SFfbl4ML0VGDbbi1ijWvKXM3Kq52Lnz5Dkx
   xbR2n2J/K3cXhEK2V63GDOIw5cR5o+tkKvVZraOPhYLAzwRefJO5WzNkT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="341297168"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="341297168"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 14:22:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="751399214"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="751399214"
Received: from kyunghyu-mobl2.amr.corp.intel.com (HELO [10.209.6.69]) ([10.209.6.69])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 14:22:48 -0700
Message-ID: <96513ddd-ee87-5fae-cb5c-79d0120fd326@intel.com>
Date:   Wed, 5 Apr 2023 14:22:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 6/6] x86/efi: Safely enable unaccepted memory in UEFI
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
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
References: <bc9e6d82-c7c1-47dc-e91f-57d9b4e2bb0a@intel.com>
 <20230404180917.4fsgkzcdhqvph6io@box.shutemov.name>
 <CAMj1kXF0XyEOuSUDqgsLSYK8GSkGN1xK3RQ525+BxhG+7+vnCA@mail.gmail.com>
 <20230404202445.6qkl7hz67qgievqz@box.shutemov.name>
 <CAMj1kXFrm74+zNcSpHJ1kw38PTMOFk1cTx_EAoGFHaG1fYzRTQ@mail.gmail.com>
 <20230404210153.tll2mojlglx4rfsa@box.shutemov.name>
 <CAMj1kXGvcg-E84h1T_vPi7qxPWxEXBpyuB79KOL+ON7v5YAgJg@mail.gmail.com>
 <e46777d3-adea-90a2-afc4-35f9d7cef50c@intel.com>
 <CAMj1kXEDYa5YcRj7t9JJmQ21+ierue2q6ADOXUOMjoOGndGRug@mail.gmail.com>
 <969a3d2a-52e7-e60e-5de6-c550c548730d@intel.com>
 <20230405190636.4mrq2daz6a23yhvr@box.shutemov.name>
 <7dd9297f-b065-2ace-1c77-22dd0126c526@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <7dd9297f-b065-2ace-1c77-22dd0126c526@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/23 13:11, Tom Lendacky wrote:
>>> The thing that worries me is the "Near future firmware" where someone
>>> runs a ~6.4 kernel and has a fast boot experience.  They upgrade to a
>>> newer, "dropped protocol" kernel and their boot gets slower.
> 
> Right, so that is what begs the question of when to actually drop the
> call. Or does it really need to be dropped? It's a small patch to
> execute a boot services call, I guess I don't see the big deal of it
> being there.
> If the firmware still has the protocol, the call is made, if it doesn't,
> its not. In the overall support for unaccepted memory, this seems to be
> a very minor piece.

I honestly don't think it's a big deal either, at least on the kernel
side.  Maybe it's a bigger deal to the firmware folks on their side.

So, the corrected table looks something like this:

              |                   Kernel                   |
              |                                            |
              | Unenlightened | Enlightened | Dropped UEFI |
Firmware      |     ~5.19??   |    ~6.4??   | protocol     |
              |---------------+-------------+--------------|
Deployed      |   Slow boot   |  Slow boot  |  Slow boot   |
Near future   |   Slow boot   |  Fast boot  |  Slow boot   |
Far future    |  2GB limited  |  Fast Boot  |  Fast boot   |


But, honestly, I don't see much benefit to the "dropped UEFI protocol".
It adds complexity and will represent a regression either in boot
speeds, or in unenlightened kernels losing RAM when moving to newer
firmware.  Neither of those is great.

Looking at this _purely_ from the kernel perspective, I think I'd prefer
this situation:

          |            Kernel           |
          |                             |
          | Unenlightened | Enlightened |
Firmware  |     ~5.19??   |    ~6.4??   |
          |---------------+-------------+
Deployed  |   Slow boot   |  Slow boot  |
Future    |   Slow boot   |  Fast boot  |

and not have future firmware drop support for the handshake protocol.
That way there are no potential regressions.

Is there a compelling reason on the firmware side to drop the
ExitBootServices() protocol that I'm missing?
