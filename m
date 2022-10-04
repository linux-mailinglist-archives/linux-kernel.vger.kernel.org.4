Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4905B5F4004
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiJDJmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiJDJli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:41:38 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D812253003;
        Tue,  4 Oct 2022 02:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664876304; x=1696412304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kcJoOVSniNtMqHoJeN8cbj6jjaioX4Ofn8a36moUA00=;
  b=QmdakK4XMaoJF2HdgqJre4SAcQ7ZnQ6w/PmW2bue2OdoGs8iisr8wfQF
   2RDpTrCr3gnGdl5kVTuhyg3Y+6fNuQDy6CourQzSK6/OkmpgbgE7JR9Mc
   NSG0Y6Ct+928hc3HfSHHzE0bGFgS9heUR1moAJ89V9lBY0Fld4Lv3FQEf
   ssOqTpdHXqeUXiTnd9MctIZ40lPXakxkHsOaAiDXC83v8LVe+j6UEJfIW
   fHOq8THFfgxDGokjLxG7tpwriNNwTaQZl1loxgcaSlsTKlNVxbYLnZK7U
   haB/aiLeg6z7DLK03S5dPH3gOqxbqAz8zeNIgPs7Uktawe+qYMVgWwxV5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="283235827"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="283235827"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 02:38:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="728151931"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="728151931"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 04 Oct 2022 02:38:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ofeNX-001ztJ-0A;
        Tue, 04 Oct 2022 12:38:19 +0300
Date:   Tue, 4 Oct 2022 12:38:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 1/5] device property: Allow const parameter to
 dev_fwnode()
Message-ID: <Yzv/Cgc28tNAYXIE@smile.fi.intel.com>
References: <20221004092129.19412-1-andriy.shevchenko@linux.intel.com>
 <20221004092129.19412-2-andriy.shevchenko@linux.intel.com>
 <Yzv+QHCIs6ruWkXM@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yzv+QHCIs6ruWkXM@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 12:34:56PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 04, 2022 at 12:21:25PM +0300, Andy Shevchenko wrote:
> > It's not fully correct to take a const parameter pointer to a struct
> > and return a non-const pointer to a member of that struct.
> > 
> > Instead, introduce a const version of the dev_fwnode() API which takes
> > and returns const pointers and use it where it's applicable.
> > 
> > With this, convert dev_fwnode() to be a macro wrapper on top of const
> > and non-const APIs that chooses one based on the type.
> 
> Hmm... it missed the device_get_match_data() implementation (reverse) change
> somehow. And it still compiles to me, probably I rebased wrongly and the hunk
> went to another patch. I'll investigate and resend as v4 the fixed version.

Ah, sorry, I mixed this with previous version of the patch here, so everything
is fine in v3!

-- 
With Best Regards,
Andy Shevchenko


