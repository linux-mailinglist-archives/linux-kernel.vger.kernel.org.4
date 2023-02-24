Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A200E6A1F60
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjBXQMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjBXQMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:12:32 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DFF6EB03
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677255146; x=1708791146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zrIOX/eAJTtv52elNQI1lM9u3xMyOfuLqflASbexGuA=;
  b=b+Mbjr9Fo5dKjkTuB4fa7W1CW0cRl1l7eR72zJ7+d/tonN5Ogb55m7ER
   WTvIGXuJH+FXTcI+pKsrskwR8lq0HvO82R2u1XnnNCaM9STEG3kBKK2M0
   A4jUap/yxuhyhlH3fXbM83nXOB0bMovaA4cVPURfQIi4HUgCrlfRcKqLq
   8AvbNMC+Aj71mGUDh0VH95KNDxgWw9niXQmemfhVIvhG5HCN7CBBsqUY6
   1ypucVr84TUAxRZDgqBjsateSoDViNxbakyM8TsqZnEWaZ+RkAQpNjIO+
   QJ+sPriytkO3N+rz4l03qeWZoSTpWYmLQV7c9jJEyIiTZ5pHpOkXkv0pn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="332197940"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="332197940"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 08:12:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="703227125"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="703227125"
Received: from rkris18-mobl.amr.corp.intel.com (HELO box.shutemov.name) ([10.252.56.190])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 08:12:22 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id B706810A5FE; Fri, 24 Feb 2023 19:12:19 +0300 (+03)
Date:   Fri, 24 Feb 2023 19:12:19 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Isaku Yamahata <isaku.yamahata@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH 0/2] Kexec enabling in TDX guest
Message-ID: <20230224161219.txwidrzpfnkbn7oi@box.shutemov.name>
References: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
 <6b09a3505bf3deaa11906a2ecb9d15c4ec427ea2.camel@infradead.org>
 <20230224143004.xqhpv6upn2fkqkjp@box.shutemov.name>
 <f32f1f77-c707-ae19-ae1a-dc0a37fa9806@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f32f1f77-c707-ae19-ae1a-dc0a37fa9806@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 07:22:18AM -0800, Dave Hansen wrote:
> On 2/24/23 06:30, Kirill A. Shutemov wrote:
> > Ideally, it has to be addressed on BIOS level: it has to provide a way to
> > offline CPUs, putting it back to pre-wakeup state.
> 
> Is there anything stopping us from just parking the CPUs in a loop
> looking at 'acpi_mp_wake_mailbox_paddr'?  Basically park them in a way
> which is indistinguishable from what the BIOS did.

+Rafael.

 - Forward compatibility can be an issue. Version 0 of mailbox supports
   only single Wakeup command. Future specs may define a new command that
   kernel implementation doesn't support.

 - BIOS owns the mailbox page and can re-use for something else after the
   last CPU has woken up. (I know it is very theoretical, but still.)

 - We can patch ACPI table to point to mailbox page in kernel allocated
   memory, but it brings other problem. If the first kernel didn't wake up
   all CPUs for some reason (CONFIG_SMP=n or nr_cpus= or something) the
   second kernel would not be able to wake up them too since they looping
   around the old address.

But ultimately, I think it is clearly missing BIOS functionality and has
to be addressed there. Hacking around it in kernel will lead to more
problems down the road.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
