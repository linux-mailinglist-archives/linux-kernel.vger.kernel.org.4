Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441E561F1C6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiKGLZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiKGLZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:25:56 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87F8183B9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 03:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667820355; x=1699356355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P9d1UxIDzcvfcEyC1I1VQZDS9kk49QINfebehAyX6fU=;
  b=b34yZa425YLjHfZASSYxxQ/R4pDDErQVGDjVABn3UirTGTi44/M4xd+O
   aG6/C5tRKZcIGKuLRstapt96D/1Dn9iR+Fgf81ttr4GejTp/YuI59iWeW
   8WWoKOBMxrwnbnx+hT0Zi4qy19EMpvSv55LljsyQRWEsW0kloHDntpD1k
   XpQFHmw7xqy+cb6KU/iZ+rL1rzV9SkJRoWiuzlqJ0sR3RSNsNGyAFh2Jt
   pdocHUkfnopJ8unFVvZFtpKi1SfVsQhgUAmzlmFbQp/5YgaHMKd5/ouuN
   TlLeTZMrDPuacSBMJJdxp6RQDh9fe2G6MmErUZLXI9yE6HEKbATbyu31B
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="293734087"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="293734087"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 03:25:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="669105094"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="669105094"
Received: from vhavel-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.46.204])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 03:25:49 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 5486410964A; Mon,  7 Nov 2022 14:25:47 +0300 (+03)
Date:   Mon, 7 Nov 2022 14:25:47 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
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
Subject: Re: [PATCHv11 00/16] Linear Address Masking enabling
Message-ID: <20221107112547.obnz775ponxjutrt@box.shutemov.name>
References: <20221025001722.17466-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025001722.17466-1-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 03:17:06AM +0300, Kirill A. Shutemov wrote:
> Linear Address Masking[1] (LAM) modifies the checking that is applied to
> 64-bit linear addresses, allowing software to use of the untranslated
> address bits for metadata.
> 
> The capability can be used for efficient address sanitizers (ASAN)
> implementation and for optimizations in JITs and virtual machines.
> 
> The patchset brings support for LAM for userspace addresses. Only LAM_U57 at
> this time.
> 
> Please review and consider applying.

Ping?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
