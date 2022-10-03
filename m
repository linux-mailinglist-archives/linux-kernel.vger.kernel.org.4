Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E565F2FFE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 14:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJCMBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 08:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJCMBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 08:01:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4BD1C12C;
        Mon,  3 Oct 2022 05:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664798463; x=1696334463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bi6E7TQrLt6qes/7MH/ji+3zlO4nhqdLIZUO3ybFEYA=;
  b=d/FQ53DzcrsGj7YqJDnTralcUYV2EQiWgzg8c9sCV682X1QMBxFuoITL
   cHokvPOrYqV+CZvE8LJ8oqoJojGoLQKzGDf2iU8t/Rj/VQBLyWanH8xeY
   QxYfCIPITA48PDwBUAdzEP/5DwLLsbrb1OuBjqR2lKMDSLluMNn4FaGX+
   r1Tf3UjrJdCZTZKcGqTZeDss0cHVAPwbXLsY4CbnTPZPTydrWQC1xnOV2
   DM5e4pkzPm08lPFWVJuI01XvlpmuJyofgXxbx3Dhes1YjnPkCzFMq9ccD
   Ji4NW3RcZ1ct0X3cgULpAHY3sjiNoi5lOyq1ri/t5NjR8MUVAhMPSI6jp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="302593831"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="302593831"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 05:01:02 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="623506344"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="623506344"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 05:00:59 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 2AD742033F;
        Mon,  3 Oct 2022 15:00:57 +0300 (EEST)
Date:   Mon, 3 Oct 2022 12:00:57 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v2 1/5] device property: Keep dev_fwnode() and
 dev_fwnode_const() separate
Message-ID: <YzrO+ZNmpKetdIPU@paasikivi.fi.intel.com>
References: <20220928105746.51208-1-andriy.shevchenko@linux.intel.com>
 <20220928105746.51208-2-andriy.shevchenko@linux.intel.com>
 <YzQqcFZtJn90URrJ@kroah.com>
 <Yzb9nXSxvgJ+Mj6z@paasikivi.fi.intel.com>
 <YzcAh/xtqQM1Qin4@kroah.com>
 <CAJZ5v0hHPjSN-369pagN3Mnxd1yvc6+4YGb0Kpx3=+aahV=AmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hHPjSN-369pagN3Mnxd1yvc6+4YGb0Kpx3=+aahV=AmQ@mail.gmail.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Mon, Oct 03, 2022 at 01:54:37PM +0200, Rafael J. Wysocki wrote:
> > I ask as I just went through a large refactoring of the kobject layer to
> > mark many things const * and I find it a bit "sad" that functions like
> > this:
> >         static inline struct device *kobj_to_dev(const struct kobject *kobj)
> >         {
> >                 return container_of(kobj, struct device, kobj);
> >         }
> > have the ability to take a read-only pointer and spit out a writable one
> > thanks to the pointer math in container_of() with no one being the
> > wiser.
> 
> Well, is this really a problem?
> 
> After all, if an immutable structure is embedded in another one, that
> doesn't automatically imply that the containing structure has to be
> immutable too.  Hence, a const pointer to the inner structure doesn't
> automatically yield a const pointer to the outer one.

I think in that case it'd be better, to at least make an informed decision
on that instead of just dropping the const qualifier.

-- 
Regards,

Sakari Ailus
