Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC9560331B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 21:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJRTMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 15:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJRTMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 15:12:13 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1628F269;
        Tue, 18 Oct 2022 12:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666120316; x=1697656316;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=J5Axrfhz5/wL/Kf2l0pHtNIJ+g37kVIeODA4nBzqE+g=;
  b=QHvhvn2A+AomiDvxOJuMnVIPcqY8flERNNNydkNBIUWUkrrb5ZcivdTR
   puOw8dhjK49rrL2v93wmkTDJJKDqXWyL1BL7ka02LMXm1Yhip8rSlIdIQ
   qrkRkxGSPMUxofde9XabRclI7yHXZ9p9MWX8a+JmLo6PRi5mvzawvsYZs
   0gJ00V1qkwaq070+jDSD33Ov01AxH/M4w8k2+WE2Y6vpRgpgvMKLmzsxi
   DSIHFRl0+T07x/yvDfbvA/6DBl7c+DTZ8mjOTX1Xj9Kx6DIfhcclogfyi
   zefurnlbHmYdWkzTnKfR+wUcek7ziT994p3v+TKDcTVVuq27f8cfTeF/g
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="303824875"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="303824875"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 12:11:54 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="957941399"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="957941399"
Received: from mhans-mobl3.amr.corp.intel.com ([10.209.54.123])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 12:11:52 -0700
Message-ID: <7f905f62ab85c9728c56482896cfd9d6d970929e.camel@linux.intel.com>
Subject: Re: [PATCH] rtc: rtc-cmos: Fix wake alarm breakage
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
To:     Len Brown <lenb@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org
Date:   Tue, 18 Oct 2022 12:11:52 -0700
In-Reply-To: <CAJvTdKnNM=bT9q=Ypv9FESBLSo0GOViRFn=SOUz_pYk3dFvBaQ@mail.gmail.com>
References: <5887691.lOV4Wx5bFT@kreacher>
         <166611112152.2353171.9661532286339710942.b4-ty@bootlin.com>
         <CAJvTdKnNM=bT9q=Ypv9FESBLSo0GOViRFn=SOUz_pYk3dFvBaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-10-18 at 18:58 +0200, Len Brown wrote:
> Works for me!
>=20
> Tested-by: Len Brown <len.brown@intel.com>
>=20
> On Tue, Oct 18, 2022 at 6:39 PM Alexandre Belloni

Works for me too

Tested-by: Todd Brandt <todd.e.brandt@intel.com>

> <alexandre.belloni@bootlin.com> wrote:
> >=20
> > On Tue, 18 Oct 2022 18:09:31 +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >=20
> > > Commit 4919d3eb2ec0 ("rtc: cmos: Fix event handler registration
> > > ordering issue") overlooked the fact that cmos_do_probe()
> > > depended
> > > on the preparations carried out by cmos_wake_setup() and the wake
> > > alarm stopped working after the ordering of them had been
> > > changed.
> > >=20
> > > [...]
> >=20
> > Applied, thanks!
> >=20
> > [1/1] rtc: rtc-cmos: Fix wake alarm breakage
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit: 0782b66ed2fbb035dda76111df095451=
5e417b24
> >=20
> > Best regards,
> >=20
> > --
> > Alexandre Belloni, co-owner and COO, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
>=20
>=20
>=20

