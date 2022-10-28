Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19122611E21
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 01:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJ1X1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 19:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiJ1X1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 19:27:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA73248CBB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666999632; x=1698535632;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZSEejlDTYHMarcJW7mGvdLQa+9Xe0rYQzpQ/t3a/mGw=;
  b=Txjir3YR7aPerXDfKlBHg7S3iJav/26QMR4gRPWHFhGyFAaf1Kyu9J37
   uYKtvz9i1xtTwZTVWVO5eUvwF1rt2wMs7KUBphkjddHfjLIEVXmBmppUF
   eRshvwHxhTMSV+jQq5rLcgdqpaZAIw0o7Bxk1RhHFCUMdxaadNUR4gjH5
   OzVvcewJi+hjq95ZDk0HlpKEe6loh5r8cWZnyzIybHHZETZFz7dSgriwt
   thqlz7VT3mJKzPpU684o4plHU6lHhT8Kf64F6Oepfm7R17/KxcfjQsDcO
   MaqCHEmtUOMm1H/xr7Da3aGO8+1cajKCccicVGw6ytVeoDACEdJ9hut6Z
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="372823324"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="372823324"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 16:27:11 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="758256901"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="758256901"
Received: from jbandiax-mobl.amr.corp.intel.com (HELO [10.209.126.71]) ([10.209.126.71])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 16:27:11 -0700
Message-ID: <c97e9273-60b6-2ca7-1993-05bfbf471f3f@intel.com>
Date:   Fri, 28 Oct 2022 16:27:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] x86/tdx: Extract GET_INFO call from get_cc_mask()
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        seanjc@google.com, thomas.lendacky@amd.com,
        elena.reshetova@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20221028141220.29217-1-kirill.shutemov@linux.intel.com>
 <20221028141220.29217-2-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221028141220.29217-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I looked at this a bit more closely.  The code is just bonkers now.  It
can't go in like this.

tdx_parse_tdinfo() stashes two global variables.  Then, about three
lines later in the function, it calls get_cc_mask() which just returns
one of those variables, modulo a little masking.

Ditto for the td_attr.  It's stashed in a global variable and then read
one time.

There is *ZERO* reason to store 'td_attr'.  There's also zero reason to
have 'gpa_width' as a global variable.  It's only used *ONE* *TIME* from
the scope of *ONE* *FUNCTION*.

Even the comment is bonkers:

        /*
         * Initializes gpa_width and td_attr. Must be called before
         * get_cc_mask() or attribute checks.
         */
        tdx_parse_tdinfo();

Comments are great.  But comments that are only there because the code
is obtuse are not.  I changed it to:

        tdx_parse_tdinfo(&cc_mask);

It doesn't even need a comment now.  Why?  Because it's obvious from the
naming and calling convention that it initializes cc_mask and what the
ordering dependency is.  Plus, even *if* I missed the call, or screwed
up the order, the compiler would tell me that I'm a dolt.

The whole global variable thing actually makes the code objectively
worse in almost every possible way.

Can you please take a look through this and make sure I didn't botch
anything:

> https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/log/?h=tdxbadve

The end result is about 50 lines less than what was there before.  Most
of it is comment removal but the code is simpler too.

Acks and Tested-by's would be appreciated.
