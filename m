Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0835BB424
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 23:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiIPVvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 17:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiIPVvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 17:51:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43299BA9FC;
        Fri, 16 Sep 2022 14:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663365107; x=1694901107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8c8cWwwOXKYrrI8tz7xN0EBWhqw3oubByMkTEjiFBn8=;
  b=WR6duLpJydt7lLhVmXVXF5kjSJqunBCfJPouHN7MKFO87p6jjlNouWRM
   0X4h5SFBer1Wc2RBylYLlkd3rpOVNfWH4ivtORs6KBVnlPDzBUK6nzXr8
   glr3DbUxM37/zpD2wEbzyTSTDiiJ/xObRZLzSeWD5q7tGiLZcoS2sHIAQ
   1ZvFu0U9Ygb1Hwndr0bZ/wtROw66t95MtybnwB+vfwM8lGGFqp3LveEsd
   zo7xbcQhZkJCFBDVg1a5n779sUGXauu3gomHZuwakMXlqNGLtwlp5nSYD
   AIfJIuslGHgG3+Sun/HnmjAt7rYTEs80vHJrOLcV34KJ4cVxH/h1EGlhf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="299908613"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="299908613"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 14:51:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="743478235"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 14:51:42 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 810BB2022B;
        Sat, 17 Sep 2022 00:51:40 +0300 (EEST)
Date:   Fri, 16 Sep 2022 21:51:40 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Shawn Tu <shawnx.tu@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Scally <djrscally@gmail.com>,
        Christian Hemp <c.hemp@phytec.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Vasut <marex@denx.de>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] media: i2c: add support for ov4689
Message-ID: <YyTv7CPytnvl05Ms@paasikivi.fi.intel.com>
References: <20220911200147.375198-1-mike.rudenko@gmail.com>
 <20220911200147.375198-3-mike.rudenko@gmail.com>
 <e3c0bafe-394c-e8cc-aba0-6eb480dc5b43@linaro.org>
 <87o7vgpa50.fsf@gmail.com>
 <c92f67a0-52f5-b5d1-8f65-d28b761d2620@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c92f67a0-52f5-b5d1-8f65-d28b761d2620@linaro.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof, Mikhail,

On Fri, Sep 16, 2022 at 10:43:11AM +0100, Krzysztof Kozlowski wrote:
> On 15/09/2022 21:40, Mikhail Rudenko wrote:
> > 
> > Hi Krzysztof,
> > 
> > On 2022-09-12 at 12:56 +02, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >> On 11/09/2022 22:01, Mikhail Rudenko wrote:
> >>> +static const struct i2c_device_id ov4689_id[] = {
> >>> +	{ "ov4689", 0 },
> >>> +	{},
> >>> +};
> >>> +MODULE_DEVICE_TABLE(i2c, ov4689_id);
> >>> +
> >>> +static const struct of_device_id ov4689_of_match[] = {
> >>> +	{ .compatible = "ovti,ov4689" },
> >>> +	{},
> >>> +};
> >>> +MODULE_DEVICE_TABLE(of, ov4689_of_match);
> >>> +
> >>> +static struct i2c_driver ov4689_i2c_driver = {
> >>> +	.driver = {
> >>> +		.name = "ov4689",
> >>> +		.pm = &ov4689_pm_ops,
> >>> +		.of_match_table = of_match_ptr(ov4689_of_match),
> >>
> >> of_match_ptr is usually paired with maybe_unused, otherwise you will
> >> have compile test warnings.
> > 
> > I see. I think we could also use `#if IS_ENABLED(CONFIG_OF)` around
> > `ov4689_of_match` and the corresponding `MODULE_DEVICE_TABLE`. Is it
> > appropriate here?
> 
> Would work, but ifdefs are not nice. Just use maybe_unused. Warnings
> should disappear.

Neither is needed. Just drop of_match_ptr().

Apart from clock handling, it would probably work on ACPI, too. No need to
address that though.

-- 
Regards,

Sakari Ailus
