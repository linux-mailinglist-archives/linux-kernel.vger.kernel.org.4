Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19226A1D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjBXOaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBXOaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:30:11 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F6763A1D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677249010; x=1708785010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8oT9KIiIwHATiu37VBCkX8K+98mUm7+5JCf02Wuh6IQ=;
  b=e+FI+k+eSgN8tgeVDSI+wAGg2f3bhwouFY1TQq16M4mFrRN8fxOLBQjP
   +akEVo4/z3Z2MwDysPrBsxubawrJ5u5rpr1yJgPNT8bU2dqjWFQp/Ah37
   sWx7EzxXI6Cwz41XBLiYSG8cJBOEM3a8sidqV27JuluNt9KV/3gAsYA4N
   B+TFsH+o7xMVBZvD3fDUW8jiIHn3xk5O3F2cz85H4qlu3Ne5ZrP38KniG
   XHGyBnYXp+Wh1OsruRt1/rbELlrwsTrn61ALukH4jbXNRLysCgoxLaDAH
   VatoouO3a2N0e1IbKON/ZwJOux15Eqmcx6zeCFI4+bX2wKO6GZcD92cbn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="313118671"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="313118671"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 06:30:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="815759493"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="815759493"
Received: from rkris18-mobl.amr.corp.intel.com (HELO box.shutemov.name) ([10.252.56.190])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 06:30:06 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 52A9910A5FE; Fri, 24 Feb 2023 17:30:04 +0300 (+03)
Date:   Fri, 24 Feb 2023 17:30:04 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Isaku Yamahata <isaku.yamahata@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Kexec enabling in TDX guest
Message-ID: <20230224143004.xqhpv6upn2fkqkjp@box.shutemov.name>
References: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
 <6b09a3505bf3deaa11906a2ecb9d15c4ec427ea2.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b09a3505bf3deaa11906a2ecb9d15c4ec427ea2.camel@infradead.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 10:26:22AM +0000, David Woodhouse wrote:
> On Tue, 2023-02-14 at 02:48 +0300, Kirill A. Shutemov wrote:
> > The patch brings basic enabling of kexec in TDX guests.
> > 
> > By "basic enabling" I mean, kexec in the guests with a single CPU.
> > TDX guests use ACPI MADT MPWK to bring up secondary CPUs. The mechanism
> > doesn't allow to put a CPU back offline if it has woken up.
> > 
> > We are looking into this, but it might take time.
> 
> Can't we park the secondary CPUs in a purgatory-like thing of their own
> and wake them from there when we want them?
> 
> Patches for that were floating around once, although the primary reason
> then was latency, and we decided to address that differently by doing
> the bringup in parallel instead.

That's plan B. It is suboptimal. kexec() can happen into something that is
not Linux which will not be able to wake up CPUs.

Ideally, it has to be addressed on BIOS level: it has to provide a way to
offline CPUs, putting it back to pre-wakeup state.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
