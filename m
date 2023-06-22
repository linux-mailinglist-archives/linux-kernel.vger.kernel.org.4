Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844FC739A87
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjFVIqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjFVIqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:46:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6A426BB;
        Thu, 22 Jun 2023 01:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687423504; x=1718959504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=i4r5gvZrep0r9eIolX8KoxXfHcDWAUh9AB6jWeHnY7U=;
  b=K7kpz5/yIK6XW2UTg0tJNMf9c7CNrX35gmAmxOufKG2XAHjxt5Zn3eG9
   KEFSimYP2E3UW6E/L50S5LDK3oCGyNsxL7kVo06WtSpFS40byPm6JlGzb
   1rv42tT2mDIwbYUO/UwviWUko7vbgpajILzDOLUWVMGXPpwzbop6Gd7k5
   +F+nYa3ZfEnBOtYWqrVkq9yDu9FPGPZhpZvm9+moECRLJ5qqx5+w2awma
   lHLSaQ4ZaxpZBl6PtsUr4VDUPLHmSpEze5VN23URNbN0Cxq0w70AgfsM4
   mgB4E2nN44NrO82ZCWcK6K6qRjyEzhU9VQ3Kte0t8wVEJ/0+M9Bv2LmPr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="426380468"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="426380468"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 01:43:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="714810526"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="714810526"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 22 Jun 2023 01:43:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qCFuS-005ixF-0u;
        Thu, 22 Jun 2023 11:43:20 +0300
Date:   Thu, 22 Jun 2023 11:43:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH v1 1/2] platform/x86: wmi: Break possible infinite loop
 when parsing GUID
Message-ID: <ZJQJqHbZy+00qhsz@smile.fi.intel.com>
References: <20230621151155.78279-1-andriy.shevchenko@linux.intel.com>
 <25715979-8148-8d1d-fd67-a973661f9781@gmx.de>
 <TnTqU2wwXh3DG07kYUwMAe0hdBiaKiuoMOqBCBIttT27lXdw-KZVV8fZ7x-Zrg_Ux8mJUHClgyFHRbDoCRmhaOI7GwOPhUPYBRLzThV8iYI=@protonmail.com>
 <b4dc2571-1163-805a-f92b-30dcc8b69246@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4dc2571-1163-805a-f92b-30dcc8b69246@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:50:51PM +0200, Armin Wolf wrote:
> Am 21.06.23 um 23:29 schrieb Barnabás Pőcze:
> > 2023. június 21., szerda 23:20 keltezéssel, Armin Wolf <W_Armin@gmx.de> írta:

[...]

> > > > -		if (WARN_ON(guid_parse(id->guid_string, &driver_guid)))
> > > 
> > > just an idea: how about printing an error/debug message in case of an
> > > malformed GUID?  This could be useful when searching for typos in GUIDs
> > > used by WMI drivers.

[...]

> > Wouldn't it be better to change `__wmi_driver_register()` to check that?
> 
> Good point, i guess we can just forget this idea. The original motivation for
> it was the WARN_ON() inside wmi_dev_match(), but your right that this is the
> wrong place to check the GUID formating.

I'm not sure what do you want me to do since patches are tested already.

I think that WARN_ON() is a bit bogus. First of all, it can be easily
transformed to BUG()-equivalent with panic_on_oops and hence kill the
entire system. If we need the message about wrong GUID format, it should
be done elsewhere (modpost ?). I.o.w. we shan't expect that code,
controlled by us, shoots to our foot.

-- 
With Best Regards,
Andy Shevchenko


