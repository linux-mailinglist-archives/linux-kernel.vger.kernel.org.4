Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DA66B8770
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 02:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjCNBIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 21:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjCNBHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 21:07:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014678C810;
        Mon, 13 Mar 2023 18:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678756067; x=1710292067;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jY+UROC4mFlLoBl1P954VMj5wdgk3zqD9N3XYq4seL0=;
  b=JoQVJpqB8TtB5RMNmFpXP92kxh874mwWyktN/9IibALGBveHqvaoxncV
   U3Pzx7igPxhN+WyBkxFKbuRWLYQzwtWf+VC0mUItCdLGlIAhQzKabDUs8
   cJrZDoLwR56pQfsJOhvl6BLQwS07/iJBWJSYeYUpWiR/fygzLWM5Dd+rE
   QGZU855qvxgPdD1g252OImIhCMEeqdoQOnPAVJPzSqarIHQDkDvOBzWAh
   WfKDt0PyVFUOLqpt4bDu/vdH0Yg7smABwpl3YMi3J7j0CVUyb6KWCtHnt
   MhdXwgwYaCLIUyQu6KmGQ481bADtIfZe6JtNB2+0pNGny4xEd/ujzksb6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="339664918"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="339664918"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:07:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="656156645"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="656156645"
Received: from ashimabu-mobl3.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.60.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:07:46 -0700
Message-ID: <06f603ab1a089e3d4dd8d91a28422d8f3300026c.camel@linux.intel.com>
Subject: Re: [PATCH v2] Fix buffer overrun in HID-SENSOR name string
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     todd.e.brandt@linux.intel.com, Andi Shyti <andi.shyti@kernel.org>,
        Todd Brandt <todd.e.brandt@intel.com>
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, jic23@kernel.org, jikos@kernel.org,
        p.jungkamp@gmx.net
Date:   Mon, 13 Mar 2023 18:07:46 -0700
In-Reply-To: <c5f67e5c49aee0ce48545a79b7295c7af779347f.camel@linux.intel.com>
References: <20230313220653.3996-1-todd.e.brandt@intel.com>
         <20230313230712.6xboy3w5ocrvj3vn@intel.intel>
         <c5f67e5c49aee0ce48545a79b7295c7af779347f.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-03-13 at 16:37 -0700, Todd Brandt wrote:
> On Tue, 2023-03-14 at 00:07 +0100, Andi Shyti wrote:
> > Hi Todd,
> > 
> > On Mon, Mar 13, 2023 at 03:06:53PM -0700, Todd Brandt wrote:
> > > On some platforms there are some platform devices created with
> > > invalid names. For example: "HID-SENSOR-INT-020b?.39.auto"
> > > instead
> > > of "HID-SENSOR-INT-020b.39.auto"
> > > 
> > > This string include some invalid characters, hence it will fail
> > > to
> > > properly load the driver which will handle this custom sensor.
> > > Also
> > > it is a problem for some user space tools, which parse
s parse/parses

> > >  the device
> > > names from ftrace and dmesg.
> > > 
> > > This is because the string, real_usage, is not NULL terminated
> > > and
> > > printed with %s to form device name.
> > > 
> > > To address this, we
Remove "we"

> > >  initialize the real_usage string with 0s.
> > > 
> > > Philipp Jungkamp created this fix, I'm simply submitting it. I've
> > > verified it fixes bugzilla issue 217169
> > > 
You don't need the above two lines. You can add

Original-by: Philipp Jungkamp <p.jungkamp@gmx.net>

Before your SOB.

> > > Reported-and-tested-by: Todd Brandt
> > > <todd.e.brandt@linux.intel.com>
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=217169
> > > Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>
> > 
> > Why is not Philip in the SoB list?
> > 
> Oh, sorry, I got feedback and assumed it needed more work on the
> changelog. I also forgot to copy over Phillip's SoB line so this one
> is
> probably worse than the original. The original was just fine, please
> ignore this one.
> 
> > Anyway the original patch made it to stable, so:
> > 
> > Fixes: 98c062e82451 ("HID: hid-sensor-custom: Allow more custom iio
> > sensors")
> > Cc: stable@vger.kernel.org
> > 
> > and with those you can add:
> > 
> > Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> > 
> > Andi
> 

