Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD28B6035D3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiJRWYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJRWYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:24:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D15A44C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666131866; x=1697667866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zfnC/cOJ9Zth74hPYMkAxky3j1dK9CbeXG7pkaQrPBY=;
  b=crqOCkax6zYkviKF/Tu6JmRmKIuDCKlznvYQSbL9CiEurxjOrb4I/5vv
   DySZoOQnVxDlfo5GjYWOAv3sHJtcFFyLI9Ny6oRa5e8cdWwEblZ6bVjyY
   8HEJQ7nS1dvsRhRgsoKl8O9MKpk3kKGqFNS8HlS08WwZ1modlV/MpDASo
   7g8SHZFFkqDNr5Wd7dngHkSzx6ChjT7Tf20eft6+/mwfP67j66+k9TuKQ
   +KJVrrY22KKwwnZUbbV1Vkwiu7TL/gABf4tLgjrqOT0T+y6FxEth27N/R
   ukxvs1xdsCVcJB/2gcOpIz4TRcHvhfxsz6QXVHY9hZyhR+wR/Hp10kb0K
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="392551472"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="392551472"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 15:24:25 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="771446900"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="771446900"
Received: from vhavel-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.51.115])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 15:24:21 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 2F785104BA9; Wed, 19 Oct 2022 01:24:19 +0300 (+03)
Date:   Wed, 19 Oct 2022 01:24:19 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
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
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv10 09/15] x86: Expose untagging mask in
 /proc/$PID/arch_status
Message-ID: <20221018222419.oy2z2wanvwp2pnrm@box.shutemov.name>
References: <20221018113358.7833-1-kirill.shutemov@linux.intel.com>
 <20221018113358.7833-10-kirill.shutemov@linux.intel.com>
 <cd8939c7-6194-53f5-14e1-89bef945fb47@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd8939c7-6194-53f5-14e1-89bef945fb47@intel.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 02:02:43PM -0700, Dave Hansen wrote:
> On 10/18/22 04:33, Kirill A. Shutemov wrote:
> > Add a line in /proc/$PID/arch_status to report untag_mask. It can be
> > used to find out LAM status of the process from the outside. It is
> > useful for debuggers.
> 
> Considering that address masking is not x86-specific, it seems like this
> needs a better home (another file in /proc).

In generic /proc/$PID/status?

And I'm not sure if it is a good idea at this stage. Semantics around tags
is not settled across architectures: somewhere it is per-thread, somewhere
per-process, somewhere it is global.

Maybe keep it arch-specific?

> This could even be left out of the series for now, right?  Nothing,
> including the selftests, depends on it.

GDB folks wanted to know the mask.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
