Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B526A697300
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjBOBC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBOBC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:02:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BCE30EA2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 17:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676422891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uNC4MqEUDW2/mIdiDF3kH441RIGy+JSKPjHydADHWoo=;
        b=egYuTHOLUbsmZRd4sLEFT6ZwzmilknUG7N3kaUwk5ARaxco9FYIS3NJriIXOI/w3bKJgSl
        WLBDTyyD52lInyBfhW17X8kL1e2adt79yEvaMnBkCilsQbpP658/z7xXmMTahuVS9PqR2l
        nlvMJDMXo4YyztSIUokqXBILVzDgTR8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-180-SvhBT2YXNY66LFZumx3wCw-1; Tue, 14 Feb 2023 20:01:30 -0500
X-MC-Unique: SvhBT2YXNY66LFZumx3wCw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA13B2805593;
        Wed, 15 Feb 2023 01:01:29 +0000 (UTC)
Received: from localhost (ovpn-12-99.pek2.redhat.com [10.72.12.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EF30492B03;
        Wed, 15 Feb 2023 01:01:28 +0000 (UTC)
Date:   Wed, 15 Feb 2023 09:01:25 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Zeng Heng <zengheng4@huawei.com>, mingo@redhat.com, bp@alien8.de,
        jroedel@suse.de, vbabka@suse.cz, hpa@zytor.com, tglx@linutronix.de,
        eric.devolder@oracle.com, tiwai@suse.de, keescook@chromium.org,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, liwei391@huawei.com, xiexiuqi@huawei.com,
        kexec@lists.infradead.org
Subject: Re: [PATCH v3] x86/kdump: Handle blocked NMIs interrupt to avoid
 kdump crashes
Message-ID: <Y+wu5UJTzVIYrsbK@MiWiFi-R3L-srv>
References: <20230202014053.3604176-1-zengheng4@huawei.com>
 <Y9t9wvQ0HRwCs1Xh@hirez.programming.kicks-ass.net>
 <e57ba121-5bcc-e63b-691d-3e3d998e9e48@huawei.com>
 <Y+tZE8ixmlIDYrOu@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+tZE8ixmlIDYrOu@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kexec list to CC.

On 02/14/23 at 10:49am, Peter Zijlstra wrote:
> On Tue, Feb 14, 2023 at 05:30:46PM +0800, Zeng Heng wrote:
> 
> > > I never remember the shutdown paths -- do we force wipe the PMU
> > > registers somewhere before this?
> > 
> > I have checked the panic process, and there is no wipe operation for PMU
> > registers,
> > 
> > which causes the watchdog bites.
> > 
> > Do you mean we should directly disable PMU registers instead of calling
> > `iret_to_self` to
> > 
> > consume blocked NMI interrupts ?
> 
> If you don't wipe the PMU, there will be many and continuous NMIs, a
> single IRET-to-SELF isn't going to safe you.
> 
> Anyway, I had a bit of a grep around and I find we have:
> 
>   kernel/events/core.c:   register_reboot_notifier(&perf_reboot_notifier);
> 
> which should end up killing all the PMU activity. Somewhere around there
> there's also a CONFIG_KEXEC_CORE ifdef, so I'm thinking it gets called
> on the panic->crash-kernel path too?

No, reboot_notifier_list is only handled in kexec reboot/reboot path,
please see kernel_restart_prepare() invocation. Kdump path only shutdown
key component like cpu, interrupt controller.

> 
> If not, someone should look at doing something there.
> 

