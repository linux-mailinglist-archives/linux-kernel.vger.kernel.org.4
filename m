Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B415E686E30
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjBAShf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjBAShV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:37:21 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CD98002D;
        Wed,  1 Feb 2023 10:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675276610; x=1706812610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=umPhYtaceRh5nbUWddx0fc4HpDBTCRW26sj4OwQAnBU=;
  b=keiXSnY3ikfotcLxcVxbY03a9jvbG+/ffL/mErUf5ykktXyjiZx6Idjh
   T7jIkuEAwWwDiuWU8PJXDUXsskWvOfwVrDJQbjw4EwWc+mNQ2x+2kIBfc
   JHmEQdN595jd8J3dR5O90ybMqi8m1sGYLt8+DB1jRhkcFgQHuBO0mkDld
   YlTdS6ZGTjtiPCm2Ls4wqvebDPob3Ulwa7WJQ5sKJZN7g80bD4m91UeHq
   3HWwYOrpL/ORDwvcmR8sqzc8n79yFNO5Io6kMHUidX5y6vDm+8XYdB1LT
   1Fu0x5BGPGg6+On366742yxvW5m5KhjbrI2AsQlxsBuEhlcqTqukgePgW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="307893951"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="307893951"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 10:36:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="658422727"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="658422727"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 01 Feb 2023 10:35:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pNHxb-000pbA-31;
        Wed, 01 Feb 2023 20:35:55 +0200
Date:   Wed, 1 Feb 2023 20:35:55 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: c8sectpfe: convert to gpio descriptors
Message-ID: <Y9qxCyB9Tw7ehFJs@smile.fi.intel.com>
References: <20230130131003.668888-1-arnd@kernel.org>
 <CAKdAkRQt15PNbwzDv0sciE5xfQ8LT76cyPepzmMdNsAYg1P1vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKdAkRQt15PNbwzDv0sciE5xfQ8LT76cyPepzmMdNsAYg1P1vA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 07:29:37PM -0800, Dmitry Torokhov wrote:
> On Mon, Jan 30, 2023 at 5:31 AM Arnd Bergmann <arnd@kernel.org> wrote:

...

> > +               tsin->rst_gpio = devm_fwnode_gpiod_get_index(dev,
> > +                                                            of_node_to_fwnode(child),

Actually, please use of_fwnode_handle() and not IRQ framework custom grown
duplicate.

> > +                                                            "reset-gpios",
> 
> Wrong name.
> 
> > +                                                            0, GPIOD_OUT_LOW,
> > +                                                            "NIM reset");

-- 
With Best Regards,
Andy Shevchenko


