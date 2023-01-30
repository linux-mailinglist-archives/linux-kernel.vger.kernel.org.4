Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9D068124A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237638AbjA3OTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237635AbjA3OTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:19:20 -0500
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F5C3B0EE;
        Mon, 30 Jan 2023 06:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1675088298; x=1706624298;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=C5oru7Dbvy/1R6SKKLx3znkVOYm2h1iV1BR520o60ms=;
  b=R3O7ERFqbE/QrrXsxdwb80zo+aP0HTnq9h/Zh+1xUfKdtHNoF99m7DYb
   mIe7tNReN7St8wmr8GhPhhpjC5Yvh2E71CTY3EIQsnYkTGAoa6gqG/2Dm
   IXua7jEaKqyuIqD9Ph2e7gxRNfg5WxRMyexU9dCLW7X5akVIzLRMGes1D
   U=;
X-IronPort-AV: E=Sophos;i="5.97,258,1669075200"; 
   d="scan'208";a="293479665"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 14:18:02 +0000
Received: from EX13MTAUEE002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com (Postfix) with ESMTPS id 6FE4FAC40E;
        Mon, 30 Jan 2023 14:17:59 +0000 (UTC)
Received: from EX19D014UEC003.ant.amazon.com (10.252.135.249) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Mon, 30 Jan 2023 14:17:55 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX19D014UEC003.ant.amazon.com (10.252.135.249) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.24;
 Mon, 30 Jan 2023 14:17:55 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1497.45 via Frontend Transport; Mon, 30 Jan 2023 14:17:55 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
        id 34AC120D34; Mon, 30 Jan 2023 15:17:55 +0100 (CET)
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
Date:   Mon, 30 Jan 2023 15:17:55 +0100
In-Reply-To: <CAJZ5v0hAjKvinPqX2VuCv1jVu50jrnDpECaO=sA2CQZFHZpJdA@mail.gmail.com>       (Rafael
 J. Wysocki's message of "Thu, 29 Dec 2022 20:26:07 +0100")
Message-ID: <mafs0zga0ds30.fsf_-_@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Thu, Dec 29 2022, Rafael J. Wysocki wrote:

> On Thu, Dec 29, 2022 at 1:58 PM Pratyush Yadav <ptyadav@amazon.de> wrote:
>>
>> Hi Rafael,
>>
>> On Wed, Dec 28 2022, Rafael J. Wysocki wrote:
>> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >
>> > When _PPC returns 0, it means that the CPU frequency is not limited by
>> > the platform firmware, so make acpi_processor_get_platform_limit()
>> > update the frequency QoS request used by it to "no limit" in that case.
>> >
>> > This addresses a problem with limiting CPU frequency artificially on
>> > some systems after CPU offline/online to the frequency that corresponds
>> > to the first entry in the _PSS return package.
>> >
>> > Reported-by: Pratyush Yadav <ptyadav@amazon.de>
>> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> > ---
[...]
>>
>> One small thing I noticed: in acpi_processor_ppc_init() "no limit" value
>> is set to INT_MAX and here it is set to FREQ_QOS_MAX_DEFAULT_VALUE. Both
>> should evaluate to the same value but I think it would be nice if the
>> same thing is used in both places. Perhaps you can fix that up when
>> applying?
>
> Yes, I'll do that.

Following up on this series. I do not see it queued anywhere in the
linux-pm [0] tree. I would like to have this in the v6.3 merge window if
possible.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/

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



