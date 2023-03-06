Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E246AC42D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjCFO6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjCFO6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:58:51 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F5F26A8;
        Mon,  6 Mar 2023 06:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678114727; x=1709650727;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=q77ZwhYUij5+bpp+XhatvdvLOPOkge/IB45qu1ZrHgc=;
  b=e8GBlaJGGPv8e6l/S+gZK3gqnLXkKSaU/+dWjENiLybo6DXJyhoIPhZU
   upo+/qNyjtGj8tTJ5IRFWh8Zm+oabNNI3NOEUkdKKDsaDvHazsrDF7T7V
   1yejoNYTZUncsC72ppHAMvv9LpBiOTV5I65OTe1ukaiMJl3n8xzsoFM4a
   WEIAX3y4zmB/tdDkZwnYOKGeo9N9EObzslAWWbz4d+H9KmwaryH+b0yiO
   58794rOVERWEWWoCKkbxa5f3OTxPkUBoRKEJq3xcIXS853dFVdTxvzHda
   rleW1uwPp+QecAADkCWDKoqXhZPiPXnKCoATKCgGyDf4yeW3JI+8UYKtC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="323880049"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="323880049"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 06:58:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="786261119"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="786261119"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 06 Mar 2023 06:58:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pZCIH-00GUGD-0p;
        Mon, 06 Mar 2023 16:58:29 +0200
Date:   Mon, 6 Mar 2023 16:58:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: Add TI ADS1100 and ADS1000
Message-ID: <ZAX/lGR9srDRIzl7@smile.fi.intel.com>
References: <20230306131312.7170-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.0270109b-145d-4024-b8ff-05d54be2ad97@emailsignatures365.codetwo.com>
 <20230306131312.7170-2-mike.looijmans@topic.nl>
 <ZAXqwaKA3Uh6TH2q@smile.fi.intel.com>
 <8a1dc110-97fe-a9c8-ce53-918f403a16eb@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a1dc110-97fe-a9c8-ce53-918f403a16eb@topic.nl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 03:44:23PM +0100, Mike Looijmans wrote:
> On 06-03-2023 14:29, Andy Shevchenko wrote:

...

> Combining it all, I'd arrive at this code:
> 
>     gain = DIV_ROUNDUP_CLOSEST(microvolts, BIT(15)) * MILLI / val2;
>     if (gain < BIT(0) || gain > BIT(3))
>         return -EINVAL;
> 
>     ads1100_set_config_bits(data, ADS1100_PGA_MASK, ffs(gain) - 1);

Fine by me.

...

> > > +			return ads1100_set_config_bits(
> > > +					data, ADS1100_DR_MASK,
> > > +					FIELD_PREP(ADS1100_DR_MASK, i));
> > Wrong indentation.
> > Please, check all your code for this kind of issues.
> > 
> I always run it through checkpatch.pl but that didn't report on this
> indentation.

Checkpatch is:

1) not comprehensive;
2) not must-to-follow;

tool.

Use your common sense. You have a lot of room on the previous line at least
for 'data'. Trailing opening ( is not good indentation. But sometimes might
be unavoidable.

> A bit of digging in the scripts directory yields "Lindent". Feeding my file
> to that indeed changes those lines (and some others too). I'll run my next
> patch through that.

If it will look nice, why not?

-- 
With Best Regards,
Andy Shevchenko


