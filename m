Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CC56B7A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjCMOST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjCMOSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:18:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7086EBBBD;
        Mon, 13 Mar 2023 07:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678717077; x=1710253077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vnCVt+wdWALDJ5asvXR3HRX+LKXTlmdftdrQVlu2wDw=;
  b=jEyZw3xt5g1heQ3eiRU+N5H6UanZPziyfDhZOaG4cjJU6nb90zW6Sm+N
   OCNxTavZKzudTY8QNblDoRxOy5YugGSBlwyStp8303qHlevM5xGUkM4Vo
   KtlpOmXi1HfQMIFN3QjMOBtyyRwzA4xZKfX0HpnpfXe1LoIWOmezX872L
   xx3mDkkaD5CoO+9vgAqk456rKB1Pz+xzl/eM5n+HFZGSGHsTUc+9kbrtN
   UVIAKCPWl4C2QkJHfDZ865QVzIGDkETW+Zou6h2HtDq2doXO0FmrfmJGG
   zY9GALTYhFDX/2jWAcbcGCxudJnJDf+5HV0zJbMnpDuT33WTje5N/AUrN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="423423944"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="423423944"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 07:17:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="821988528"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="821988528"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 13 Mar 2023 07:17:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pbizo-002fW4-1b;
        Mon, 13 Mar 2023 16:17:52 +0200
Date:   Mon, 13 Mar 2023 16:17:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
Message-ID: <ZA8wkMhShRbyE/wm@smile.fi.intel.com>
References: <cover.1678093787.git.mazziesaccount@gmail.com>
 <a4cb9a34ca027867ac014ffe93ca7e8245ce263f.1678093787.git.mazziesaccount@gmail.com>
 <ZAXiKfRbsXpHhwAJ@smile.fi.intel.com>
 <e507c171-bebc-84f6-c326-ff129b42fb7f@gmail.com>
 <ZA8kTx4exvGwUfNn@smile.fi.intel.com>
 <b4bf8587-d3cd-ff88-0276-7e394c110757@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4bf8587-d3cd-ff88-0276-7e394c110757@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 03:59:03PM +0200, Matti Vaittinen wrote:
> On 3/13/23 15:25, Andy Shevchenko wrote:
> > On Mon, Mar 13, 2023 at 02:47:45PM +0200, Matti Vaittinen wrote:
> > > On 3/6/23 14:52, Andy Shevchenko wrote:
> > > > On Mon, Mar 06, 2023 at 11:17:15AM +0200, Matti Vaittinen wrote:

...

> > > > > +	if (ret && gts->avail_all_scales_table)
> > > > 
> > > > In one case you commented that free(NULL) is okay, in the other, you add
> > > > a duplicative check. Why?
> > > 
> > > Sorry but what do you mean by dublicative check?
> > > 
> > > Usually I avoid the kfree(NULL). That's why I commented on it in that
> > > another case where it was not explicitly disallowed. I'll change that for v4
> > > to avoid kfree(NULL) as you suggested.
> > 
> > So, and with it you put now a double check for NULL, do you think it's okay?
> > I don't.
> 
> I don't see the double check. I see only one check just above the kfree()?
> Where is the other check?

	if (... gts->avail_all_scales_table)

is a double to one, which is inside kfree(). I.o.w. kfree() is NULL-aware
and you know that.

> > > > > +		kfree(gts->avail_all_scales_table);

-- 
With Best Regards,
Andy Shevchenko


