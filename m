Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4964641793
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 16:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiLCPl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 10:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiLCPlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 10:41:55 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F51218A7;
        Sat,  3 Dec 2022 07:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670082114; x=1701618114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9CAAZYx5QtB8bGk6Bu4vfzSdNz5rmp6CUGug+ibS7H4=;
  b=dyhGoyWLRr6w2+5ymfsf2vik2Zcc0fYOg1te/YQc1dLbBd1bkTC1cxwY
   3Qz9IB1QSM+f4x1++/81qPqrGF0+Fbc6XDGGdGMTELiet7Rvje+BW8S2s
   9K44NIoLmI/jEwJ3aUt4lqYFr7qJ4NGC29gmgDcf8Jgv8wNYGX04fA4tB
   e4oHrf9bSGCTibbXWiKIETq3o9U7HmCNk5Tr2cor19c+T7qrJ2pO+JAxs
   Ykl5H82M6H/EPGe57MoytgWN7X4BHjjzYCO4DR7/Gga8FHmmgPWChB95L
   Sz/Q6xRHgeeBXqJq/0UQHcbdZFaGz9GgR8Gz8R/Z94927j7fU/+vJfDtU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="314835236"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="314835236"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2022 07:41:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787605439"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="787605439"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 03 Dec 2022 07:41:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1p1UeB-00432n-1I;
        Sat, 03 Dec 2022 17:41:47 +0200
Date:   Sat, 3 Dec 2022 17:41:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Juxin Gao <gaojuxin@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        Arnaud Patard <apatard@mandriva.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
Subject: Re: [PATCH v10 1/2] gpio: loongson: add gpio driver support
Message-ID: <Y4tuOyKOdZcQ4sjm@smile.fi.intel.com>
References: <20221201123220.7893-1-zhuyinbo@loongson.cn>
 <CACRpkdZm-4-5625szX_VqJoQH1OQZnw+jH3SqWsb9nr3S0Nbmw@mail.gmail.com>
 <35ff475a-e925-81eb-ffeb-448be43f59ff@loongson.cn>
 <Y4tq4i2CJdnQWFZC@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y4tq4i2CJdnQWFZC@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2022 at 05:27:31PM +0200, Andy Shevchenko wrote:
> On Sat, Dec 03, 2022 at 06:53:20PM +0800, Yinbo Zhu wrote:
> > 在 2022/12/3 18:03, Linus Walleij 写道:
> > > On Thu, Dec 1, 2022 at 1:33 PM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
> > > > +config GPIO_LOONGSON_64BIT
> > > > +       tristate "Loongson 64 bit GPIO support"
> > > > +       depends on LOONGARCH || COMPILE_TEST
> > > > +       select GPIO_GENERIC
> > > > +       select GPIOLIB_IRQCHIP
> > > If the kernelbots start complaining you might need to add a:
> > > 
> > > select IRQ_DOMAIN_HIERARCHY
> > > 
> > > here.
> > 
> > Bartosz had merged my patch and I will add a change on top of the existing
> > series.
> 
> I don;'t know why he had done that, the driver requires a lot of cleanups,
> e.g. why it uses acpi.h, what that "nice" container of the platform device for.

+ we have macros for get_direction() returned values and so on.

-- 
With Best Regards,
Andy Shevchenko


