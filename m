Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F36A6D7714
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbjDEIgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237539AbjDEIg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:36:29 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C853C3E;
        Wed,  5 Apr 2023 01:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680683787; x=1712219787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kZYnLU8SOtNyYo+2Y55HVr7QX63LleD2aWRYlI7W+Ro=;
  b=hXf1/3j43Zd6IBUnyZUqha9nlweT8GV7q1hhVnjEKqu8hPGc4WJP6FLU
   yzPSYKU5Y/AYFSdeIYiTSSu2HlIZjtyB+uRmFwflps/0/yE1TL7woB6qH
   t7ewIG+CbXS/Bvt9a3Oc31RX7mck8g17kBLoLe7l+X0MiZUVRpbx1Tzz4
   awiiaxghEB43VZZJPfJ0uATt5AVFxyq/+uXX6Tj88ZOuayq3bDPB2bUoZ
   ALm/TfJ0eDvlQBFvgAd+MKcWZDAKBwUoZg2THeaG2emNBdq4P2wcXut/A
   G9XmITkySogcF7sR6IS5mFHS/0z5ReYmCNqjS4kMz4SOmuyMvn2kuE5Po
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="344114409"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="344114409"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:36:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="689187109"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="689187109"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 05 Apr 2023 01:36:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pjyct-00Ckig-1k;
        Wed, 05 Apr 2023 11:36:19 +0300
Date:   Wed, 5 Apr 2023 11:36:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee@kernel.org>
Cc:     "Sahin, Okan" <Okan.Sahin@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
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
Message-ID: <ZC0zA1bVsrg0XEld@smile.fi.intel.com>
References: <20230307112835.81886-1-okan.sahin@analog.com>
 <20230307112835.81886-6-okan.sahin@analog.com>
 <20230315175223.GI9667@google.com>
 <20230315175257.GJ9667@google.com>
 <MN2PR03MB5168249900206433A082875EE7889@MN2PR03MB5168.namprd03.prod.outlook.com>
 <20230329143615.GS2673958@google.com>
 <MN2PR03MB51685B1F84AA679FB604E738E7929@MN2PR03MB5168.namprd03.prod.outlook.com>
 <20230403140950.GF548901@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230403140950.GF548901@google.com>
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

On Mon, Apr 03, 2023 at 03:09:50PM +0100, Lee Jones wrote:
> On Mon, 03 Apr 2023, Sahin, Okan wrote:

...


> > In fact, one of the maintainers suggested assigning chip_info to data
> > instead of enumeration. Then I added chip_info and put devices into
> > sub-structure above. I will replace chip_info with id structure in max77541
> > device structure, right? I will use enumeration for data as I will assign
> > it to id, and distinguish different devices.
> 
> Yes, that's correct.  Please remove chip_info altogether.

Then it will provoke casting in the OF ID table which I believe is not what
we want. I would agree on your first suggestion to have a plain number in I²C
ID table, but I'm against it in OF and/or ACPI ID table.

-- 
With Best Regards,
Andy Shevchenko


