Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA8B653B22
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 05:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbiLVEKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 23:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLVEKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 23:10:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B871A811
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 20:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671682154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PZyafQqgBt7zn6f3VZzK00nebPDqAfKuXzcWmeIT/HE=;
        b=NtaCpndjf3mKXYgAqC3sCC9EpjHWiTEwvm4K7mgNPmXnZ6kJDQPXFxsPUFzxqUHETN4MPm
        AMPhEatbnY3WM/S4UMGJhielOwFKpRl2MxzUr9z0LRKin5xCls1zrGIoRQrnlx/ztCUIRe
        /cn5v9j9WiEiGbddwwVNMnVjxoyeUyA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-8zmO4qUJPZen_wuY0c0Plg-1; Wed, 21 Dec 2022 23:09:13 -0500
X-MC-Unique: 8zmO4qUJPZen_wuY0c0Plg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA7311C02D35;
        Thu, 22 Dec 2022 04:09:09 +0000 (UTC)
Received: from localhost (ovpn-12-50.pek2.redhat.com [10.72.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1672151E5;
        Thu, 22 Dec 2022 04:09:08 +0000 (UTC)
Date:   Thu, 22 Dec 2022 12:09:05 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     x86@kernel.org, kexec@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: kdump kernel randomly hang with tick_periodic call trace on bare
 metal system
Message-ID: <Y6PYYUKXR2OCH3WG@MiWiFi-R3L-srv>
References: <Y6FJgh3fOYoF0wSV@MiWiFi-R3L-srv>
 <Y6FK++b4buO5EgjD@MiWiFi-R3L-srv>
 <Y6FNTFbH9DbhEogg@MiWiFi-R3L-srv>
 <efe7e25e-8b05-90e7-fc02-4f1dc84fe324@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efe7e25e-8b05-90e7-fc02-4f1dc84fe324@igalia.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/22 at 12:46pm, Guilherme G. Piccoli wrote:
> On 20/12/2022 02:51, Baoquan He wrote:
> > On 12/20/22 at 01:41pm, Baoquan He wrote:
> >> On one intel bare metal system, I can randomly reproduce the kdump hang
> >> as below with tick_periodic call trace. Attach the kernel config for
> >> reference.
> > 
> > Forgot mentioning this random hang is also caused by adding
> > 'nr_cpus=2' into normal kernel's cmdline, then triggering crash will get
> > kdump kernel hang as below kdump log shown.
> > 
> 
> The weird thing is that you seem to be using "nr_cpus=1" instead - this
> is the cmdline from the log:
> 
> "nr_cpus=2 irqpoll nr_cpus=1 reset_devices cgroup_disable=memory mce=off
> numa=off udev.children-max=2 panic=10 acpi_no_memhotplug
> transparent_hugepage=never nokaslr hest_disable novmcoredd cma=0
> hugetlb_cma=0 disable_cpu_apicid=16 [...]"
> 
> You seems to pass twice the "nr_cpus" thing, and I guess kernel pick the
> last one?

From the kdump kernel boot log, yes, the nr_cpus=1 is taken. The
parse_early_param() will parse the kernel parameters one by one, then
the last one will take effect. Here, the problem is not at nr_cpus=2 or
1, the bare metal system has 16 cpus, only 2 cpus is present, it seems
to be the halted 14 cpus get wrong message and behave incorrectly to
cause the issue.

> 
> Also, what is "disable_cpu_apicid=16"? Could this be related?

Not really. Please check disable_cpu_apicid in
Documentation/admin-guide/kdump/kdump.rst, it's bsp's apic id.

