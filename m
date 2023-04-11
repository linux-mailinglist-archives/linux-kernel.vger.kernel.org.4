Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37286DD9B5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjDKLnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjDKLnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:43:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0964234
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681213376; x=1712749376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MmgttL6Z2ite1qRkYYnR8yRMQm4E4KBl2+ANiydF4NE=;
  b=hYdUuSSYYzJtZwIPbcB6StX6XTvxxB9FKbZOj/5SIkr23EQSJnn+RkrD
   SKbOddUah1oGGuPYXj1Ej34VbK+eeVlAGOgD4OzmqSqMfMOuLB/UH+nzc
   KG4kkNVSOTXhsjJKmPQ5NpROpc6A4iiVdGG7Yy8ixRL38qHxqDIXUsTHu
   7Rw5XpfgC8OTwg61wpNseqnXFPValzSdDuGwGNH42VJCfY+RkvffE5TLp
   ZHiqArblvkVv73kNofTCRmGt+qxs7w0ichOA2WdXhshKJ82rx1oz1iWyS
   ckD0HFqQejjO1LFBu6kxRc+iEhi9bU8yGWh9OFnrj/3U8dFihvVqel+Lm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341085905"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341085905"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 04:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="721175700"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="721175700"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 11 Apr 2023 04:42:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pmCOZ-00FFDR-2f;
        Tue, 11 Apr 2023 14:42:43 +0300
Date:   Tue, 11 Apr 2023 14:42:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v2 2/5] extcon: Get rid of not really used name field in
 struct extcon_dev
Message-ID: <ZDVHs7JB4Na4g+De@smile.fi.intel.com>
References: <20230405152745.24959-1-andriy.shevchenko@linux.intel.com>
 <20230405152745.24959-3-andriy.shevchenko@linux.intel.com>
 <4632ce69-2a94-0c33-9a76-b97596436e24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4632ce69-2a94-0c33-9a76-b97596436e24@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 04:26:35AM +0900, Chanwoo Choi wrote:
> On 23. 4. 6. 00:27, Andy Shevchenko wrote:

...

> > -	if (IS_ERR_OR_NULL(edev->name)) {
> > -		dev_err(&edev->dev,
> > -			"extcon device name is null\n");
> > -		return -EINVAL;
> > -	}

JFYI: this is a dead code in case you want to clean it up.
Since the patch is NAKed, I'm not going to split it. Hence
just for your information.

-- 
With Best Regards,
Andy Shevchenko


