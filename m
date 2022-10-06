Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F435F6BF4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 18:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiJFQmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 12:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiJFQly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 12:41:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AFBAD9BF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 09:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665074514; x=1696610514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W9E1ROr0NyiVbElne9gtGbCHBMDnF4H4qBChZiwnZqE=;
  b=AF7iB80nE447ftCQtcpCcyC/jks32x6vNppuzwi4bhztqbuKSdoTEXNL
   9k1Cgo/OkI8rZbfPuub7C+ESXVByW/EiHOHCZyfnL7QbAnixHGDeWv8zN
   QJMDc1g/TkW2toILTReMo/x9zJOpDSt19JLj2zgMCS8HScMK4jfvj6RmN
   kTxX6OqGHYA49EfwIJTLfLxPFQfd7it9sgRXaOJrdl4CP1YOFhaBHNa8G
   X+E+tUtuIx1/7bghvB/JsyQo8kAMQIMTvJc+PKt0LMHhkuRrG6UXAfdUE
   CBZ+3za6uLxD23YFIbqJdKFLxN2m2uTjO15w2poEiLRCOBDE5vqvQ/Wm4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="365438644"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="365438644"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 09:41:48 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="627081189"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="627081189"
Received: from tliusvaa-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.212.99])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 09:41:37 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 21579104D90; Thu,  6 Oct 2022 19:41:34 +0300 (+03)
Date:   Thu, 6 Oct 2022 19:41:34 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv9 00/14] Linear Address Masking enabling
Message-ID: <20221006164134.sottfzqyugxt6eas@box.shutemov.name>
References: <20220930144758.30232-1-kirill.shutemov@linux.intel.com>
 <CAG_fn=X0xfY-5DS+YSpaLy8mHhAoJoceTq0vb2xmGBxB75wGMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=X0xfY-5DS+YSpaLy8mHhAoJoceTq0vb2xmGBxB75wGMA@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 03:58:21PM +0200, Alexander Potapenko wrote:
> On Fri, Sep 30, 2022 at 4:48 PM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > Linear Address Masking[1] (LAM) modifies the checking that is applied to
> > 64-bit linear addresses, allowing software to use of the untranslated
> > address bits for metadata.
> >
> > The capability can be used for efficient address sanitizers (ASAN)
> > implementation and for optimizations in virtual machines.
> >
> > The patchset brings support for LAM for userspace addresses. Only LAM_U57 at
> > this time.
> >
> > Please review and consider applying.
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
> 
> Not a big deal, but this tree contains LAM_U48 patches, and after
> skipping those the SVM patch does not apply cleanly.

Sorry, forgot to push the update. Pushed now.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
