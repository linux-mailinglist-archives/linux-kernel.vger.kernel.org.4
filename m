Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530DF72C9BF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239414AbjFLPUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237316AbjFLPUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:20:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3362210F2;
        Mon, 12 Jun 2023 08:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686583222; x=1718119222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q8JaITbanHGw6fa7joaZEriYniFQhtzpInAYV2vakQg=;
  b=bHl84HgYi8AA69qSIKF88ZFwCZ+KhCOnJpLVHoqGqKEl5/yi4gINGLEr
   0TA4NtdIy9lkslPmTiRWGkpb7QwHvQs6+2HlS0KEgt7f1Ty0hIRfFyLe3
   ZAbYEjJA1ycdMW5RHHr4JISfThgQkCx0XqivMslJC8KDZbve+HTbWQwiV
   1NYfK97+Hld6eGnD3QMoPEUewYfz5D1zvMHm1tA8lIXL30LxuCv4C54rw
   zXmOXMjY+k0OPMT+wnk1x4BZ+DNRbIuCPXucL7VZcUYtfQRgc/rF+lW5k
   yRFpsaHOeZbZOMeLwk9Xah7bPyCDupoWdyJIsscOhFfkqev+5RrUG8BkW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="360556475"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="360556475"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:20:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="741066906"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="741066906"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 12 Jun 2023 08:20:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q8jL7-00397x-1y;
        Mon, 12 Jun 2023 18:20:17 +0300
Date:   Mon, 12 Jun 2023 18:20:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 3/3] ata: ahci_platform: Make code agnostic to OF/ACPI
Message-ID: <ZIc3sQD7U2Ifrneh@smile.fi.intel.com>
References: <20230609154900.43024-1-andriy.shevchenko@linux.intel.com>
 <20230609154900.43024-4-andriy.shevchenko@linux.intel.com>
 <ZIbRJGhikaYEkuay@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIbRJGhikaYEkuay@kekkonen.localdomain>
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

On Mon, Jun 12, 2023 at 08:02:44AM +0000, Sakari Ailus wrote:
> On Fri, Jun 09, 2023 at 06:49:00PM +0300, Andy Shevchenko wrote:
> > With the help of a new device_is_compatible() make
> > the driver code agnostic to the OF/ACPI. This makes
> > it neater. As a side effect the header inclusions is
> > corrected (seems mod_devicetable.h was implicitly
> > included).
> 
> You're wrapping the lines well before 75. Why?

Didn't pay attention to that much. Is it a problem? Should I send a new
version because of that?

> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko


