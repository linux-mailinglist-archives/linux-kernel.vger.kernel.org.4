Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8683F6B4357
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjCJONr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjCJONO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:13:14 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A621194C0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678457526; x=1709993526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eT1/PfAlxqAh8Ui82KVTi+GVM4QdA9Y6UqoS7N9Xvds=;
  b=ZJ6eOTh3GHZzwph4gBOEgvS+YFAxRHPUzlBdG4HnvpnCytOiTkZSu3LF
   lie5kK2v83ohsXjk402hpjGbr3snoq0Mke8+P0b0h2+0ewNEIoLxOdSzl
   9nJfUpkMArY1lNHNi9Yiojw/wUT6/hUMyV1PkL+A3+zmSlxm1wUkp1hA+
   kqdQt/ZaLcBhRtnbA7qrBdME0FR8sWdbq8tH28GJt1OOVH7i+ha8wuw/D
   bmJ1AjKGdrBSIyid7EXT7OHJS4IY9u0WHdUCYvGwBDwBNmBrMs9OOnHt1
   Puj4neNZLVoE28abNMFlh/UOJPlQIS5IRWaOPdpWKabf4Yp5aDwqr7l7D
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="423000167"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="423000167"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 06:11:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="1007133019"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="1007133019"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 10 Mar 2023 06:11:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1padTC-000wvC-0y;
        Fri, 10 Mar 2023 16:11:42 +0200
Date:   Fri, 10 Mar 2023 16:11:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] devres: Pass unique name of the resource to
 devm_add_action()
Message-ID: <ZAs6nZz05C016l0E@smile.fi.intel.com>
References: <20230224200745.17324-1-andriy.shevchenko@linux.intel.com>
 <83bebd97-ba44-9e19-d66c-95b43b123797@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83bebd97-ba44-9e19-d66c-95b43b123797@alu.unizg.hr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 02:21:24PM +0100, Mirsad Todorovac wrote:
> On 2/24/23 21:07, Andy Shevchenko wrote:
> > Pass the unique name of the resource to devm_add_action(),
> > so it will be easier to debug managed resources.

...

> (I'm late two weeks w testing, but those were rather busy two weeks.)

Thank you for this test!

> I see what it is meant to do, but I am unsure of how to test whether it works.

Your test below is good enough.

> Being the unfaithful Thomas, I always prefer to test rather to just assume it
> is OK.
> 
> Is this OK output you expected to see in syslog?

Not really. It seems that we need to also wrap the devm_add_action_or_reset()
separately.

> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000ea28d384 action (16 bytes)

> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000004090f288 action (16 bytes)
> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000004090f288 action (16 bytes)

> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000ea28d384 action (16 bytes)

Instead of 'action' we need to see the real name of the action.

> NOTE: Maybe I should emphasise that this is not seen in either dmesg or kernel console.

Do you have 'ignore_loglevel' in the kernel command line? You should,
independently on this patch, for debug testing.

> I have just checked, and DEVRES lines are only in /var/log/messages (on AlmaLinux 8.7, CentOS fork).
> 
> As you must have guessed yourself already, this will frustrate debugging past the lifetime of rsyslog process.
> 
> Also, there is no way known to me to access dmesg log from the previous kernel run.

Can you test this on top?

diff --git a/include/linux/device.h b/include/linux/device.h
index 0f128520f6e5..12dc08aa5c0f 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -250,17 +250,19 @@ int __devm_add_action(struct device *dev, void (*action)(void *), void *data, co
 #define devm_add_action(release, action, data) \
 	__devm_add_action(release, action, data, #action)
 
-static inline int devm_add_action_or_reset(struct device *dev,
-					   void (*action)(void *), void *data)
+static inline int __devm_add_action_or_reset(struct device *dev, void (*action)(void *),
+					     void *data, const char *name)
 {
 	int ret;
 
-	ret = devm_add_action(dev, action, data);
+	ret = __devm_add_action(dev, action, data, name);
 	if (ret)
 		action(data);
 
 	return ret;
 }
+#define devm_add_action_or_reset(release, action, data) \
+	__devm_add_action_or_reset(release, action, data, #action)
 
 /**
  * devm_alloc_percpu - Resource-managed alloc_percpu

-- 
With Best Regards,
Andy Shevchenko


