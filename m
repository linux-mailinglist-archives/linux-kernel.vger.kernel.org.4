Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEF0622019
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 00:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiKHXJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 18:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiKHXJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 18:09:09 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569C11181A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667948948; x=1699484948;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7FgGCLqTrdXQYxvV137BlK3VIXaIE0ETqLqleR7pIf8=;
  b=R3OXZsNjBtozZp3M9bMsXWxZ7HsFVuyZSs665SRoiix1/qPEugXoeLOH
   /4QG1pdaegK92uNbV9U2VGhGtqW5c1cq5Xw4Am0nMSAdO4yEoaN0skYXb
   8yQr67/4TiiCMA+lYlQT4Jjy2Jdiq7V8TgoXs7+TZ6hjavo6V04msnTZ+
   1qevNv/+4HfaWCvNzz5VabqEw3TqIaoCbima4q2+RjAF9eR5m+7VA5A+q
   QsPVJE64PL3hu8vHRMZ530KfDlthb4cVeTTjiMcyxBfxFjsyOdcI2S7hF
   lDXrsQA6VXgF7qk5uWFTuhcOl07fRwCi3a3qBlaR/UH+qaqcJdNry/W3M
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="294203671"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="294203671"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 15:09:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="761664429"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="761664429"
Received: from vibhusha-mobl1.amr.corp.intel.com (HELO [10.252.133.56]) ([10.252.133.56])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 15:09:07 -0800
Message-ID: <2993a60c-edaa-a29a-2644-3ee86c622847@intel.com>
Date:   Tue, 8 Nov 2022 15:09:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 0/2] x86/boot: fix relying on link order
Content-Language: en-US
To:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20221101161529.1634188-1-alexandr.lobakin@intel.com>
 <20221107125528.543764-1-alexandr.lobakin@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221107125528.543764-1-alexandr.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 04:55, Alexander Lobakin wrote:
> Ping?
> 
> Also, I managed to remove .head.text at all from x86. Would it be
> better to respin this series with the third patch or send a
> follow-up later?
> 

Hi Alexander,

Things are a bit busy in the review queue at the moment.  As always,
we'd love help reviewing stuff.  So, while you're waiting for us to
review this, could you perhaps look around and find a series that's also
hurting for review tags?
