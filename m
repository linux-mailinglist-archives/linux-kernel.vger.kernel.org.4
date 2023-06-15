Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F9A731CE7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241579AbjFOPon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241806AbjFOPoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:44:25 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87296123;
        Thu, 15 Jun 2023 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686843864; x=1718379864;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RXbiqLl8GWsL9ZGg7ZpV3Yt5NwEmT30I05Aoa4zNtRk=;
  b=aagqDEz7d/9T8HgUyOFDewNFIyAunk3chAK120Dz44VRoFOkaSVpk/0P
   WDTP51nYilfxz6t/R1TRSpEk3VK+plR43qQQjqVCbmodZk0coGpkuvP14
   CosY0lt2sWwVq1tWYbIUxp92It7nHKfgBd5KUyUvW5kiHcdHH/iIzn38q
   Lg0NRls+sIVZL2VwDiJviacVEwxMU+Grs69XO9AVvlznZzf99EXWIW1F1
   dCfDE10/ooLTRl5G5hHtTSwN/HqRrFXU7Y8TlkXJF2qyxf9ubDJ5mMSvn
   GvHZk9vzHGwA+dMoskIdle/CWZEyGbw4HlohpOTU2bKFBoGE6N9veSfNA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="358943554"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="358943554"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 08:44:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="742277036"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="742277036"
Received: from makuznet-mobl1.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.168.134])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 08:44:17 -0700
Date:   Thu, 15 Jun 2023 08:44:15 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mike Rapoport <rppt@kernel.org>, x86@kernel.org,
        linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derick Marks <derick.w.marks@intel.com>
Subject: Re: [PATCH v2 1/2] x86/numa: Introduce numa_fill_memblks()
Message-ID: <ZIsxz6Swf54a66FN@aschofie-mobl2>
References: <cover.1686712819.git.alison.schofield@intel.com>
 <9fcc548a6b4727cb2538e5227d7bad2e94e6adaf.1686712819.git.alison.schofield@intel.com>
 <20230615083407.GB1683497@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615083407.GB1683497@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 10:34:07AM +0200, Peter Zijlstra wrote:
> On Tue, Jun 13, 2023 at 09:35:24PM -0700, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > numa_fill_memblks() fills in the gaps in numa_meminfo memblks
> > over an HPA address range.
> 
> What's with the Host part, should that not simply be PA ?

Yes, it should be PA.

The HPA acronym usage is CXL-land language, where we qualify
qualify physical addresses as either HPAs and DPAs (Device),
seeping in needlessly.


