Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470696533AC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 16:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiLUPw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 10:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiLUPwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 10:52:22 -0500
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FB71A396;
        Wed, 21 Dec 2022 07:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1671637941; x=1703173941;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9YK/PrzS2uS8rT8WWzdNdUDB+lVs6VKHUehwJrBeLqk=;
  b=e1UzpUf3gWZdp5oBcj/RZ+J7d6Eull+5y5ftmBaAL79h73T8EDVSdcIz
   bZ7tZD+yrcRKIuKIDC/Ne9Ap5XX9UPayHx3Kawtu3Adf3qE1qc6TitnSb
   RcOKAgWFgDBlTcIkDoGuddWHXv9XJZRlWUrtuRZmtyTNH9etMwY4FulCE
   0=;
X-IronPort-AV: E=Sophos;i="5.96,262,1665446400"; 
   d="scan'208";a="1085825342"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-b404fda3.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 15:52:13 +0000
Received: from EX13D47EUB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-m6i4x-b404fda3.us-east-1.amazon.com (Postfix) with ESMTPS id 806BB863B5;
        Wed, 21 Dec 2022 15:52:10 +0000 (UTC)
Received: from EX19D028EUB002.ant.amazon.com (10.252.61.43) by
 EX13D47EUB001.ant.amazon.com (10.43.166.250) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Wed, 21 Dec 2022 15:52:09 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX19D028EUB002.ant.amazon.com (10.252.61.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.20; Wed, 21 Dec 2022 15:52:09 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1497.42 via Frontend Transport; Wed, 21 Dec 2022 15:52:08 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
        id 2B4AF20D08; Wed, 21 Dec 2022 16:52:07 +0100 (CET)
From:   Pratyush Yadav <ptyadav@amazon.de>
To:     <linux-pm@vger.kernel.org>
CC:     Pratyush Yadav <ptyadav@amazon.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devel@acpica.org>
Subject: [PATCH 0/2] intel_pstate: fix turbo not being used after a processor is rebooted
Date:   Wed, 21 Dec 2022 16:52:01 +0100
Message-ID: <20221221155203.11347-1-ptyadav@amazon.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a processor is brought offline and online again, it is unable to
use Turbo mode because the _PSS table does not contain the whole turbo
frequency range, but only +1 MHz above the max non-turbo frequency. This
causes problems when ACPI processor driver tries to set frequency
constraints. See patch 2 for more details.

Pratyush Yadav (2):
  acpi: processor: allow fixing up the frequency for a performance state
  cpufreq: intel_pstate: use acpi perflib to update turbo frequency

 drivers/acpi/processor_perflib.c | 40 ++++++++++++++++++++++++++++++++
 drivers/cpufreq/intel_pstate.c   |  5 ++--
 include/acpi/processor.h         |  2 ++
 3 files changed, 45 insertions(+), 2 deletions(-)

--
2.38.1

