Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75006577AF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 15:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiL1OWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 09:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiL1OWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 09:22:45 -0500
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C7BE0E6;
        Wed, 28 Dec 2022 06:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1672237364; x=1703773364;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=h3umiEVN6xVCtWMnEfxoi68bgBtHL0Jz7Hqfcl2rLp0=;
  b=o8fqEczvvVEYX865STNEpv+k2wLQLrIYiEBstRMPQHQjBOCKJhB7K9WC
   G92phB8cgRdwD7Xfq8Z+TlT4c+9ewOWYw/f/SUzOjka3A9pnikDw1HtlS
   TK1WApGtK+rfw85qX/iOORBH1MUORpm2nu3mQzFUtXToQ++7zp3utJq93
   Q=;
X-IronPort-AV: E=Sophos;i="5.96,280,1665446400"; 
   d="scan'208";a="251384519"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 14:22:39 +0000
Received: from EX13MTAUEE002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id A919282221;
        Wed, 28 Dec 2022 14:22:36 +0000 (UTC)
Received: from EX13D36UEE002.ant.amazon.com (10.43.62.110) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Wed, 28 Dec 2022 14:22:35 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D36UEE002.ant.amazon.com (10.43.62.110) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Wed, 28 Dec 2022 14:22:34 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1497.42 via Frontend Transport; Wed, 28 Dec 2022 14:22:34 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
        id 49EE320D2E; Wed, 28 Dec 2022 15:22:33 +0100 (CET)
From:   Pratyush Yadav <ptyadav@amazon.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v1 1/2] ACPI: processor: perflib: Use the "no limit"
 frequency QoS
References: <12138067.O9o76ZdvQC@kreacher>
Date:   Wed, 28 Dec 2022 15:22:33 +0100
In-Reply-To: <12138067.O9o76ZdvQC@kreacher> (Rafael J. Wysocki's message of
        "Tue, 27 Dec 2022 20:51:43 +0100")
Message-ID: <mafs0zgb7boba.fsf@amazon.de>
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

On Tue, Dec 27 2022, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> When _PPC returns 0, it means that the CPU frequency is not limited by
> the platform firmware, so make acpi_processor_get_platform_limit()
> update the frequency QoS request used by it to "no limit" in that case
> and avoid updating the QoS request when the _PPC return value has not
> changed.
>
> This addresses a problem with limiting CPU frequency artificially on
> some systems after CPU offline/online to the frequency that corresponds
> to the first entry in the _PSS return package.
>
> While at it, move the _PPC return value check against the state count
> earlier to avoid setting performance_platform_limit to an invalid value.
>
> Reported-by: Pratyush Yadav <ptyadav@amazon.de>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Tested-by: Pratyush Yadav <ptyadav@amazon.de>

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



