Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C18072DDBD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240546AbjFMJdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239532AbjFMJdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:33:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810FD18E;
        Tue, 13 Jun 2023 02:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686648823; x=1718184823;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s6xsUBvMQBvwXMxPKFv6VAm7oSub0u5Wh+bYY89/XOM=;
  b=ilj4YJqbXjE1SW8c+YMvfye2v/IG6UOIJkyephe5uOXiQzGoQB0h4aTI
   Fazfa7CvoVbJ/EMISG2LtP9fjELEF7HPDffHcMq+knb3MzInqUFVpZVGX
   GIaNDByl8J0L3hxONpu0hUXs/ENQS4q4jYseOL5y5FTJBpV4ceUgmMEjR
   l4QyExPnnllv8lJGqAOMBZDV044TMr9yy4tNTFD88uRsUOk+ToDnIFVj/
   vak9O94haAuilPDVmf9kcXOCsy/EPJLfPYy4cdCly0x6IxxwjjuOLnaUk
   JMpt4IX4+BiklNn2CaMqFUozz0MqiyljEqIPG4Yk9zUzMVhDbgC1yN5KH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="360762828"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="360762828"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 02:33:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="776739520"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="776739520"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 02:33:39 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 9A44011F9D2;
        Tue, 13 Jun 2023 12:26:32 +0300 (EEST)
Date:   Tue, 13 Jun 2023 09:26:32 +0000
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
Message-ID: <ZIg2SBegQW7d5QJf@kekkonen.localdomain>
References: <20230609154900.43024-1-andriy.shevchenko@linux.intel.com>
 <20230609154900.43024-4-andriy.shevchenko@linux.intel.com>
 <ZIbRJGhikaYEkuay@kekkonen.localdomain>
 <ZIc3sQD7U2Ifrneh@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIc3sQD7U2Ifrneh@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 06:20:17PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 12, 2023 at 08:02:44AM +0000, Sakari Ailus wrote:
> > On Fri, Jun 09, 2023 at 06:49:00PM +0300, Andy Shevchenko wrote:
> > > With the help of a new device_is_compatible() make
> > > the driver code agnostic to the OF/ACPI. This makes
> > > it neater. As a side effect the header inclusions is
> > > corrected (seems mod_devicetable.h was implicitly
> > > included).
> > 
> > You're wrapping the lines well before 75. Why?
> 
> Didn't pay attention to that much. Is it a problem? Should I send a new
> version because of that?

I guess not. But it's a good practice to wrap at 75 instead.

-- 
Sakari Ailus
