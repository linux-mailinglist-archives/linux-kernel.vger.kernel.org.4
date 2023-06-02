Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3B47203FC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 16:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbjFBOHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 10:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbjFBOHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:07:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60072197;
        Fri,  2 Jun 2023 07:07:19 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="355886975"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="355886975"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 07:07:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="740843836"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="740843836"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 02 Jun 2023 07:07:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1q55Qx-000ex8-0C;
        Fri, 02 Jun 2023 17:07:15 +0300
Date:   Fri, 2 Jun 2023 17:07:14 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v8 1/1] gpio: add sloppy logic analyzer using polling
Message-ID: <ZHn3krVTwGp/0YhO@smile.fi.intel.com>
References: <20220329091126.4730-1-wsa+renesas@sang-engineering.com>
 <20220329091126.4730-2-wsa+renesas@sang-engineering.com>
 <ZHkQDTvk6I2q-9CF@surfacebook>
 <CAMuHMdUaugQ5+Zhmg=oe=X2wvhazMiT=K-su0EJYKzD4Hdyn3Q@mail.gmail.com>
 <CAMuHMdWhtVvA4=vh4imMtL+KssybzB57CNcLaNq9oVKkpeS1iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWhtVvA4=vh4imMtL+KssybzB57CNcLaNq9oVKkpeS1iA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 08:57:36AM +0200, Geert Uytterhoeven wrote:
> On Fri, Jun 2, 2023 at 8:51 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Jun 1, 2023 at 11:40 PM <andy.shevchenko@gmail.com> wrote:
> > > Tue, Mar 29, 2022 at 11:11:26AM +0200, Wolfram Sang kirjoitti:

...

> > > However, I haven't checked if it's pure theoretical issue with the current code
> > > base of debugfs or a potential problem. Easy fix is to check an error code and
> >
> > I think debugfs_create_dir() can only fail reasonably due to OOM.
> 
> Oops, you were talking about NULL, not an error code.
> I don't think that can ever happen.

That's looks correct, I don't see (looking briefly into the fs/debugfs) that
NULL is possible to be returned. Wondering, why the heck we (used to) have
a lot of IS_ERR_OR_NULL() checks.

> And if I did miss something, it would crash when dereferencing a NULL
> pointer in d_really_is_positive() (as called in start_creating())...

I don't see how, but I see a big comment on top of `if (!parent)`.

-- 
With Best Regards,
Andy Shevchenko


