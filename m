Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BF95EA5B9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 14:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbiIZMOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 08:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbiIZMNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 08:13:18 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F71926AE9;
        Mon, 26 Sep 2022 03:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664189920; x=1695725920;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1yrpJYkku/0zqJqzokRG75N3kP7OfV/uBx48KxXJJOg=;
  b=BucTH/EXknyMQXmJJimqQH3h51l7xR6ZCo1KiwgsLAfqlqxJzC4BVofe
   zXLcNpQlBMh/2+Z3oNVIOuIua5Gz5IMQSoMqk+C4VHqoNmWozxwT1jT0E
   kIAdjT6adKR909KIKnhP49+c1+RKZkNivTSnKru/Y1sp2mS9qRgeGIS10
   Ah6PtaavtEkvy3CdGA/HntYFiRCcRx5PaEm9DU5O2ypk1QP6AnfnFiIW5
   QMWdvb1w/25dcZSM+hp30X8AyrZCc4D2F1FtUF1kdhgH5ZWmx9lpHFSC2
   rUn7F5oTZ6CUmdM8QlZ8/cBFm7UwOJUEuJ2rWOXvg7LXxX+0eRb4fJCd/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="299719867"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="299719867"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 03:56:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="710077501"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="710077501"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Sep 2022 03:56:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oclml-007lcY-0g;
        Mon, 26 Sep 2022 13:56:27 +0300
Date:   Mon, 26 Sep 2022 13:56:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] Input: matrix_keypad - replace header inclusions
 by forward declarations
Message-ID: <YzGFWt40IhkASq4j@smile.fi.intel.com>
References: <20220923184632.2157-1-andriy.shevchenko@linux.intel.com>
 <20220923184632.2157-2-andriy.shevchenko@linux.intel.com>
 <Yy4C5HH3yxssLMPh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy4C5HH3yxssLMPh@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 12:03:00PM -0700, Dmitry Torokhov wrote:
> On Fri, Sep 23, 2022 at 09:46:32PM +0300, Andy Shevchenko wrote:
> > When the data structure is only referred by pointer, compiler may not need
> > to see the contents of the data type. Thus, we may replace header inclusions
> > by respective forward declarations.

...

> > +struct device;
> > +struct input_dev;
> 
> This results in a ton of compile errors. While I believe this change is
> a good one, we need to fix users of this include first.

Indeed, sorry for breaking things (I compile-tested with limited drivers
enabled). I will look into LKP reports and will fix the users.

-- 
With Best Regards,
Andy Shevchenko


