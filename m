Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D8863DA30
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiK3QHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiK3QHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:07:16 -0500
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2B943861
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1669824436; x=1701360436;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4HeO5q4X4CFfVFHYtGp/Sa2VvrBi6GbKhIVzYVDzgWc=;
  b=Aqm5IdddT7OnnW85pJUm0jw7piTRrbrryuKFmsmcRhyb57e1wkMXqxd3
   ZVM86pzXbsqtl9Ub6pjISytnkBA3GYRlG0XpyRq35kCJnull9aNEyfZ0I
   qLCbopRAmeCHJjUEfgWgD30q55F2uAsGv8Ey7orOHVUOHa/UmgdF/0hmf
   I=;
X-IronPort-AV: E=Sophos;i="5.96,206,1665446400"; 
   d="scan'208";a="285619910"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-d40ec5a9.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 16:07:15 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-m6i4x-d40ec5a9.us-west-2.amazon.com (Postfix) with ESMTPS id 92F5C4161F;
        Wed, 30 Nov 2022 16:07:11 +0000 (UTC)
Received: from EX19D003UWC001.ant.amazon.com (10.13.138.144) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Wed, 30 Nov 2022 16:07:11 +0000
Received: from [192.168.3.46] (10.43.160.223) by EX19D003UWC001.ant.amazon.com
 (10.13.138.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.20; Wed, 30 Nov 2022
 16:07:10 +0000
Date:   Wed, 30 Nov 2022 10:02:58 -0600
From:   Geoff Blake <blakgeof@amazon.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] perf/arm-cmn: Cope with spurious IRQs better
In-Reply-To: <bc8183fcd7f6ca07b0d56aa8061d816485b84341.1669822447.git.robin.murphy@arm.com>
Message-ID: <f41af5cb-7fc7-4bd3-ec9e-53071b9a41f9@amazon.com>
References: <bc8183fcd7f6ca07b0d56aa8061d816485b84341.1669822447.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.43.160.223]
X-ClientProxiedBy: EX13D28UWB004.ant.amazon.com (10.43.161.56) To
 EX19D003UWC001.ant.amazon.com (10.13.138.144)
X-Spam-Status: No, score=-14.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robin,

From my perspective, this is a worse solution as now we're sweeping an 
issue under the rug and consuming CPU cycles handling IRQs we should not 
be getting in the first place.  While an overflow IRQ from the cmn should 
not be high frequency, there is a non-zero chance in the future it could 
be and this could lead to a very hard to debug performance issue instead 
of the current problem, which is discovering we need to clean up better 
from a noisy kernel message.

The driver as best I can grok currently is optimized to limit the amount 
of register writes for the common use-case, which is setting and unsetting 
events, so all the wiring for the PMU to feed events to the DTC is done up 
front on load: DTC_CTL's DT_EN bit is set immediately during probe, as is 
OVFL_INTR_EN. All the DN states and DTM PMU_CONFIG_PMU_EN is deferred 
for when an event is actually set, and here we go through all of them 
anyways for each event unless its bynodeid, so the expense of setting 
events grows linearly with the mesh size anyways.  

Doing a one time scan on remove/shutdown to reset everything to a 
clean state seems like a wash performance wise and wanting to keep just a 
single register write doesn't make much sense to me.  

Should I instead pull this step out as a 
generic initialization step that can live as a single chunk of code to 
make it better for maintainability?  Would that be a better solution?

- Geoff
