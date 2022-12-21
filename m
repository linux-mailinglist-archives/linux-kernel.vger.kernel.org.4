Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029C7653485
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbiLUREv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLUREt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:04:49 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5991130
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671642288; x=1703178288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=toZEkgvadSsma8a/8EOi7qiCjxBdc+ASRB09eDTlogU=;
  b=HyvOzN1mfz9JehW+EFYaMmL2+1hKArAo3VNv3eiEnUsgQWBW28Sdc46p
   tzZEeTo/8wCX5iQs4DKp5vwloTXu71DPKxM8dv0dOEMavy6zfx1N4qj2U
   6THd3OFM/rr+dmrheWLUNZuZc9xhP1Q85ftbb8h3p0dwYUlr+fHCce0zA
   ccO6N4TeNJlTEuvHsBopTw5aa2kSQonrC587ewQitJaTh5tmzbkRumg+U
   J2op9g2N3kRetsa3IbxvEpXllImwQGoFW703HOm1KoIFZNMzL8idrRDvn
   q/Oshtq7lohspQ8DYo6CegjhFT/8c1mdQIJg0SCYHNA1o4jfJjrM+7boq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="303351581"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="303351581"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 09:00:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="793765283"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="793765283"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 21 Dec 2022 09:00:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p82SW-00Dasc-2V;
        Wed, 21 Dec 2022 19:00:48 +0200
Date:   Wed, 21 Dec 2022 19:00:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joe Perches <joe@perches.com>, Petr Mladek <pmladek@suse.com>,
        Matthew WilCox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v3 1/4] mm/hwpoison: remove MF_MSG_SLAB from
 action_page_types
Message-ID: <Y6M7wJu6ikxu+zkB@smile.fi.intel.com>
References: <20221218101901.373450-1-42.hyeyoo@gmail.com>
 <20221218101901.373450-2-42.hyeyoo@gmail.com>
 <20221220235246.GA2334024@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221220235246.GA2334024@hori.linux.bs1.fc.nec.co.jp>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 11:53:11PM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Sun, Dec 18, 2022 at 07:18:58PM +0900, Hyeonggon Yoo wrote:
> > As suggested by Naoya [1], identify_page_state() is never
> > called when handling memory error on a slab page.
> > 
> > Clean this up before moving PG_slab flag to page_type in later patch.

> > [1] https://lore.kernel.org/linux-mm/Y2s+dnBsHAJu19ob@hyeyoo/#r

You can make it to be a Link: tag.

-- 
With Best Regards,
Andy Shevchenko


