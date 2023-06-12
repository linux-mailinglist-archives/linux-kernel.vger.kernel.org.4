Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D74672BA3A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjFLIVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjFLIVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:21:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E4210FC;
        Mon, 12 Jun 2023 01:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686558070; x=1718094070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NrB05QMo0F6HFzF4tpbs8kKozdr9ZYcXmHPgXhr98hk=;
  b=HpeO5eF7oxNaS2z4GBROimv7fE9RrXB/HLdoG3hpChnQXWi/ZiRSCMrX
   d8JhM0gIQr/jZ8xcQCCqc4O3TT9OwF3P9TgM8Qu4xSb0Dsb1xYvJ2c9Fl
   XAWJ7yXiayZF8DuuzQ8plkRtlUekuZIbgQpZXRPNMqOhY8nQRwpeHF9PA
   LVUQ3CkpIG0uRDzW/eCtSBQVqRHrvGpYamvrC4dYBYOGvnvMXXhrX9ZNv
   rscMvcclEXQUcywm8ZvRRXchl9HKRIc/wJQH/p2E5UF2EtP3315SfIoFj
   +yr4xc0OwvqvkIPDtWfS+fK+D/01XS545LadEMlRAri9zhfE8xVq9k0Mr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="355468919"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="355468919"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 01:02:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="740924079"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="740924079"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 01:02:47 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id DB904120BE1;
        Mon, 12 Jun 2023 11:02:44 +0300 (EEST)
Date:   Mon, 12 Jun 2023 08:02:44 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Message-ID: <ZIbRJGhikaYEkuay@kekkonen.localdomain>
References: <20230609154900.43024-1-andriy.shevchenko@linux.intel.com>
 <20230609154900.43024-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609154900.43024-4-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, Jun 09, 2023 at 06:49:00PM +0300, Andy Shevchenko wrote:
> With the help of a new device_is_compatible() make
> the driver code agnostic to the OF/ACPI. This makes
> it neater. As a side effect the header inclusions is
> corrected (seems mod_devicetable.h was implicitly
> included).

You're wrapping the lines well before 75. Why?

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
