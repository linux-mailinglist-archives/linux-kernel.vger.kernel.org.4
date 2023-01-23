Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A849B678641
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjAWT0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjAWT0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:26:19 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55092113;
        Mon, 23 Jan 2023 11:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674501978; x=1706037978;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jy150XyuERCh2fiwnJuz+EToeoCHCaLdsWTWyPJgDPA=;
  b=LeAMQCP/ml5BMLzbKgKnT4T5xeBo++hHrSbMxwFlfLwBghKXmT+qljQ1
   2Y8uuNs7h4dJCMmsCRf3DMwJUNME59g0oJVd0o/F6bcRPjAJbGqzUQG4K
   9c+8qrIHp4YZtI1h5Fp4hsqx8m1t9kZm89zSfMwQcWGGZVn5oA3PZQnjP
   xvTCGazdpGzElVYp+zp27u70P2cz5oAgPYQnrZ14fvlMnA5mSviBth+t4
   25L/+CjPj1kR3I/sSyx4F/DlCwqXl4wEYpQANS+ijzpKlrgTBzXIDb56q
   Txhu6BQ7B7qveZqQrjYXoFcR/qO7oIJkG45jxYo/5wx5i3rf5HyOpX4FR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="412355868"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="412355868"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 11:26:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="663789877"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="663789877"
Received: from mhkirsch-mobl1.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.134.26])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 11:26:18 -0800
Message-ID: <19f1860e20fbc75c3d2c3eefda29cccd18ca59a9.camel@linux.intel.com>
Subject: Re: [PATCH v7 0/3] thermal: intel: Use generic trip points in 2
 drivers
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Date:   Mon, 23 Jan 2023 11:26:09 -0800
In-Reply-To: <3234230.44csPzL39Z@kreacher>
References: <5916342.lOV4Wx5bFT@kreacher> <2882611.e9J7NaK4W3@kreacher>
         <3234230.44csPzL39Z@kreacher>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-01-23 at 19:52 +0100, Rafael J. Wysocki wrote:
> On Monday, January 23, 2023 7:45:30 PM CET Rafael J. Wysocki wrote:
> > On Monday, January 23, 2023 7:36:52 PM CET Rafael J. Wysocki wrote:
> > > Hi All,
> > > 
> > > This is a new version of the series from Daniel posted as:
> > > 
> > > https://lore.kernel.org/linux-pm/20230120231530.2368330-1-daniel.lezcano@linaro.org/
> > > 
> > > The first patch has been reworked (see
> > > https://lore.kernel.org/linux-pm/5911499.lOV4Wx5bFT@kreacher/)
> > > and the other two have been rebased on top of it.
> > > 
> > > I have retained the R-by tags from Rui, because the changes in
> > > patches [2-3/3] are
> > > not essential, but I think that this new set needs to be tested
> > > again.
> > > 
> > > Srinivas, can you test it please?
> > 
> > Something's wrong, sorry.
> > 
> > I get some invalid trip temperatures with this set.
> 
> Sorry, scratch this, I got confused by THERMAL_TEMP_INVALID showing
> up in
> sysfs, but it did show up before too.
> 
> Please test!
> 

> 

> 
> It will be easy if you have some test branch to avoid dependecies on
> other patches.

Thanks,
Srinivas

> 
> 

