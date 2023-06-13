Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471AA72E748
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242809AbjFMPdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239278AbjFMPdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:33:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8FF1BF5;
        Tue, 13 Jun 2023 08:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686670417; x=1718206417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OJLCl5j2fnbCKOJmS3WpzNGl7C0daKs5FfuZDCveZmM=;
  b=MjrEHrQ+g/xQmR6JzqoN/KV6rXsM/+nbLDItiWtu69TXKmcqIQUuBDVs
   lb5HALNoHl0rfJz6lYsPN6J+LA6Jh57g2RQbZA84UaxL6JCdbqnIV5CxB
   AQI29D/o+B1rxt7gu2rarAp9NI8YMrtRAEdOJmUMa0pKak8Z/MkGbYxZG
   WBobKHARtd0whiYrZZBUaBPaoRfADBledSP3tKzeJJPrjMC/uxNXHCaXU
   I28XTT2QOuQ/di0y8I6IdnoFwMvE8wJgUO2Fq8YacLbS/6NoJb/ReeLeR
   nv3ppNvgSBDWPSLUs6nYgr+hIxstwUJjzAONA1f5T9Ebr0RauXiffHBNJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="386769296"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="386769296"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 08:33:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711704575"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="711704575"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 13 Jun 2023 08:33:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q961U-003UJI-1P;
        Tue, 13 Jun 2023 18:33:32 +0300
Date:   Tue, 13 Jun 2023 18:33:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] pinctrl: Relax user input size in pinmux_select()
Message-ID: <ZIiMTGaUNMKQCkfC@smile.fi.intel.com>
References: <20230604131215.78847-2-andriy.shevchenko@linux.intel.com>
 <24d8898b-1e3b-8180-e96b-a3296de178a9@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24d8898b-1e3b-8180-e96b-a3296de178a9@web.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
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

On Tue, Jun 13, 2023 at 04:38:17PM +0200, Markus Elfring wrote:
> > This is debugfs and there is no much sense to strict the user from
> > sending as much data as they can. The memdup_user_nul() will anyway
> > fail if there is not enough memory.
> >
> > Relax the user input size by removing an artificial limitaion.
> 
> How are the chances to avoid typos also in such a change description?

Almost 0. This is now part of the non-rebased branch. It can be fixed
if and only if
- something really wrong happened before this patch in the tree and has
  to be fixed, and
- maintainer will remember to fix the typo.

-- 
With Best Regards,
Andy Shevchenko


