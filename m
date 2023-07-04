Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E27746B46
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjGDH4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjGDH4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:56:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46634171C;
        Tue,  4 Jul 2023 00:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688457377; x=1719993377;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pY7UO1dW1lF5ty9U5RtleFnvnVJOmebuE8AT5wlps04=;
  b=aOn2pb2yAexvTtgAeppdB4uHTK5Z88Ud7o2oxzVHIlKq58Zr72pg69Er
   xb2eVfsSAtSQplJcLHxNiy2SEUfP5Hd5Z6I5JYrdBGUZs9fGHisfc9rQw
   jPWFD7cgGqhAkjnGpAzFaoTu4G7MWm+ThWZVuT0oH2zgArVUZRUMGWFra
   70HBCGA7HVYNckMtJIwjhZXLYETyYi+yCLMjWAPz/9bnbJP3govdZ25YG
   FgZ0VBUAAaFjNyFIa960uC6mRUh1DHvzRosNo4z2DUeoUm/jzYWvNW4Yi
   FXsFMVnCv5HeK8J+2Xe1ffaVyuck7PO+cGOum7ZRllCYk6YoXz8mIUISU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="347854585"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="347854585"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 00:56:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="808838387"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="808838387"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jul 2023 00:55:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qGatA-0024jp-0X;
        Tue, 04 Jul 2023 10:55:56 +0300
Date:   Tue, 4 Jul 2023 10:55:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?utf-8?B?5bCk5bq35LuB?= <youkangren@vivo.com>
Cc:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Damian Muszynski <damian.muszynski@intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Srinivas Kerekare <srinivas.kerekare@intel.com>,
        "open list:QAT DRIVER" <qat-linux@intel.com>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "opensource.kernel" <opensource.kernel@vivo.com>,
        =?utf-8?B?6Lev57qi6aOe?= <luhongfei@vivo.com>
Subject: Re: [PATCH v4] crypto: qat - Replace the if statement with min()
Message-ID: <ZKPQi+C/9ibEVTfa@smile.fi.intel.com>
References: <PUZPR06MB5936BE4F5D5353CF2A08A07BAA2EA@PUZPR06MB5936.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PUZPR06MB5936BE4F5D5353CF2A08A07BAA2EA@PUZPR06MB5936.apcprd06.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 07:45:42AM +0000, 尤康仁 wrote:
> Hi Andy,
> 
> Can you tell me what is your tag? I haven't found it in Re: [PATCH v3]
> crypto: qat - Replace the if statement with min()

Please, avoid top-postings.

Tag in this case is the line started with Reviewed-by:.

Please, read this [1] to get familiar with the tags and process.
And be respectful to the reviewers in the future.

[1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

> -----Original email-----
> On Tue, Jul 04, 2023 at 02:56:39PM +0800, You Kangren wrote:
> > mark UWORD_CPYBUF_SIZE with U suffix to make the type the same with
> 
> You need to respect English grammar and punctuation.
> Here should be
> 
>   Mark...
> 
> > words_num and replace the if statement with min() in
> 
> (drop trailing space)
> 
> > qat_uclo_wr_uimage_raw_page() to make code shorter
> 
> ...and here the period is missing.
> 
> Also, Haven't I given my tag? Why it's not added?
> 
> > Signed-off-by: You Kangren <youkangren@vivo.com>
> > ---
> 
> Where is the changelog from v3? What had been changed so far?

-- 
With Best Regards,
Andy Shevchenko


