Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288747424AA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 13:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjF2LGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 07:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjF2LG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 07:06:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20ABE4C;
        Thu, 29 Jun 2023 04:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688036788; x=1719572788;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W2cppJmOBSXO1P/UyN7qi1Jn6DHPKLt2MNzx8ozIQCM=;
  b=CvW9LfROqOgOvNzJJRdMjmVfwyVWgl2GfgserDil75itPleHkd2c6+pP
   oH06yIo46nmac2AV5KSYZhwbaGCRE1xSZupQpSUmXu/0oX1SVfgsGaNRF
   QDb+CGkV9ysRqMRQSTlhSkmg5QGxVVrT3BzEtZNzbtBvovEuZTMiB0HfW
   BU3nS+yXel3m3b+QiWQnPTPzi1ynZ01rCyyd/MKWzRjxQMC25tteNmLCJ
   ifGdfkVe4kpg4sG0Du0R/7Ugz83CoIwYapULCeOWjoN2b/xVMhouf4WTk
   oYnL7HC9SpWhfYrH6tmfV4KEoO84NErU9MDVZlE4krg/wJHGotjnGisBh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="392803824"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="392803824"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 04:06:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="694586230"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="694586230"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 29 Jun 2023 04:06:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qEpTf-000ppe-2t;
        Thu, 29 Jun 2023 14:06:19 +0300
Date:   Thu, 29 Jun 2023 14:06:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     ruihongluo <colorsu1922@gmail.com>
Cc:     gregkh@linuxfoundation.org, ilpo.jarvinen@linux.intel.com,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, luoruihong@xiaomi.com,
        wengjinfei@xiaomi.com, weipengliang@xiaomi.com
Subject: Re: [PATCH v2 1/1] serial: 8250: Preserve original value of DLF
 register
Message-ID: <ZJ1lq8mVU8NbZRcV@smile.fi.intel.com>
References: <ZJ1M5QvyWzgWNlpE@smile.fi.intel.com>
 <20230629094204.60246-1-luoruihong@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629094204.60246-1-luoruihong@xiaomi.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 05:42:05PM +0800, ruihongluo wrote:
> This commit is aimed at preserving the original value of the
> DLF(Divisor Latch Fraction Register). When the DLF register is
> modified without preservation, it can disrupt the baudrate settings
> established by firmware or bootloader , leading to data corruption
> and the generation of unreadable or distorted characters.

> Fixes: 701c5e73b296 ("serial: 8250_dw: add fractional divisor support")
> 

To make it a tag you should avoid blank lines in the tag block.

> Signed-off-by: ruihongluo <luoruihong@xiaomi.com>
> ---
> v2:
> - added fixes tag

Actually not. See above.

And what about the  rest of the comments?

...

> Just wanted to drop a quick note to say thanks for your help with git
> send-email and code modifications.
> Your assistance on the details was much appreciated.

You're welcome!

> Ruihong Luo

This seems needs to be in your Git config:

$ cat ~/.gitconfig
[user]
	name = Ruihong Luo
	email = luoruihon@xiaomi.com

-- 
With Best Regards,
Andy Shevchenko


