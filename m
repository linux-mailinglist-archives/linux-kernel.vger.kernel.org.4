Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2B3740F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjF1Kr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:47:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:49263 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230480AbjF1Kqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687949209; x=1719485209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V6BRz1ccabVF0NLRCSxDQU25VaPJciuHd5oFM5K9ktA=;
  b=XFlw/I3vJqq/L+yW2CdONaTIJRL9uUJKU4gAjcJZok/fXEhh6ACRuUWX
   qv8mCb7Onrwue4y05uB5G0JcnUfnRGDj4P6nU8WHcT6K6qOZEf8mk6mvk
   10SDVpMen9gZjWhN6opvNECTB44xnLs8Uajb7nGTUGLGlSJrSaF+yAbkp
   p+mNeuXXrt/PdKqB1pydVYAvzZ81RH8jm1nLUKMRSxR0At4H673D095WD
   AezuNFf9YVM91BHpd4kWJz2pbdOrWprgtCYX0F+M350qtAKtYF4NvFGyq
   pRj/ea+I5tHBtvMu4H9USZeHcJ4aewkGsbyyBwcuyvdna9MDXAgq2Xoax
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="427817225"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="427817225"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 03:46:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="752194298"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="752194298"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 28 Jun 2023 03:46:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qEShA-000Z0B-1L;
        Wed, 28 Jun 2023 13:46:44 +0300
Date:   Wed, 28 Jun 2023 13:46:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     You Kangren <youkangren@vivo.com>
Cc:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Damian Muszynski <damian.muszynski@intel.com>,
        Srinivas Kerekare <srinivas.kerekare@intel.com>,
        "open list:QAT DRIVER" <qat-linux@intel.com>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v2] crypto: qat - Replace the if statement with min()
Message-ID: <ZJwPlLC7/sJP8U7u@smile.fi.intel.com>
References: <20230627071726.20578-1-youkangren@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627071726.20578-1-youkangren@vivo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 03:17:24PM +0800, You Kangren wrote:
> Replace the if statement with min_t() to simplify the code

...

> -		if (words_num < UWORD_CPYBUF_SIZE)
> -			cpylen = words_num;
> -		else
> -			cpylen = UWORD_CPYBUF_SIZE;
> +		cpylen = min_t(unsigned int, words_num, UWORD_CPYBUF_SIZE);

min_t() can be dangerous some times.

To make it robust I would suggest to use min() and mark UWORD_CPYBUF_SIZE
with U suffix to make the type the same.

-- 
With Best Regards,
Andy Shevchenko


