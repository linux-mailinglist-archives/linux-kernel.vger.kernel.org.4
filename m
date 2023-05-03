Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87D86F5C33
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 18:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjECQpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 12:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjECQpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 12:45:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F0D55AF
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 09:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683132300; x=1714668300;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FT786ZN4dfiNo6eVSAF6p7LpeFKcekhw/d1wBJTp9U8=;
  b=S0IDVENvTL8o0apYwnFPWN9/N81LjgRi3b5Eqx6dM/PAJLN+POUXGFnm
   SFA/P7xBRTwazO7lYaiJPW5Hab8wVsqHx++jtBXjcnx+Qbe12UCQQiiiv
   +07QeD5Ia9QPImckhpy/enkCgED03V4Fn8RYm5T6gOlzA5orA/icppK7I
   QOWXy7bt/HFqpF2N6t6lhFKEX0mXmVY11VKnZDIfk0CmuoYXn/wQ4EJXe
   HPcpWhHGBjhNR7pgRdKfkJmHO6mpru3SfzbVPtkQQqiYSzX/SqK2xLBll
   HI7k8H1IX27wkXiUD0kpH6dOM8jatFUycNLqBG7KPjoqCLU+zX15h5Yyi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="348745562"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="348745562"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 09:44:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="690757014"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="690757014"
Received: from ypissay-laptop.amr.corp.intel.com (HELO [10.212.127.167]) ([10.212.127.167])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 09:44:51 -0700
Message-ID: <95f17f84-f172-417c-fe7e-ca0a07b205fb@intel.com>
Date:   Wed, 3 May 2023 09:44:50 -0700
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
 <f5983c42-82a5-1cd8-c717-67bfd72377dc@intel.com>
 <CAHk-=wgpOqujY210W9-KJPEfD42W_bvUdLwF-PAvyxJQ92tzDg@mail.gmail.com>
 <CAHk-=wj7q6Ng5uemZtrDnhtcfrgkzX5Z18eKZj94FY5d2quP6A@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAHk-=wj7q6Ng5uemZtrDnhtcfrgkzX5Z18eKZj94FY5d2quP6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/23 09:38, Linus Torvalds wrote:
>> Why does it do that "shift-by-63" game there, instead of making
>> tlbstate_untag_mask just have bit #63 always set?
> And it turns out that bit #63 really _is_ always set, so I think the
> solution to this all is to remove the sign games in untag_addr()
> entirely.

Yes, there are only two possible values right now, both of which have
bit 63 set:

LAM off: mm->context.untag_mask = -1UL;
LAM on:  mm->context.untag_mask = ~GENMASK(62, 57);

> Untagging a kernel address will "corrupt" it, but it will stay a
> kernel address (well, it will stay a "high bit set" address), which is
> all we care about anyway.
> 
> If somebody actually tries to untag a kernel address, that would be a
> bug anyway, as far as I can tell.

Is it a bug?  The do_madvise() path, for instance, is passing a value in
there that came right from userspace.

> So I'm going to just remove the 'sign' games entirely. They are
> completely broken in 'untagged_addr_remote()', they _used_ to be
> completely broken in 'untagged_addr()', and it looks like it's all
> unnecessary.

Yes, it looks completely superfluous.
