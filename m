Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA356902EF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjBIJLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjBIJLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:11:11 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13EBFF0B;
        Thu,  9 Feb 2023 01:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675933870; x=1707469870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a2MkqYZarU9Kj5aK8npfH96rjIcTD8gaXekRrzr5ZCE=;
  b=P7/AR0hBLuJCElGxmAzDGZzfplTLRsTi7/0SDTJ933CG1AE0mvNBvs14
   oXvGb9yWZso5h4mVJYcG3mmwzpR/cexbHKzZ0XvNN3TepmUwZT5auTBct
   qUBjExYrufmseekWMrbG5QmtnliMQd1GTTrHUgHbJySjioSy8Ae082voX
   AhROpDv0cIjBtUrIwgy6+7P06wMbUJsr90OZAb3Vv2sCN2E5VHTV6iU9f
   W5EZ9xkhBzSO53p6JgVdWYBfAzaG4XgatWAKtrk5gQu6L57I14w698jpO
   JgbKHXTyg8vWuDylruN8lYHvmaLik7noVW2HeltsNjYeeMYnv6GmrumrJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="310413202"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="310413202"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 01:11:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="791542638"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="791542638"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 01:11:08 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 085691218A3;
        Thu,  9 Feb 2023 11:11:05 +0200 (EET)
Date:   Thu, 9 Feb 2023 11:11:05 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: int3472/discrete: add LEDS_CLASS dependency
Message-ID: <Y+S4qZAQf6LAT16s@kekkonen.localdomain>
References: <20230208163658.2129009-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208163658.2129009-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 05:36:52PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> int3472 now fails to link when the LED support is disabled:
> 
> x86_64-linux-ld: drivers/platform/x86/intel/int3472/led.o: in function `skl_int3472_register_pled':
> led.c:(.text+0xf4): undefined reference to `led_classdev_register_ext'
> x86_64-linux-ld: led.c:(.text+0x131): undefined reference to `led_add_lookup'
> x86_64-linux-ld: drivers/platform/x86/intel/int3472/led.o: in function `skl_int3472_unregister_pled':
> led.c:(.text+0x16b): undefined reference to `led_remove_lookup'
> x86_64-linux-ld: led.c:(.text+0x177): undefined reference to `led_classdev_unregister'
> 
> Add an explicit Kconfig dependency.
> 
> Fixes: 5ae20a8050d0 ("platform/x86: int3472/discrete: Create a LED class device for the privacy LED")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
