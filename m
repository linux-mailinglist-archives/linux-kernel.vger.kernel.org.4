Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A5B60D098
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbiJYPaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbiJYPaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:30:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDD92AC78;
        Tue, 25 Oct 2022 08:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666711805; x=1698247805;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=xn5JOS/FH+ZZXqzrPkPODHcTMuCEZjsZ59+va4WxJ7A=;
  b=CvPslIeOsFexfPByRaSzOuU8ter0iUdOGyGigzfK/IAq3bXKJNNfwUf0
   hcVkRfi64TzU4gjecrijIu/b2NfpGxfN9BqnaOf7pgFlgwgT9Zgkh6XdK
   8fHfU8aMXVH6tGucy8D7uTfz2z7P6n+rT2AG1jCaOj8bYXDG68cQ/Dxkf
   UdE23kwtTIQKkDEFB2PDqGEmBb0RobqYR4APHA9zXwcK7BKBLYcbMsHcq
   49VqNwxGQ8C3CDfavm/tysVnSK4C7xMQXiYy9MVYT1a5eUivbcA4e56yD
   uEHty3t+S1/JeHe4E8pPozr9Urbxv/p2YLKnwsjaz35nVv/qdA0g2l+Rx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="371921673"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="371921673"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 08:28:41 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="694995410"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="694995410"
Received: from wdunn-mobl1.amr.corp.intel.com ([10.212.194.192])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 08:28:39 -0700
Message-ID: <836b1787426d5b1569f6d77007a4765ee17d5ea6.camel@linux.intel.com>
Subject: Re: [PATCH] rtc: rtc-cmos: Fix wake alarm breakage
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org
Date:   Tue, 25 Oct 2022 08:28:39 -0700
In-Reply-To: <166611112152.2353171.9661532286339710942.b4-ty@bootlin.com>
References: <5887691.lOV4Wx5bFT@kreacher>
         <166611112152.2353171.9661532286339710942.b4-ty@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-10-18 at 18:38 +0200, Alexandre Belloni wrote:
> On Tue, 18 Oct 2022 18:09:31 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >=20
> > Commit 4919d3eb2ec0 ("rtc: cmos: Fix event handler registration
> > ordering issue") overlooked the fact that cmos_do_probe() depended
> > on the preparations carried out by cmos_wake_setup() and the wake
> > alarm stopped working after the ordering of them had been changed.
> >=20
> > [...]
>=20
> Applied, thanks!

I did testing yesterday on the 6.1.0-rc2 build and this patch hasn't
made it into rc2. This is an extreme inconvenience to anyone testing
low power modes as the rtc wakealarm doesn't function. I'm a little
surprised more people haven't complained.

Please get this in 6.1.0-rc3.

> [1/1] rtc: rtc-cmos: Fix wake alarm breakage
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit: 0782b66ed2fbb035dda76111df0954515e=
417b24
>=20
> Best regards,
>=20

