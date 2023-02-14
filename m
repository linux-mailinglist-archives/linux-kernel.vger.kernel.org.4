Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79876966B2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjBNO0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjBNOZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:25:52 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30787B47C;
        Tue, 14 Feb 2023 06:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676384744; x=1707920744;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=rfaoZsgtkph5tbhQQ3UUnwAFv5xUvSirRQpgUD+R3bQ=;
  b=OOhZcaW9z6pHRFNWfz0/VfG91fMpM/uOTVdftTGPhZh0FEux46s7RYGA
   HfrCvmMR8tNYuSEgPPo+mS2ZOdMGOSObJPEu8ZGrHXgzXASNbk1MM0wbX
   9SPpgUXnRA8H1jRdbMod/+k1UmDbA4ObtHeLF2+GXs2wBXlpRrVbCxhTc
   cNVNPz4v6epUGFyUcOJIvBYqI12umsV1dHvfmyGRJ9uvveJG7V/85w4a7
   fzQaASc7BJbJYJHXGCM694ryXFMfkfrOwmH/DRkTAMq++p4SfvCYqKGpq
   pnKJArAEHx1x6WQs9Gf1NT1Ko8rtKRKHRu9Voh+UB7EPNw9yCOCqe4t3Z
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="331166774"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="331166774"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 06:25:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="914756323"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="914756323"
Received: from bogasiva-mobl.amr.corp.intel.com ([10.215.122.78])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 06:25:41 -0800
Message-ID: <dc9f52c96be1be761177e4d52eae1cd4306abeb4.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/3] ACPI: processor: perflib: Use the "no limit"
 frequency QoS
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pratyush Yadav <ptyadav@amazon.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Date:   Tue, 14 Feb 2023 06:25:37 -0800
In-Reply-To: <CAJZ5v0g1PiMDFUeVKy3YL4pni6oDDaEVTw-LLYnYMMsF+5uuMQ@mail.gmail.com>
References: <12138067.O9o76ZdvQC@kreacher> <12124970.O9o76ZdvQC@kreacher>
         <mafs0sfgybc3q.fsf_-_@amazon.de>
         <CAJZ5v0hAjKvinPqX2VuCv1jVu50jrnDpECaO=sA2CQZFHZpJdA@mail.gmail.com>
         <mafs0zga0ds30.fsf_-_@amazon.de>
         <CAJZ5v0j1CBe7Hjhg7Tzm3HkuinA9zgtPffMtd96ZaOds=US+xQ@mail.gmail.com>
         <0f74e16d2a1c5005c342d800445c046b8fe248cb.camel@linux.intel.com>
         <CAJZ5v0g1PiMDFUeVKy3YL4pni6oDDaEVTw-LLYnYMMsF+5uuMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-02-14 at 14:57 +0100, Rafael J. Wysocki wrote:
> On Tue, Feb 14, 2023 at 2:40 PM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > On Mon, 2023-01-30 at 15:58 +0100, Rafael J. Wysocki wrote:
> > > On Mon, Jan 30, 2023 at 3:18 PM Pratyush Yadav
> > > <ptyadav@amazon.de>
> > > wrote:
> > > >=20
> > > >=20
> >=20
> > [...]
> >=20
> > > > [0]
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
/
> > >=20
> > > It's already in the mainline:
> > >=20
> > > e8a0e30b742f cpufreq: intel_pstate: Drop ACPI _PSS states table
> > > patching
> > > 99387b016022 ACPI: processor: perflib: Avoid updating frequency
> > > QoS
> > > unnecessarily
> > > c02d5feb6e2f ACPI: processor: perflib: Use the "no limit"
> > > frequency
> > > QoS
> >=20
> > I am checking 6.2-rc8.
> > I don't see these commits.
>=20
> You are right, they are in linux-next only, sorry for the confusion.
>=20
> I'm going to push them for 6.3-rc1 this week, though.
I don't think they are marked for stable. Can we add that?

Thanks,
Srinivas
