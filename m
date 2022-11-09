Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E690622F4A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiKIPoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiKIPoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:44:44 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B5C1117C;
        Wed,  9 Nov 2022 07:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668008683; x=1699544683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7cvXQLdjnZSAwelqwxNw9hgKkTj3AieEeADHrvNo7TQ=;
  b=BLYwWUYSwHrx6InVhSUkdCbvciGPKaDRRwa+UYYR2hqMRdGh0OmQrnE5
   C8nkXR7Bjl8HJLvAtOmLwE3uYQQpd1M+e0Tzi676P5pV/wsaPR+xk8E0k
   8ifhs51VsO4Euses582Q1Php6zSczcy+uhKk/zQMHvMp3d9djzrUyXNT1
   Zx+Q9MIg5qlONXdtwWOHwxGoQV8k+/GFMJAt5VH9+drJyw1caUTFx75uR
   IPfPYDWs7G7+n/t+5CqPrE4iJlz6FH/pmxrnFIr9vzF6T6Q014W2VauHE
   FjbtsT+qjjMxrhzuzEcB11smanchQrmNrSTDL7eR5ygAt5npP4uP3gHcy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="290727041"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="290727041"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 07:41:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="881969554"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="881969554"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 09 Nov 2022 07:41:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1osnCo-009oEy-2V;
        Wed, 09 Nov 2022 17:41:34 +0200
Date:   Wed, 9 Nov 2022 17:41:34 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>
Subject: Re: [PATCH v8 1/2] pinctrl: pinctrl-loongson2: add pinctrl driver
 support
Message-ID: <Y2vKLqV+IiJh4O1o@smile.fi.intel.com>
References: <20221109061122.786-1-zhuyinbo@loongson.cn>
 <fc52c692-4cbd-e5f9-2e62-d05b5330052a@loongson.cn>
 <CACRpkdbu-gqNBK0=L8pOr2TwYGOv2MUvFxzYiBNfJ5KyJT+A8g@mail.gmail.com>
 <Y2vA09rQSbCRX+rL@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2vA09rQSbCRX+rL@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 05:01:39PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 09, 2022 at 09:30:03AM +0100, Linus Walleij wrote:
> > On Wed, Nov 9, 2022 at 7:42 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
> > 
> > > I had added some changes in these series patch in v8, please help add my
> > > change and merge it into your tree and sync it to linux-next.
> > 
> > Yeah no problem, I took out the v7 version and applied this one instead.
> 
> It needs more work.

I mean it still needs more work, the ugliest part is the castings for IO
accessors. Must be fixed beforehand.

-- 
With Best Regards,
Andy Shevchenko


