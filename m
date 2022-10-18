Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D164E60234D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 06:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiJREc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 00:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiJREcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 00:32:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192799E2F3;
        Mon, 17 Oct 2022 21:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666067572; x=1697603572;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=2R8xlhxfdNbMouFpmIx5uoo8HNnSnQ0/jK1OkdiCVDY=;
  b=eVBjsWs5p9DazXp4bUbeDlFK19CCvRnXtNIdlBAitv4MTpPnAbNngJSn
   dIp+H0sOrXgOXZA+uvj0dcot4whc/PtGU1VTwFP7kfvf8Wcf//8lhPCmb
   veq/OcSKJQd3b66FAfzQkF5ct5vexmfKwo7imOwtLvDIT+YTEOmy2M0Hd
   x/otQah4I8BinH1dXv0IFFA0J/NCNuAF++Z6h/cHZO7AuMk46J2/YR0Pw
   7/Y7fZ+kLmnc1OlXHRh1U2OQ8aH9lR+NHEKcwajdIgUIyjB3YDi8kMOOZ
   mYi1w5D+Ia4gtdmeCb0L6i6VgaWLCj2q/Wb123cP2P+76UbhOx0d+1nox
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="370191904"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="370191904"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 21:32:51 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="630951123"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="630951123"
Received: from tpavlacx-mobl.amr.corp.intel.com ([10.209.40.195])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 21:32:51 -0700
Message-ID: <2bad27135167f65565cc02c57baffac821e1cf76.camel@linux.intel.com>
Subject: Re: RTC wakealarm file is missing in v6.1-rc1
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
To:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Cc:     rafael.j.wysocki@intel.com, alexandre.belloni@bootlin.com
Date:   Mon, 17 Oct 2022 21:32:50 -0700
In-Reply-To: <967cfe4e2dba242352ccd1cd00bdbcfb48bdd697.camel@linux.intel.com>
References: <967cfe4e2dba242352ccd1cd00bdbcfb48bdd697.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-10-17 at 19:19 -0700, Todd Brandt wrote:
> In the v6.1-rc1 kernel release from about 24 hours ago, the wakealarm
> file for the real time clock appears to be missing. Specifically:
>=20
> /sys/class/rtc/rtc0/wakealarm
>=20
> Without this sysfs file, the rtcwake and sleepgraph tools no longer
> function properly (and probably all tools that use the RTC through
> sysfs). I've tested on 10 machines so far and this occurs on all of
> them regardless of the specific hardware.
>=20
> The issue is in this patch set for the rtc subsystem. If I remove
> this
> commit and rebuild, the issue goes away. I'm in the process of
> bisecting further.
>=20
> commit b7270c69a36efc61ed6ebd31a8a458f354a6edc0
> Merge: 4ce1b97949cb e5f12a398371
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:=C2=A0=C2=A0 Fri Oct 14 18:36:42 2022 -0700
>=20
> I've opened a bugzilla issue here:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D216600
>=20
I've bisected this issue to a single commit. I recommend that this
commit be reverted immediately while Raphael creates a fix. It breaks
linux tools that use the rtc wakealarm.

commit 4919d3eb2ec0ee364f7e3cf2d99646c1b224fae8
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Wed Oct 12 20:07:01 2022 +0200

    rtc: cmos: Fix event handler registration ordering issue
   =20
