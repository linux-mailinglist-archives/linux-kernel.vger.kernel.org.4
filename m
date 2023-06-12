Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFECD72BB71
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbjFLI7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjFLI7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:59:04 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB684C15;
        Mon, 12 Jun 2023 01:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686560186; x=1718096186;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xy2e3u2eLop2iTdpDgrwak2FZeN59pMzNKD71Og9rzQ=;
  b=WGivlqABS8heX5+NbLPfapvXY215MwfyFlk9uZXkp3mSWYs5KVSQA85a
   lnHt6qL0UzadoQMPdh5W5ZwiGelVpe5dAof8xyKPCEr79hwSUDOkI3Sbl
   LBjjf47WZbtdMbgeL217T0nva7Pn4/aZUikWPnBfRD3ENide6KzbITVYK
   GCAE9oJJeoW+HS8wSvxkmeIeHujSjnQEXCqxAY/UMGy+o0FndOnva9OsA
   /deT7c/sWlFxnUvM7BfpoCcZT0mmAPOx5nvXje/5nL8UsJA4eCF+9p7Za
   oWgAZY/Ks4yHJisq1yaV6189RHLYL+tZHcV2VwP4CQUYW8ieWVQuqM2kW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="361333984"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="361333984"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 00:57:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="705293664"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="705293664"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 00:57:31 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id B6663120BE1;
        Mon, 12 Jun 2023 10:57:28 +0300 (EEST)
Date:   Mon, 12 Jun 2023 07:57:28 +0000
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
Subject: Re: [PATCH v2 2/3] device property: Implement device_is_compatible()
Message-ID: <ZIbP6OWq9tmEsjyJ@kekkonen.localdomain>
References: <20230609154900.43024-1-andriy.shevchenko@linux.intel.com>
 <20230609154900.43024-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609154900.43024-3-andriy.shevchenko@linux.intel.com>
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

On Fri, Jun 09, 2023 at 06:48:59PM +0300, Andy Shevchenko wrote:
> Some users want to use the struct device pointer to see if the
> device is compatible in terms of Open Firmware specifications,
> i.e. if it has a 'compatible' property and it matches to the
> given value. Provide inline helper for the users.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
