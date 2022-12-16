Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519DE64F0BE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 19:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiLPSLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 13:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiLPSLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 13:11:20 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD26821268
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 10:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671214278; x=1702750278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=stUaaL039hb6lbPf87RkHV5eDc/UUb9w9ogXsU3o/to=;
  b=Qj4HYQk+LfR3qt6SRNImG2xuSQqyqmFDb/2TmNw7uAy1fNlP6c0XbKl9
   2Aw9G6jVqaoCymzmFwk9i4m+2pX4Rsm8MPA7AHSHhyb+xR1q9cY/tLJIH
   O+PPHSLWicxDJw6obJZt3xiwP49ATpwk3USgYSkp3ROmFTCTj5kAoapWT
   X29pp69HihqaiD8EvVRAz2VpWUppzqAMVnigy6aKbya3e5hS/5OFtnFds
   nQk3OvNVOoH0tjLuh5AMWlBLVie1Fl4SCf5qYLG8YEXRtqZUxWcb/G+2U
   hOSYVAvQHBWNpQIE7RxcBL1lbqkeSOfImcBDxiydz/UvdbVf8ClMzFvUt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="306700751"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="306700751"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 10:11:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="600027638"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="600027638"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga003.jf.intel.com with ESMTP; 16 Dec 2022 10:11:16 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 2BGIBFrj026579;
        Fri, 16 Dec 2022 18:11:15 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>, jbaron@akamai.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] vmlinux.lds.h: add HEADERED_SECTION_* macros
Date:   Fri, 16 Dec 2022 19:11:07 +0100
Message-Id: <20221216181107.687254-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221216162500.3023331-1-alexandr.lobakin@intel.com>
References: <Y20+PqtF+dFAe7hX@kroah.com> <20221117002022.860237-1-jim.cromie@gmail.com> <20221117002022.860237-3-jim.cromie@gmail.com> <20221216162500.3023331-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jim Cromie <jim.cromie@gmail.com>
> Date: Wed, 16 Nov 2022 17:20:22 -0700
> 
> > These macros elaborate on BOUNDED_SECTION_(PRE|POST)_LABEL macros,
> > prepending an optional KEEP(.gnu.linkonce##_sec_) reservation, and a
> > linker-symbol to address it.
> > 
> > This allows a developer to define a header struct (which must fit with
> > the section's base struct-type), and could contain:
> 
> [...]
> 
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index 85d5d5b203dc..a3b6aa30a525 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -214,6 +214,21 @@
> >  
> >  #define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
> >  

Also, those two pasting ops below:

> > +#define HEADERED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
> > +	_HDR_##_label_	= .;						\
> > +	KEEP(*(.gnu.linkonce.##_sec_))					\

                             ^^

> > +	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)
> > +
> > +#define HEADERED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
> > +	_label_##_HDR_ = .;						\
> > +	KEEP(*(.gnu.linkonce.##_sec_))					\

                             ^^

will produce incorrect results when @_sec_ starts with a dot (not
a rare thing for section names):

	HEADERED_SECTION_BY(.entry_sites, _entry_sites)

vmlinux.map:

.entry_sites    0xffffffff83c89ca0    0x37118 load address 0x0000000003c89ca0
                0xffffffff83c89ca0                __header_entry_sites = .
 *(.gnu.linkonce. .entry_sites)

here            ^^^

 .entry_sites   0xffffffff83c89ca0    0x37118 vmlinux.o
                0xffffffff83cc0db8                __start_entry_sites = .
 *(.entry_sites)
                0xffffffff83cc0db8                __stop_entry_sites = .

^ as a result, all .entry_sites entries went to the "header" instead
of the "body".

Sorta dangerous stuff as for me, maybe that could be handled
differently?

> > +	BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
> > +
> > +#define HEADERED_SECTION_BY(_sec_, _label_)				\
> > +	HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
> 
> Now HEADERED_SECTION_PRE_LABEL() takes 5 arguments, but this line
> passes only 4 to it. This went unnoticed probably due to that the
> macro is not used anywhere, thus can't trigger a compiler error.
> Would you prefer to fix it yourself or me to send the fix?[*]
> 
> > +
> > +#define HEADERED_SECTION(_sec)	 HEADERED_SECTION_BY(_sec, _sec)
> > +
> >  #ifdef CONFIG_TRACE_BRANCH_PROFILING
> >  #define LIKELY_PROFILE()						\
> >  	BOUNDED_SECTION_BY(_ftrace_annotated_branch, _annotated_branch_profile)
> > -- 
> > 2.38.1
> 
> [*] If it needs fixing at all -- some people over the MLs say that
>     if there's no trigger, then there's nothing to fix :clownface:
> 
> Thanks,
> Olek

Thanks,
Olek
