Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105115F8702
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 21:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJHTHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 15:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJHTHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 15:07:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10F13740E
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 12:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665256061; x=1696792061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4kB/2FdBRDRaObqrdIgUdVFwdTU9bXgQ20I+d3z2XxA=;
  b=djKvaRrf74SsUFebxUlvFaLhdWrIJQFeqUu6XCSTt/Aq1qiL+qDX7m9R
   zTOPn0PKp/WLwL8yyrNV6cH2vSQu+WubVFOhYcUAXd/Mf/qojB8DffbvF
   rEoS8q85JFJa6L/hDEZdjOYyCQOhK4mR+sHvLWEzd+nIwieWJKKttJY3H
   SlNiMG9j36enJiwLoxaFqRMkAiGSAAMxcpizZ+rTHqvNZ48UXokwHcjAJ
   3vqulA8EgcBtyn7vJHsxKxpINJHdSJaYCFwHiupTCRW4t23iwYZOvx85R
   3wVXYY9ZW1VNmmJNdxwWrHX0fcbIcfLYs8du9h5FX9p1UJKJNREoP79va
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10494"; a="287207991"
X-IronPort-AV: E=Sophos;i="5.95,170,1661842800"; 
   d="scan'208";a="287207991"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2022 12:07:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10494"; a="767946994"
X-IronPort-AV: E=Sophos;i="5.95,170,1661842800"; 
   d="scan'208";a="767946994"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 08 Oct 2022 12:07:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ohFAg-0049dZ-0g;
        Sat, 08 Oct 2022 22:07:38 +0300
Date:   Sat, 8 Oct 2022 22:07:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, arnd@arndb.de,
        lee@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "mfd: syscon: Remove repetition of the
 regmap_get_val_endian()"
Message-ID: <Y0HKeTWneX12OP+Y@smile.fi.intel.com>
References: <Y0GZwkDwnak2ReTt@zx2c4.com>
 <20221008154700.404837-1-Jason@zx2c4.com>
 <CAHk-=wiqN9EJ6zKXh21EQ2CV-B7_oDJKy73+yhRwtbNMWCzfVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiqN9EJ6zKXh21EQ2CV-B7_oDJKy73+yhRwtbNMWCzfVA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 08, 2022 at 09:45:16AM -0700, Linus Torvalds wrote:
> On Sat, Oct 8, 2022 at 8:47 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > This reverts commit 72a95859728a7866522e6633818bebc1c2519b17. It broke
> > reboots on big-endian MIPS and MIPS64 malta QEMU instances, which use
> > the syscon driver. Little-endian is not effected, which means likely
> > it's important to handle regmap_get_val_endian() in this function after
> > all.
> 
> Hmm. The revert may indeed be the right thing to do, but we're still
> early in the release process, so let's go through the channels.
> 
> I do note that commit 72a95859728a points to commit 0dbdb76c0ca8
> ("regmap: mmio: Parse endianness definitions from DT") as the reason
> why it's not necessary any more, but that commit
> 
>  (a) doesn't seem to set config->val_format_endian (which somebody may
> care about). It does set the operation pointers etc, but doesn't set
> that field.

It should.

of_syscon_register() calls to regmap_init_mmio() with syscon_config data
structure as a parameter.

Before 72a95859728a the of_syscon_register() fills the val_format_endian with
something it parses from DT. After that commit the default value (0) is
REGMAP_ENDIAN_DEFAULT. Now when __regmap_init_mmio_clk() is called it
creates a context base on DT since the field is 0.

>  (b) it uses regmap_get_val_endian(), which doesn't actually even look
> at the OF properties unless config->val_format_endian is
> REGMAP_ENDIAN_DEFAULT

Which is 0!

> so the code that commit 72a95859728a removed was actually quite a bit
> different from the code in commit 0dbdb76c0ca8.
> 
> Maybe the problem is related to those semantic differences, and is
> easy to fix for somebody who knows what the heck that stuff is doing.

But while looking into this, I think I know what is going on,
of_syscon_register() calls regmap API with dev == NULL, hence
fwnode == NULL, hence nothing to read from DT.

But default (via regmap bus configuration) is LE and LE works fine.

> And if not, please just send me the revert through the normal channels. Ok?

Yeah, revert is a good move here.

For real deduplication we need to either add a regmap_get_val_endian() kind
that takes fwnode as a parameter and call it explicitly or propagate fwnode
to __regmap_init_mmio_clk() somehow.

-- 
With Best Regards,
Andy Shevchenko


