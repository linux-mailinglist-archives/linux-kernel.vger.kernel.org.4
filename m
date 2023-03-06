Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC286AC34B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjCFObz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjCFObs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:31:48 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B79183FC;
        Mon,  6 Mar 2023 06:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678113066; x=1709649066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SksSVVJC6Th1nYSN79c+dSdt06LId3S3q3vX1EepjTk=;
  b=bLiM5Fsf/HxbJaj498hJZmNv9N2g+NRix0a9/Dvxug5lGspBdc1MQRqi
   Fov0WKwTNRpEKhi4fGwB13rJq6jDrasyLGjpOpCngchflBDovB7Sk3iPU
   XBXF4tbdPQUIQkNn96ks36Rf7pZlddK1ee89s3aAOBlxhW8yRM6g21n/Q
   93AKwwO0atIgPpeX9qJrl3yuPM9xbHNU066RAXklWdindjv8D6JmfNqH2
   EhtEHwlfHR6Xu/d/C0GLoHlklPmOtASpw9Sdwb6Ycd2B7kyPL3Z5dP8MA
   7cHNWPdhawM7eD1pTG0wbsdaTsGgUr8zA0ae8ays55ObAhya+CLcqXEpv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="315223089"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="315223089"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 06:29:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="765234872"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="765234872"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Mar 2023 06:29:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pZBq5-00GTZD-2K;
        Mon, 06 Mar 2023 16:29:21 +0200
Date:   Mon, 6 Mar 2023 16:29:21 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] regmap: Reorder fields in 'struct regmap_bus' to save
 some memory
Message-ID: <ZAX4wSFwKwr+2pZY@smile.fi.intel.com>
References: <077ca39622c8870a3ea932298a9cec34f7a8295a.1676363976.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <077ca39622c8870a3ea932298a9cec34f7a8295a.1676363976.git.christophe.jaillet@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 09:40:14AM +0100, Christophe JAILLET wrote:
> Group some bool variables to reduce hole and avoid padding.
> On x86_64, this shrinks the size from 136 to 128 bytes.
> 
> As an example:
> 
> $ size drivers/base/regmap/regmap-fsi.o (Before)
>    text	   data	    bss	    dec	    hex	filename
>    4837	    136	      0	   4973	   136d	drivers/base/regmap/regmap-fsi.o
> 
> $ size drivers/base/regmap/regmap-fsi.o (After)
>    text	   data	    bss	    dec	    hex	filename
>    4701	    136	      0	   4837	   12e5	drivers/base/regmap/regmap-fsi.o

FYI: we have scripts/bloat-o-meter for this.

-- 
With Best Regards,
Andy Shevchenko


