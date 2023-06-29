Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B3C74270F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjF2NNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 09:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjF2NNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:13:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976062116;
        Thu, 29 Jun 2023 06:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688044421; x=1719580421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ybmdUv2+ejnKmER1jcJZx9b+/IRmHl5y7rWMPhxbP+E=;
  b=TeEw6bSQJuCLZvcikwNsWh3YdG/t8sIdhTUhSrZDOLSBRfvvy8QfqSKO
   FpFyGWDMI6cdwZ7i4ZKNq+7L8+erJ3UZcJKyspx1zuRHQhnehvSodjhdV
   c7fVZtX21aOpiej2R/AI68vSsd+5WZOrfNXRlYkXk+5ge6Zyo2OmafEJO
   Pj7S31flhOcRaTCI77rw1BRlQ2fnU/cFPqOQascst14l0sEaQ2kM3ZgJA
   V4oKKVACvMsG6/njNgP98UF65qPbQoQApOes3Gz8LZX6+5lqXYAdiIJIc
   Ty3wRBN3KKVDOAZz/S437J79ULyHhotzvIL5lqOc26KYBZRQv2t30jPE5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="365565384"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="365565384"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 06:06:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="807293763"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="807293763"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jun 2023 06:06:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qErMG-000rXO-1I;
        Thu, 29 Jun 2023 16:06:48 +0300
Date:   Thu, 29 Jun 2023 16:06:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ruihong Luo <colorsu1922@gmail.com>
Cc:     gregkh@linuxfoundation.org, ilpo.jarvinen@linux.intel.com,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, luoruihong@xiaomi.com,
        weipengliang@xiaomi.com, wengjinfei@xiaomi.com
Subject: Re: [PATCH v2] serial: 8250: Preserve original value of DLF register
Message-ID: <ZJ2B6I+ShqyJJJ+o@smile.fi.intel.com>
References: <ZJ1lq8mVU8NbZRcV@smile.fi.intel.com>
 <20230629123529.62232-1-luoruihong@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629123529.62232-1-luoruihong@xiaomi.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 08:35:30PM +0800, Ruihong Luo wrote:
> This commit is aimed at preserving the original value of the

Preserve the original value...

> DLF(Divisor Latch Fraction Register). When the DLF register is

Divisor Latch Fraction (DLF) register...

> modified without preservation, it can disrupt the baudrate settings
> established by firmware or bootloader , leading to data corruption

...bootloader, leading...

> and the generation of unreadable or distorted characters.

> Fixes: 701c5e73b296 ("serial: 8250_dw: add fractional divisor support")
> Signed-off-by: Ruihong Luo <luoruihong@xiaomi.com>
> ---
> v2:
> - add a tag

It's a v3 and still some comments are not (yet) addressed:
1) your from header in email != SoB;
2) do not use In-reply-to email header for the new patch versions;
3) the commit message should be amended as I pointed out above again.

It will go nowhere if you continue ignoring reviewers' comments.

-- 
With Best Regards,
Andy Shevchenko


