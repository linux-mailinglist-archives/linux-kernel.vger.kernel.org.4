Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5AE5E8019
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiIWQnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiIWQmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:42:49 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114DF109522;
        Fri, 23 Sep 2022 09:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663951366; x=1695487366;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vq/+1HI102LsXNNK8DNNAtktfl0zaPdHOJaQaPsJxVo=;
  b=jlxSc4HLyyve3aUL3YZRXJPVlpFdvL+enrK3dlnQ2ulxrfc50N25S+em
   HAaWbR0UV1jrzBbu5uonLe4PjMC9CyRaGarGuGibu3r0PWuTPC+i9AYOP
   1TkpCb6k8/7KxF4yzFlHEX7T3BulV1I0Po97gEnACogfx7k+7m/IQHdn6
   MfIf9FaxwnSmxL88TtXYckW5na4Pfd6tmVpVF9HXDleMopsSw88WFbaX5
   RBNmbngU5BYUVQctkgy2qZgn+aijOxC4AjdC5KzvLdcHW3Pt3qwCX5fxj
   Y2XjGs9PQKvz4zS5JVbHMA1NFXw8dEW3Md0/M6eGW9/byirT5Nep5Qcue
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="326962394"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="326962394"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 09:42:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="724190234"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 23 Sep 2022 09:42:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1obllA-006Z7Y-1e;
        Fri, 23 Sep 2022 19:42:40 +0300
Date:   Fri, 23 Sep 2022 19:42:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Ferry Toth <fntoth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <thinhn@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v4] usb: dwc3: Don't switch OTG -> peripheral if extcon
 is present
Message-ID: <Yy3iAHLlS2emAmWn@smile.fi.intel.com>
References: <20220403164907.662860-1-andrew.smirnov@gmail.com>
 <Yyw0K/hcTZ02UP+A@smile.fi.intel.com>
 <691c3073-5105-9a2b-e6f2-ea0a4b8aaea8@gmail.com>
 <CAHQ1cqGFFJ0gRbdN+DH0iJhcKc=eee8uNoDyfHEy00-CMgstiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQ1cqGFFJ0gRbdN+DH0iJhcKc=eee8uNoDyfHEy00-CMgstiw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 04:32:55PM -0700, Andrey Smirnov wrote:
> On Thu, Sep 22, 2022 at 3:23 AM Ferry Toth <fntoth@gmail.com> wrote:
> > On 22-09-2022 12:08, Andy Shevchenko wrote:
> > On Sun, Apr 03, 2022 at 09:49:07AM -0700, Andrey Smirnov wrote:

FYI: For now I sent a revert, but if we got a solution quicker we always
can choose the course of actions.

> > If the extcon device exists, get the mode from the extcon device. If
> > the controller is DRD and the driver is unable to determine the mode,
> > only then default the dr_mode to USB_DR_MODE_PERIPHERAL.
> >
> > According to Ferry (Cc'ed) this broke Intel Merrifield platform. Ferry, can you
> > share bisect log?
> >
> > I can but not right now. But what I did was bisect between 5.18.0 (good) and 5.19.0 (bad) then when I got near the culprit (~20 remaining) based on the commit message I tried 0f01017191384e3962fa31520a9fd9846c3d352f "usb: dwc3: Don't switch OTG -> peripheral if extcon is present" (bad) and commit before that (good).
> >
> > The effect of the patch is that on Merrifield (I tested with Intel Edison Arduino board which has a HW switch to select between host and device mode) device mode works but in host mode USB is completely not working.
> >
> > Currently on host mode - when working - superfluous error messages from tusb1210 appear. When host mode is not working there are no tusb1210 messages in the logs / on the console at all. Seemingly tusb1210 is not probed, which points in the direction of a relation to extcon.
> >
> > Taking into account the late cycle, I would like to revert the change. And
> > Ferry and I would help to test any other (non-regressive) approach).
> >
> > I have not yet tested if a simple revert fixes the problem but will tonight.
> >
> >
> > I would be happy to test other approaches too.
> 
> 
> It's a bit hard for me to suggest an alternative approach without
> knowing how things are breaking in this case. I'd love to order one of
> those boards to repro and fix this on my end, but it looks like this
> HW is EOLed and out of stock in most places. If you guys know how to
> get my hands on those boards I'm all ears.

There are still some second hand Intel Edison boards flying around
(but maybe cost a bit more than expected) and there are also
Dell Venue 7 3740 tablets based on the same platform/SoC. The latter
option though requires more actions in order something to be boot
there.

In any case, it's probably quicker to ask Ferry or me for testing.
(Although currently I have no access to the board to test OTG, it's
 remote device which I can only power on and off and it has always
 be in host mode.)

> Barring that, Ferry can you dig more into this failure? E.g. is it this hunk
> 
> @@ -85,7 +86,7 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
>                  * mode. If the controller supports DRD but the dr_mode is not
>                  * specified or set to OTG, then set the mode to peripheral.
>                  */
> -               if (mode == USB_DR_MODE_OTG &&
> +               if (mode == USB_DR_MODE_OTG && !dwc->edev &&
>                     (!IS_ENABLED(CONFIG_USB_ROLE_SWITCH) ||
>                      !device_property_read_bool(dwc->dev, "usb-role-switch")) &&
>                     !DWC3_VER_IS_PRIOR(DWC3, 330A))
> @@ -1632,6 +1633,51 @@ static void dwc3_check_params(struct dwc3 *dwc)
>         }
>  }
> 
> that's problematic or moving

I think you wanted to revert only this line and test?

>  static int dwc3_probe(struct platform_device *pdev)
>  {
>         struct device           *dev = &pdev->dev;
> @@ -1744,6 +1790,13 @@ static int dwc3_probe(struct platform_device *pdev)
>                 goto err2;
>         }
> 
> +       dwc->edev = dwc3_get_extcon(dwc);
> +       if (IS_ERR(dwc->edev)) {
> +               ret = PTR_ERR(dwc->edev);
> +               dev_err_probe(dwc->dev, ret, "failed to get extcon\n");
> +               goto err3;
> +       }
> +
>         ret = dwc3_get_dr_mode(dwc);
>         if (ret)
>                 goto err3;
> 
> to happen earlier?

It is not always possible to have an extcon driver available, that's why in
some cases the probe of it defers. I dunno how your patch supposed to work
in that case.

> Does tracing the "mrfld_bcove_pwrsrc" driver (the
> excton provider in this case AFIACT) show anything interesting?

I believe there is nothing interesting.

-- 
With Best Regards,
Andy Shevchenko


