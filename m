Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20B26C84E3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjCXSV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCXSV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:21:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C251F92C;
        Fri, 24 Mar 2023 11:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679682115; x=1711218115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2n+dCeg7wtjmU4qgYht1y0lqTlyInii8rzz/qlD/AGw=;
  b=c1/A3OmsfBKaXRCq1nsO2b/FtQ3Zpxr2zuqXuG70nysBIh8JA1nMuSOy
   vmj/S0x+BxaRuLsyJ8CIa8qH1mSNYhhY3kcoCFnQ6GF6Mdhlte0N8IYRx
   gtU/h72Fe4/Iee2+eK5teGK7Id8R+VBS2/uRaKoOpy+gih2VZ0HYWYcHt
   YtsvcYTlOz3i0MY9fCCxgkmeDbh48nmq+tKfA1jgkFexhxuG8Hnr59gp9
   BSsj/I7qHL35AydeufL+RxwAt82fYMnYHiYjFCMSF926ZsAnFhVHDX11P
   fEtO3zn0V9KCIv+V+fMyn0pVgq/QuiI1jwgYPhLEaaWcgdAI7Dy7Zinb1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="342243792"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="342243792"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 11:21:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="928746432"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="928746432"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 11:21:48 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id CA33B1207CD;
        Fri, 24 Mar 2023 20:21:43 +0200 (EET)
Date:   Fri, 24 Mar 2023 20:21:43 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH v1 1/1] device property: Constify a few fwnode APIs
Message-ID: <ZB3qNy6ts8ry+spb@kekkonen.localdomain>
References: <20230324112720.71315-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324112720.71315-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 01:27:20PM +0200, Andy Shevchenko wrote:
> The fwnode parameter is not altered in the following APIs:
> 
> - fwnode_get_next_parent_dev()
> - fwnode_is_ancestor_of()
> - fwnode_graph_get_endpoint_count()
> 
> so constify them.
> 
> Reported-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, Andy!

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
