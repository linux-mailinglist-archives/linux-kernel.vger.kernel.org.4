Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73ABF6520E0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiLTMnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbiLTMms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:42:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99BB1A81D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671539928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2YGLPYrhUM3liQYpN3p/+bDVBoiicBenOmdXkygbdC0=;
        b=LXDEEGFr2NiW0tHm7TOAuFUfYCvdyxpv3v+YV19EwolWYJLGXiJDlTspVrIUC2if0wn03E
        LM9uCzN38oQymBy4hTGCQQEMlQmvtwS9j+MKUjEYGgjzVPYA4bfdyBLVfT3Zv5vrHCh0U6
        v0qoZERRx21OGgKE8SEIfPyLxMx8D9A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-hvM0dMytMiWl0AERQdiC_g-1; Tue, 20 Dec 2022 07:38:44 -0500
X-MC-Unique: hvM0dMytMiWl0AERQdiC_g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04002183B3C3;
        Tue, 20 Dec 2022 12:38:44 +0000 (UTC)
Received: from localhost (ovpn-12-53.pek2.redhat.com [10.72.12.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 30D8240C201B;
        Tue, 20 Dec 2022 12:38:42 +0000 (UTC)
Date:   Tue, 20 Dec 2022 20:38:39 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, kexec@lists.infradead.org, dgilbert@redhat.com
Subject: Re: [PATCH] Revert "x86/apic/x2apic: Implement IPI shorthands
 support"
Message-ID: <Y6Gsz4mqnZCtC9rn@MiWiFi-R3L-srv>
References: <Y6FJgh3fOYoF0wSV@MiWiFi-R3L-srv>
 <Y6GextAcO4OZig3Y@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6GextAcO4OZig3Y@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/22 at 12:38pm, Peter Zijlstra wrote:
> On Tue, Dec 20, 2022 at 01:34:58PM +0800, Baoquan He wrote:
> > This reverts commit 43931d350f30c6cd8c2f498d54ef7d65750abc92.
> > 
> > On kvm guest with 4 cpus deployed, when adding 'nr_cpus=2' to normal
> > kernel's cmdline, and triggering crash to jump to kdump kernel, kdump
> > kernel will stably hang. Reverting commit 43931d350f30 ("x86/apic/x2apic:
> > Implement IPI shorthands support") can fix it.
> > 
> > The problem will disappear if removing 'nr_cpus=2' from normal kerne's
> > cmdline.
> 
> And the root cause for this is... ? Does the kvm x2apic emulation
> somehow get upset when we shorthand CPUs that haven't been initialized?

Thanks for checking.

I haven't figure out the root cause. I haven't read the apic code for
long time, and not familiar with the kvm code. So raise the issue to
upstream.

I can do testing if any suggestion.

Add our virt dev Dr. David Alan Gilbert to CC.

