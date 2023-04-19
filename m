Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CAA6E831C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjDSVL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjDSVLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:11:24 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D4D3A81;
        Wed, 19 Apr 2023 14:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681938683; x=1713474683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1hUN6Aknab0oQQIjZ84k+50reseqSO8Xakk3s4YgMkM=;
  b=UAymgX+SfNsQ6LnvUk6dEGs/lj0noNIV2M6OFFMtYNPF8OSRaITKasLT
   BzIBiL6F7WO2+EuK59fi8iycxtc+fT4ANtLLHUB9ohGAjciCh8GIHHX9f
   OMYS/5G5J4FJI+ziATzflyA9XuJjbCVyGgTI6h0Ps+QXvXqL1v/yPaeWJ
   XyBE00UHm+h88A74nj0WRZb+49ZytJIglkDs5bIhYS14KzKrYZPBDR5fs
   FosS2wUoCN8aSe3FyigRW9AGHBhzXXo5xsHtwB/8u0BaU27FunVx6qzXY
   PttXa8EHf0LhPvJf7Y77cPk/0u4TcQBtrVmSvcrsmIyTe18cZ8rcIknWx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="344311971"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="344311971"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 14:11:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="691653762"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="691653762"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 14:11:20 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id D5B65120D2E;
        Thu, 20 Apr 2023 00:11:16 +0300 (EEST)
Date:   Thu, 20 Apr 2023 00:11:16 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH] device property: make device_property functions take
 const device *
Message-ID: <ZEBY9Ec8pJf15Ya4@kekkonen.localdomain>
References: <20230419164127.3773278-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419164127.3773278-1-linux@roeck-us.net>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 09:41:27AM -0700, Guenter Roeck wrote:
> device_property functions do not modify the device pointer passed to them.
> The underlying of_device and fwnode_ functions actually already take
> const * arguments. Mark the parameter constant to simplify conversion
> from of_property to device_property functions, and to let the calling code
> use const device pointers where possible.
> 
> Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Found by Chris when trying to convert a driver from of_property_ to
> device_property_ functions. I don't really see a reason why the device
> parameter to device_property functions should not be const.
> Please let me know if I am missing sonething.

Thanks!

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
