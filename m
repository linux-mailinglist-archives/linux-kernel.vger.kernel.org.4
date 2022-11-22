Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37CF633CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbiKVMmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbiKVMmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:42:10 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1045F864
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 04:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669120929; x=1700656929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=70oScF9E2e8KOZen+yyr+BrcYQ7BJfDudm/5i0oxoBI=;
  b=CeAULWNpQY+UCTbjjbJzoYkjl9YlSHKQrS7DTzed4JrcyKEvkYHh0uAk
   7o0q/VPzposz0r0A5RZ+pQofQ/c2rG+iDs9tIubtEWLcRQjm/IA6AT1jE
   KSqlTluI4qx0lCcJiagY85R6zAkW7ytV7lzAdJyLbl4CydutaJsHmyIuy
   Y2RxABW9dRixOdE0bFKVkvn1s92QxcamxmEmcdh+HYFtBCklh5rQIzgQw
   /4wy3y6ccxPH6jn4GmDdmfr2Dy7IpoG5uewlKDa8ZEQYDWyxOqXN/mc7c
   h+cfqnJOHtZIqqeUkvJ7+sz8V0mmDomD9XZVOsEaHQaxo09/n/RSxw10d
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="301353286"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="301353286"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 04:42:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="766326547"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="766326547"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 22 Nov 2022 04:42:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxSbD-00Fpff-2g;
        Tue, 22 Nov 2022 14:42:03 +0200
Date:   Tue, 22 Nov 2022 14:42:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>
Cc:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-lgm-soc <linux-lgm-soc@maxlinear.com>
Subject: Re: [PATCH v3 0/4] x86/of: Fix a bug in x86 arch OF support
Message-ID: <Y3zDm1zaqpn8uMiV@smile.fi.intel.com>
References: <cover.1669100394.git.rtanwar@maxlinear.com>
 <Y3yTxRAVSOJTMuUu@smile.fi.intel.com>
 <a7a1b539-bd69-0227-ea93-b90f2e3ef2cd@maxlinear.com>
 <Y3yhFWQ7NHMArO74@smile.fi.intel.com>
 <fee4cf31-11be-9459-7d7b-ba8729dfb356@maxlinear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fee4cf31-11be-9459-7d7b-ba8729dfb356@maxlinear.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 10:45:12AM +0000, Rahul Tanwar wrote:
> On 22/11/2022 6:15 pm, Andy Shevchenko wrote:
> > On Tue, Nov 22, 2022 at 09:49:04AM +0000, Rahul Tanwar wrote:

...

> > I recommend to utilize my "smart" script [1] for sending series.
> > (You may take an idea from it how to prepare the Cc list close to proper 
> > one)
> > 
> > [1]: 
> > https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh 
> 
> Agree on the Cc list being wrong. Thanks for the script.
> 
> Quite useful. Could not understand how the script works for multiple 
> commits when you take count & version as inputs.

It starts from the commit <COMMIT_HASH>~$count and goes up. So it's basically
depth from the given commit (<COMMIT_HASH>).

> Also, where does it 
> create patches (format-patch)? It seems to get suitable to & cc list & 
> send emails to them. And the input is COMMIT_HASH. How do i use it for a 
> series with multiple commits & do i have to create patches on my own? 

It creates patches automatically in the same was as it's done by
`git format-patch`. That's why it accepts a lot of the parameters
which you usually add there.

Typical use for the series is

  ge2maintainer.sh -v 1 -c 4 HEAD~0 --annotate --cover-letter

Note, that your editor should be able to handle several files to edit
(e.g. vim supports that mode).

-- 
With Best Regards,
Andy Shevchenko


