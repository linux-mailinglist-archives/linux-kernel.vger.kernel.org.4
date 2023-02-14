Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175FE696864
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjBNPr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjBNPrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:47:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5B22B62D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 07:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3rjVE6ACVjf7c6QIeVhBmIQJ6jMmzCDPZMc1WKEkyeM=; b=sSPR2E9ZvemyWobSnvpHBemQwQ
        g5PKMSHwxAjUqZt1znyq5LBs3vYTNK7wuCTrTsBTm3y2Qjk87mt2lAdhn12l5H68Y0ChslB36JJKF
        9TB0zsHbDVyq1YObRenB62WwGr1Ts1nEtn4iriXAJggiLwO/uen8MLsebh9AIMYTgBfbJ1CoFgFZl
        r5HNo2L9ekgjJ0zT85exaK/0BpEKZL5wrxHnGE/IfI2/4WJ2et9F8BrYX76lHkArB+l0obXiRbmAf
        fy1Av4BkAgTmr4sGV7UWTWdB0+kBYDqg2XlLbb1ZC5TB7ET8uourN74t8IPI17yW4AY+G8uNSe829
        uUUI0X1g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRxW7-006c3d-Bs; Tue, 14 Feb 2023 15:46:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BCA0030020C;
        Tue, 14 Feb 2023 10:49:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9005720B4E943; Tue, 14 Feb 2023 10:49:07 +0100 (CET)
Date:   Tue, 14 Feb 2023 10:49:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     mingo@redhat.com, bp@alien8.de, jroedel@suse.de, vbabka@suse.cz,
        hpa@zytor.com, tglx@linutronix.de, eric.devolder@oracle.com,
        bhe@redhat.com, tiwai@suse.de, keescook@chromium.org,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, liwei391@huawei.com, xiexiuqi@huawei.com
Subject: Re: [PATCH v3] x86/kdump: Handle blocked NMIs interrupt to avoid
 kdump crashes
Message-ID: <Y+tZE8ixmlIDYrOu@hirez.programming.kicks-ass.net>
References: <20230202014053.3604176-1-zengheng4@huawei.com>
 <Y9t9wvQ0HRwCs1Xh@hirez.programming.kicks-ass.net>
 <e57ba121-5bcc-e63b-691d-3e3d998e9e48@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e57ba121-5bcc-e63b-691d-3e3d998e9e48@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 05:30:46PM +0800, Zeng Heng wrote:

> > I never remember the shutdown paths -- do we force wipe the PMU
> > registers somewhere before this?
> 
> I have checked the panic process, and there is no wipe operation for PMU
> registers,
> 
> which causes the watchdog bites.
> 
> Do you mean we should directly disable PMU registers instead of calling
> `iret_to_self` to
> 
> consume blocked NMI interrupts ?

If you don't wipe the PMU, there will be many and continuous NMIs, a
single IRET-to-SELF isn't going to safe you.

Anyway, I had a bit of a grep around and I find we have:

  kernel/events/core.c:   register_reboot_notifier(&perf_reboot_notifier);

which should end up killing all the PMU activity. Somewhere around there
there's also a CONFIG_KEXEC_CORE ifdef, so I'm thinking it gets called
on the panic->crash-kernel path too?

If not, someone should look at doing something there.
