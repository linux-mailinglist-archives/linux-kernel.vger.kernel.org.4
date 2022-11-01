Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553C961534A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 21:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiKAUac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 16:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiKAUaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 16:30:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1AE1C92C;
        Tue,  1 Nov 2022 13:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667334622; x=1698870622;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=APQeYjrRT3hLyy+c2ncnyeZeok1od6+0PtsZwGx62ts=;
  b=jWvXBsMxWvBmNNnAt2/Yd9S4+cKj+OKFdz/6nkba4mwqs2thplT6X48P
   NbgncmACQsgv45hcwlm3rSvIQ68j8wLnZ8gHgc+YAQ6re6e/soBSPbu7/
   O3Hh0wV/s03vI8ooQodfz/WrwalzgXppeStzZyFgXYZyN2uCb2IULq3MV
   NxHFn2z8Cahkn61iBFEjh2HbVw75/E6//Rk27vZQsWbLV5MJlhCUNxteY
   ojYOt8G+eq/LYedGjZ9zpNqs2L0u4vnWWFdiEsBmcxFO4M9KWayr2lCyr
   Oifg/dk929R9v9cdvNuZIxNrxviNZgDGwbLFda2wNqbIeY2pHHNI/j9bq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="309233501"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="309233501"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 13:30:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="963255856"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="963255856"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 01 Nov 2022 13:30:22 -0700
Received: from ritvikti-mobl.amr.corp.intel.com (unknown [10.212.195.64])
        by linux.intel.com (Postfix) with ESMTP id B33A8580AA7;
        Tue,  1 Nov 2022 13:30:21 -0700 (PDT)
Message-ID: <c5be860724b0e74623bcc2f09bde8abd62b2dcdd.camel@linux.intel.com>
Subject: Re: [PATCH v1] platform/x86: intel_pmc_core: promote S0ix failure
 warn() to WARN()
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Sven van Ashbrook <svenva@chromium.org>,
        "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Rajat Jain <rajatja@google.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        David E Box <david.e.box@intel.com>,
        Mark Gross <markgross@kernel.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>
Date:   Tue, 01 Nov 2022 13:30:21 -0700
In-Reply-To: <CAM7w-FUTHEAis-F3bDWSsxzQdT-koD-UO54ee9NzbBpKiQhPzQ@mail.gmail.com>
References: <20221027151908.v1.1.I295e65357f06f162b46ea6fc6c03be37e3978bdc@changeid>
         <4b7304c0-8dd5-9add-7c84-4e9f0aa9396b@redhat.com>
         <MN0PR12MB6101BCCA364437A76FED924AE2339@MN0PR12MB6101.namprd12.prod.outlook.com>
         <CAG-rBijvNoN3ppz6bdkEUofYPPBxCtFfo1nWBK5TdG69fcKMnA@mail.gmail.com>
         <CAE2upjS6qRGRcuVYuAB5DMf66A7VcfCKKYEkpsr1My7RnKDFtQ@mail.gmail.com>
         <CAG-rBihDRq1y61tAp56yYCoTOSZXO9OZNzn7gXb_y8XaiO_zqg@mail.gmail.com>
         <MN0PR12MB610109F448E3FC8CE71FBA76E2379@MN0PR12MB6101.namprd12.prod.outlook.com>
         <CACK8Z6E7=xt118d47FTpmgKHgUBgH48FQzTi5iL90C3MjHb-3Q@mail.gmail.com>
         <29e7c8f5-0784-6501-e3fb-f2ab33d3f438@amd.com>
         <CAM7w-FUTHEAis-F3bDWSsxzQdT-koD-UO54ee9NzbBpKiQhPzQ@mail.gmail.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-11-01 at 13:24 -0400, Sven van Ashbrook wrote:
> On Mon, Oct 31, 2022 at 4:55 PM Limonciello, Mario
> <mario.limonciello@amd.com> wrote:
> > I just spun together an RFC series for this idea and while doing it I
> > had the same realization.  So I left the warning messages in place for
> > both drivers.
> > 
> > You can take a look at the series here:
> > 
> > https://lore.kernel.org/platform-driver-x86/20221031204320.22464-1-mario.limonciello@amd.com/T/#m6c7db55c98b8a3ce8c48d451fc01c1d9b0df37fb
> > 
> 
> We've had some internal discussions within ChromeOS intel big core,
> and we believe this is a worthwhile effort, and we are supportive, as
> long as our current S0ix fail detection will not break for the
> foreseeable future, i.e. as long as the warning message and register
> dump stays in place. Which is the case for your RFC.

Yeah, I did not see this as a replacement for anything in the pmc drivers. Given
the prevalence of S0ix, and that hardware based low power idle support is
indicated in the FADT (so part of the standard) it makes sense to have it
tracked by the suspend core, particularly when it's being used as a replacement
for S3. We don't need to collect any implementation or debug details there. Only
detect when it's available, being used for suspend, and being achieved. Maybe
residency information as well if available but that's it. Other information is
separate and should be contained to the individual drivers which have the
detailed platform knowledge.

David

> 
> +swboyd@chromium.org who expressed interest in doing something similar for
> ARM.

