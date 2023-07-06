Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606377499C6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjGFKu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjGFKuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:50:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F16210D;
        Thu,  6 Jul 2023 03:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688640590; x=1720176590;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O2939U5ty2TolRbfyGjefCGhnUFfQlvKQ0xUsYPEdMY=;
  b=HbeQev9rSCoYMBCSKjtsy4EiIvCCZKVxI1yX/WmOr74fVa8+mj71Z9Qf
   3sEg0MVAoTEWTpCQcV3Cm0w48Ngm0P7Bpj06QyvxZAXYgvy5GeAMjjc4U
   FufnHzRM2CK8q2J1jfaaRwMjk4zrISn09xTHknHYbq07GdM2Wd/HHbPhx
   rnQIcK2bCp9iAeMXGVhD2gtbCtoI0D2/o/bEVGGlK3uwcfDtX6ugbkMQN
   QJtuGIzl6OJsFO22+7JLS1bNrDs8+eD1AHjaHbLL4T+96FTPiSB8Em9/9
   ox4MUE6vV35VlElMxfOpRNrUQoJ1t/YjBz10mVnVW/kS6BlCUSU6gZo8Z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="366146988"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="366146988"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 03:49:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="669716936"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="669716936"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 06 Jul 2023 03:49:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qHMY9-000V0Z-2a;
        Thu, 06 Jul 2023 13:49:25 +0300
Date:   Thu, 6 Jul 2023 13:49:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Armin Wolf <W_Armin@gmx.de>,
        =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH v1 1/2] platform/x86: wmi: Break possible infinite loop
 when parsing GUID
Message-ID: <ZKacNbTKz6rgWgww@smile.fi.intel.com>
References: <20230621151155.78279-1-andriy.shevchenko@linux.intel.com>
 <25715979-8148-8d1d-fd67-a973661f9781@gmx.de>
 <TnTqU2wwXh3DG07kYUwMAe0hdBiaKiuoMOqBCBIttT27lXdw-KZVV8fZ7x-Zrg_Ux8mJUHClgyFHRbDoCRmhaOI7GwOPhUPYBRLzThV8iYI=@protonmail.com>
 <b4dc2571-1163-805a-f92b-30dcc8b69246@gmx.de>
 <ZJQJqHbZy+00qhsz@smile.fi.intel.com>
 <ZJRh9o1a0k0yMbOG@smile.fi.intel.com>
 <decdc3d2-8e30-3ca9-d64c-4c76b8f160ca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <decdc3d2-8e30-3ca9-d64c-4c76b8f160ca@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 01:02:11PM +0200, Hans de Goede wrote:
> On 6/22/23 17:00, Andy Shevchenko wrote:
> > On Thu, Jun 22, 2023 at 11:43:20AM +0300, Andy Shevchenko wrote:
> >> On Wed, Jun 21, 2023 at 11:50:51PM +0200, Armin Wolf wrote:

...

> >> I think that WARN_ON() is a bit bogus. First of all, it can be easily
> >> transformed to BUG()-equivalent with panic_on_oops and hence kill the
> >> entire system. If we need the message about wrong GUID format, it should
> >> be done elsewhere (modpost ?). I.o.w. we shan't expect that code,
> >> controlled by us, shoots to our foot.
> > 
> > Additional info. There will be another driver elsewhere that may use similar
> > API and also needs GUID in device ID table.
> > 
> > Looking into that implementation it seems that validation should be made in
> > file2alias.c for WMI and reused by that driver.
> > 
> > So, taking into account that we have no wrong IDs so far, I would drop
> > WARN_ON() here and guarantee that file2alias.c will be changed to validate
> > the GUID one way or the other.
> > 
> > Would it work? Hans, what is your comment here?
> 
> 
> I agree that warning on malformed GUIDs does not belong here and
> your patch already drops the WARN_ON while switching to the new
> guid_parse_and_compare() helper.
> 
> So I'll go and merge this into my fixes branch once rc1 is out.

Thank you!

-- 
With Best Regards,
Andy Shevchenko


