Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B65675850
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjATPSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjATPSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:18:16 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1719BEF96;
        Fri, 20 Jan 2023 07:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674227895; x=1705763895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DMrNEjNnupgz3UG0MstA6kUJVX0stvsDi/5oCO/sBx8=;
  b=UQ90htaQ5wN4+th9TCM0PeU6AC48C1vA3+zDqHigdAH47mCGxVvwQ327
   P26nrOU217CvK/JH56/N96z8oXutTgjPZOwr7b0Zj7e6lf8fdwGkr69Iw
   XcqmxkgACdKk5Utdv+JyDHHD6L4WCUePko3DK9CXMpT5LXU9JwWIXeqWe
   0e0pedtC+7QCAe5cc4ASqEwFDHYuH90dAKx0yc+7S8KilhpSISgqZm1bH
   h8I4Y/EMWQeMLl4LibKAvx8JUKypx6tsY53CJzSrH7l8DxoXHPsQOVmaF
   IlMQtZi0l+mbEeTjEU9ufRkoNqDurhWGDqrbF/0Lmorby9clGRBmEx7hl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="326876826"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="326876826"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 07:18:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="803099574"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="803099574"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jan 2023 07:18:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pIt9d-00CHZD-28;
        Fri, 20 Jan 2023 17:18:09 +0200
Date:   Fri, 20 Jan 2023 17:18:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luca Ellero <l.ellero@asem.it>
Cc:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, u.kleine-koenig@pengutronix.de,
        mkl@pengutronix.de, miquel.raynal@bootlin.com, imre.deak@nokia.com,
        luca.ellero@brickedbrain.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Input: ads7846 - don't check penirq immediately for
 7845
Message-ID: <Y8qwsdUy9dT7l4OT@smile.fi.intel.com>
References: <20230120124544.5993-1-l.ellero@asem.it>
 <20230120124544.5993-4-l.ellero@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120124544.5993-4-l.ellero@asem.it>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 01:45:44PM +0100, Luca Ellero wrote:
> To discard false readings, one should use "ti,penirq-recheck-delay-usecs".
> Checking get_pendown_state() at the beginning, most of the time fails
> causing malfunctioning.

Should it have a Fixes: tag?

> Signed-off-by: Luca Ellero <l.ellero@asem.it>

-- 
With Best Regards,
Andy Shevchenko


