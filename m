Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E626A4196
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 13:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjB0MTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 07:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjB0MTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 07:19:10 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD41B1BACD;
        Mon, 27 Feb 2023 04:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677500343; x=1709036343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+e9QEVf6QWwJqpHxYXhKwH6VLsqTxnUQhQzbaZesWQA=;
  b=Vv+P6qF4gaHoUgBQm2OyHsjKJlRm6BugfIbOVJ0IneaBpKtMJedQ3Mvd
   3yTUCvillW68qUu/69oWwZyem9m3qcWGi22h1kX9rKJxrx06jF73oRRZW
   ZihbP7FRS29K0/4nAtufdfo9yVtJ+bJvp9/JVXR4MiYZZ76e2UAdrV/Yv
   Q8ZrQHg8yqJO2nYDBfkqBCXusU1wH14iJxbefA03OAfUCO7JH7td0WgDA
   qMixmlXp7zHYSkzWzC4PKuRBsGDjziIa8IPLT3fFBIvVZ8i1iU1JD3OB4
   BAnj+s+hUQNksu7EWP0aORepK3gkubVpEzMpTe2xuhNlmnm85ufDg5P/X
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="420109910"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="420109910"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 04:19:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="816624877"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="816624877"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 27 Feb 2023 04:19:00 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 27 Feb 2023 14:18:59 +0200
Date:   Mon, 27 Feb 2023 14:18:59 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Implementation of fwnode_operations :: device_get_match_data()
 for software nodes?
Message-ID: <Y/yfs3Zo70gV/V9b@kuha.fi.intel.com>
References: <20230223203713.hcse3mkbq3m6sogb@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223203713.hcse3mkbq3m6sogb@skbuf>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

On Thu, Feb 23, 2023 at 10:37:13PM +0200, Vladimir Oltean wrote:
> Hi,
> 
> I have a need to instantiate a driver written for OF which calls
> device_get_match_data(dev) to get various information based on the
> compatible string.
> 
> I am creating a software node based on the following properties:
> 
> 	struct property_entry props[2] = {
> 		PROPERTY_ENTRY_STRING("compatible", compatible),
> 		{},
> 	};
> 
> (I see I'm not the only one doing this, some drivers/platform/x86/x86-android-tablets.c
> and drivers/platform/chrome/chromeos_laptop.c also do it)
> 
> and the driver in question does begin to probe, but its match_data is
> NULL, because the operation from the title isn't implemented for
> software nodes. So probing ultimately fails.
> 
> Is there some sort or reason why this doesn't exist, other than a lack
> of need?

There has not been any need for it before.

> Can someone please help me with an implementation of this feature?

Try this - I'm sorry, I don't know does it actually work:

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 1886995a0b3a3..5262b49c7c790 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/property.h>
+#include <linux/mod_devicetable.h>
 #include <linux/slab.h>
 
 #include "base.h"
@@ -379,6 +380,25 @@ static void software_node_put(struct fwnode_handle *fwnode)
        kobject_put(&swnode->kobj);
 }
 
+static const void *
+software_node_get_match_data(const struct fwnode_handle *fwnode, const struct device *dev)
+{
+       const struct of_device_id *id;
+       const char *compat;
+
+       if (!dev->driver || !dev->driver->of_match_table)
+               return NULL;
+
+       if (fwnode_property_read_string(fwnode, "compatible", &compat))
+               return NULL;
+
+       for (id = dev->driver->of_match_table; id->compatible[0]; id++)
+               if (!strcmp(compat, id->compatible))
+                       return id->data;
+
+       return NULL;
+}
+
 static bool software_node_property_present(const struct fwnode_handle *fwnode,
                                           const char *propname)
 {
@@ -662,6 +682,7 @@ software_node_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 static const struct fwnode_operations software_node_ops = {
        .get = software_node_get,
        .put = software_node_put,
+       .device_get_match_data = software_node_get_match_data,
        .property_present = software_node_property_present,
        .property_read_int_array = software_node_read_int_array,
        .property_read_string_array = software_node_read_string_array,

-- 
heikki
