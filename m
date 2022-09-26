Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4A75EA075
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbiIZKhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235910AbiIZKfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:35:25 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C407152443;
        Mon, 26 Sep 2022 03:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664187705; x=1695723705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZI/NmP5hf87eJW7hJhRibqf28tTpkvqWuLGDEY5H9K0=;
  b=L4FSJGSZvMpCYIt4BQ14szrEKWBekLl3ARCKYoVtBlaHuDjxp8ZcYhL8
   s8O3Ltqc22QqxXcM/kyhMChjHBzr1equRHd213fx/d23O5U3QgVbL70EA
   dOdlYMdf+J27fBY/0Hzbv161A+jbPEpFYXdgKIuYJfW1/dIkgVkFlJGe5
   Ez17S08NF1hLEpbnBZfn4+jKx9738TwElJezTt6O0BHcu3+ZGYH3TaVQM
   gDtxcstzWDmbrCHSAYWrWeRJwZV76+5FiwSok5ypZazn0bxA49Yk5L7On
   HolIzkTiPkpcV336DgEVJXlKH99MwKcuuCgedP66swtIwFFZkdb6bRFTh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="362821284"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="362821284"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 03:21:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="598678576"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="598678576"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 26 Sep 2022 03:21:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oclF5-007kSA-1y;
        Mon, 26 Sep 2022 13:21:39 +0300
Date:   Mon, 26 Sep 2022 13:21:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Ferry Toth <fntoth@gmail.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <thinhn@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v4] usb: dwc3: Don't switch OTG -> peripheral if extcon
 is present
Message-ID: <YzF9M3vs5ujdtUMF@smile.fi.intel.com>
References: <20220403164907.662860-1-andrew.smirnov@gmail.com>
 <Yyw0K/hcTZ02UP+A@smile.fi.intel.com>
 <691c3073-5105-9a2b-e6f2-ea0a4b8aaea8@gmail.com>
 <CAHQ1cqGFFJ0gRbdN+DH0iJhcKc=eee8uNoDyfHEy00-CMgstiw@mail.gmail.com>
 <Yy3iAHLlS2emAmWn@smile.fi.intel.com>
 <47a0249c-e129-7e98-503d-4254f216e485@gmail.com>
 <CAHQ1cqG7oL2sn=SRxp9se_h=rm+C6qYTkjp_DD1hPLBRPJpoGg@mail.gmail.com>
 <a911ac0c-561f-85ad-2bc7-c3ee54f8c7bc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a911ac0c-561f-85ad-2bc7-c3ee54f8c7bc@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 06:06:04PM +0200, Ferry Toth wrote:
> Op 24-09-2022 om 03:34 schreef Andrey Smirnov:

...

> Ulpi is there but is waiting for driver.

This rings a bell to the fw_devlink broken series [1].

[1]: https://lore.kernel.org/r/CAOesGMh5GHCONTQ9M1Ro7zW-hkL_1F7Xt=xRV0vYSfPY=7LYkQ@mail.gmail.com

-- 
With Best Regards,
Andy Shevchenko


