Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0123B726012
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbjFGMvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236543AbjFGMvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:51:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F121FF7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686142257; x=1717678257;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=96j5LP+QrdvCGDRDBIDgXK+1HoouV0Xv0Dmwi4N0S9M=;
  b=b4Rk6b0MC39zHKsoMDfvfC9Anndt0JwePwHzfVJudC2F1M7mftVAVHlx
   6K1ZFwjM0RPcw8JtFRLwCK4FPIQ39Ls48uL93Y/F32jCbnutv5tBXHZ/a
   WSnd1ZMWXkRApGZSvDMWQjJtW54bwK2I2Es+BQwtbseoEo3CxnLYPLKLc
   Qq62/XvhGjl7P38WzYl+NUbKjIqlnSxocaDdkhNeL1DnDN6Q9ghTX3al/
   ZERYJhFN6nyZjW/Gm6ldgTUk7PoPQw/GHI2jhPZkQMruamam9zpx0jqpt
   19AdhnbprqBmmpg7aj3J49Xft0aQzVJO6f2omKT+w4yuOQvmpay2jbW5O
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="355829399"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="355829399"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 05:49:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="774592705"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="774592705"
Received: from vsmyers-mobl2.amr.corp.intel.com (HELO [10.212.146.233]) ([10.212.146.233])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 05:49:16 -0700
Message-ID: <1f633e99-d294-6932-31e9-0eb158d030ea@intel.com>
Date:   Wed, 7 Jun 2023 05:49:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC 0/4] x86/fixmap: Unify FIXADDR_TOP
Content-Language: en-US
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>,
        linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Suren Baghdasaryan <surenb@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Usama Arif <usama.arif@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        x86@kernel.org, xen-devel@lists.xenproject.org
References: <cover.1684137557.git.houwenlong.hwl@antgroup.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <cover.1684137557.git.houwenlong.hwl@antgroup.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 01:19, Hou Wenlong wrote:
> This patchset unifies FIXADDR_TOP as a variable for x86, allowing the
> fixmap area to be movable and relocated with the kernel image in the
> x86/PIE patchset [0]. This enables the kernel image to be relocated in
> the top 512G of the address space.

What problems does this patch set solve?  How might that solution be
visible to end users?  Why is this problem important to you?

Also, while you're waiting for someone to review _your_ code, have you
considered reviewing anyone else's code?  I don't think I've seen any
review activity from you lately.
