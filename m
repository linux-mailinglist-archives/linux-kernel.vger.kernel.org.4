Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33FC65CB63
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 02:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbjADB1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 20:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjADB1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 20:27:09 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EBF13D5A
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672795629; x=1704331629;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=DXoPEIMd6UVnQDWYw06WocR2X2QCmcLou+Tw+fjtH4w=;
  b=SQkUT16Cboue3692VZH8a+niSedVVbL1A5FV/sxnQUU6JYEIJW0duixR
   RnV6Qbujtd2r0TcRc8yjk/GrtkFfZUXSUD73NSVTYafVal5dHVP8J5CJV
   g6eglIpiz1ZAMCL4KD9QedCej04KKrQ4SyQrSUo9rxlReiHU/LscC3XhR
   n/221bHCRcBtECkkmBNn2TjLumwqxZGSF/ZuR+I3nO4t5/kwUprV7mVBn
   dA1y5L1qsaUapXgbopunSc1pXGgr3mCKe8tDycefvTwOAFy71pNf9Rjp1
   lzBHCrZWM6tCMstI18lmaCYeCSi/XvmRWG5ofsTJ3OJIBbS4bu3SysOjr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="323037383"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="323037383"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 17:27:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="743679335"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="743679335"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 17:27:05 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Matthew Wilcox" <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        "Alistair Popple" <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH 6/8] migrate_pages: move migrate_folio_done() and
 migrate_folio_unmap()
References: <20221227002859.27740-1-ying.huang@intel.com>
        <20221227002859.27740-7-ying.huang@intel.com>
        <926CD8E3-1B52-454B-9026-FACE622666BE@nvidia.com>
Date:   Wed, 04 Jan 2023 09:26:11 +0800
In-Reply-To: <926CD8E3-1B52-454B-9026-FACE622666BE@nvidia.com> (Zi Yan's
        message of "Tue, 03 Jan 2023 14:02:52 -0500")
Message-ID: <87cz7vnl8s.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zi Yan <ziy@nvidia.com> writes:

> On 26 Dec 2022, at 19:28, Huang Ying wrote:
>
>> Just move the position of 2 functions.  There's no any functionality
>> change.  This is to make it easier to review the next patch via
>> putting code near its position in the next patch.
>
> This probably can be merged into prior patches.

I will check whether this will make patch harder to be reviewed.  If
not, I will merged them.  Previously, I had merged this patch with the
next patch in series, and it turns out this make the patches much harder
to be reviewed.

Best Regards,
Huang, Ying

