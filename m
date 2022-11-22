Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DB5634005
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 16:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbiKVPVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 10:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbiKVPVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 10:21:15 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5826663EC;
        Tue, 22 Nov 2022 07:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669130474; x=1700666474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s3VVg2g632Tux17uwTkaAb/v5mQIhikDvfW22IAN4Os=;
  b=OuK3+nnJb1LRXZb+k9CkuD8SWVrCvIZF8nE3/JYGGrh1brjqVML3SdP6
   V98uA+ms0BrQmDyQTJvV81f5tYcR2XQTH0rbFjgQlQDUMlhUKmaTWu6bu
   QJVC6/Dprgsrpgpu6SrRu08+Q/yVTrqTWa4cENisiMoUDUOHZyNnczUHR
   88zW8lL2znmEtDmiNCaRu1YKnCBU4JFT65KKPabE0RMDvPD/fT3Xq32Rh
   CWwOfDzRahGt1zfUYaWHj4P2dvt367CmyGc9ZAUxDGVoyQxfRGvQ7BgQM
   C7Vg5I14USreFsTaMXl7w5AA5ve5UzvivHHtAZJQk14DnKl2qfyFeyYhx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="301388858"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="301388858"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 07:20:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="886570850"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="886570850"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 22 Nov 2022 07:20:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxV4i-00FsuP-1K;
        Tue, 22 Nov 2022 17:20:40 +0200
Date:   Tue, 22 Nov 2022 17:20:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/4] usb: gadget: hid: Convert to use list_count()
Message-ID: <Y3zoyFs2Q9ogoz/L@smile.fi.intel.com>
References: <20221114162207.62559-1-andriy.shevchenko@linux.intel.com>
 <20221114162207.62559-2-andriy.shevchenko@linux.intel.com>
 <CAOMZO5CJvuMUNwPQ7GUQh0dinYSfQ5TTLMawUt7hMVKJD4S3GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5CJvuMUNwPQ7GUQh0dinYSfQ5TTLMawUt7hMVKJD4S3GQ@mail.gmail.com>
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

On Mon, Nov 14, 2022 at 04:15:35PM -0300, Fabio Estevam wrote:
> On Mon, Nov 14, 2022 at 1:22 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > The list API now provides the list_count() to help with counting
> > existing nodes in the list. Uilise it.
> 
> s/Uilise/Utilise

Fixed for v3, thanks!

-- 
With Best Regards,
Andy Shevchenko


