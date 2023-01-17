Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CED866D82C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbjAQI21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbjAQI2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:28:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8E122798
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 00:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673944053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gg7qkv1C1Ou83J3gkN1LzeHJIr1iBZFQETY1qPldk9s=;
        b=HaZlw81mSN4CIrkQQsHpNiCsU6f6iWVgOozE+dvURnCRh4eeXa3A187F9swC3zTAAPHW9t
        oWOInbgtqfOLOjCufpeRrty3YllwN3654h+qb0pYBsldaWzUtBRRuKls3aPkgde7ilx2T0
        o6jUDDS1P3nrSCiFkC0i6nwVYGEN+vI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-nESQqZ6lMb2BsRB0SL1EKg-1; Tue, 17 Jan 2023 03:27:28 -0500
X-MC-Unique: nESQqZ6lMb2BsRB0SL1EKg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D6D2858F09;
        Tue, 17 Jan 2023 08:27:28 +0000 (UTC)
Received: from localhost (ovpn-12-229.pek2.redhat.com [10.72.12.229])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5173C15BA0;
        Tue, 17 Jan 2023 08:27:27 +0000 (UTC)
Date:   Tue, 17 Jan 2023 16:27:23 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH] Revert "x86/apic/x2apic: Implement IPI shorthands
 support"
Message-ID: <Y8Zb696MT1E1p2jZ@fedora>
References: <Y6FJgh3fOYoF0wSV@MiWiFi-R3L-srv>
 <87k01vjrnt.ffs@tglx>
 <Y7zMZ8nCNtSt09kV@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7zMZ8nCNtSt09kV@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/23 at 10:24am, Baoquan He wrote:
> On 01/09/23 at 10:59pm, Thomas Gleixner wrote:
> > On Tue, Dec 20 2022 at 13:34, Baoquan He wrote:
> > > This reverts commit 43931d350f30c6cd8c2f498d54ef7d65750abc92.
> > >
> > > On kvm guest with 4 cpus deployed, when adding 'nr_cpus=2' to normal
> > > kernel's cmdline, and triggering crash to jump to kdump kernel, kdump
> > > kernel will stably hang. Reverting commit 43931d350f30 ("x86/apic/x2apic:
> > > Implement IPI shorthands support") can fix it.
> > 
> > Is there any output on the early console or hangs it silently?
> > 
> > If the latter, can you attach GDB to the guest and figure out where it
> > is stuck?
> 
> No any output on the ealry console. I will try gdb debugging. Thanks.

I rebase to the latest upstream kernel and tested, the stable kdump
kernel hang disappear. Seems I need do another round of bisect to see
on which commit it's made to fix that. Will update if any progress.

