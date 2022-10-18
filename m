Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04487603491
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiJRVDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiJRVDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:03:05 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5153BC4587
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 14:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666126973; x=1697662973;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HaNZmq41zK29iOnkJK28GdD5R+VHcXlZCvrP5NcvQyo=;
  b=VDnNTv+6K7/mM81eb0AkSO8eZ+eNSDa4KNZFSrmCWpoAncWRfZVpD4eG
   u9Jk+MrQCge1rufRo+w5KVemKaHAyBlpBuqhb4rdlBR6hxxek0+66i5fW
   PtpFmxqAGggF678MMTE/cIuz+Ti1HTpCJPRtZFm9pdMhFocf/V+O+DWNg
   vZiGR4ojlr+RghVrsIaaVl+UzH284rd3KpylReh8IydfrUM782Ji1gKT9
   MYJiVm/E/EYnhP6HGUWFECj6ieFrQcEKnaZGqw/a7xCWzuFMHzT40uNHT
   ntJbPjnHC57eilYYsVA+BK+LIBWT21t62p3nfJxoLzK2d1yth8pH8tcC8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="307343803"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="307343803"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 14:02:45 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="631323993"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="631323993"
Received: from jjsopko-mobl.amr.corp.intel.com (HELO [10.213.163.40]) ([10.213.163.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 14:02:44 -0700
Message-ID: <cd8939c7-6194-53f5-14e1-89bef945fb47@intel.com>
Date:   Tue, 18 Oct 2022 14:02:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCHv10 09/15] x86: Expose untagging mask in
 /proc/$PID/arch_status
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
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
References: <20221018113358.7833-1-kirill.shutemov@linux.intel.com>
 <20221018113358.7833-10-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221018113358.7833-10-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/22 04:33, Kirill A. Shutemov wrote:
> Add a line in /proc/$PID/arch_status to report untag_mask. It can be
> used to find out LAM status of the process from the outside. It is
> useful for debuggers.

Considering that address masking is not x86-specific, it seems like this
needs a better home (another file in /proc).

This could even be left out of the series for now, right?  Nothing,
including the selftests, depends on it.
