Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277F06814EC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238080AbjA3PYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbjA3PYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:24:02 -0500
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CA5CDC6;
        Mon, 30 Jan 2023 07:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1675092242; x=1706628242;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=A66cVsR4HyfnWSdDHQxAKiNNCa+Rl3FGTfIyI72znt8=;
  b=fP9vMw+p8s6Fn9j7yKe31G17TdgxUXSUl4YEFdfdUl7Fe2MMr7dPWFY8
   N8BwMFDswu8D73Z66AWMDQ94YJk6aMjE7meeYwOlyEtFZP4LMDy6RbkRg
   N3Fld6iykXyEuJLot1nI/TDs1rexP5Z1dgN7DXj02oTU3kbR3wdURTUGO
   k=;
X-IronPort-AV: E=Sophos;i="5.97,258,1669075200"; 
   d="scan'208";a="305617471"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 15:23:55 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com (Postfix) with ESMTPS id 8EB0B42420;
        Mon, 30 Jan 2023 15:23:54 +0000 (UTC)
Received: from EX19D031UWA002.ant.amazon.com (10.13.139.96) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Mon, 30 Jan 2023 15:23:54 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX19D031UWA002.ant.amazon.com (10.13.139.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.24; Mon, 30 Jan 2023 15:23:53 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server id
 15.0.1497.45 via Frontend Transport; Mon, 30 Jan 2023 15:23:53 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
        id 1C57120D6D; Mon, 30 Jan 2023 16:23:52 +0100 (CET)
From:   Pratyush Yadav <ptyadav@amazon.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 1/3] ACPI: processor: perflib: Use the "no limit"
 frequency QoS
References: <12138067.O9o76ZdvQC@kreacher> <12124970.O9o76ZdvQC@kreacher>
        <mafs0sfgybc3q.fsf_-_@amazon.de>
        <CAJZ5v0hAjKvinPqX2VuCv1jVu50jrnDpECaO=sA2CQZFHZpJdA@mail.gmail.com>
        <mafs0zga0ds30.fsf_-_@amazon.de>
        <CAJZ5v0j1CBe7Hjhg7Tzm3HkuinA9zgtPffMtd96ZaOds=US+xQ@mail.gmail.com>
Date:   Mon, 30 Jan 2023 16:23:51 +0100
In-Reply-To: <CAJZ5v0j1CBe7Hjhg7Tzm3HkuinA9zgtPffMtd96ZaOds=US+xQ@mail.gmail.com>       (Rafael
 J. Wysocki's message of "Mon, 30 Jan 2023 15:58:47 +0100")
Message-ID: <mafs0v8kodp14.fsf_-_@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Mon, Jan 30 2023, Rafael J. Wysocki wrote:
> On Mon, Jan 30, 2023 at 3:18 PM Pratyush Yadav <ptyadav@amazon.de> wrote:
>>
>> Hi Rafael,
>>
>> On Thu, Dec 29 2022, Rafael J. Wysocki wrote:
>>
>> > On Thu, Dec 29, 2022 at 1:58 PM Pratyush Yadav <ptyadav@amazon.de> wrote:
>> >>
>> >> Hi Rafael,
>> >>
>> >> On Wed, Dec 28 2022, Rafael J. Wysocki wrote:
>> >> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >> >
>> >> > When _PPC returns 0, it means that the CPU frequency is not limited by
>> >> > the platform firmware, so make acpi_processor_get_platform_limit()
>> >> > update the frequency QoS request used by it to "no limit" in that case.
>> >> >
>> >> > This addresses a problem with limiting CPU frequency artificially on
>> >> > some systems after CPU offline/online to the frequency that corresponds
>> >> > to the first entry in the _PSS return package.
>> >> >
>> >> > Reported-by: Pratyush Yadav <ptyadav@amazon.de>
>> >> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >> > ---
>> [...]
>> >>
>> >> One small thing I noticed: in acpi_processor_ppc_init() "no limit" value
>> >> is set to INT_MAX and here it is set to FREQ_QOS_MAX_DEFAULT_VALUE. Both
>> >> should evaluate to the same value but I think it would be nice if the
>> >> same thing is used in both places. Perhaps you can fix that up when
>> >> applying?
>> >
>> > Yes, I'll do that.
>>
>> Following up on this series. I do not see it queued anywhere in the
>> linux-pm [0] tree. I would like to have this in the v6.3 merge window if
>> possible.
>>
>> [0] https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/
>
> It's already in the mainline:
>
> e8a0e30b742f cpufreq: intel_pstate: Drop ACPI _PSS states table patching
> 99387b016022 ACPI: processor: perflib: Avoid updating frequency QoS
> unnecessarily
> c02d5feb6e2f ACPI: processor: perflib: Use the "no limit" frequency QoS

Hmm, I skimmed through the git log and did not spot any of these. Seems
like they were buried deeper in the logs due to merges. I can see them
now. My bad.

-- 
Regards,
Pratyush Yadav



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



