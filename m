Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A4C686E48
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjBASln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjBASlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:41:39 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4B06A69;
        Wed,  1 Feb 2023 10:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675276887; x=1706812887;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nk2UjAD3MyqHuQla+/DxMZglQldIVZk+vp5CLUYP/LQ=;
  b=Kz/8ANOIGY5PdmMX8hmSZ4JjpjW5gfDUau6eeXRpf7eywjM0MQduoB6W
   oWR+Lw/jY7xjnTsy0uuNTRleiwtoh/aO+Z5OEzET0+/e/K7s/bV58fPxA
   FnrSpubbbCeYKyhD/nPeXIZw00l2N6pZnYB5yzbbEzc3FSsGzyQaCzAIP
   03cBYfnIfRKzv6KZnJuKNRgbbGDP+L5MGgUoTEm/D9vA1Nn+WDFw0z+bq
   zWRXmafeFFfFttvhutC4ZxIkBl5xIduw8v+yq4WzPe8YDxwLgKRQNpxTB
   QHJyYpLXiE2Hl1g7q2eX19zxWPb5fLH8UqhPDqGNlGAKROoebQpwhAbvf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="328249072"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="328249072"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 10:41:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="993793228"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="993793228"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 01 Feb 2023 10:41:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pNI2m-000pi2-0y;
        Wed, 01 Feb 2023 20:41:16 +0200
Date:   Wed, 1 Feb 2023 20:41:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     John Stultz <jstultz@google.com>
Cc:     Yongqin Liu <yongqin.liu@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Nishanth Menon <nm@ti.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Won Chung <wonchung@google.com>,
        David Gow <davidgow@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev, Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH 5/6] driver core: Add __alloc_size hint to devm allocators
Message-ID: <Y9qyTLmfdD2lR+YU@smile.fi.intel.com>
References: <20221101222520.never.109-kees@kernel.org>
 <20221101223321.1326815-5-keescook@chromium.org>
 <CAMSo37W3gRkP02tSCxGX71ZDAt3WgPZrkTRTM6J1iQ4gvUS9vg@mail.gmail.com>
 <CANDhNCogJrvt=yEXFK-xVmGjkcRxSNGZUqUeNw2MV9bFRrwPdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANDhNCogJrvt=yEXFK-xVmGjkcRxSNGZUqUeNw2MV9bFRrwPdQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 12:11:41AM -0800, John Stultz wrote:
> On Tue, Jan 31, 2023 at 11:36 PM Yongqin Liu <yongqin.liu@linaro.org> wrote:

...

> data->nr_sensors = 1;
> data->sensor = devm_kzalloc(dev, sizeof(*data->sensor) *
>    data->nr_sensors, GFP_KERNEL);

Side note: This should use devm_kcalloc().

-- 
With Best Regards,
Andy Shevchenko


