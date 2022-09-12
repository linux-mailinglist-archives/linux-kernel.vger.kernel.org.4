Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E1B5B62E7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 23:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiILVl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 17:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiILVly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 17:41:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA7A4C61F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 14:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663018913; x=1694554913;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qFnIjffMALUQQUIAOVDoq6z2zOO7NBVKHgBfILKSm68=;
  b=m5R6mxcqh9cDwTuB5X4Qk5dvUcEU5bGf7xyyCL8SLaOH8H/szIqKlZ0d
   jylS4abmc2z6q5k0CD6HBgLShtqpscasuHzju1st7Pm1/Q6R7uMTm83OY
   wZHWj2/6VbD3M6RpUXRgUwJnMYWy81QpFwdQN74Wrj5ojTUQyYqF8EBqL
   je9eOeJC9j2tEd1jbadjgQwKgwGXuZcOPgCe1AGhT7VI7tjVP0PpzmOny
   M72Ec2PPqrEXif9JH+P+h82yoM2dtFpsD2kUbLaW0MR0oB9avZ8s0pY2u
   XTwrvExDBmqqDYf5NJeqCE0gsnPULWIm/Bv+8eY5kbnFoqP5Fo5C94uZs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="298775514"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="298775514"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 14:41:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="646645164"
Received: from gjmurphy-mobl.ger.corp.intel.com (HELO [10.213.203.202]) ([10.213.203.202])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 14:41:48 -0700
Message-ID: <356d4ad1-f7d8-b8ff-3b63-819a64bf5b9f@intel.com>
Date:   Mon, 12 Sep 2022 14:41:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok_raj@linux.intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
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
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
 <YxDvpLb77lwb8zaT@araj-dh-work>
 <20220904003952.fheisiloilxh3mpo@box.shutemov.name>
 <Yxtk4gMbcVgTKzKg@araj-dh-work> <20220912133935.3bb3e247@jacob-builder>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220912133935.3bb3e247@jacob-builder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/22 13:39, Jacob Pan wrote:
>>> +	if (pasid_valid(mm->pasid) && !forced) {
> I don't think this works since we have lazy pasid free.  for example,
> after all the devices did sva_unbind, mm->pasid  we'll remain valid until
> mmdrop(). LAM  should be supported in this case.

Nah, it works fine.

It just means that the rules are "you can't do LAM if your process
*EVER* got a PASID" instead of "you can't do LAM if you are actively
using your PASID".

We knew that PASID use would be a one-way trip for a process when we
moved to the simplified implementation.  This is just more fallout from
that.  It's fine.

> Perhaps, we could introduce another prctl flag for SVA, PR_GET_SVA?
> Both iommu driver and LAM can set/query the flag. LAM applications may not
> be the only ones want to know if share virtual addressing is  on.

I don't think it's a good idea to add yet more UABI around this issue.
Won't the IOMMU folks eventually get their hardware in line with LAM?
Isn't this situation temporary?
