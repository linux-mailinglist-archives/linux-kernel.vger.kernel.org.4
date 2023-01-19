Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55105673F9C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjASRKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjASRKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:10:46 -0500
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17F6808B3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1674148241; x=1705684241;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8RD2NMlTLbb1fDHF7JSh91WOGDcsE0IX4cxLuRZNagI=;
  b=nC4Vl50fVFOJewPwmCWlKc97tY8XhInmwBdhuy5C0VIdp8AZYUZfOmwg
   jXVMAuuYWBIRjGW4drT9tqafJnAd/wcUlRG+3yoQSzRZeq43384Sw3P0a
   +ytwU+9EaKKkJ2L9Gck7lBwAWn8Ucw6+cbLrn4lJhhLH5/o23tNs+BT5H
   w=;
X-IronPort-AV: E=Sophos;i="5.97,229,1669075200"; 
   d="scan'208";a="172897248"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 17:10:39 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com (Postfix) with ESMTPS id 152C741CE6;
        Thu, 19 Jan 2023 17:10:39 +0000 (UTC)
Received: from EX19D003UWC001.ant.amazon.com (10.13.138.144) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Thu, 19 Jan 2023 17:10:38 +0000
Received: from freeip.amazon.com (10.43.162.56) by
 EX19D003UWC001.ant.amazon.com (10.13.138.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.7;
 Thu, 19 Jan 2023 17:10:37 +0000
Date:   Thu, 19 Jan 2023 11:10:29 -0600
From:   Geoff Blake <blakgeof@amazon.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] perf/arm-cmn: Add shutdown routine
In-Reply-To: <7071a073-08f5-104b-f10f-e1013d1b5390@arm.com>
Message-ID: <ed89d1a0-3aac-d8dc-2056-21cb4609e7fb@amazon.com>
References: <2bb86e97-6cef-700e-70ed-4f303da10fd9@amazon.com> <20221215180039.18035-1-blakgeof@amazon.com> <ab93909a-2c81-302f-9f85-33cf1a745e74@amazon.com> <7071a073-08f5-104b-f10f-e1013d1b5390@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.43.162.56]
X-ClientProxiedBy: EX13D41UWC001.ant.amazon.com (10.43.162.107) To
 EX19D003UWC001.ant.amazon.com (10.13.138.144)
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Jan 2023, Robin Murphy wrote:
 
> If you have a convincing argument that returning IRQ_NONE for unexpected
> spurious interrupts is a real and important concern, then please propose
> a general solution, because if it matters for arm-cmn then it matters
> for hundreds of other drivers too, by rough estimate:
> 
> $ git grep -l IRQ_NONE '*.c' | xargs git grep -L IRQF_SHARED | wc -l
> 834

The general solution for IRQ_NONE exists in the layer above the 
driver, it complains with a visible warning that something might be wrong 
and then moves on. Nothing more is needed.

Your shutdown routine that flips DT_EN in CMN_DT_DTC_CTL is sufficient, as 
after some testing it solves the problem with left over IRQs for my kexec 
use case.  

-Geoff
