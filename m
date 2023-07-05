Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928827482F4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 13:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjGELgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 07:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjGELgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 07:36:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979311703;
        Wed,  5 Jul 2023 04:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688556964; x=1720092964;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IcBpGpbg2SWjjirWksL0uymR/Eu/8w4PzybBcluQYJQ=;
  b=PlO4eekbDYtXQfzZHKX0W9DJ+/qPv8+6WBWgzBMkBhvQ4K3T2V1/mfH7
   6gymS+txDAWBcRiTifbLrA8hJPtvOsB/lK00KYLSTjhz4D1DAsdhL9Ihq
   033GRwtavzYVRsxKdFxKLeXWpmwcZfMFL1kT6CZr2u2ydCDIUMTYKhrPK
   m1+Ep3OV8xfedLU3qNx6ILd3Y/8Fl/mYnSjSqhjlAyws9hUgpbrlpzCfw
   ov4yIOvXgp3T7lyOInQndys2DfoPChmgdMMMpfHvzeHl5P2bvWHS+9cMg
   jmuhUOp1fvJKGtC57O2U7RvHZ+T8T3FCgEY+BX648Mg9EdF1yLrJeG2r3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="362186264"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="362186264"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 04:36:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="754333758"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="754333758"
Received: from banerje2-mobl2.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.58.122])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 04:35:59 -0700
Message-ID: <f3679761bbf31ff93d45985f67a85f28b0027eac.camel@linux.intel.com>
Subject: Re: [PATCH 5/8] thermal/drivers/int3400: Use thermal zone device
 wrappers
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, thierry.reding@gmail.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        open list <linux-kernel@vger.kernel.org>, rafael@kernel.org
Date:   Wed, 05 Jul 2023 04:35:59 -0700
In-Reply-To: <77c90891-3712-4b3b-a22c-d9ccba36f58e@linaro.org>
References: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
         <20230525140135.3589917-6-daniel.lezcano@linaro.org>
         <ab892878-9c66-f94f-cf4c-9961723411d2@linaro.org>
         <74c232550c6787ef34ddac67a61339e6c028fb0d.camel@linux.intel.com>
         <77c90891-3712-4b3b-a22c-d9ccba36f58e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed, 2023-07-05 at 12:41 +0200, Daniel Lezcano wrote:
> 
> Hi Srinivas,
> 
> thanks for your answer. What about the patch 6?
I was not CCed. But checked from LKML, 
The change looks good.

Thanks,
Srinivas

> 
> 
> On 03/07/2023 18:15, srinivas pandruvada wrote:
> > Hi Daniel,
> > 
> > On Mon, 2023-07-03 at 12:49 +0200, Daniel Lezcano wrote:
> > > 
> > > Hi Srinivas,
> > > 
> > > do you agree with the changes in patches 5 and 6 ?
> > > 
> > > Thanks
> > > 
> > >     -- Daniel
> > > 
> > > 
> > > On 25/05/2023 16:01, Daniel Lezcano wrote:
> > > > The driver is accessing the thermal zone device structure but
> > > > the
> > > > accessors are already existing and we want to consolidate the
> > > > thermal
> > > > core code by preventing accesses to the internals from the
> > > > drivers.
> > > > 
> > > > Let's use these accessors.
> > > > 
> > > > On the other side, the code is getting directly the temperature
> > > > from
> > > > tz->temperature, but the temperature is a faked on, so we can
> > > > replace
> > > > this access by the fake temp and remove the thermal zone device
> > > > structure access.
> > > > 
> > May be something simple description like this will be enough.
> > 
> > "
> > Use thermal core API to access thermal zone "type" field instead of
> > directly using the structure field.
> > While here, remove access to temperature field, as this driver is
> > reporting fake temperature, which can be replaced with
> > INT3400_FAKE_TEMP. Also replace hardcoded 20C with
> > INT3400_FAKE_TEMP.
> > "
> > 
> > The change itself looks fine.
> 
> 

