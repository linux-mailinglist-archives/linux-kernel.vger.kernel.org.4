Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBA560361E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiJRWlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiJRWlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:41:50 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D27AF1BE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666132907; x=1697668907;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=43nga7sHlYGp/WXO1HBW7Mr8hHzUz0ck5JawD+SCfMg=;
  b=IAG9nqqi7IRLDZeCA/Fsl6+rMaMVVdxCDrbOxmvvNzGzyu+Kzv1kk5KA
   01L0lbqAaJJGMcvD8kjGrL8TqMuHdnWe+4KBisj+MxJ8k5ROyFq854Ptd
   hLe/dndv1FZ37KqHmId8u/Sqf9vSh+0MWtGtb60DqWPkgTrUqM9Yhtqqz
   nTGUSM8rUCkUJX/zkwSU7+DkqkLdXc8uFiHnhxNk3sld6pjOpihDywaU4
   TeE/EdxN0B0hg7C6OaFqtOIZRwNm9mgd+Ooi749JnTzWIqkV+cRCir1hG
   1qVv9MOFBJ2vUClakpDLrY7eZjMkwnjlZECdlH2JFMxlBlAepyhRW8tj6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="368305154"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="368305154"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 15:41:46 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="660032778"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="660032778"
Received: from jjsopko-mobl.amr.corp.intel.com (HELO [10.213.163.40]) ([10.213.163.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 15:41:44 -0700
Message-ID: <35961c2f-08ab-9036-bc0c-6ede269ad3ec@intel.com>
Date:   Tue, 18 Oct 2022 15:41:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCHv10 09/15] x86: Expose untagging mask in
 /proc/$PID/arch_status
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20221018113358.7833-1-kirill.shutemov@linux.intel.com>
 <20221018113358.7833-10-kirill.shutemov@linux.intel.com>
 <cd8939c7-6194-53f5-14e1-89bef945fb47@intel.com>
 <20221018222419.oy2z2wanvwp2pnrm@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221018222419.oy2z2wanvwp2pnrm@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/22 15:24, Kirill A. Shutemov wrote:
> On Tue, Oct 18, 2022 at 02:02:43PM -0700, Dave Hansen wrote:
>> On 10/18/22 04:33, Kirill A. Shutemov wrote:
>>> Add a line in /proc/$PID/arch_status to report untag_mask. It can be
>>> used to find out LAM status of the process from the outside. It is
>>> useful for debuggers.
>> Considering that address masking is not x86-specific, it seems like this
>> needs a better home (another file in /proc).
> In generic /proc/$PID/status?

Seems like a sane place to me.

> And I'm not sure if it is a good idea at this stage. Semantics around tags
> is not settled across architectures: somewhere it is per-thread, somewhere
> per-process, somewhere it is global.
> 
> Maybe keep it arch-specific?

Yeah, but all of those things could be served by a thread-specific ABI.
The per-thread ABI won't enumerate the scope of the thing, of course.
But, it _can_ precisely communicate what semantics the thread has.
