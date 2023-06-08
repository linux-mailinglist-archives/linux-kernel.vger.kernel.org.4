Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1126F728BE2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbjFHXgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjFHXgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:36:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A1930D5;
        Thu,  8 Jun 2023 16:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686267340; x=1717803340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sN7dvQMQ+/TpXG6CIcwf0XKyIcjODwPRfKZrLnuiPSY=;
  b=UXqehFPuabB/RcoG8sNH/tX04ZZ+qGwLovbZb9OkWoz/EE3a13PqPnaO
   jkVtAYuGFcj//7Ykm1zbTe71ntQ+tcukP5B41OhyE/dTk4qfLsYcu8MOU
   7Bpsn0enkAnhqDb5Xjxp/MHdOY3GtpfdCIpTSZCW5MkGHK2jEYCeyALiK
   cI1vBIG3ngxiWQkgw4Dpy8AZ+iN8+lotACEPj0gA7jLxg2lneR+UHLTAo
   vOD1qUx8kW/pGF2B5ZXwhpvwVRU6YLcCUJMpFDi9T7mLA82YztW5UduqE
   FZoPwn2u3E/LXGKJ+8Wgz2Nsrby98mhlyLoPQ9HZf7zYp1wNv+Rsfpsqn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="337097733"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="337097733"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 16:34:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="822822455"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="822822455"
Received: from yjiang5-mobl.amr.corp.intel.com (HELO localhost) ([10.144.161.97])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 16:34:03 -0700
Date:   Thu, 8 Jun 2023 16:34:02 -0700
From:   Yunhong Jiang <yunhong.jiang@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [patch] x86/realmode: Make stack lock work in trampoline_compat()
Message-ID: <20230608233402.GA3430@yjiang5-mobl.amr.corp.intel.com>
References: <20230508181633.089804905@linutronix.de>
 <20230508185218.962208640@linutronix.de>
 <20230524204818.3tjlwah2euncxzmh@box.shutemov.name>
 <87y1lbl7r6.ffs@tglx>
 <87sfbhlwp9.ffs@tglx>
 <20230529023939.mc2akptpxcg3eh2f@box.shutemov.name>
 <87bki3kkfi.ffs@tglx>
 <20230529203129.sthnhzgds7ynddxd@box.shutemov.name>
 <87h6rujdvl.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6rujdvl.ffs@tglx>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SCC_BODY_URI_ONLY,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 12:46:22PM +0200, Thomas Gleixner wrote:
> The stack locking and stack assignment macro LOAD_REALMODE_ESP fails to
> work when invoked from the 64bit trampoline entry point:
> 
> trampoline_start64
>   trampoline_compat
>     LOAD_REALMODE_ESP <- lock
One possibly dumb question and hope get some hints. The LOAD_REALMODE_ESP is
defined under .code16 directive and will be used by 32-bit mode caller also. Is
it ok because the instructions there will be same for both 16-bit and 32-bit? I
checked
https://ftp.gnu.org/old-gnu/Manuals/gas-2.9.1/html_chapter/as_16.html#SEC205 and
don't find much information there.

