Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841E45E7CBB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiIWOTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiIWOTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:19:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E01913F739;
        Fri, 23 Sep 2022 07:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663942753; x=1695478753;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cF3OhXh4Ydj3/v5de8W7g+mdWwMq2bsCnZD5n0V16R0=;
  b=PX+fgqNm7CziKI2E3Pi1edLqgMPGv2Zd/5JYLIhnbL45QlXx2vzeZdrN
   wgUC09ALG6NroOHjMDCE7c/Y8GMq+1AzO6aaj6X3DaBoDMIou36xiWJct
   qFFmZQTOSX+zUKOwsnmDtSrMpWpEFvR8OlJjlc/kSeJlr3HvSQpwkFijl
   ftEQbV1HfjZAxLx9BvwQJCEtf5BD82nJM4X85c5t5unBM0ISQDYe7qwZA
   sXvIlTnwowDJKOzJVmz8qL9ueZaJK7sY0Su7SyjmHtSl9xjv0Q9mANkCl
   N24rR73gYP8obd04F+Cl7veNhpd0fojBNnjn7NjAqeSaz+3oTPzcx7rjK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="302048901"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="302048901"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 07:19:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="688728079"
Received: from weiyeeta-mobl.gar.corp.intel.com ([10.213.40.75])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 07:19:09 -0700
Message-ID: <c1d4ec94cc666897d8e493364352bd1442bdb819.camel@intel.com>
Subject: Re: [PATCH v4 02/30] thermal/sysfs: Do not make get_trip_hyst
 optional
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>
Date:   Fri, 23 Sep 2022 22:19:05 +0800
In-Reply-To: <20220921094244.606948-3-daniel.lezcano@linaro.org>
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
         <20220921094244.606948-3-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-09-21 at 11:42 +0200, Daniel Lezcano wrote:
> The get_trip_hyst() ops is optional. It results all around the
> thermal
> framework code a check against the ops pointer and different action
> adding more complexity and making the code less readable and
> understandable.
> 
> A zero hysteresis value is perfectly valid, so instead of adding more
> circumvolutions in the code, create unconditionnaly the hysteresis
> and
> use the thermal_zone_get_trip() function which returns a zero
> hysteresis if the get_trip_hyst() is not defined.

I think an alternative way is to use the .is_visible() callback to make
this cleanup transparent to userspace.

With this, we can remove the
	if (tz->ops->set_trip_hyst)check in create_trip_attrs() as well.

But you make the cal. :)

thanks,
rui


