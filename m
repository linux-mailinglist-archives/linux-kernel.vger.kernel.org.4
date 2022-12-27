Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2060656C9E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 16:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiL0Pia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 10:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiL0Pi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 10:38:27 -0500
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD02810F6;
        Tue, 27 Dec 2022 07:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1672155506; x=1703691506;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=j2XZBAWveY6jluLbVtDIMUY2FnTmKnvj9fGVpj/UwzM=;
  b=VUfmyDggK1hW7WJYcvLkHB1p8Hd5tvlknDrkUcxQZNhOnlaATW16Mnux
   f4H6ZSAhh9fq/ENdr2Ai9kHprroZMQAINp0VpZ+cniBUjtlxghx/V2+tu
   6GV9USEX10e2StIjtuPfvGFteUQ4Vd2Ijqzrg5Z9/1Qr/vk4jgiTK44gx
   4=;
X-IronPort-AV: E=Sophos;i="5.96,278,1665446400"; 
   d="scan'208";a="1087264031"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 15:38:18 +0000
Received: from EX13MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com (Postfix) with ESMTPS id 5D49941C12;
        Tue, 27 Dec 2022 15:38:18 +0000 (UTC)
Received: from EX19D023UWA001.ant.amazon.com (10.13.139.15) by
 EX13MTAUWA002.ant.amazon.com (10.43.160.12) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Tue, 27 Dec 2022 15:38:17 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX19D023UWA001.ant.amazon.com (10.13.139.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.20; Tue, 27 Dec 2022 15:38:17 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server id
 15.0.1497.42 via Frontend Transport; Tue, 27 Dec 2022 15:38:17 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
        id E4D7B20D2D; Tue, 27 Dec 2022 16:38:15 +0100 (CET)
From:   Pratyush Yadav <ptyadav@amazon.de>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
CC:     <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Robert Moore" <robert.moore@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devel@acpica.org>
Subject: Re: [PATCH 0/2] intel_pstate: fix turbo not being used after a
 processor is rebooted
References: <20221221155203.11347-1-ptyadav@amazon.de>
        <72bcd14eef038ec9181d30b3d196b0a872f47ccb.camel@linux.intel.com>
        <mafs0k02jd8oh.fsf_-_@dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com>
        <2ed9702b67832e3e33ef352808124980206c1e95.camel@linux.intel.com>
        <8e2cc66f7dadcfb04099aac7c4eef0b02075c91b.camel@linux.intel.com>
Date:   Tue, 27 Dec 2022 16:38:15 +0100
In-Reply-To: <8e2cc66f7dadcfb04099aac7c4eef0b02075c91b.camel@linux.intel.com>
        (srinivas pandruvada's message of "Sat, 24 Dec 2022 16:28:19 -0800")
Message-ID: <mafs07cycdfh4.fsf_-_@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On Sat, Dec 24 2022, srinivas pandruvada wrote:

> On Fri, 2022-12-23 at 10:10 -0800, srinivas pandruvada wrote:
>> Hi Pratyush,
>>
>> On Thu, 2022-12-22 at 11:39 +0100, Pratyush Yadav wrote:
>> >
>> > Hi Srinivas,
>> >
>> > On Wed, Dec 21 2022, srinivas pandruvada wrote:
>> > > On Wed, 2022-12-21 at 16:52 +0100, Pratyush Yadav wrote:
>> > > > When a processor is brought offline and online again, it is
>> > > > unable to
>> > > > use Turbo mode because the _PSS table does not contain the whole
>> > > > turbo
>> > > > frequency range, but only +1 MHz above the max non-turbo
>> > > > frequency.
>> > > > This
>> > > > causes problems when ACPI processor driver tries to set frequency
>> > > > constraints. See patch 2 for more details.
>> > > >
>> I can reproduce on a Broadwell server platform. But not on a client
>> system with acpi_ppc usage.
>>
>> Need to check what change broke this.
>
> When PPC limits enforcement changed to PM QOS, this broke. Previously
> acpi_processor_get_platform_limit() was not enforcing any limits. It
> was just setting variable. So any update done after
> acpi_register_performance_state() call to pr->performance-
>>states[ppc].core_frequency, was effective.
>
> We don't really need to call
>         ret = freq_qos_update_request(&pr->perflib_req,
>                         pr->performance->states[ppc].core_frequency *
> 1000);
>
> if the PPC is not changed. When PPC is changed, this gets called again,
> so then we can call the above function to update cpufreq limit.
>
> The below change fixed for me.

Right. Should I re-roll my patches with your diff below then? Or do you
think my patches should be good to merge as-is?

>
> diff --git a/drivers/acpi/processor_perflib.c
> b/drivers/acpi/processor_perflib.c
> index 757a98f6d7a2..c6ced89c00dd 100644
> --- a/drivers/acpi/processor_perflib.c
> +++ b/drivers/acpi/processor_perflib.c
> @@ -75,6 +75,11 @@ static int acpi_processor_get_platform_limit(struct
> acpi_processor *pr)
>         pr_debug("CPU %d: _PPC is %d - frequency %s limited\n", pr->id,
>                        (int)ppc, ppc ? "" : "not");
>
> +       if (ppc == pr->performance_platform_limit) {
> +               pr_debug("CPU %d: _PPC is %d - frequency not
> changed\n", pr->id, ppc);
> +               return 0;
> +       }
> +
>         pr->performance_platform_limit = (int)ppc;
>
>         if (ppc >= pr->performance->state_count ||
>

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



