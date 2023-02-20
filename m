Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0167469D0A4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjBTPaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjBTPaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:30:16 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708BE7EDA;
        Mon, 20 Feb 2023 07:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676907015; x=1708443015;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+HlrZP+jq3sz23IKR7YQHeZ/SCn5VW2Xfx4/ww7nx2M=;
  b=Mh8nRjrV6izrqpKrM056BnvLxzq57LZGCaUsu7p22XbcydxUvqrFKu+a
   466B5Kppa51OQJUtO+wTT+NeS6Q8UnajTAKGGML1Xn6ssLGRrbnPjnbvf
   HbXO0viWPS0dle83xmYESAcmCqWSWvhLGs6jPsFZ8zdppClSuA3ZwAdko
   dyqpkXYgnkJlKn9SGsF49bNBVTE8rJPLyCLTzEHs2u6fAozl409ewWMMY
   rYFDR6b4dtuXgnD9vUc4exuuuWX+/36mchg1vSSWBDKlrwZGNW3TRSkyc
   v5Xd010oKW5IWmr6c/2EWOoiVloKl7lXr/SZvkMnLxYkZLYw57zxrPwme
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="331091085"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="331091085"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 07:30:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="780686854"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="780686854"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 20 Feb 2023 07:30:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pU87C-009ZB3-39;
        Mon, 20 Feb 2023 17:30:06 +0200
Date:   Mon, 20 Feb 2023 17:30:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Sahin, Okan" <Okan.Sahin@analog.com>
Cc:     Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] drivers: regulator: Add ADI MAX77541/MAX77540
 Regulator Support
Message-ID: <Y/OR/pq8ene7sA2Z@smile.fi.intel.com>
References: <20230201103534.108136-1-okan.sahin@analog.com>
 <20230201103534.108136-3-okan.sahin@analog.com>
 <Y9p3dIj+ix0A7SpR@sirena.org.uk>
 <MN2PR03MB516851FC99B1EDA2604B557FE7A49@MN2PR03MB5168.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR03MB516851FC99B1EDA2604B557FE7A49@MN2PR03MB5168.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 02:58:47PM +0000, Sahin, Okan wrote:
> Wed, 1 Feb 2023 5:30 PM
> Mark Brown <broonie@kernel.org> wrote:
> >On Wed, Feb 01, 2023 at 01:35:15PM +0300, Okan Sahin wrote:

> >Please submit patches using subject lines reflecting the style for the subsystem,
> >this makes it easier for people to identify relevant patches.
> >Look at what existing commits in the area you're changing are doing and make
> >sure your subject lines visually resemble what they're doing.
> >There's no need to resubmit to fix this alone.
> >
> >> +	if (max77541->chip->id == MAX77540)
> >> +		desc = max77540_regulators_desc;
> >> +	else if (max77541->chip->id == MAX77541)
> >> +		desc = max77541_regulators_desc;
> >> +	else
> >> +		return -EINVAL;
> >
> >Write this as a switch statement for extensibility.
> >
> >Otherwise this looks good.

> Thank you for your feedback.  I am not sure that I fully understand your
> feedback. What do you mean by "reflecting style for the subsystem". For
> example, this patch includes files modified or added under regulator
> directory as stated in the subject line. Do I need to say anything about mfd
> as regulator is subdevice?

It's about Subject.

Just run `git log --online --no-merges -- drivers/regulator/max77*` and
look closely at it.

-- 
With Best Regards,
Andy Shevchenko


