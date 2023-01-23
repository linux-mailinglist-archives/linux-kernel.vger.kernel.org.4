Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D34D6789C2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjAWVfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjAWVfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:35:37 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F7816AD4;
        Mon, 23 Jan 2023 13:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674509736; x=1706045736;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nR7qvqEhQSQs2BJuXYecKKgYCOIc9fcU9d15EG7XyuE=;
  b=HljD/vjcUJoZSMvS15lsu+6LE6EiZvbm5p+Fz8mL7qduiFLHRrx2Q9ip
   5pQnm5EHMvR/bXYKCnv0WShoFBb0wV13AjifrEQTJeQE1JRqm45EBv1jj
   /yya9YlBTP0+Yxkg+kdq0AGMBaRkrPg2w1v9yh1dnErVyGRd6T7nU6lqr
   uOifIdk4MBB/qQfCxozmJalHNN7lECqrdQizAJ5w9wJX+5Yl0GbDRArJu
   SAClSJkKMMnObr4g7LVS/hAv6FiA3zRz7Vr4n5FmCYR/aUEzGpvonNrpe
   focO2vtSNhO49gDNVbqQM6qHDJxlgk/884p2fWkm17VjpsDWJf6JnwT3Z
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="353428761"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="353428761"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 13:35:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="663833142"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="663833142"
Received: from mhkirsch-mobl1.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.134.26])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 13:35:36 -0800
Message-ID: <ca878d5a177b68eaf5f698e0afda5c0b1718a53f.camel@linux.intel.com>
Subject: Re: [PATCH v7 0/3] thermal: intel: Use generic trip points in 2
 drivers
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Date:   Mon, 23 Jan 2023 13:35:35 -0800
In-Reply-To: <CAJZ5v0gK_O-9_tPEVbmBbf+2vxVA2_C5tPGOo_qghyw86pohoA@mail.gmail.com>
References: <5916342.lOV4Wx5bFT@kreacher> <2882611.e9J7NaK4W3@kreacher>
         <3234230.44csPzL39Z@kreacher>
         <19f1860e20fbc75c3d2c3eefda29cccd18ca59a9.camel@linux.intel.com>
         <CAJZ5v0gK_O-9_tPEVbmBbf+2vxVA2_C5tPGOo_qghyw86pohoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-01-23 at 20:54 +0100, Rafael J. Wysocki wrote:
> On Mon, Jan 23, 2023 at 8:26 PM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > On Mon, 2023-01-23 at 19:52 +0100, Rafael J. Wysocki wrote:
> > > On Monday, January 23, 2023 7:45:30 PM CET Rafael J. Wysocki
> > > wrote:
> > > > On Monday, January 23, 2023 7:36:52 PM CET Rafael J. Wysocki
> > > > wrote:
> > > > > Hi All,
> > > > > 
> > > > > This is a new version of the series from Daniel posted as:
> > > > > 
> > > > > https://lore.kernel.org/linux-pm/20230120231530.2368330-1-daniel.lezcano@linaro.org/
> > > > > 
> > > > > The first patch has been reworked (see
> > > > > https://lore.kernel.org/linux-pm/5911499.lOV4Wx5bFT@kreacher/
> > > > > )
> > > > > and the other two have been rebased on top of it.
> > > > > 
> > > > > I have retained the R-by tags from Rui, because the changes
> > > > > in
> > > > > patches [2-3/3] are
> > > > > not essential, but I think that this new set needs to be
> > > > > tested
> > > > > again.
> > > > > 
> > > > > Srinivas, can you test it please?
> > > > 
> > > > Something's wrong, sorry.
> > > > 
> > > > I get some invalid trip temperatures with this set.
> > > 
> > > Sorry, scratch this, I got confused by THERMAL_TEMP_INVALID
> > > showing
> > > up in
> > > sysfs, but it did show up before too.
> > > 
> > > Please test!
> > > 
> > 
> > > 
> > 
> > > 
> > It will be easy if you have some test branch to avoid dependecies
> > on
> > other patches.
> 
> Please see the thermal-intel-test branch in linux-pm.git.  It's this
> series on top of the core thermal stuff + ARM drivers.
Tested on one system. Works fine.

Thanks,
Srinivas

