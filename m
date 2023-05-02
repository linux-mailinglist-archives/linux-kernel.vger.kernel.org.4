Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345966F4ADA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjEBUD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjEBUDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:03:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B809F1997;
        Tue,  2 May 2023 13:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683057829; x=1714593829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DyYgu8EaagPkfyeH/Mvma9nZqR7FqJ8nacbfBWhR9Wc=;
  b=QvHfI0K6mPtT159OUS3L5OZj81wiqTs/FsuptJA5e1VOM4dev3i3+4+b
   ip3fd0X7lmH3A2MFYqu0aveCNccTAosJ8r/kNvQSlQF/7MnLOWHYs3fbO
   Dg6W7WeNPaMGOClHDySUFi4pCl8EzVrZaVQfbeltF12yp+poBaTA0PTYG
   EunkPNME7KP/sAsOiZHiH9Yz5zhHbCKABGpE5pqvY0BzTR2CtfdIHj9xB
   X3ox3iaQPEbJuo8i6RSh9EuP/VKofSQ5PYL+/+VdYlINLgmwRfNgBZtKI
   KClvTCjA2CplXH9VB4kbsfFDUz/RwPM0yRX1UcuRLT/GugWIOMt2B6E41
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="350567698"
X-IronPort-AV: E=Sophos;i="5.99,245,1677571200"; 
   d="scan'208";a="350567698"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 13:03:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="942578101"
X-IronPort-AV: E=Sophos;i="5.99,245,1677571200"; 
   d="scan'208";a="942578101"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 02 May 2023 13:03:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ptwDv-008DIu-06;
        Tue, 02 May 2023 23:03:43 +0300
Date:   Tue, 2 May 2023 23:03:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Konrad =?iso-8859-1?Q?Gr=E4fe?= <k.graefe@gateware.de>
Cc:     Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] vsprintf: Add %p[mM]U for uppercase MAC address
Message-ID: <ZFFsni5znI4hS953@smile.fi.intel.com>
References: <20230427115120.241954-2-k.graefe@gateware.de>
 <20230428064905.145858-1-k.graefe@gateware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230428064905.145858-1-k.graefe@gateware.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 08:49:04AM +0200, Konrad Gräfe wrote:
> The CDC-ECM specification requires an USB gadget to send the host MAC
> address as uppercase hex string. This change adds the appropriate
> modifier.

Why not teaching %ph to provide an uppercase? Would be much more useful than
this.

-- 
With Best Regards,
Andy Shevchenko


