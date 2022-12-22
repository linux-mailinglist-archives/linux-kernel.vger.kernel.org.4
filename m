Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB0565484C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 23:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbiLVWST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 17:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiLVWSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 17:18:15 -0500
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9862666;
        Thu, 22 Dec 2022 14:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1671747494; x=1703283494;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=UwKdVjpYLkRqGESN/NcUvn6sDkhajOztv9Cw8D+KxY4=;
  b=Fv4eeOfs891uuujrf+t+KVo5G8Xs2yDTt/EHFiyEnbjW6JgZ4R2rlCzx
   n/fzVpmPDI595tFmldDC7gnBGheKY+OKalwZ2AcI2vsFD/zEPe7+60cjw
   cL9M+ndcitTIAKTaaJI0+O3eqJDUUZR8PH+5A5pIPPtdgBxZXafGAUF53
   A=;
X-IronPort-AV: E=Sophos;i="5.96,266,1665446400"; 
   d="scan'208";a="250387884"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-1cca8d67.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 22:18:07 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-1cca8d67.us-west-2.amazon.com (Postfix) with ESMTPS id 431A482186;
        Thu, 22 Dec 2022 22:18:06 +0000 (UTC)
Received: from EX13D34UEA003.ant.amazon.com (10.43.61.16) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Thu, 22 Dec 2022 22:18:06 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D34UEA003.ant.amazon.com (10.43.61.16) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Thu, 22 Dec 2022 22:18:05 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1497.42 via Frontend Transport; Thu, 22 Dec 2022 22:18:05 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
        id 5DACF20D15; Thu, 22 Dec 2022 23:18:04 +0100 (CET)
From:   Pratyush Yadav <ptyadav@amazon.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>,
        "Srinivas Pandruvada" <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devel@acpica.org>
Subject: Re: [PATCH 1/2] acpi: processor: allow fixing up the frequency for
 a performance state
References: <20221221155203.11347-1-ptyadav@amazon.de>
        <20221221155203.11347-2-ptyadav@amazon.de>
        <CAJZ5v0i-mrt57=2ROywn4Na_N3YVk+3D869QpHWqp9eo2NtGAw@mail.gmail.com>
Date:   Thu, 22 Dec 2022 23:18:04 +0100
In-Reply-To: <CAJZ5v0i-mrt57=2ROywn4Na_N3YVk+3D869QpHWqp9eo2NtGAw@mail.gmail.com>       (Rafael
 J. Wysocki's message of "Thu, 22 Dec 2022 17:23:41 +0100")
Message-ID: <mafs0edsrdqw3.fsf_-_@amazon.de>
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

On Thu, Dec 22 2022, Rafael J. Wysocki wrote:
> On Wed, Dec 21, 2022 at 4:52 PM Pratyush Yadav <ptyadav@amazon.de> wrote:
>>
>> In some cases the ACPI table can have an incorrect frequency populated
>> for a performance state. For example, in Intel platforms, the Turbo
>> frequency is just listed as +1 MHz above the max non-turbo frequency.
>
> Which is a known convention based on compatibility with some older OSes.

Interesting. I did not know that.

>
>> The frequency can actually go much higher based on various factors like
>> temperature, voltage, etc.
>
> It can.
>
>> Allow drivers like intel_pstate to fix up performance state frequencies
>> with the actual maximum value.
>
> Why do you want to do that?

To be able to use my processors at the full frequency they are capable
of. See [0] for more details.

[0] https://lore.kernel.org/linux-pm/mafs0k02jd8oh.fsf_-_@dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com/

>
[...]

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



