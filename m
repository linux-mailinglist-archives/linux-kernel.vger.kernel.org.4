Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CECC6E2DFC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 02:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjDOAoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 20:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjDOAoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 20:44:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D19C4EFB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 17:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681519407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jLzcmt6yXFfM7kna/P8KGa04zAmCOpl3/oE8xB2gQTc=;
        b=CIu0Q9Rv/+dselgn5y7vHsNUQsoc6d5dUrq628AOyZCZxCPRq5h6Y0haIRT6UC+vMdACJm
        VFa9RwF05IubpbLK53vh8d7m9dcsKLUN9MfiyxkxvFJJfx2paX5W1xnvv+tZ5ED4DYjX24
        UTMicskF7HW2ncuM1saYFOvV0D0r3mY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-2cQ0V8l1PEOwMptCbG6fhg-1; Fri, 14 Apr 2023 20:43:24 -0400
X-MC-Unique: 2cQ0V8l1PEOwMptCbG6fhg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2B792823815;
        Sat, 15 Apr 2023 00:43:23 +0000 (UTC)
Received: from localhost (ovpn-12-58.pek2.redhat.com [10.72.12.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 91CDE1121320;
        Sat, 15 Apr 2023 00:43:22 +0000 (UTC)
Date:   Sat, 15 Apr 2023 08:43:17 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        horms@kernel.org, thunder.leizhen@huawei.com,
        John.p.donnelly@oracle.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZDnzJaqQLkllQox1@MiWiFi-R3L-srv>
References: <20230407022419.19412-1-bhe@redhat.com>
 <20230414143413.GA27911@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414143413.GA27911@willie-the-truck>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/14/23 at 03:34pm, Will Deacon wrote:
> Hi,
> 
> On Fri, Apr 07, 2023 at 10:24:19AM +0800, Baoquan He wrote:
> > On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> > suitable memory region top down. If the 'xM' of crashkernel high memory
> > is reserved from high memory successfully, it will try to reserve
> > crashkernel low memory later accoringly. Otherwise, it will try to search
> > low memory area for the 'xM' suitable region. Please see the details in
> > Documentation/admin-guide/kernel-parameters.txt.
> 
> [...]
> 
> >  arch/arm64/mm/init.c | 44 ++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 34 insertions(+), 10 deletions(-)
> 
> I tried to apply this, but smatch is unhappy with the result:
> 
>   | arch/arm64/mm/init.c:153 reserve_crashkernel() error: uninitialized symbol 'search_base'.
> 
> I _think_ this is a false positive, but I must say that the control flow
> in reserve_crashkernel() is extremely hard to follow so I couldn't be
> sure. If the static checker is struggling, then so will humans!
> 
> Ideally, this would all be restructured to make it easier to follow,
> but in the short term we need something to squash the warning.

Sorry for that, I didn't run static checker. We should do initialization
as below to fix the warning. Below code can be added into this v5 patch,
or I can post v6 with Catalin's Reviewed-by tag.

Yes, about restructuring, I can think about it later. The added corner
cases handling specific for arm64 makes the flow a little harder to
flow. I will consider if adding document in arm64 is better.

From 3575571ab9614c31f30933148a8693924a30321c Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Sat, 15 Apr 2023 08:35:08 +0800
Subject: [PATCH] arm64: kdump: fix warning reported by static checker
Content-type: text/plain

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm64/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 13750b0548da..bfc117cefcd5 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -128,9 +128,9 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
  */
 static void __init reserve_crashkernel(void)
 {
-	unsigned long long crash_base, crash_size, search_base;
+	unsigned long long crash_low_size = 0, search_base = 0;
 	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
-	unsigned long long crash_low_size = 0;
+	unsigned long long crash_base, crash_size;
 	char *cmdline = boot_command_line;
 	bool fixed_base = false;
 	bool high = false;
-- 
2.34.1


