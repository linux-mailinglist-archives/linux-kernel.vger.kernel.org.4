Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7E76CC70B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjC1PsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbjC1Prw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:47:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D7355A1;
        Tue, 28 Mar 2023 08:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680018471; x=1711554471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=24T96MRUkvahofWk1u6QPPXpvn4MM1W+NreI36DEZHU=;
  b=lTGMG+j2+jaoBYJgswpZhkDBYL+9T062CEOna/9PSKwTxrbbABcZD88V
   oJrHGZI0D2GcHm//fZsf7DzZmawThhgorJJeNomBY9kKTKdGPF+jTD9eE
   tFzcZJBWt3JJCXAPFNXmlFH9SvHsixcLivR7me2JPQ9ZIHDmQKpz4INpR
   Bsf/u0F1NAXvPey3M8ulzRmFfMFbA78msf2K1j5CfptuD76Uz6PHIu7He
   Bh9nXRgZICpRoY7tKjQ8cK7ua1pve5+QMNVB46H0CSYXkBCeEFpZltIO0
   RIyFQ7eJTv/i49wfhgGWTA/3fftMSkxTevl9L+bCY/9fCnM89qD1iHnrZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="324502650"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="324502650"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:47:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="929960931"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="929960931"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 28 Mar 2023 08:47:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1phBXz-009gH3-0h;
        Tue, 28 Mar 2023 18:47:43 +0300
Date:   Tue, 28 Mar 2023 18:47:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "Sahin, Okan" <Okan.Sahin@analog.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v6 5/5]  mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <ZCMMHl5ENSuCstFV@smile.fi.intel.com>
References: <20230307112835.81886-6-okan.sahin@analog.com>
 <20230315175223.GI9667@google.com>
 <20230315175257.GJ9667@google.com>
 <MN2PR03MB5168249900206433A082875EE7889@MN2PR03MB5168.namprd03.prod.outlook.com>
 <ZCLi6MB/aHIf4lMr@smile.fi.intel.com>
 <cdd53e29ca3d8dbfdfa1a2520935e2bf9418313d.camel@gmail.com>
 <d2bed74b-9eb9-45af-8f45-ad2c2889024a@sirena.org.uk>
 <fc07de9af0b691fbd3a5915c8293f0c7ad4c4e06.camel@gmail.com>
 <ZCL7J5a7UZVayQVS@smile.fi.intel.com>
 <60bbad1b38b8e3c9c3efefb0fb7b8d3cad7fa98c.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60bbad1b38b8e3c9c3efefb0fb7b8d3cad7fa98c.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 04:51:18PM +0200, Nuno Sá wrote:
> On Tue, 2023-03-28 at 17:35 +0300, Andy Shevchenko wrote:
> > On Tue, Mar 28, 2023 at 04:18:30PM +0200, Nuno Sá wrote:
> > > On Tue, 2023-03-28 at 14:46 +0100, Mark Brown wrote:
> > > > On Tue, Mar 28, 2023 at 03:26:44PM +0200, Nuno Sá wrote:
> > > > 
> > > > > IIRC, regmap_read() is not really reentrant and it is used in
> > > > > the
> > > > > IIO
> > > > > driver on the sysfs interface. So, yeah, I think you need the
> > > > > regmap
> > > > > lock and better just leave the config as is. Yes, the lock is
> > > > > opt-
> > > > > out
> > > > > so let's not disable it :)
> > > > 
> > > > All the regmap operations are fully thread safe.
> > > 
> > > Even if 'config->disable_locking' is set? I think that is what's
> > > being
> > > discussed in here...
> > 
> > In case the driver has its own lock to serialize IO how on earth the
> > regmap
> > lock is needed. That's what I asked the author of the driver. He told
> > the code
> 
> Well, if the driver has it's own locking, then sure we do not need
> regmap's lock...
> 
> > doesn't require the regmap lock, and I tend to believe the author.
> > So, why to
> > keep it?
> 
> However, if you look at the adc driver, I can see plain regmap_read()
> calls without any "outside" locking.

Then author of the code should know what they are doing. Right?

-- 
With Best Regards,
Andy Shevchenko


