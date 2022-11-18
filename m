Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D5C62FE11
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbiKRTih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbiKRTie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:38:34 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363DBFAD3;
        Fri, 18 Nov 2022 11:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668800311; x=1700336311;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZqZx+idQo5swkuCmhFonwd2HZT0peKBVNzr/ZV5o0Ig=;
  b=kwCt2pkuIWfyo5HXVR2Jx5rsggyaoH9RGPCYlt8tvc/dQlpgzcn18Eky
   8pBrEtctl94uSgfs/cYrTPFaFb5tnRGYnXQW+WrhFJJsQjK7zaGMwuTqJ
   W3UkzKup7KKf7WRS05JamFZXjAQfbE0TYxvaRFUKbYLQiFiX7oOEM8pio
   wzmQy8/AmXz1HPoP3SdVlhvaE1TSr2pB8jhT6MH9YYTUViZ/XISFJh3b9
   kKBruUEdY/Ebc8ORREpFirbQfMeytLe6cKLguJLrJTD+PMEftKO6hdDL8
   stDew/R+0sIaJOP+NxAcFVhKs2qzClCzgMJHYLv9b58tlfc6ZUjlYMHvE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="292921180"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="292921180"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 11:38:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="746117903"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="746117903"
Received: from mkmoraki-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.144.176])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 11:38:16 -0800
Message-ID: <4b168fc1cad6a57e0f20b9050c86174a57b34989.camel@linux.intel.com>
Subject: Re: [PATCH RESEND 1/2] thermal: intel: Prevent accidental clearing
 of HFI status
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date:   Fri, 18 Nov 2022 11:35:18 -0800
In-Reply-To: <CAJZ5v0hQkZ=jprMc5MNaCudKNATtjs_5Z+N7+a7eeaXRjGpaDQ@mail.gmail.com>
References: <20221116025417.2590275-1-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0hQkZ=jprMc5MNaCudKNATtjs_5Z+N7+a7eeaXRjGpaDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-11-18 at 18:54 +0100, Rafael J. Wysocki wrote:
> On Wed, Nov 16, 2022 at 3:54 AM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > When there is a package thermal interrupt with PROCHOT log, it will
> > be
> > processed and cleared. It is possible that there is an active HFI
> > event
> > status, which is about to get processed or getting processed. While
> > clearing PROCHOT log bit, it will also clear HFI status bit. This
> > means
> > that hardware is free to update HFI memory.
> > 
> > When clearing a package thermal interrupt, some processors will
> > generate
> > a "general protection fault" when any of the read only bit is set
> > to 1.
> > The driver maintains a mask of all read-write bits which can be
> > set.
> > This mask doesn't include HFI status bit. This bit will also be
> > cleared,
> > as it will be assumed read-only bit. So, add HFI status bit 26 to
> > the
> > mask.
> > 
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> 
> Is a Fixes tag missing here?
While adding the following change, this should have been take care of:
ab09b0744a99 ("thermal: intel: hfi: Enable notification interrupt")

But the above change didn't add this line, which this patch is
changing. We can add:

Fixes: ab09b0744a99 ("thermal: intel: hfi: Enable notification
interrupt")

Do you want me to send another PATCH with fixes.

> 
> Also, do you want it in 6.1-rc7 or would 6.2 suffice?
Not urgent. 6.2 should be fine.

Thanks,
Srinivas

> 
> > ---
> > Email address was wrong, so sending again.
> > 
> >  drivers/thermal/intel/therm_throt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/thermal/intel/therm_throt.c
> > b/drivers/thermal/intel/therm_throt.c
> > index 8352083b87c7..9e8ab31d756e 100644
> > --- a/drivers/thermal/intel/therm_throt.c
> > +++ b/drivers/thermal/intel/therm_throt.c
> > @@ -197,7 +197,7 @@ static const struct attribute_group
> > thermal_attr_group = {
> >  #define THERM_STATUS_PROCHOT_LOG       BIT(1)
> > 
> >  #define THERM_STATUS_CLEAR_CORE_MASK (BIT(1) | BIT(3) | BIT(5) |
> > BIT(7) | BIT(9) | BIT(11) | BIT(13) | BIT(15))
> > -#define THERM_STATUS_CLEAR_PKG_MASK  (BIT(1) | BIT(3) | BIT(5) |
> > BIT(7) | BIT(9) | BIT(11))
> > +#define THERM_STATUS_CLEAR_PKG_MASK  (BIT(1) | BIT(3) | BIT(5) |
> > BIT(7) | BIT(9) | BIT(11) | BIT(26))
> > 
> >  static void clear_therm_status_log(int level)
> >  {
> > --
> > 2.31.1
> > 

