Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEB564BF9B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 23:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbiLMWpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 17:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236882AbiLMWop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:44:45 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A5625EA2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 14:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670971470; x=1702507470;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c+9YkiDCKG1HcuHGaSW/UZ3+yOPPib+maJicYy8Yu2w=;
  b=BiBZOzveuxMXT/HG6xbK/QdVcPydmx2JeDafIUUG8CfmHzcVMxUZRzbR
   yhI4UfJVmNQ1GBb+xTHZAul/fQ/ii4pTdzT+PoPqAR1VAaU4123ZhHckE
   N82ixr2b+ur2Re3iAUBFTY65AscC3rX77r37X//ogi9k+mFcsv3cMOetJ
   uM26IeRyBWtzrAaIePSq1theomVBMFiw4HY7wOugayttd3y+Bj3EgpAwz
   urZVUaEzyom/vLHHGauvHoiXJFdby1TCgqa+e/tPyOxvHlTHEUqU7rSSd
   C4O/gBOmdA+0Mhn+ERB1cSfVXjXmFmv5aQ7IQYEdqvSSfLzfVyaGRiS6M
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="380463006"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="380463006"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 14:44:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="977595516"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="977595516"
Received: from snjones-mobl1.amr.corp.intel.com (HELO [10.212.218.27]) ([10.212.218.27])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 14:44:27 -0800
Message-ID: <7d2a1ae7-56cf-a83d-4883-b2f8631a5e3d@intel.com>
Date:   Tue, 13 Dec 2022 14:44:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/4] x86/tdx: Expand __tdx_hypercall() to handle more
 arguments
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221209132524.20200-1-kirill.shutemov@linux.intel.com>
 <20221209132524.20200-2-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221209132524.20200-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/22 05:25, Kirill A. Shutemov wrote:
> So far __tdx_hypercall() only handles six arguments for VMCALL.
> Expanding it to six more register would allow to cover more use-cases.

like...

> Using RDI and RSI as VMCALL arguments requires more register shuffling.
> RAX is used to hold tdx_hypercall_args pointer and RBP stores flags.
> 
> While there, fix typo in the comment on panic branch.

This isn't the world's largest patch, but it doing at least three or
four different logical things.  Ideally, you'd do the restructuring in a
couple of patches and then the last one would just add the six new
registers.

Could you take 20 minutes and see if you can break this down into three
or four patches?

It looks _ok_.  I'd almost ack it as-is, but it should be pretty simple
to break down.

