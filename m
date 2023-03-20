Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C05F6C1246
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjCTMsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjCTMrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:47:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9FA149AB;
        Mon, 20 Mar 2023 05:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679316455; x=1710852455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BS/iDj084XvVXlM/TI4ORDgBbDzLSZq0yXe7n1ACXBA=;
  b=j9QG30vAS0DKc/3qnMLMiFY6bp9keIN4U7TKil+tNwggJBlBHE1OGdou
   Ev3hGaBRV0UqJ/V0IY0FARCF8BkxP7/vpmT1IucShYPvlZOVCYp4RHFG3
   u2p/n43Db23Ch67urc+ILtKcE0QTHNyQuaFjO6gvkNxSG2SYmPKD7wB0S
   CeidzDI12sphF0MbiQxsrHW1wn+1+nm+YaigHaMwLrtF9AztVQTjcCs7s
   XNVqf/oGAAlmyaURzYERCQhuCcIrwRd4cPpXyq5Aj25JEmN0qlPW4kO+t
   dlaM9tr9TYJ6rA3ZR+nYkYQff4XMdpWxmZo0HuezHYLF72yGco18BsY2G
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="319050903"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="319050903"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 05:46:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="745361757"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="745361757"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 20 Mar 2023 05:46:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1peEuW-006GkN-0C;
        Mon, 20 Mar 2023 14:46:48 +0200
Date:   Mon, 20 Mar 2023 14:46:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Paul Fertser <fercerpav@gmail.com>
Cc:     Iwona Winiarska <iwona.winiarska@intel.com>,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-aspeed@lists.ozlabs.org, linux-doc@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Zev Weiss <zweiss@equinix.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v8 10/13] hwmon: peci: Add cputemp driver
Message-ID: <ZBhVt74i1DSoa+bE@smile.fi.intel.com>
References: <20220208153639.255278-1-iwona.winiarska@intel.com>
 <20220208153639.255278-11-iwona.winiarska@intel.com>
 <ZBhHS7v+98NK56is@home.paul.comp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBhHS7v+98NK56is@home.paul.comp>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 02:45:15PM +0300, Paul Fertser wrote:
> Hello,
> 
> We are seeing wrong DTS temperatures on at least "Intel(R) Xeon(R)
> Bronze 3204 CPU @ 1.90GHz" and most probably other Skylake Xeon CPUs
> are also affected, see inline.

Thanks for the report! I guess we need a fix for this indeed.

> On Tue, Feb 08, 2022 at 04:36:36PM +0100, Iwona Winiarska wrote:
> > Add peci-cputemp driver for Digital Thermal Sensor (DTS) thermal
> > readings of the processor package and processor cores that are
> > accessible via the PECI interface.
> ...
> > +static const struct cpu_info cpu_hsx = {
> > +	.reg		= &resolved_cores_reg_hsx,
> > +	.min_peci_revision = 0x33,
> > +	.thermal_margin_to_millidegree = &dts_eight_dot_eight_to_millidegree,
> > +};
> > +
> > +static const struct cpu_info cpu_icx = {
> > +	.reg		= &resolved_cores_reg_icx,
> > +	.min_peci_revision = 0x40,
> > +	.thermal_margin_to_millidegree = &dts_ten_dot_six_to_millidegree,
> > +};
> ...
> > +	{
> > +		.name = "peci_cpu.cputemp.skx",
> > +		.driver_data = (kernel_ulong_t)&cpu_hsx,
> > +	},
> 
> With this configuration we get this data:
> 
> /sys/bus/peci/devices/0-30/peci_cpu.cputemp.skx.48/hwmon/hwmon15# grep . temp[123]_{label,input}
> temp1_label:Die
> temp2_label:DTS
> temp3_label:Tcontrol
> temp1_input:30938
> temp2_input:67735
> temp3_input:80000
> 
> On the host system "sensors" report
> 
> Package id 0:  +31.C (high = +80.C, crit = +90.C)
> 
> So I conclude Die temperature as retrieved over PECI is correct while
> DTS is mis-calculated. The old downstream code in OpenBMC was using
> ten_dot_six_to_millidegree() function for conversion, and that was
> providing expected results. And indeed if we reverse the calculation
> here we get 80000 - ((80000-67735) * 256 / 64) = 30940 which matches
> expectations.

-- 
With Best Regards,
Andy Shevchenko


