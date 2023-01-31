Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B576826A5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjAaIjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjAaIjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:39:12 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0B815556
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675154352; x=1706690352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RCAx/SVdwzpoxtG6dsVhEuTiwPDXXArst9gLzvIUq5g=;
  b=NLCtQCSmRqbVRZ0lAyjxn1OsiNHbTrSUmK7Qm5IhbORTuygFDxPSvAnM
   IE/YA3Al2Wm2WEAUDf1fLr8WXaDVWDIiyCkepF0o3ZbVJuHBeccoHcQ6C
   ePD/mLYQ4KBNRYIU5VIdrQJROBmLuCCo7T6hPq1RO/tfG0Wha5XjaMfQv
   S34jtrwGvOqrdjxjzm3lW6k1WAa+2qt1iMQFRzEwTVYhZqFK4zA/rY1eT
   gup7cxnNycm5nWCoqHPRe6ZZ+XBmkGJmGaC0holUDjfX+9KUXmO/zNNaW
   7Jpw185F4VjhwygmlZYkmBtEUnUO0IWG5tFTjAtOIHz4wvPCZYPPTG2q2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="414002124"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="414002124"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 00:39:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="664420245"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="664420245"
Received: from dianaman-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.33.19])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 00:39:04 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 090D610DF86; Tue, 31 Jan 2023 11:39:02 +0300 (+03)
Date:   Tue, 31 Jan 2023 11:39:01 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] x86/tdx: Do not corrupt frame-pointer in
 __tdx_hypercall()
Message-ID: <20230131083901.ssg5huno2lhrbmzg@box.shutemov.name>
References: <20230130135354.27674-1-kirill.shutemov@linux.intel.com>
 <Y9jShNfS/d8LGu8w@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9jShNfS/d8LGu8w@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 09:34:12AM +0100, Peter Zijlstra wrote:
> On Mon, Jan 30, 2023 at 04:53:54PM +0300, Kirill A. Shutemov wrote:
> > If compiled with CONFIG_FRAME_POINTER=y, objtool in not happy that
> > __tdx_hypercall() messes up RBP.
> > 
> >   objtool: __tdx_hypercall+0x7f: return with modified stack frame
> > 
> > Rework the function to store TDX_HCALL_ flags on stack instead of RBP.
> 
> Also, on IRC you mentioned that per TDX spec, BP is a valid argument
> register too and you were going to raise this and get it fixed, TDX
> hypercalls must not use BP to pass data.

I've raised the question yesterday. No progress so far. It will take time
to get it into the public spec.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
