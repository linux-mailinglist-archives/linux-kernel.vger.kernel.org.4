Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A1C641785
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 16:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiLCP1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 10:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiLCP1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 10:27:41 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB1A2BC0;
        Sat,  3 Dec 2022 07:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670081258; x=1701617258;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uSf2YHH5QrA+iUzZpxeHz51OuUatV/0N2ramzCq2LzY=;
  b=WH2VZl4V96I5i/spmTiYeOBAbFimUT1yxXYxbnTqjvJ3cCCTjtEUXGCY
   ye2XvjX8lBtQw16Ulu7lKJ41zlfq2ksfuy6yUCZPvw+/tlXfRkuqWhloo
   32GOlBCUeOvLDIDUpiHDecwV9RI3bqBXT8GYTsWd8FMhbLdULeCYjhTUI
   PRHLq1grj7buNjwl7paBPQjCN92PVK0zlhHig0MhoRjPXujUOSKeY85K/
   qHu2DrJCVVzXmz62NHx+grZgCbNfkmK+wqnmYG5w6vvqOK5sLlkc7exwC
   2Bk3zZFnhMvAVaCTl0QRLtnaq/hJfS1RbcZU4ESIEsVVKBWVjWnY8cEnW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="314834590"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="314834590"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2022 07:27:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787604048"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="787604048"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 03 Dec 2022 07:27:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1p1UQN-0042l6-0l;
        Sat, 03 Dec 2022 17:27:31 +0200
Date:   Sat, 3 Dec 2022 17:27:30 +0200
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
Message-ID: <Y4tq4i2CJdnQWFZC@smile.fi.intel.com>
References: <20221201123220.7893-1-zhuyinbo@loongson.cn>
 <CACRpkdZm-4-5625szX_VqJoQH1OQZnw+jH3SqWsb9nr3S0Nbmw@mail.gmail.com>
 <35ff475a-e925-81eb-ffeb-448be43f59ff@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35ff475a-e925-81eb-ffeb-448be43f59ff@loongson.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2022 at 06:53:20PM +0800, Yinbo Zhu wrote:
> 在 2022/12/3 18:03, Linus Walleij 写道:
> > On Thu, Dec 1, 2022 at 1:33 PM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
> > > +config GPIO_LOONGSON_64BIT
> > > +       tristate "Loongson 64 bit GPIO support"
> > > +       depends on LOONGARCH || COMPILE_TEST
> > > +       select GPIO_GENERIC
> > > +       select GPIOLIB_IRQCHIP
> > If the kernelbots start complaining you might need to add a:
> > 
> > select IRQ_DOMAIN_HIERARCHY
> > 
> > here.
> 
> Bartosz had merged my patch and I will add a change on top of the existing
> series.

I don;'t know why he had done that, the driver requires a lot of cleanups,
e.g. why it uses acpi.h, what that "nice" container of the platform device for.

-- 
With Best Regards,
Andy Shevchenko


