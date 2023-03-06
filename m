Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC256ABDFA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjCFLQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjCFLPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:15:44 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9233313D47;
        Mon,  6 Mar 2023 03:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678101335; x=1709637335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RR/M7LB9tttv8lFF7BDZcQHBMimkmWhTKT0FsCi42bc=;
  b=Lig3Nq+C0hVAUns7BV3t9SFCsrrdIBWtw9i0p2z1fUck5hCfrAbVUJwz
   UoZlbgzZZlflJQTtT/A+CC8JNIUyodHpuOWPqlquLBbff4vWbbyeNMiFy
   Wkf8UU/iHEtKV0fxIJnXz/JrKr01TPMTMs1GA/TqQG6L0BavsyPidheQc
   MhSOSaCfkyWQLmPpLbPU+kiHGboF6IV5QUe1wDYwzQvlkcuvK5afbnWl1
   tKiyB5gRTmWqUrZuAAhj8Qbukor+0Rn3rnnUWWkes4dBFjjM7p8vaIJN7
   6sdm5+7kZ4caWuZ1+rbneZGEpg5ehZEMt1zZlJJ2s8qdJMvqiEfT4Q8tN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="333003376"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="333003376"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 03:15:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="626124682"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="626124682"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 06 Mar 2023 03:15:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pZ8oU-00GJpZ-1Z;
        Mon, 06 Mar 2023 13:15:30 +0200
Date:   Mon, 6 Mar 2023 13:15:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio: light: Add gain-time-scale helpers
Message-ID: <ZAXLUvdrqVWiGkHH@smile.fi.intel.com>
References: <cover.1677750859.git.mazziesaccount@gmail.com>
 <9895826669118a1aa1db3f85c2610fa759426c33.1677750859.git.mazziesaccount@gmail.com>
 <20230304183557.2ea54737@jic23-huawei>
 <081bc734-bfac-1eed-cc2a-c85cd2eac13e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <081bc734-bfac-1eed-cc2a-c85cd2eac13e@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2023 at 09:42:22PM +0200, Matti Vaittinen wrote:
> On 3/4/23 20:35, Jonathan Cameron wrote:
> > On Thu, 2 Mar 2023 12:57:54 +0200

...

> > I've been meaning to finish namespacing the rest of IIO but not
> > gotten around to it yet.
> > As this is a separate library probably makes sense to have a unique
> > namespace for it that the users opt in on.
> > Perhaps IIO_GTS makes sense?
> 
> Thanks. I think I'll use that. Although, as all of the symbols are prefixed
> with iio_gts - if I really saw a risk of symbol clash it would probably make
> more sense to use just about anything else ;) This because if someone else
> were prefixing symbols with iio_gts - he would likely be using the exactly
> same namespace.

There is another aspect, i.e. global namespace pollution. This saves memory
if not used.

-- 
With Best Regards,
Andy Shevchenko


