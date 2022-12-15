Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727BD64E084
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiLOSSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiLOSSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:18:40 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4976A1FF95
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671128319; x=1702664319;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l0/CnKczoIcW8sONWqRn+Ta4EJzy3U0AUrCPj/4T4P4=;
  b=WanGPxF0qKQoKbFcAAOj1hy8HCkYz+0AAjXnQL3cBdR89e+8aDWhITfH
   XZdRj5nQFF+l/uvLAifGzdfzHPv2JsffA0UNa0nygsJ1wJV3N2WI+uzJu
   QfgBZu9ykeEHAEV6Gq4Tc5oL18T92reJ6Vda69UG9/nYfZ6ed26BoMg93
   15Sxrequ9S1uGvkUmWe6c2p9J0fvzj64cQCmfA3lqtgLjP07E7knPK1eF
   Re1iQLBDN4NEcRnIk4TFP8U+Cqr+wFZAlKPDlkBwLm4mp8cciPicflSEs
   77liakMxbieYLW82bIzav7tjK2VKgTtzr7FqJSLEt8yXBRwuzI9tBvQsf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="345845157"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="345845157"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 10:18:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="773816929"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="773816929"
Received: from ajanssen-mobl.amr.corp.intel.com (HELO [10.209.22.168]) ([10.209.22.168])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 10:18:24 -0800
Message-ID: <795d6e1d-c79c-b079-3412-69ca2f8ee874@intel.com>
Date:   Thu, 15 Dec 2022 10:18:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/4] x86/tdx: Use ReportFatalError to report missing
 SEPT_VE_DISABLE
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221209132524.20200-1-kirill.shutemov@linux.intel.com>
 <20221209132524.20200-3-kirill.shutemov@linux.intel.com>
 <3121847d-d334-67fc-43d8-0670c08c64b6@intel.com>
 <20221215171254.3v4maexfhkdnbfk2@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221215171254.3v4maexfhkdnbfk2@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/22 09:12, Kirill A. Shutemov wrote:
>> Getting *all* users of panic this magic ability would be a lot better
>> than giving it to one call-site of panic().
>>
>> I'm all for making the panic() path as short and simple as possible, but
>> it would be nice if this fancy hypercall would get used in more than one
>> spot.
> Well, I don't see an obvious way to integrate this into panic().
> 
> There is panic_notifier_list and it kinda/sorta works, see the patch
> below.
> 
> But it breaks panic_notifier_list contract: the callback will never return
> and no other callback will be able to do their stuff. panic_timeout is
> also broken.
> 
> So ReportFatalError() is no good for the task. And I don't have anything
> else :/

Do we *really* have to do a hard stop when SEPT_VE_DISABLE is missing?

Wouldn't it be simpler to just defer the check until we can spit out a
sane error message about it?

Or is there too much security exposure by continuing?
