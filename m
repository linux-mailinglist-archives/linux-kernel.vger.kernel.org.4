Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E3C6F4E3D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 03:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjECAxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 20:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjECAxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 20:53:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0E82D4B
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 17:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683075216; x=1714611216;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ay/Mwg8qOsS0W2dMW2Uq032t5x+wCyoCdaWP7b6QFO4=;
  b=lVzLzLqz02bF3V84xtpGdJ+7dOO/29sInnUWOj2PY4D6u8L3n52dHE7d
   ulkT3XHJrGVY2SJ7ZIA3LSKCHaf/z0LqikWozcR1f/O1mG+3OtItP8abF
   rjUlOiicDHSQ+9AzKY2kRrOggtDOBZrZyGsPmPBcdG6W1RY6cgcAgAdZH
   LZb4v3pkPr+tYAJ/ZDwV3ibcyDPPIoLVLXrDaetXoZ7t+a/8bgZlChucJ
   6BNwkRZERuiWuAQ8M0D0Vh3bmAAZuycgAkXakhiGliASCxRD+M3W13xmb
   GdsNgiznm1oS+vGcwKKKOQvxowABBGbkHCMzkzU2nGkRLQ+SsrixnbbWE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="350611725"
X-IronPort-AV: E=Sophos;i="5.99,245,1677571200"; 
   d="scan'208";a="350611725"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 17:53:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="726967190"
X-IronPort-AV: E=Sophos;i="5.99,245,1677571200"; 
   d="scan'208";a="726967190"
Received: from vsanka-mobl.amr.corp.intel.com (HELO [10.212.168.155]) ([10.212.168.155])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 17:53:33 -0700
Message-ID: <f5983c42-82a5-1cd8-c717-67bfd72377dc@intel.com>
Date:   Tue, 2 May 2023 17:53:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [GIT PULL] x86/mm for 6.4
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>
References: <20230427225647.1101172-1-dave.hansen@linux.intel.com>
 <CAHk-=wgrdOm8RwO+u8bydrbgs0wXJV_9mBYAtzX9d9hEY7a25A@mail.gmail.com>
 <CAHk-=wiHvdgbLxayyCsRU45JnKCZkCOpEJPfOvE3eYCnGjVcSA@mail.gmail.com>
 <20230429003822.n3mglslg666j3npp@box.shutemov.name>
 <641a9348-a052-6bb5-e6c7-64acb6405328@intel.com>
 <CAHk-=wgnGoj8qZg3SRh1Z1-mU=b3ryydXZykUuarnrAn6LuHBw@mail.gmail.com>
 <CAHk-=wgN=GY2A0htYQQRmPaLCorWnFatY_XO0X2w_m9xXQDcPA@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAHk-=wgN=GY2A0htYQQRmPaLCorWnFatY_XO0X2w_m9xXQDcPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/23 13:14, Linus Torvalds wrote:
> No, the problem is that probably *because* "access_ok()" has that
> warning, not all users use "access_ok()" at all. We have places that
> use "__access_ok()" instead. Like copy_from_nmi().
> 
> So now copy_from_nmi() doesn't do the untagging, so if you were to use
> tagged pointers for the stack, you'd not get stack traces.
> 
> End result: I think that
> 
>  (a) that WARN_ON_IN_IRQ() is actively detrimental and causes problems
> 
>  (b) the current "use untagged_addr() in access_ok()" model is also broken

Ugh, yes.

The fallout seems limited to (probably) perf and tracing poking at user
stack frames.  But, yes, it definitely looks broken there.

While I bet we could shoehorn the existing tlbstate checks into the
__access_ok() sites, I also vastly prefer the high bit checks in
access_ok() instead.  The less state we have to consult, the better.

Once the WARN_ON_IN_IRQ() is gone, it seems like it's just a matter of
collapsing __access_ok() into access_ok() and converting the (~3) callers.


