Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E2A626D77
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 03:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbiKMCf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 21:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiKMCf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 21:35:27 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F4FFD39;
        Sat, 12 Nov 2022 18:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668306925; x=1699842925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gT7wBumMbUVlYyDmNw4XcR4Yfyh5B4WGurYATeDlOJU=;
  b=V+XbQS5eYtwDBuglgHhFY9IXZT8XaEAUOLxMxkknEqX45oUXLfSh8v8M
   4yncRCogrIqnwOCrl8vDZsQROEgapzj/j37OfVXBHv+XzEhW3ne8Gm3d4
   4PfNzATt2v6VRHJWLZAm1yW158lRAoqujNj20PBfe0jd0O7uhoqcRlWzn
   /A5RtH6Rvv+R6a5I86bXHUAAQDDr+EgqdHzeewQz2MnMCXwhQoE39A+ja
   Zd9UAns+sOxajfsazv3oXSqsoSWEkChg2fsu990dD7ya0qKcQmRR9Vrnm
   tng9lt/0EXF/MLTEnJTMeLs/sGpCO6ZWXkcohkFiCbzkcgMrqcngQ5+Eo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="309400071"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="309400071"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2022 18:35:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="701589635"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="701589635"
Received: from fkabir-mobl.amr.corp.intel.com (HELO tjmaciei-mobl5.localnet) ([10.255.228.60])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2022 18:35:24 -0800
From:   Thiago Macieira <thiago.macieira@intel.com>
To:     Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>
Cc:     "Joseph, Jithu" <jithu.joseph@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
Subject: Re: [PATCH v2 12/14] platform/x86/intel/ifs: Add current_batch sysfs entry
Date:   Sat, 12 Nov 2022 18:35:23 -0800
Message-ID: <2687702.9iZYToFQE1@tjmaciei-mobl5>
Organization: Intel Corporation
In-Reply-To: <B12A4934-AD7A-4F8E-A2FB-229542C1A098@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com> <Y2/z0yY3zcKmR5BN@zn.tnic> <B12A4934-AD7A-4F8E-A2FB-229542C1A098@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 12 November 2022 15:32:47 PST Luck, Tony wrote:
> > Because if this is going to be run during downtime, as Thiago says, then
> > you can just as well use debugfs for this. And then there's no need to
> > cast any API in stone and so on.
>=20
> Did Thiago say =E2=80=9Cduring downtime=E2=80=9D? I think
> he talked about some users opportunistic
> use of scan tests. But that=E2=80=99s far from only
> during downtime. We fully expect CSPs to
> run these scans periodically on production
> machines.

Let me clarify. I did not mean full system downtime for maintenance, but I =
did=20
mean that there's a gap in consumer workload, for both threads of one or mo=
re=20
cores. As Tony said, it should have little observable effect on any other c=
ore,=20
meaning an IFS run can be scheduled *as* any other workload (albeit a=20
privileged one) for a subset of the machine, while the rest of the system=20
remains in production. This allows them a lot of flexibility and is the rea=
son=20
I am talking about containers, with the implied constraint that the=20
container's view of the filesystem is narrower than the kernel's.

There'll be some coordination required to get all cores to have run all tes=
ts,=20
but it should be doable over a period of time, and I'm thinking days, not=20
years. This should still be short enough to reveal if the system can detect=
 a=20
defect or wear-out before any real workload is impacted by it.

If an issue is detected, the admin can decide whether to offline the core(s=
)=20
reporting problems but keep the rest serving workloads and generating reven=
ue,=20
or offline the entire machine for full maintenance and to run more invasive=
 and=20
time-consuming tests.

=2D-=20
Thiago Macieira - thiago.macieira (AT) intel.com
  Cloud Software Architect - Intel DCAI Cloud Engineering



