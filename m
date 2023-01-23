Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3323678474
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjAWSVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbjAWSVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:21:51 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5740D27D79;
        Mon, 23 Jan 2023 10:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674498110; x=1706034110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wjKXxFwxKsHhW1Zn2UhqeyPFNrU7rkAFDdAJE1qDxlc=;
  b=ZremmeRYRUXR1ZSwT9Z2DvcKoJa6PMENiQZhCsasrVfqqeO47p0Oozwy
   BqgOxQC756WhlGvjnAS0hzi4c08pKUmL9CBZsvofceeHMWHCXymnHVwVz
   tMFWREzUVoK1jqE2UL9uQlSorRC7nc2szkRrDa1YLf5sbBl+5kLLly+jX
   z5vm7VSm+Y+J8BHPdbjLK/wn4+cgXRQlSB1hfrBaL0YdEbWp+e40UuyJL
   HpgNrdbHHTv2z96MTuQ08xoJsmoGkPlzCre4QhEvssn+LsBCdmoTZ4fas
   +aMfldprQH1xZikiMEdhhM/s84fZY41UXnZgq+1avG6w4hwMhHw/GNS/9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="390613296"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="390613296"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 10:21:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="611715664"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="611715664"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 23 Jan 2023 10:21:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pK1RY-00Ds1K-0p;
        Mon, 23 Jan 2023 20:21:20 +0200
Date:   Mon, 23 Jan 2023 20:21:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raul Rangel <rrangel@chromium.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Wolfram Sang <wsa@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Smythe <ncsmythe@scruboak.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Hasemeyer <markhas@chromium.org>
Subject: Re: [PATCH 2/2] gpiolib-acpi: Don't set GPIOs for wakeup in S3 mode
Message-ID: <Y87QH6jZTcO51GDq@smile.fi.intel.com>
References: <20230121134812.16637-1-mario.limonciello@amd.com>
 <20230121134812.16637-3-mario.limonciello@amd.com>
 <CAMRc=Meeiix1BuPi81Ad08yePvd7U5S-AVNwU+vYUHv2VcDiEQ@mail.gmail.com>
 <CAHQZ30Dgs=ScuQ2MkNkuHyZNC1wwaBDkMhcvh9dt3oAppTKBbw@mail.gmail.com>
 <Y87ERbaTEhKIK1nq@smile.fi.intel.com>
 <CAHQZ30Aj-S1kRiYhh4sFzZYH8MLKY=sdqYRDqZtqOGGMn1Bang@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHQZ30Aj-S1kRiYhh4sFzZYH8MLKY=sdqYRDqZtqOGGMn1Bang@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 10:54:29AM -0700, Raul Rangel wrote:
> On Mon, Jan 23, 2023 at 10:30 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Jan 23, 2023 at 08:55:02AM -0700, Raul Rangel wrote:
> > > On Mon, Jan 23, 2023 at 8:03 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > > On Sat, Jan 21, 2023 at 2:48 PM Mario Limonciello
> > > > <mario.limonciello@amd.com> wrote:

...

> > > We still need to figure out a proper fix for this. If you read my post
> > > here: https://gitlab.freedesktop.org/drm/amd/-/issues/2357#note_1732372
> > > I think we misinterpreted what the SharedAndWake bit is used for. To
> > > me it sounds like it's only valid for HW Reduced ACPI platforms, and
> > > S0ix. My changes made it so we call `dev_pm_set_wake_irq` when the
> > > Wake bit is set. Does anyone have any additional context on the Wake
> > > bit? I think we either need to make `dev_pm_set_wake_irq` (or a
> > > variant) only enable the wake on S0i3, or we can teach the ACPI
> > > subsystem to manage arming the IRQ's wake bit. Kind of like we already
> > > manage the GPE events for the device.
> >
> > From the spec:
> >
> > Shared is an optional argument and can be one of Shared, Exclusive,
> > SharedAndWake or ExclusiveAndWake. If not specified, Exclusive is assumed.
> > The “Wake” designation indicates that the interrupt is capable of waking
> > the system from a low-power idle state or a system sleep state. The bit
> > field name _SHR is automatically created to refer to this portion of
> > the resource descriptor.
> >
> >
> > Note: "...a low-power idle state or a system sleep state.". I believe it
> > applies to both.
> 
> Without the _PRW, how do we determine the valid system sleep states
> the device can wake the system from?

Good question. I believe you need to ask somebody from ASWG for the
clarifications.

-- 
With Best Regards,
Andy Shevchenko


