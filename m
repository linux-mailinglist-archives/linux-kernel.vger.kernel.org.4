Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED89E6A721F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjCARbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjCARbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:31:13 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AB92DE61;
        Wed,  1 Mar 2023 09:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677691864; x=1709227864;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pl+6Oma7rkYPAw63rJdiWlF3m83NK3f4ox/bDikxE5Q=;
  b=NGkizqPSA9UT01FIg8lEnucF/1J+S5sh+FXEew1K7/miNts6mFaqfQSS
   Vsc0ZkTC9PfyUq04mQeDMqi6wAf+gY4ecpAXXV7L0FiMHiwqYVhCMIINu
   z+TeeUdHbUVN8UAsnlnG5zchj2sP3XhoDO30lW573Sn+WkJToOOpmsL4Y
   +mUW8NHJaju12TwebGWPQJy31PDYvjHZ7dKtWPqjvs8FqTpvcH/BmgmQY
   ZpgMahXOK+jx/e7gztZe+X0gLKDM0SmkU3Cr6nsGIuvs6FQFl04O6G6zl
   q3r/0Kx3xk0fV1CTACVOZhsmLpTAC1iM3kemlOrOto9aguBwU+jJM4Uou
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="336764237"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="336764237"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 09:30:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="674643196"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="674643196"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 01 Mar 2023 09:30:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pXQHm-00Dr9m-26;
        Wed, 01 Mar 2023 19:30:38 +0200
Date:   Wed, 1 Mar 2023 19:30:38 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 0/3] leds: simatic-ipc-leds-gpio: split up
Message-ID: <Y/+Lvq36nIgIcAIK@smile.fi.intel.com>
References: <20230301170215.23382-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301170215.23382-1-henning.schild@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 06:02:12PM +0100, Henning Schild wrote:

> This series mainly splits the one GPIO driver into two. The split allows
> to clearly model runtime and compile time dependencies on the GPIO chip
> drivers.
> 
> p1 is kind of not too related to that split but also prepares for more
> GPIO based drivers to come.
> 
> p2 takes the driver we had and puts some of its content into a -core,
> to be used by the two drivers.
> 
> p3 deals with more fine-grained configuration posibilities and compile
> time dependencies.
> 
> It is based on
> [PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the GPIO providing driver

Thank you for an update.
Not big issues found (except maybe the Makefile).

-- 
With Best Regards,
Andy Shevchenko


