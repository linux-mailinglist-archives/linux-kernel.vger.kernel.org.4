Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE82E6CDBB7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjC2ONF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjC2OMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:12:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F21B5FD9;
        Wed, 29 Mar 2023 07:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680099103; x=1711635103;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uqRixI+rCRUn5ojNLm8F/UrKpimmbseAK3K5c/AtPKI=;
  b=O2xupxpTWc403nesMbIbqSBhTiF/+boII9BxVuiejMdhab7M5ARk8RDS
   aOtRjoRkrtAHWnlXtOqjv+8TtQpddkTd7VmKrSCAgLph4iie0qgva0ytq
   LgXbGlkjpuox22As/bK0qGqVbX2wRM2KFjl+o6QrAnn6kmNzsRPINVi8k
   +gNi/gE7MbSz35WiDYSegBbN4QS+BWjZ3RDMVxeD+iUe1Ohz74vrZlIKe
   EYCMj6lb0QIiGda82CNHjtbhhFHI55qsttmJk36dneWIffAsJbHMUkNdD
   cFE3hP3UhJ9kSnZkmyjMmQB2JDsvHhtzuJS8xSEhkEo3XJPNctP3D5w9J
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="342480942"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="342480942"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 07:06:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="684280183"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="684280183"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 29 Mar 2023 07:06:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1phWRZ-00A3Kf-03;
        Wed, 29 Mar 2023 17:06:29 +0300
Date:   Wed, 29 Mar 2023 17:06:28 +0300
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
Message-ID: <ZCRF5Be1/PIaGf+m@smile.fi.intel.com>
References: <20230315175257.GJ9667@google.com>
 <MN2PR03MB5168249900206433A082875EE7889@MN2PR03MB5168.namprd03.prod.outlook.com>
 <ZCLi6MB/aHIf4lMr@smile.fi.intel.com>
 <cdd53e29ca3d8dbfdfa1a2520935e2bf9418313d.camel@gmail.com>
 <d2bed74b-9eb9-45af-8f45-ad2c2889024a@sirena.org.uk>
 <fc07de9af0b691fbd3a5915c8293f0c7ad4c4e06.camel@gmail.com>
 <ZCL7J5a7UZVayQVS@smile.fi.intel.com>
 <60bbad1b38b8e3c9c3efefb0fb7b8d3cad7fa98c.camel@gmail.com>
 <ZCMMHl5ENSuCstFV@smile.fi.intel.com>
 <9ba3c559e2fb685c941b02fcfddaeb82aefed6f7.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ba3c559e2fb685c941b02fcfddaeb82aefed6f7.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 09:01:30AM +0200, Nuno Sá wrote:
> On Tue, 2023-03-28 at 18:47 +0300, Andy Shevchenko wrote:
> > On Tue, Mar 28, 2023 at 04:51:18PM +0200, Nuno Sá wrote:
> > > On Tue, 2023-03-28 at 17:35 +0300, Andy Shevchenko wrote:
> > > > On Tue, Mar 28, 2023 at 04:18:30PM +0200, Nuno Sá wrote:
> > > > > On Tue, 2023-03-28 at 14:46 +0100, Mark Brown wrote:
> > > > > > On Tue, Mar 28, 2023 at 03:26:44PM +0200, Nuno Sá wrote:
> > > > > > 
> > > > > > > IIRC, regmap_read() is not really reentrant and it is used
> > > > > > > in
> > > > > > > the
> > > > > > > IIO
> > > > > > > driver on the sysfs interface. So, yeah, I think you need
> > > > > > > the
> > > > > > > regmap
> > > > > > > lock and better just leave the config as is. Yes, the lock
> > > > > > > is
> > > > > > > opt-
> > > > > > > out
> > > > > > > so let's not disable it :)
> > > > > > 
> > > > > > All the regmap operations are fully thread safe.
> > > > > 
> > > > > Even if 'config->disable_locking' is set? I think that is
> > > > > what's
> > > > > being
> > > > > discussed in here...
> > > > 
> > > > In case the driver has its own lock to serialize IO how on earth
> > > > the
> > > > regmap
> > > > lock is needed. That's what I asked the author of the driver. He
> > > > told
> > > > the code
> > > 
> > > Well, if the driver has it's own locking, then sure we do not need
> > > regmap's lock...
> > > 
> > > > doesn't require the regmap lock, and I tend to believe the
> > > > author.
> > > > So, why to
> > > > keep it?
> > > 
> > > However, if you look at the adc driver, I can see plain
> > > regmap_read()
> > > calls without any "outside" locking.
> > 
> > Then author of the code should know what they are doing. Right?
> 
> In theory yes, but you know that's not always the case :)

Exactly. That's why I want to hear from the author of the code to make sure
they know _their_ code.

-- 
With Best Regards,
Andy Shevchenko


