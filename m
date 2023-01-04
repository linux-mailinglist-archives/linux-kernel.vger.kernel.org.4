Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B086F65DAE7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 18:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239690AbjADREa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 12:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239451AbjADRE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:04:28 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE6917E37;
        Wed,  4 Jan 2023 09:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672851867; x=1704387867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zeo0ju0JCBAA+XzQk/IwdwkjF5L0GvLkgSkwHbL7J6E=;
  b=FQeYIAsHmjrVDHFPQM/dPyTkTUvxBed13mp12eXoGd5EdeBmtztZplnd
   XxNpMa4fgj49R18LvhmcGSKLGoCfjcoAp/o+lAMlykMNm2amg4EXR9u+J
   tt4WBuxTYYcL5ooWwEsNc5lorZ/UufoZgu3OW+2GugjY0P5AFvR7VxLJU
   2bpn1hyjIAFhx+mPAdjMwJXJliMy1bGbVyM7jgkeLlBdF4MIb1iMDg5Yo
   p8s2GnjOTfom3pJFQOUDJTVa9XCBBIEsdD6nsHCxHuUM4xpeXw/T+WyAv
   eFjnQfNrgILPduTxj+iB+o/fWfwqqh9qI/r3GEgJsv9Hc13V37jF2fISg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="322057130"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="322057130"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 09:01:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="685807825"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="685807825"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 04 Jan 2023 09:01:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pD78u-004OCO-0G;
        Wed, 04 Jan 2023 19:01:32 +0200
Date:   Wed, 4 Jan 2023 19:01:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mani@kernel.org, hemantk@codeaurora.org, quic_jhugo@quicinc.com,
        andersson@kernel.org, Michael.Srba@seznam.cz, arnd@arndb.de,
        dipenp@nvidia.com, bvanassche@acm.org, iwona.winiarska@intel.com,
        ogabbay@kernel.org, tzimmermann@suse.de, fmdefrancesco@gmail.com,
        jason.m.bills@linux.intel.com, jae.hyun.yoo@linux.intel.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Subject: Re: [PATCH 3/3] wiegand: add Wiegand GPIO bit-banged controller
 driver
Message-ID: <Y7Ww67pIyjeLKBE7@smile.fi.intel.com>
References: <20230104133414.39305-1-m.zatovic1@gmail.com>
 <20230104133414.39305-4-m.zatovic1@gmail.com>
 <Y7WwVCqDCXFrTqR9@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y7WwVCqDCXFrTqR9@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 06:59:00PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 04, 2023 at 02:34:14PM +0100, Martin Zaťovič wrote:

...

> > +What:		/sys/devices/platform/.../wiegand-gpio-attributes/format

> > +What:		/sys/devices/platform/.../wiegand-gpio-attributes/payload_len

> Why all these attributes? What is special about them and how they are specific
> to the hardware in question?
> 
> To me it all sounds like layering violation: a GPIO driver that has to be
> generic provides a complete custom ABIs which we usually put on the upper
> layer (in the kernel as a child driver or in the user space).

Okay, it seems the consumer driver.

-- 
With Best Regards,
Andy Shevchenko


