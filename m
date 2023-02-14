Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59BB6964DD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjBNNlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbjBNNks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:40:48 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281B425B8C;
        Tue, 14 Feb 2023 05:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676382044; x=1707918044;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=fox8qfqjUxnSFtXHl7w9GmVt3WYi/aN+a+4IC9ygdKw=;
  b=NCEBr+3WKSS4hI+tRk1fpiq2c/TTaLyE5i/S5GRFOCLovn7uOCheuIf2
   sWppUgxs2doA4zWRw0/ib/BAQhSOigTShKVcziRmMnlqNhgzwpD0LPL2x
   m6feN2PWHZoI7v+IDccT1emF/XpCNGXXwcgxvbBKq2Stoi3VgyHzWpp6L
   A+MrlOs487LvG3p1FgcKC5GIZ4qg3rnFFpHR8gbAfXYcAByST6Yz2T87S
   Jhf1aNN2z5+0HzuyFOOAoiuLa2/tCo7g7VtWcd5rY0emxkB44bZkIiVob
   ksQfRWjN0k00DIXwo+rT2hoV+2j+PWkWzf2u9NX9lzo0EfRbuHeT0RYvY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="314803099"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="314803099"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 05:40:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="671222003"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="671222003"
Received: from bogasiva-mobl.amr.corp.intel.com ([10.215.122.78])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 05:40:35 -0800
Message-ID: <0f74e16d2a1c5005c342d800445c046b8fe248cb.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/3] ACPI: processor: perflib: Use the "no limit"
 frequency QoS
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pratyush Yadav <ptyadav@amazon.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Date:   Tue, 14 Feb 2023 05:40:32 -0800
In-Reply-To: <CAJZ5v0j1CBe7Hjhg7Tzm3HkuinA9zgtPffMtd96ZaOds=US+xQ@mail.gmail.com>
References: <12138067.O9o76ZdvQC@kreacher> <12124970.O9o76ZdvQC@kreacher>
         <mafs0sfgybc3q.fsf_-_@amazon.de>
         <CAJZ5v0hAjKvinPqX2VuCv1jVu50jrnDpECaO=sA2CQZFHZpJdA@mail.gmail.com>
         <mafs0zga0ds30.fsf_-_@amazon.de>
         <CAJZ5v0j1CBe7Hjhg7Tzm3HkuinA9zgtPffMtd96ZaOds=US+xQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-01-30 at 15:58 +0100, Rafael J. Wysocki wrote:
> On Mon, Jan 30, 2023 at 3:18 PM Pratyush Yadav <ptyadav@amazon.de>
> wrote:
> >=20
> >=20

[...]

> > [0]
> > https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/
>=20
> It's already in the mainline:
>=20
> e8a0e30b742f cpufreq: intel_pstate: Drop ACPI _PSS states table
> patching
> 99387b016022 ACPI: processor: perflib: Avoid updating frequency QoS
> unnecessarily
> c02d5feb6e2f ACPI: processor: perflib: Use the "no limit" frequency
> QoS

I am checking 6.2-rc8.
I don't see these commits.

The last commit in mainline is
 git log --oneline drivers/acpi/processor_perflib.c
f1a70bac90ca ACPI: processor: perflib: Adjust
acpi_processor_notify_smm() return value

Whereas linux-pm tree it is :

git log --oneline drivers/acpi/processor_perflib.c
99387b016022 ACPI: processor: perflib: Avoid updating frequency QoS
unnecessarily
c02d5feb6e2f ACPI: processor: perflib: Use the "no limit" frequency QoS
f1a70bac90ca ACPI: processor: perflib: Adjust
acpi_processor_notify_smm() return value


Thanks,
Srinivas
