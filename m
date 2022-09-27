Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E124D5EC286
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbiI0MWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiI0MWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:22:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8A85725A;
        Tue, 27 Sep 2022 05:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664281310; x=1695817310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XpkDDEEchrcj3F5SD5RBgWCP709u3VmyVEynWHWmfZE=;
  b=Ut1Blr3b8nJp5q9DiiV17rKU+3B1SphfJIahvWX4W5622+57RDgaRTQA
   UCbRG7gv5oc0/XjhbxUyznya5HqMKQoq/kv5y39TtUfu5HyCIhxm6bA8g
   vNlgB1LTIif45EDmptfaFzGJnACePMNTu+MB/kqg7cY1bBZ4y9NGMvKlB
   F8VbWcYpZyStdZmrDgrJmpUrRlA1q9LO6E4QmwTjRID2FFwO6TSVYwzET
   kEeEtbItNvGhmhxPZ7dERi8AID8dsL1wZUqKDdyi4+p9mgJWqPrTvR5mZ
   8SNYrUXCbdgeWh1+ODzb1itimgUQ+qNMeLVEQwpb3aobDCm55wBX25rWt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="288452433"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="288452433"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 05:21:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="725492545"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="725492545"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 27 Sep 2022 05:21:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1od9ar-008RLy-1N;
        Tue, 27 Sep 2022 15:21:45 +0300
Date:   Tue, 27 Sep 2022 15:21:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Ferry Toth <fntoth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <thinhn@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH v4] usb: dwc3: Don't switch OTG -> peripheral if extcon
 is present
Message-ID: <YzLq2WJD78sjiBZg@smile.fi.intel.com>
References: <Yyw0K/hcTZ02UP+A@smile.fi.intel.com>
 <691c3073-5105-9a2b-e6f2-ea0a4b8aaea8@gmail.com>
 <CAHQ1cqGFFJ0gRbdN+DH0iJhcKc=eee8uNoDyfHEy00-CMgstiw@mail.gmail.com>
 <Yy3iAHLlS2emAmWn@smile.fi.intel.com>
 <CAHQ1cqHWZeVHp6QmsDw5bjVq=nknRVG5iETB0n4fMMLWginbLg@mail.gmail.com>
 <966ef528-455c-5180-fc63-ea77cb933af1@gmail.com>
 <331b5644-e204-8915-cd08-bd4fabbfcb49@gmail.com>
 <CAHQ1cqGrfTO9JLgD-k0Akg7+hXNT+WevfjH_YpsVi8wQt6_iBw@mail.gmail.com>
 <YzF8l7kiS7m496YE@smile.fi.intel.com>
 <CAHQ1cqEVXwMiUxp+QGRkHMea-74DxS1Obvc2xwhy=ySwfxhu7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQ1cqEVXwMiUxp+QGRkHMea-74DxS1Obvc2xwhy=ySwfxhu7w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 11:31:58AM -0700, Andrey Smirnov wrote:
> On Mon, Sep 26, 2022 at 3:19 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Sun, Sep 25, 2022 at 10:43:07PM -0700, Andrey Smirnov wrote:
> > > On Sun, Sep 25, 2022 at 12:21 PM Ferry Toth <fntoth@gmail.com> wrote:

...

> > > IMHO instead of trying to rush something in it be prudent to revert my
> > > patch _and_ address the fact that above patch was lost during the
> > > merge (Andy's revert needs to be updated)
> >
> > I'm not an expert in your fixes for DWC3, so please come up with
> > the solution sooner than later, otherwise I will try to get my
> > reverts into the final release, because they obviously fix the
> > regression.
> 
> You don't need to be an expert here. All that's required is that your
> revert get the code to look like it looks in
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.0-rc6&id=ab7aa2866d295438dc60522f85c5421c6b4f1507
> 
> so the last hunk in your patch instead of looking like:
> 
> @@ -538,6 +584,10 @@ int dwc3_drd_init(struct dwc3 *dwc)
>  {
>         int ret, irq;
> 
> +       dwc->edev = dwc3_get_extcon(dwc);
> +       if (IS_ERR(dwc->edev))
> +               return PTR_ERR(dwc->edev);
> +
>         if (ROLE_SWITCH &&
>             device_property_read_bool(dwc->dev, "usb-role-switch"))
>                 return dwc3_setup_role_switch(dwc);
> 
> should look like
> 
> @@ -538,6 +584,10 @@ int dwc3_drd_init(struct dwc3 *dwc)
>  {
>         int ret, irq;
> 
>         if (ROLE_SWITCH &&
>             device_property_read_bool(dwc->dev, "usb-role-switch"))
>                 return dwc3_setup_role_switch(dwc);
> 
> +       dwc->edev = dwc3_get_extcon(dwc);
> +       if (IS_ERR(dwc->edev))
> +               return PTR_ERR(dwc->edev);
> +
> 
> Can you update your series accordingly or do you need me to do that? I
> won't have the cycles until the end of the week (Sat).

Thanks for elaboration. I will do it (hopefully today).

-- 
With Best Regards,
Andy Shevchenko


